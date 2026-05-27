// Member page click delegation. The page defines editMember, showUserEvents,
// and deleteMember because it owns the modal markup.
document.addEventListener('DOMContentLoaded', function() {
    const signedInUserId = typeof currentUserId === 'number' ? currentUserId : null;

    const editableButtons = document.querySelectorAll('.btn-edit, .btn-delete');
    for (let i = 0; i < editableButtons.length; i++) {
        const rowUserId = parseInt(editableButtons[i].getAttribute('data-user-id'), 10);
        if (!signedInUserId || rowUserId !== signedInUserId) {
            editableButtons[i].style.display = 'none';
        }
    }

    document.addEventListener('click', function(e) {
        const editButton = e.target.closest('.btn-edit');
        if (editButton && typeof window.editMember === 'function') {
            window.editMember(
                editButton.getAttribute('data-user-id'),
                editButton.getAttribute('data-username'),
                editButton.getAttribute('data-email'),
                editButton.getAttribute('data-roll')
            );
        }

        const showButton = e.target.closest('.btn-show');
        if (showButton && typeof window.showUserEvents === 'function') {
            window.showUserEvents(
                showButton.getAttribute('data-user-id'),
                showButton.getAttribute('data-username')
            );
        }

        const deleteButton = e.target.closest('.btn-delete');
        if (deleteButton && typeof window.deleteMember === 'function') {
            window.deleteMember(deleteButton.getAttribute('data-user-id'));
        }
    });
});
