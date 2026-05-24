// ==========================================
// SGIPC Event Management System
// Front-end only - uses localStorage for data
// ==========================================

console.log("events.js loaded");

// Approved Team Members - Only these can create/manage events
const approvedTeamMembers = [
    { name: "Nilay Das", email: "nilay@stud.kuet.ac.bd", role: "President" },
    { name: "Md. Tanjimul Hasan", email: "tanjimul@stud.kuet.ac.bd", role: "Vice President" },
    { name: "Shah Md Khalil Ullah", email: "khalil@stud.kuet.ac.bd", role: "Vice President" },
    { name: "Khadimul Islam Mahi", email: "mahi@stud.kuet.ac.bd", role: "General Secretary" },
    { name: "Mohammad Abu Daud Sharif", email: "sharif@stud.kuet.ac.bd", role: "Assistant General Secretary" },
    { name: "Md Umar Faruk", email: "faruk@stud.kuet.ac.bd", role: "Treasurer" },
    { name: "Amit Kairy", email: "amit@stud.kuet.ac.bd", role: "Organizing Secretary" },
    { name: "Md. Ashraful Haque Sifat", email: "sifat@stud.kuet.ac.bd", role: "Organizing Secretary" },
    { name: "Siam Arif", email: "siam@stud.kuet.ac.bd", role: "Assistant Organizing Secretary" },
    { name: "Siyam Khan", email: "siyam@stud.kuet.ac.bd", role: "Assistant Organizing Secretary" }
];

// Current logged-in user (simulated)
// TODO: Replace with actual user data from backend when available
const currentUser = {
    name: "Nilay Das",
    email: "nilay@stud.kuet.ac.bd"
};

// Check if current user is an approved team member
function isApprovedTeamMember() {
    return approvedTeamMembers.some(member =>
        member.email.toLowerCase() === currentUser.email.toLowerCase()
    );
}

// Initialize events from localStorage or use default events
function initializeEvents() {
    const storedEvents = localStorage.getItem('sgipcEvents');
    
    if (storedEvents) {
        return JSON.parse(storedEvents);
    }
    
    // Default seed events
    const defaultEvents = [
        {
            id: 1,
            title: "Algorithm Bootcamp",
            description: "Master advanced algorithms and data structures. Learn sorting, graph theory, dynamic programming and more.",
            eventType: "normal",
            eventDate: "2026-05-22",
            startTime: "14:00",
            endTime: "17:00",
            location: "Main Hall",
            registrationStatus: "open",
            registrationLink: "https://forms.gle/algorithm-bootcamp",
            contestLink: "",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        },
        {
            id: 2,
            title: "Weekly Contest",
            description: "Test your skills in our weekly competitive programming contest. Compete with peers and climb the leaderboard.",
            eventType: "contest",
            eventDate: "2026-05-29",
            startTime: "18:00",
            endTime: "20:00",
            location: "Online",
            registrationStatus: "open",
            registrationLink: "",
            contestLink: "https://vjudge.net/contest/example",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        },
        {
            id: 3,
            title: "Industry Expert Talk",
            description: "Learn from professionals working at leading tech companies. Gain insights into career development and opportunities.",
            eventType: "normal",
            eventDate: "2026-06-05",
            startTime: "15:00",
            endTime: "16:30",
            location: "Auditorium",
            registrationStatus: "open",
            registrationLink: "https://forms.gle/expert-talk",
            contestLink: "",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        },
        {
            id: 4,
            title: "Web Development Workshop",
            description: "Learn modern web development with HTML, CSS, and JavaScript. Build responsive web applications from scratch.",
            eventType: "normal",
            eventDate: "2026-06-12",
            startTime: "14:00",
            endTime: "17:00",
            location: "Lab A",
            registrationStatus: "open",
            registrationLink: "https://forms.gle/web-dev-workshop",
            contestLink: "",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        },
        {
            id: 5,
            title: "Team Hackathon",
            description: "24-hour hackathon event where teams collaborate to build innovative solutions. Code, create, and compete!",
            eventType: "team",
            eventDate: "2026-06-19",
            startTime: "10:00",
            endTime: "22:00",
            location: "Main Campus",
            registrationStatus: "open",
            registrationLink: "https://forms.gle/hackathon-team",
            contestLink: "",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        },
        {
            id: 6,
            title: "Code Review Session",
            description: "Get your code reviewed by experienced developers. Learn best practices and improve your programming skills.",
            eventType: "normal",
            eventDate: "2026-06-26",
            startTime: "16:00",
            endTime: "18:00",
            location: "Meeting Room 3",
            registrationStatus: "open",
            registrationLink: "https://forms.gle/code-review",
            contestLink: "",
            isPublished: true,
            createdByEmail: "nilay@stud.kuet.ac.bd"
        }
    ];
    
    saveEvents(defaultEvents);
    return defaultEvents;
}

// Get all events
function getAllEvents() {
    return initializeEvents();
}

// Get only published events
function getPublishedEvents() {
    return getAllEvents().filter(event => event.isPublished);
}

// Save events to localStorage
function saveEvents(events) {
    try {
        const jsonString = JSON.stringify(events);
        console.log("Saving events to localStorage, count:", events.length, "data:", jsonString);
        localStorage.setItem('sgipcEvents', jsonString);
        console.log("Events saved successfully to localStorage");
    } catch (error) {
        console.error("Error saving events:", error);
        alert("Error saving events: " + error.message);
    }
}

// Create new event
function createEvent(eventData) {
    console.log("createEvent called with:", eventData);
    console.log("isApprovedTeamMember:", isApprovedTeamMember());
    console.log("currentUser:", currentUser);
    
    if (!isApprovedTeamMember()) {
        alert("You are not authorized to create events. Current email: " + currentUser.email);
        return false;
    }
    
    const events = getAllEvents();
    const newId = Math.max(0, ...events.map(e => e.id)) + 1;
    
    const newEvent = {
        id: newId,
        ...eventData,
        createdByEmail: currentUser.email
    };
    
    console.log("Created event:", newEvent);
    
    events.push(newEvent);
    saveEvents(events);
    console.log("Events after save:", getAllEvents());
    return true;
}

// Edit event
function editEvent(eventId, eventData) {
    if (!isApprovedTeamMember()) {
        alert("You are not authorized to edit events.");
        return false;
    }
    
    const events = getAllEvents();
    const event = events.find(e => e.id === eventId);
    
    if (!event) {
        alert("Event not found.");
        return false;
    }
    
    // Update event properties
    Object.assign(event, eventData);
    saveEvents(events);
    return true;
}

// Delete event
function deleteEvent(eventId) {
    if (!isApprovedTeamMember()) {
        alert("You are not authorized to delete events.");
        return false;
    }
    
    let events = getAllEvents();
    events = events.filter(e => e.id !== eventId);
    saveEvents(events);
    return true;
}

// Publish/Unpublish event
function publishEvent(eventId, isPublished) {
    if (!isApprovedTeamMember()) {
        alert("You are not authorized to publish events.");
        return false;
    }
    
    const events = getAllEvents();
    const event = events.find(e => e.id === eventId);
    
    if (!event) {
        alert("Event not found.");
        return false;
    }
    
    event.isPublished = isPublished;
    saveEvents(events);
    return true;
}

// Get button text based on event type
function getButtonText(eventType) {
    switch(eventType) {
        case 'normal': return 'Register Now';
        case 'team': return 'Register Team';
        case 'contest': return 'Join Contest';
        default: return 'Register';
    }
}

// Get button action URL
function getButtonUrl(event) {
    if (event.eventType === 'contest') {
        return event.contestLink;
    }
    return event.registrationLink;
}

// Format time to HH:MM
function formatTime(timeString) {
    if (!timeString) return '';
    const [hours, minutes] = timeString.split(':');
    const hour = parseInt(hours);
    const min = minutes;
    const ampm = hour >= 12 ? 'PM' : 'AM';
    const displayHour = hour % 12 || 12;
    return `${displayHour}:${min} ${ampm}`;
}

// Format date to readable format
function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
}

// Get countdown until event starts
function getCountdown(eventDate, startTime) {
    const eventDateTime = new Date(eventDate + 'T' + startTime);
    const now = new Date();
    const diff = eventDateTime - now;
    
    if (diff < 0) {
        // Check if event has ended
        const endTime = new Date(eventDate + 'T' + startTime);
        // Assume 3 hours is standard event duration if we don't have end time
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
}

// Render a single event card
function renderEventCard(event) {
    const countdown = getCountdown(event.eventDate, event.startTime);
    const isApproved = isApprovedTeamMember();
    const isOwnEvent = event.createdByEmail === currentUser.email;
    
    const dateObj = new Date(event.eventDate);
    const day = dateObj.getDate().toString().padStart(2, '0');
    const month = dateObj.toLocaleDateString('en-US', { month: 'short' });
    
    let countdownHtml = '';
    if (countdown.status === 'upcoming') {
        countdownHtml = `<div class="event-countdown" data-event-id="${event.id}">
            <i class="fas fa-hourglass-half"></i>
            Starts in: <span class="countdown-text">${countdown.days}d ${countdown.hours}h ${countdown.minutes}m ${countdown.seconds}s</span>
        </div>`;
    } else if (countdown.status === 'started') {
        countdownHtml = `<div class="event-countdown event-started">
            <i class="fas fa-play"></i>
            Event Started
        </div>`;
    } else {
        countdownHtml = `<div class="event-countdown event-ended">
            <i class="fas fa-flag-checkered"></i>
            Event Ended
        </div>`;
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
        // Check if required link exists
        const buttonUrl = getButtonUrl(event);
        if (!buttonUrl) {
            buttonDisabled = true;
            buttonText = 'Link Not Available';
        }
    }
    
    if (buttonDisabled) {
        buttonHtml = `<button class="event-btn" disabled>${buttonText}</button>`;
    } else {
        const url = getButtonUrl(event);
        buttonHtml = `<button class="event-btn" onclick="window.open('${url}', '_blank');">${buttonText}</button>`;
    }
    
    let managementHtml = '';
    if (isApproved && isOwnEvent) {
        managementHtml = `
            <div class="event-management-controls">
                <button class="btn-edit" onclick="editEventClick(${event.id});" title="Edit Event">
                    <i class="fas fa-edit"></i> Edit
                </button>
                <button class="btn-delete" onclick="deleteEventClick(${event.id});" title="Delete Event">
                    <i class="fas fa-trash"></i> Delete
                </button>
                ${event.isPublished ? 
                    `<button class="btn-unpublish" onclick="unpublishEventClick(${event.id});" title="Unpublish Event">
                        <i class="fas fa-eye-slash"></i> Unpublish
                    </button>` :
                    `<button class="btn-publish" onclick="publishEventClick(${event.id});" title="Publish Event">
                        <i class="fas fa-eye"></i> Publish
                    </button>`
                }
            </div>
        `;
    }
    
    const eventTypeLabel = event.eventType.charAt(0).toUpperCase() + event.eventType.slice(1);
    
    return `
        <div class="event-card" data-event-id="${event.id}">
            <div class="event-date">
                <span class="date-day">${day}</span>
                <span class="date-month">${month}</span>
            </div>
            <div class="event-content">
                <div class="event-type-badge">${eventTypeLabel}</div>
                <h3>${event.title}</h3>
                <p class="event-description">
                    ${event.description}
                </p>
                <div class="event-meta">
                    <span><i class="fas fa-clock"></i> ${formatTime(event.startTime)} - ${formatTime(event.endTime)}</span>
                    <span><i class="fas fa-map-pin"></i> ${event.location}</span>
                </div>
                ${countdownHtml}
                <div class="event-registration-status">
                    Status: <strong>${event.registrationStatus.charAt(0).toUpperCase() + event.registrationStatus.slice(1)}</strong>
                </div>
                ${buttonHtml}
                ${managementHtml}
            </div>
        </div>
    `;
}

// Render all events to the page
function renderAllEvents() {
    const container = document.getElementById('eventsContainer');
    console.log("renderAllEvents called, container:", container);
    
    if (!container) {
        console.error("eventsContainer not found!");
        return;
    }
    
    const eventsToShow = isApprovedTeamMember() ? getAllEvents() : getPublishedEvents();
    console.log("Events to show:", eventsToShow);
    
    if (eventsToShow.length === 0) {
        console.log("No events to show");
        container.innerHTML = '<p class="no-events">No events available.</p>';
        return;
    }
    
    const html = eventsToShow
        .map(event => renderEventCard(event))
        .join('');
    
    console.log("Rendered HTML length:", html.length);
    container.innerHTML = html;
    
    // Attach countdown update intervals
    updateAllCountdowns();
}

// Update countdown timers every second
function updateAllCountdowns() {
    setInterval(() => {
        const countdownElements = document.querySelectorAll('.event-countdown[data-event-id]');
        countdownElements.forEach(element => {
            const eventId = parseInt(element.getAttribute('data-event-id'));
            const event = getAllEvents().find(e => e.id === eventId);
            
            if (event) {
                const countdown = getCountdown(event.eventDate, event.startTime);
                
                if (countdown.status === 'upcoming') {
                    const countdownText = element.querySelector('.countdown-text');
                    if (countdownText) {
                        countdownText.textContent = 
                            `${countdown.days}d ${countdown.hours}h ${countdown.minutes}m ${countdown.seconds}s`;
                    }
                }
            }
        });
    }, 1000);
}

// UI Event Handlers

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
        form.reset();
        form.removeAttribute('data-event-id');
    }
    const submitBtn = document.querySelector('#eventForm button[type="submit"]');
    if (submitBtn) {
        submitBtn.textContent = 'Save Event';
    }
}

function editEventClick(eventId) {
    const event = getAllEvents().find(e => e.id === eventId);
    if (!event) return;
    
    // Populate form with event data
    document.getElementById('eventTitle').value = event.title;
    document.getElementById('eventDescription').value = event.description;
    document.getElementById('eventType').value = event.eventType;
    document.getElementById('eventDate').value = event.eventDate;
    document.getElementById('startTime').value = event.startTime;
    document.getElementById('endTime').value = event.endTime;
    document.getElementById('eventLocation').value = event.location;
    document.getElementById('registrationStatus').value = event.registrationStatus;
    document.getElementById('registrationLink').value = event.registrationLink;
    document.getElementById('contestLink').value = event.contestLink;
    document.getElementById('publishStatus').value = event.isPublished ? 'published' : 'unpublished';
    
    // Mark form for editing
    document.getElementById('eventForm').setAttribute('data-event-id', eventId);
    document.querySelector('#eventForm button[type="submit"]').textContent = 'Update Event';
    
    // Show form
    document.getElementById('eventManagementForm').style.display = 'block';
}

function deleteEventClick(eventId) {
    if (confirm('Are you sure you want to delete this event?')) {
        if (deleteEvent(eventId)) {
            renderAllEvents();
        }
    }
}

function publishEventClick(eventId) {
    if (publishEvent(eventId, true)) {
        renderAllEvents();
    }
}

function unpublishEventClick(eventId) {
    if (publishEvent(eventId, false)) {
        renderAllEvents();
    }
}

// Initialize on page load
document.addEventListener('DOMContentLoaded', function() {
    console.log("DOMContentLoaded fired");
    console.log("isApprovedTeamMember():", isApprovedTeamMember());
    
    // Show management controls if approved team member
    const controls = document.getElementById('teamMemberControls');
    console.log("teamMemberControls element:", controls);
    
    if (controls && isApprovedTeamMember()) {
        controls.style.display = 'block';
        console.log("Showing team member controls");
    } else {
        console.log("NOT showing team member controls");
    }
    
    // Set up event listeners
    const createBtn = document.getElementById('createEventBtn');
    console.log("createEventBtn element:", createBtn);
    
    if (createBtn) {
        createBtn.addEventListener('click', function() {
            console.log("Create Event button clicked");
            toggleEventForm();
        });
        console.log("Event listener attached to createBtn");
    }
    
    const cancelBtn = document.getElementById('cancelEventBtn');
    if (cancelBtn) {
        cancelBtn.addEventListener('click', function() {
            console.log("Cancel button clicked");
            document.getElementById('eventManagementForm').style.display = 'none';
            clearEventForm();
        });
    }
    
    // Handle form submission
    const eventForm = document.getElementById('eventForm');
    console.log("eventForm element:", eventForm);
    
    if (eventForm) {
        eventForm.addEventListener('submit', function(e) {
            e.preventDefault();
            console.log("Form submitted");
            
            const eventId = this.getAttribute('data-event-id');
            console.log("eventId from form:", eventId);
            
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
            
            console.log("eventData:", eventData);
            
            let success = false;
            if (eventId) {
                // Edit existing event
                console.log("Editing event:", eventId);
                success = editEvent(parseInt(eventId), eventData);
                if (success) alert('Event updated successfully!');
            } else {
                // Create new event
                console.log("Creating new event");
                success = createEvent(eventData);
                if (success) alert('Event created successfully!');
            }
            
            console.log("success:", success);
            
            if (success) {
                document.getElementById('eventManagementForm').style.display = 'none';
                clearEventForm();
                renderAllEvents();
            }
        });
        console.log("Event listener attached to form submission");
    }
    
    // Initial render
    console.log("Initial render...");
    renderAllEvents();
});
