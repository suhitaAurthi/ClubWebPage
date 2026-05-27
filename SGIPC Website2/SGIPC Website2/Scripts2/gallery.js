// Gallery management

function isGalleryTeamMember() {
    return typeof isCurrentUserTeamMember !== 'undefined' && isCurrentUserTeamMember === true;
}

function getGridForCategory(category) {
    switch (category) {
        case 'achievements':
            return document.getElementById('achievementsGrid');
        case 'workshops':
            return document.getElementById('workshopsGrid');
        case 'team-events':
            return document.getElementById('teamEventsGrid');
        default:
            return null;
    }
}

function escapeHtml(value) {
    const div = document.createElement('div');
    div.textContent = value || '';
    return div.innerHTML;
}

function renderGalleryItem(item) {
    return '<div class="gallery-item dynamic-gallery-item" data-gallery-id="' + escapeHtml(item.id) + '">' +
        '<div class="gallery-image">' +
        '<img src="' + escapeHtml(item.imagePath) + '" alt="' + escapeHtml(item.title) + '" />' +
        (isGalleryTeamMember() ? '<button type="button" class="gallery-delete-btn" onclick="deleteGalleryPhoto(' + escapeHtml(item.id) + ')" title="Delete Photo"><i class="fas fa-trash"></i></button>' : '') +
        '<div class="gallery-overlay">' +
        '<h4>' + escapeHtml(item.title) + '</h4>' +
        '<p>' + escapeHtml(item.description) + '</p>' +
        '</div>' +
        '</div>' +
        '</div>';
}

function loadGalleryItemsFromDatabase() {
    if (typeof $ === 'undefined') return;

    $.ajax({
        type: 'POST',
        url: 'gallery.aspx/GetGalleryItems',
        contentType: 'application/json; charset=utf-8',
        dataType: 'json',
        success: function(response) {
            let items = [];
            try {
                const parsed = typeof response.d === 'string' ? JSON.parse(response.d) : response.d;
                if (parsed && parsed.success === false) {
                    console.error(parsed.message);
                    return;
                }
                items = parsed || [];
            } catch (error) {
                console.error('Error parsing gallery items:', error);
                return;
            }

            for (let i = 0; i < items.length; i++) {
                const grid = getGridForCategory(items[i].category);
                if (grid) {
                    grid.insertAdjacentHTML('beforeend', renderGalleryItem(items[i]));
                }
            }
        },
        error: function(error) {
            console.error('Error loading gallery items:', error);
        }
    });
}

function openGalleryForm(category) {
    if (!isGalleryTeamMember()) {
        alert('Only team members can add gallery photos.');
        return;
    }

    const form = document.getElementById('galleryManagementForm');
    const categoryField = document.getElementById('galleryCategory');

    if (categoryField) {
        categoryField.value = category;
    }

    if (form) {
        form.style.display = 'block';
        form.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

function clearGalleryForm() {
    const title = document.getElementById('galleryTitle');
    const description = document.getElementById('galleryDescription');
    const imageFile = document.getElementById('galleryImageFile');

    if (title) title.value = '';
    if (description) description.value = '';
    if (imageFile) imageFile.value = '';
}

function saveGalleryPhoto() {
    if (!isGalleryTeamMember()) {
        alert('Only team members can add gallery photos.');
        return;
    }

    const title = document.getElementById('galleryTitle').value.trim();
    const description = document.getElementById('galleryDescription').value.trim();
    const imageFile = document.getElementById('galleryImageFile').files[0];
    const category = document.getElementById('galleryCategory').value;

    if (!title || !imageFile || !category) {
        alert('Please provide a title, image file, and section.');
        return;
    }

    if (imageFile.size > 5 * 1024 * 1024) {
        alert('Image must be 5 MB or smaller.');
        return;
    }

    const reader = new FileReader();
    reader.onload = function() {
        $.ajax({
            type: 'POST',
            url: 'gallery.aspx/AddGalleryItem',
            contentType: 'application/json; charset=utf-8',
            data: JSON.stringify({
                userId: currentUserId,
                title: title,
                description: description,
                fileName: imageFile.name,
                imageData: reader.result,
                category: category
            }),
            dataType: 'json',
            success: function(response) {
                const result = typeof response.d === 'string' ? JSON.parse(response.d) : response.d;

                if (!result.success) {
                    alert('Error: ' + result.message);
                    return;
                }

                const grid = getGridForCategory(category);
                if (grid) {
                    grid.insertAdjacentHTML('afterbegin', renderGalleryItem({
                        id: result.galleryId,
                        title: title,
                        description: description,
                        imagePath: result.imagePath,
                        category: category
                    }));
                }

                alert(result.message);
                clearGalleryForm();
                document.getElementById('galleryManagementForm').style.display = 'none';
            },
            error: function(error) {
                console.error('Error adding gallery photo:', error);
                alert('Error adding gallery photo.');
            }
        });
    };
    reader.readAsDataURL(imageFile);
}

function deleteGalleryPhoto(galleryId) {
    if (!isGalleryTeamMember()) {
        alert('Only team members can delete gallery photos.');
        return;
    }

    if (!confirm('Delete this photo from the gallery?')) {
        return;
    }

    $.ajax({
        type: 'POST',
        url: 'gallery.aspx/DeleteGalleryItem',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify({
            userId: currentUserId,
            galleryId: galleryId
        }),
        dataType: 'json',
        success: function(response) {
            const result = typeof response.d === 'string' ? JSON.parse(response.d) : response.d;
            if (!result.success) {
                alert('Error: ' + result.message);
                return;
            }

            const item = document.querySelector('.dynamic-gallery-item[data-gallery-id="' + galleryId + '"]');
            if (item) {
                item.remove();
            }
            alert(result.message);
        },
        error: function(error) {
            console.error('Error deleting gallery photo:', error);
            alert('Error deleting gallery photo.');
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    console.log('Gallery team member status:', isGalleryTeamMember(), 'currentUserId:', currentUserId);

    if (isGalleryTeamMember()) {
        const controls = document.querySelectorAll('.team-gallery-control');
        for (let i = 0; i < controls.length; i++) {
            controls[i].style.display = 'inline-flex';
            controls[i].addEventListener('click', function() {
                openGalleryForm(this.getAttribute('data-category'));
            });
        }
    }

    const closeBtn = document.getElementById('closeGalleryFormBtn');
    if (closeBtn) {
        closeBtn.addEventListener('click', function() {
            document.getElementById('galleryManagementForm').style.display = 'none';
            clearGalleryForm();
        });
    }

    const saveBtn = document.getElementById('saveGalleryPhotoBtn');
    if (saveBtn) {
        saveBtn.addEventListener('click', saveGalleryPhoto);
    }

    loadGalleryItemsFromDatabase();
});
