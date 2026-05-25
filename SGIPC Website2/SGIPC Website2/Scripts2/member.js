// Member Management JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Event delegation for edit button
    document.addEventListener('click', function(e) {
        if (e.target.closest('.btn-edit')) {
            const button = e.target.closest('.btn-edit');
            const userId = button.getAttribute('data-user-id');
            const username = button.getAttribute('data-username');
            const email = button.getAttribute('data-email');
            const roll = button.getAttribute('data-roll');
            editMember(userId, username, email, roll);
        }
        
        // Event delegation for show events button
        if (e.target.closest('.btn-show')) {
            const button = e.target.closest('.btn-show');
            const userId = button.getAttribute('data-user-id');
            const username = button.getAttribute('data-username');
            showUserEvents(userId, username);
        }
        
        // Event delegation for delete button
        if (e.target.closest('.btn-delete')) {
            const button = e.target.closest('.btn-delete');
            const userId = button.getAttribute('data-user-id');
            deleteMember(userId);
        }
    });
});

// Edit member function
function editMember(userId, username, email, roll) {
    console.log('Edit member:', { userId, username, email, roll });
    // TODO: Implement edit modal or redirect to edit page
    alert('Edit functionality for: ' + username);
}

// Show user events function
function showUserEvents(userId, username) {
    console.log('Show events for user:', { userId, username });
    // TODO: Implement showing user events
    alert('Show events for: ' + username);
}

// Delete member function
function deleteMember(userId) {
    console.log('Delete member:', userId);
    if (confirm('Are you sure you want to delete this member?')) {
        // TODO: Implement delete functionality via AJAX
        alert('Delete member: ' + userId);
    }
}
