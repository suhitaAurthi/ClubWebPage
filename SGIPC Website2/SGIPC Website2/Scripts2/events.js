// ==========================================
// SGIPC Event Management System
// Database-driven event management
// ==========================================

console.log("events.js loaded");

// Global variables from backend - DO NOT DECLARE HERE
// The backend RegisterStartupScript sets these values
// isCurrentUserTeamMember, currentUser, currentUserId are set by backend
var currentEvents = [];  // Store currently displayed events

// Initialize events from database
function initializeEvents() {
    console.log("===== initializeEvents called =====");
    console.log("currentUserId:", currentUserId);
    console.log("isCurrentUserTeamMember:", isCurrentUserTeamMember);
    console.log("isApprovedTeamMember():", isApprovedTeamMember());
    
    if (!currentUserId) {
        console.log("No user ID, loading published events only");
        loadPublishedEventsFromDatabase();
    } else {
        console.log("User logged in as ID:", currentUserId, "Team member:", isApprovedTeamMember());
        loadAllEventsFromDatabase(currentUserId);
    }
}

// Load published events from database via AJAX
function loadPublishedEventsFromDatabase() {
    console.log("===== loadPublishedEventsFromDatabase called =====");
    
    $.ajax({
        type: "POST",
        url: "events.aspx/GetPublishedEvents",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function(response) {
            console.log("GetPublishedEvents AJAX success - Raw response:", response);
            let events = [];
            try {
                let parsed = JSON.parse(response.d);
                console.log("Parsed events:", parsed);
                // Check if response contains an error message
                if (parsed && parsed.success === false && parsed.message) {
                    console.error("Database error:", parsed.message);
                    throw new Error(parsed.message);
                }
                events = parsed;
            } catch (e) {
                console.error("Error parsing events:", e);
                let container = document.getElementById('eventsContainer');
                if (container) {
                    container.innerHTML = '<p class="no-events">Error loading events: ' + e.message + '<br/>Please check database connection and refresh.</p>';
                }
                return;
            }
            console.log("✓ Loaded published events count:", events.length);
            currentEvents = events;
            renderAllEvents();
        },
        error: function(error) {
            console.error("GetPublishedEvents AJAX ERROR:", error);
            let container = document.getElementById('eventsContainer');
            if (container) {
                container.innerHTML = '<p class="no-events">Error loading events. Connection failed. Please refresh the page.</p>';
            }
        }
    });
}

// Load all events from database via AJAX
function loadAllEventsFromDatabase(userId) {
    console.log("===== loadAllEventsFromDatabase called with userId:", userId);
    
    $.ajax({
        type: "POST",
        url: "events.aspx/GetAllEvents",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({ userId: userId }),
        dataType: "json",
        success: function(response) {
            console.log("GetAllEvents AJAX success - Raw response:", response);
            let events = [];
            try {
                let parsed = JSON.parse(response.d);
                console.log("Parsed events:", parsed);
                // Check if response contains an error message
                if (parsed && parsed.success === false && parsed.message) {
                    console.error("Database error:", parsed.message);
                    throw new Error(parsed.message);
                }
                events = parsed;
            } catch (e) {
                console.error("Error parsing events:", e);
                let container = document.getElementById('eventsContainer');
                if (container) {
                    container.innerHTML = '<p class="no-events">Error loading events: ' + e.message + '<br/>Please check database connection and refresh.</p>';
                }
                return;
            }
            console.log("✓ Loaded all events count:", events.length);
            currentEvents = events;
            renderAllEvents();
        },
        error: function(error) {
            console.error("GetAllEvents AJAX ERROR:", error);
            let container = document.getElementById('eventsContainer');
            if (container) {
                container.innerHTML = '<p class="no-events">Error loading events. Connection failed. Please refresh the page.</p>';
            }
        }
    });
}

function isApprovedTeamMember() {
    return isCurrentUserTeamMember === true;
}

// function createEvent(eventData) {
//     console.log("createEvent called");
//     console.log("isApprovedTeamMember:", isApprovedTeamMember());
//     console.log("currentUserId:", currentUserId);
    
//     if (!isApprovedTeamMember()) {
//         alert("You are not authorized to create events. Only team members can create events.");
//         return false;
//     }
    
//     if (!currentUserId) {
//         alert("You must be logged in to create events.");
//         return false;
//     }
    
//     // Check if we're editing an existing event
//     const eventId = document.getElementById('eventForm').getAttribute('data-event-id');
    
//     if (eventId) {
//         // Edit existing event
//         $.ajax({
//             type: "POST",
//             url: "events.aspx/EditEvent",
//             contentType: "application/json; charset=utf-8",
//             data: JSON.stringify({
//                 userId: currentUserId,
//                 eventId: parseInt(eventId),
//                 title: eventData.title,
//                 description: eventData.description,
//                 eventType: eventData.eventType,
//                 eventDate: eventData.eventDate,
//                 startTime: eventData.startTime,
//                 endTime: eventData.endTime,
//                 location: eventData.location,
//                 registrationStatus: eventData.registrationStatus,
//                 registrationLink: eventData.registrationLink,
//                 contestLink: eventData.contestLink,
//                 isPublished: eventData.isPublished
//             }),
//             dataType: "json",
//             success: function(response) {
//                 console.log("EditEvent response:", response);
//                 try {
//                     let result = JSON.parse(response.d);
//                     if (result.success) {
//                         alert('✓ ' + result.message);
//                         // Clear the event ID so form resets for new creation
//                         document.getElementById('eventForm').removeAttribute('data-event-id');
//                         loadAllEventsFromDatabase(currentUserId);
//                     } else {
//                         alert('✗ Error: ' + result.message);
//                     }
//                 } catch (e) {
//                     alert("Error updating event");
//                 }
//             },
//             error: function(error) {
//                 console.error("Error updating event:", error);
//                 alert("Error updating event: " + error.statusText);
//             }
//         });
//     } else {
//         // Create new event
//         $.ajax({
//             type: "POST",
//             url: "events.aspx/CreateEventInDatabase",
//             contentType: "application/json; charset=utf-8",
//             data: JSON.stringify({
//                 userId: currentUserId,
//                 title: eventData.title,
//                 description: eventData.description,
//                 eventType: eventData.eventType,
//                 eventDate: eventData.eventDate,
//                 startTime: eventData.startTime,
//                 endTime: eventData.endTime,
//                 location: eventData.location,
//                 registrationStatus: eventData.registrationStatus,
//                 registrationLink: eventData.registrationLink,
//                 contestLink: eventData.contestLink,
//                 isPublished: eventData.isPublished
//             }),
//             dataType: "json",
//             success: function(response) {
//                 console.log("CreateEventInDatabase response:", response);
//                 try {
//                     let result = JSON.parse(response.d);
//                     if (result.success) {
//                         alert('✓ ' + result.message);
//                         loadAllEventsFromDatabase(currentUserId);
//                     } else {
//                         alert('✗ Error: ' + result.message);
//                     }
//                 } catch (e) {
//                     alert("Error creating event");
//                 }
//             },
//             error: function(error) {
//                 console.error("Error creating event:", error);
//                 alert("Error creating event: " + error.statusText);
//             }
//         });
//     }
    
//     return true;
// }

function createEvent(eventData) {
    console.log("===== createEvent STARTED =====");
    console.log("Event Data:", eventData);
    console.log("isApprovedTeamMember:", isApprovedTeamMember());
    console.log("isCurrentUserTeamMember (raw):", isCurrentUserTeamMember);
    console.log("currentUserId:", currentUserId);
    
    if (!isApprovedTeamMember()) {
        console.error("FAILED: User is not an approved team member");
        alert("You are not authorized to create events. Only team members can create events.");
        return false;
    }
    
    if (!currentUserId) {
        console.error("FAILED: No currentUserId found");
        alert("You must be logged in to create events.");
        return false;
    }
    
    const eventId = document.getElementById('eventForm').getAttribute('data-event-id');
    console.log("Editing existing event?", !!eventId);
    
    if (eventId) {
        // Edit existing event
        $.ajax({
            type: "POST",
            url: "events.aspx/EditEvent",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                userId: currentUserId,
                eventId: parseInt(eventId),
                title: eventData.title,
                description: eventData.description,
                eventType: eventData.eventType,
                eventDate: eventData.eventDate,
                startTime: eventData.startTime,
                endTime: eventData.endTime,
                location: eventData.location,
                registrationStatus: eventData.registrationStatus,
                registrationLink: eventData.registrationLink,
                contestLink: eventData.contestLink,
                isPublished: eventData.isPublished
            }),
            dataType: "json",
            success: function(response) {
                console.log("EditEvent response:", response);
                try {
                    let result = typeof response.d === "string" ? JSON.parse(response.d) : response.d;
                    if (result.success) {
                        alert('✓ ' + result.message);
                        document.getElementById('eventManagementForm').style.display = 'none';
                        clearEventForm();
                        initializeEvents();
                    } else {
                        alert('✗ Error: ' + result.message);
                    }
                } catch (e) {
                    alert("Error updating event");
                }
            },
            error: function(error) {
                console.error("Error updating event:", error);
                alert("Error updating event: " + error.statusText);
            }
        });
    } else {
        // Create new event
        $.ajax({
            type: "POST",
            url: "events.aspx/CreateEventInDatabase",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({
                userId: currentUserId,
                title: eventData.title,
                description: eventData.description,
                eventType: eventData.eventType,
                eventDate: eventData.eventDate,
                startTime: eventData.startTime,
                endTime: eventData.endTime,
                location: eventData.location,
                registrationStatus: eventData.registrationStatus,
                registrationLink: eventData.registrationLink,
                contestLink: eventData.contestLink,
                isPublished: eventData.isPublished
            }),
            dataType: "json",
            success: function(response) {
                console.log("===== CreateEventInDatabase SUCCESS =====");
                console.log("Raw Response:", response);
                console.log("Response.d type:", typeof response.d);
                try {
                    // Check type compatibility dynamically
                    let result = typeof response.d === "string" ? JSON.parse(response.d) : response.d;
                    console.log("Parsed Result:", result);
                    console.log("Result.success:", result.success);
                    
                    if (result.success) {
                        console.log("✓ Event creation successful!");
                        alert('✓ ' + result.message);
                        
                        // Close the form
                        document.getElementById('eventManagementForm').style.display = 'none';
                        clearEventForm();
                        
                        // Wait a moment for DB to settle, then refresh
                        console.log("Waiting 1 second before refreshing events...");
                        setTimeout(function() {
                            console.log("NOW calling initializeEvents to refresh the list");
                            initializeEvents();
                        }, 1000);
                    } else {
                        console.error("✗ Event creation failed:", result.message);
                        alert('✗ Error: ' + result.message);
                    }
                } catch (e) {
                    console.error("Parsing breakdown:", e);
                    console.error("Response.d content:", response.d);
                    alert("Error creating event while evaluating database response. Check console.");
                }
            },
            error: function(error) {
                console.error("===== AJAX ERROR creating event =====");
                console.error("Error details:", error);
                console.error("Status:", error.status);
                console.error("StatusText:", error.statusText);
                console.error("ResponseText:", error.responseText);
                alert("ERROR creating event: " + error.status + " " + error.statusText + "\n\nCheck console for details.");
            }
        });
    }
    
    return true;
}

function getButtonText(eventType) {
    switch(eventType) {
        case 'normal': return 'Register Now';
        case 'team': return 'Register Team';
        case 'contest': return 'Join Contest';
        default: return 'Register';
    }
}

function getButtonUrl(event) {
    if (event.eventType === 'contest') {
        return event.contestLink;
    }
    return event.registrationLink;
}

function formatTime(timeString) {
    if (!timeString || timeString === '00:00:00') return '';
    try {
        const parts = timeString.split(':');
        const hour = parseInt(parts[0]);
        const min = parts[1];
        const ampm = hour >= 12 ? 'PM' : 'AM';
        const displayHour = hour % 12 || 12;
        return displayHour + ':' + min + ' ' + ampm;
    } catch (e) {
        return timeString;
    }
}

function normalizeTimeForInput(timeString) {
    if (!timeString) return '';
    const parts = timeString.split(':');
    if (parts.length >= 2) {
        return parts[0].padStart(2, '0') + ':' + parts[1].padStart(2, '0');
    }
    return timeString;
}

function escapeJsString(value) {
    return (value || '').replace(/\\/g, '\\\\').replace(/'/g, "\\'").replace(/\r?\n/g, ' ');
}

function formatDate(dateString) {
    try {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    } catch (e) {
        return dateString;
    }
}

function getCountdown(eventDate, startTime) {
    try {
        const eventDateTime = new Date(eventDate + 'T' + startTime);
        const now = new Date();
        const diff = eventDateTime - now;
        
        if (diff < 0) {
            return { status: 'ended' };
        }
        
        const days = Math.floor(diff / (1000 * 60 * 60 * 24));
        const hours = Math.floor((diff % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
        const minutes = Math.floor((diff % (1000 * 60 * 60)) / (1000 * 60));
        const seconds = Math.floor((diff % (1000 * 60)) / 1000);
        
        if (days === 0 && hours === 0 && minutes === 0 && seconds === 0) {
            return { status: 'started' };
        }
        
        return { 
            status: 'upcoming',
            days: days,
            hours: hours,
            minutes: minutes,
            seconds: seconds
        };
    } catch (e) {
        return { status: 'unknown' };
    }
}

function registerForEvent(eventId, externalUrl) {
    console.log("registerForEvent called for eventId:", eventId);

    if (!currentUserId) {
        alert("You must be logged in to register for events.");
        window.location.href = "login.aspx";
        return;
    }

    $.ajax({
        type: "POST",
        url: "events.aspx/RegisterForEvent",
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify({
            userId: currentUserId,
            eventId: eventId
        }),
        dataType: "json",
        success: function(response) {
            console.log("RegisterForEvent response:", response);
            try {
                let result = typeof response.d === "string" ? JSON.parse(response.d) : response.d;
                if (result.success) {
                    alert("Registered successfully.");
                    if (externalUrl) {
                        window.open(externalUrl, "_blank");
                    }
                } else {
                    alert(result.message);
                    if (externalUrl && result.message && result.message.indexOf("already registered") !== -1) {
                        window.open(externalUrl, "_blank");
                    }
                }
            } catch (e) {
                alert("Registration submitted");
                if (externalUrl) {
                    window.open(externalUrl, "_blank");
                }
            }
        },
        error: function(error) {
            console.error("Error registering:", error);
            alert("Error during registration");
        }
    });
}
function renderEventCard(event) {
    const countdown = getCountdown(event.eventDate, event.startTime);
    const isApproved = isApprovedTeamMember();
    
    const dateObj = new Date(event.eventDate);
    const day = String(dateObj.getDate()).padStart(2, '0');
    const month = dateObj.toLocaleDateString('en-US', { month: 'short' });
    
    let countdownHtml = '';
    if (countdown.status === 'upcoming') {
        countdownHtml = '<div class="event-countdown" data-event-id="' + event.id + '"><i class="fas fa-hourglass-half"></i> Starts in: <span class="countdown-text">' + countdown.days + 'd ' + countdown.hours + 'h ' + countdown.minutes + 'm</span></div>';
    } else if (countdown.status === 'started') {
        countdownHtml = '<div class="event-countdown event-started"><i class="fas fa-play"></i> Event Started</div>';
    } else {
        countdownHtml = '<div class="event-countdown event-ended"><i class="fas fa-flag-checkered"></i> Event Ended</div>';
    }
    
    let buttonHtml = '';
    let buttonDisabled = false;
    let buttonText = getButtonText(event.eventType);
    
    if (event.registrationStatus === 'closed') {
        buttonDisabled = true;
        buttonText = 'Registration Closed';
    } else if (event.registrationStatus === 'coming-soon') {
        buttonDisabled = true;
        buttonText = 'Coming Soon';
    } else {
        const buttonUrl = getButtonUrl(event);
        if (!buttonUrl && event.eventType !== 'normal') {
            buttonDisabled = true;
            buttonText = 'Link Not Available';
        }
    }
    
    if (buttonDisabled) {
        buttonHtml = '<button type="button" class="event-btn" disabled>' + buttonText + '</button>';
    } else {
        const url = getButtonUrl(event);
        if (url) {
            buttonHtml = '<button type="button" class="event-btn" onclick="registerForEvent(' + event.id + ', \'' + escapeJsString(url) + '\');">' + buttonText + '</button>';
        } else {
            buttonHtml = '<button type="button" class="event-btn" onclick="registerForEvent(' + event.id + ');">Register</button>';
        }
    }
    
    let draftBadge = '';
    if (isApproved && !event.isPublished) {
        draftBadge = '<span class="draft-badge">DRAFT</span>';
    }
    
    let managementHtml = '';
    if (isApproved) {
        managementHtml = '<div class="event-management-controls">' +
            '<button type="button" class="btn-edit" onclick="editEventClick(' + event.id + ');" title="Edit Event"><i class="fas fa-edit"></i> Edit</button>' +
            '<button type="button" class="btn-delete" onclick="deleteEventClick(' + event.id + ');" title="Delete Event"><i class="fas fa-trash"></i> Delete</button>' +
            '</div>';
    }
    
    const eventTypeLabel = event.eventType.charAt(0).toUpperCase() + event.eventType.slice(1);
    
    return '<div class="event-card" data-event-id="' + event.id + '">' +
        '<div class="event-date"><span class="date-day">' + day + '</span><span class="date-month">' + month + '</span></div>' +
        '<div class="event-content">' +
        '<div class="event-type-badge">' + eventTypeLabel + ' ' + draftBadge + '</div>' +
        '<h3>' + event.title + '</h3>' +
        '<p class="event-description">' + event.description + '</p>' +
        '<div class="event-meta">' +
        '<span><i class="fas fa-clock"></i> ' + formatTime(event.startTime) + ' - ' + formatTime(event.endTime) + '</span>' +
        '<span><i class="fas fa-map-pin"></i> ' + event.location + '</span>' +
        '</div>' +
        countdownHtml +
        '<div class="event-registration-status">Status: <strong>' + event.registrationStatus.charAt(0).toUpperCase() + event.registrationStatus.slice(1) + '</strong></div>' +
        buttonHtml +
        managementHtml +
        '</div></div>';
}

function renderAllEvents() {
    const container = document.getElementById('eventsContainer');
    console.log("renderAllEvents called, events count:", currentEvents.length);
    
    if (!container) {
        console.error("eventsContainer not found!");
        return;
    }
    
    if (currentEvents.length === 0) {
        container.innerHTML = '<p class="no-events">No events available.</p>';
        return;
    }
    
    let html = '';
    for (let i = 0; i < currentEvents.length; i++) {
        html += renderEventCard(currentEvents[i]);
    }
    
    container.innerHTML = html;
    updateAllCountdowns();
}

function updateAllCountdowns() {
    setInterval(function() {
        const elements = document.querySelectorAll('.event-countdown[data-event-id]');
        for (let i = 0; i < elements.length; i++) {
            const element = elements[i];
            const eventId = parseInt(element.getAttribute('data-event-id'));
            const event = currentEvents.find(function(e) { return e.id == eventId; });
            
            if (event) {
                const countdown = getCountdown(event.eventDate, event.startTime);
                if (countdown.status === 'upcoming') {
                    const countdownText = element.querySelector('.countdown-text');
                    if (countdownText) {
                        countdownText.textContent = countdown.days + 'd ' + countdown.hours + 'h ' + countdown.minutes + 'm';
                    }
                }
            }
        }
    }, 1000);
}

function toggleEventForm() {
    const form = document.getElementById('eventManagementForm');
    if (form) {
        const isVisible = form.style.display !== 'none';
        form.style.display = isVisible ? 'none' : 'block';
        if (!isVisible) {
            clearEventForm();
        }
    }
}

function clearEventForm() {
    const form = document.getElementById('eventForm');
    if (form) {
        form.removeAttribute('data-event-id');
    }
    const formTitle = document.getElementById('eventFormTitle');
    if (formTitle) {
        formTitle.textContent = 'Create Event';
    }
    const fields = document.querySelectorAll('#eventForm input, #eventForm textarea, #eventForm select');
    for (let i = 0; i < fields.length; i++) {
        fields[i].value = fields[i].tagName === 'SELECT' ? fields[i].querySelector('option').value : '';
    }
    const publishStatus = document.getElementById('publishStatus');
    if (publishStatus) {
        publishStatus.value = 'published';
    }
    const submitBtn = document.getElementById('saveEventBtn');
    if (submitBtn) {
        submitBtn.innerHTML = '<i class="fas fa-save"></i> Save Event';
    }
}

document.addEventListener('DOMContentLoaded', function() {
    console.log("DOMContentLoaded fired");
    console.log("isCurrentUserTeamMember:", isCurrentUserTeamMember);
    console.log("currentUserId:", currentUserId);
    
    const controls = document.getElementById('teamMemberControls');
    if (controls && isApprovedTeamMember()) {
        controls.style.display = 'block';
        console.log("Showing team member controls");
    }
    
    const createBtn = document.getElementById('createEventBtn');
    if (createBtn && !createBtn.hasAttribute('data-listener-attached')) {
        createBtn.addEventListener('click', function() {
            console.log("Create Event button clicked");
            if (!isApprovedTeamMember()) {
                alert("Only team members can create events.");
                return;
            }
            toggleEventForm();
        });
        createBtn.setAttribute('data-listener-attached', 'true');
    }
    
    const closeFormBtn = document.getElementById('closeFormBtn');
    if (closeFormBtn) {
        closeFormBtn.addEventListener('click', function() {
            document.getElementById('eventManagementForm').style.display = 'none';
            clearEventForm();
        });
    }
    
    const cancelBtn = document.getElementById('cancelEventBtn');
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function() {
            document.getElementById('eventManagementForm').style.display = 'none';
            clearEventForm();
        });
    }
    
    const saveEventBtn = document.getElementById('saveEventBtn');
    if (saveEventBtn) {
        saveEventBtn.addEventListener('click', function(e) {
            e.preventDefault();
            
            if (!document.getElementById('eventTitle').value ||
                !document.getElementById('eventDescription').value ||
                !document.getElementById('eventType').value ||
                !document.getElementById('eventLocation').value ||
                !document.getElementById('eventDate').value ||
                !document.getElementById('startTime').value ||
                !document.getElementById('endTime').value ||
                !document.getElementById('registrationStatus').value) {
                alert('Please fill in all required event fields.');
                return;
            }

            const eventData = {
                title: document.getElementById('eventTitle').value,
                description: document.getElementById('eventDescription').value,
                eventType: document.getElementById('eventType').value,
                eventDate: document.getElementById('eventDate').value,
                startTime: document.getElementById('startTime').value,
                endTime: document.getElementById('endTime').value,
                location: document.getElementById('eventLocation').value,
                registrationStatus: document.getElementById('registrationStatus').value,
                registrationLink: document.getElementById('registrationLink').value,
                contestLink: document.getElementById('contestLink').value,
                isPublished: document.getElementById('publishStatus').value === 'published'
            };
            
            if (eventData.eventType === 'contest' && !eventData.contestLink) {
                alert('Error: Contest events require a contest link!');
                return;
            }
            
            createEvent(eventData);
        });
    }
    
    console.log("Initial render...");
    initializeEvents();
});

// If DOM is already loaded, attach handlers immediately
// Otherwise, set up a listener for DOMContentLoaded
function setupHandlers() {
    const createBtn = document.getElementById('createEventBtn');
    if (createBtn) {
        // Check if listener already attached
        if (!createBtn.hasAttribute('data-listener-attached')) {
            createBtn.addEventListener('click', function() {
                console.log("Create Event button clicked");
                if (!isApprovedTeamMember()) {
                    alert("Only team members can create events.");
                    return;
                }
                toggleEventForm();
            });
            createBtn.setAttribute('data-listener-attached', 'true');
        }
    }
}

// Handle case where DOM is already loaded before events.js loads
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', setupHandlers);
} else {
    setupHandlers();
}

// Edit Event - populate form and show it for editing
function editEventClick(eventId) {
    const event = currentEvents.find(e => e.id === eventId.toString() || e.id == eventId);
    
    if (!event) {
        alert('Event not found');
        return;
    }
    
    if (!isApprovedTeamMember()) {
        alert('Only team members can edit events');
        return;
    }
    
    // Get the form element
    const eventForm = document.getElementById('eventForm');
    if (!eventForm) {
        alert('Event form not found in page');
        console.error('eventForm element not found');
        return;
    }
    
    // Populate the form with event data
    const titleField = document.getElementById('eventTitle');
    if (titleField) titleField.value = event.title;
    
    const descField = document.getElementById('eventDescription');
    if (descField) descField.value = event.description;
    
    const typeField = document.getElementById('eventType');
    if (typeField) typeField.value = event.eventType;
    
    const dateField = document.getElementById('eventDate');
    if (dateField) dateField.value = event.eventDate;
    
    const startField = document.getElementById('startTime');
    if (startField) startField.value = normalizeTimeForInput(event.startTime);
    
    const endField = document.getElementById('endTime');
    if (endField) endField.value = normalizeTimeForInput(event.endTime);
    
    const locField = document.getElementById('eventLocation');
    if (locField) locField.value = event.location;
    
    const regField = document.getElementById('registrationStatus');
    if (regField) regField.value = event.registrationStatus;
    
    const regLinkField = document.getElementById('registrationLink');
    if (regLinkField) regLinkField.value = event.registrationLink || '';
    
    const contestLinkField = document.getElementById('contestLink');
    if (contestLinkField) contestLinkField.value = event.contestLink || '';
    
    const pubField = document.getElementById('publishStatus');
    if (pubField) pubField.value = event.isPublished ? 'published' : 'unpublished';
    
    // Store event ID in form for submission
    eventForm.setAttribute('data-event-id', eventId);

    const saveBtn = document.getElementById('saveEventBtn');
    if (saveBtn) {
        saveBtn.innerHTML = '<i class="fas fa-save"></i> Update Event';
    }

    const formTitle = document.getElementById('eventFormTitle');
    if (formTitle) {
        formTitle.textContent = 'Edit Event';
    }
    
    // Show the form
    const formContainer = document.getElementById('eventManagementForm');
    if (formContainer) {
        formContainer.style.display = 'block';
        formContainer.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
}

// Delete Event - confirm and delete
function deleteEventClick(eventId) {
    const event = currentEvents.find(e => e.id === eventId.toString() || e.id == eventId);
    
    if (!event) {
        alert('Event not found');
        return;
    }
    
    if (!isApprovedTeamMember()) {
        alert('Only team members can delete events');
        return;
    }
    
    if (confirm('Are you sure you want to delete "' + event.title + '"? This action cannot be undone.')) {
        $.ajax({
            type: 'POST',
            url: 'events.aspx/DeleteEvent',
            data: JSON.stringify({
                userId: currentUserId,
                eventId: eventId
            }),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            success: function(response) {
                console.log("Delete response:", response);
                const result = typeof response.d === 'string' ? JSON.parse(response.d) : response.d;
                
                if (result.success) {
                    alert('✓ Event deleted successfully!');
                    // Remove from currentEvents array
                    currentEvents = currentEvents.filter(e => e.id !== eventId.toString() && e.id != eventId);
                    // Re-render
                    renderAllEvents();
                } else {
                    alert('Error: ' + result.message);
                }
            },
            error: function(err) {
                console.log("Delete error:", err);
                alert('Error deleting event: ' + err.statusText);
            }
        });
    }
}
