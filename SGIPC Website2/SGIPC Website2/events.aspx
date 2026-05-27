<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="events.aspx.cs" Inherits="SGIPC_Website2.events" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SGIPC - Events</title>
    <link rel="stylesheet" href="Content2/index.css" />
    <link rel="stylesheet" href="Content2/events.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>

<body>
    <form id="form2" runat="server">

        <!-- Fixed Header -->
        <header class="header">
            <div class="brand-box">
                <img src="Images2/sgipc_logo.png" alt="SGIPC Logo" class="club-logo" />
                <div class="brand-divider"></div>
                <div class="brand-text">
                    <h1>SGIPC</h1>
                    <p>Programming Club</p>
                </div>
            </div>
            <div class="auth-links">
                <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="true">
                    <a href="login.aspx">Login</a>
                    <a href="register.aspx">Register</a>
                </asp:Panel>
                <asp:Panel ID="pnlLoggedIn" runat="server" Visible="false">
                    <span style="color: white; margin-right: 15px;">Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                    <a href="logout.aspx">Logout</a>
                </asp:Panel>
            </div>
        </header>

        <!-- Hamburger Menu -->
        <input type="checkbox" id="hamburger-toggle" class="hamburger-toggle" />
        <label for="hamburger-toggle" class="hamburger">
            <span class="menu-text">MENU</span>
            <span class="menu-dots">
                <span></span>
                <span></span>
                <span></span>
            </span>
            <span class="close-icon">Close <i class="fas fa-times"></i></span>
        </label>

        <!-- Sidebar Navigation -->
        <aside class="sidebar">
            <div class="sidebar-brand">
                <img src="Images2/sgipc_logo.png" alt="SGIPC Logo" />
                <div>
                    <h3>SGIPC</h3>
                    <p>Explore Club</p>
                </div>
            </div>
            <div class="sidebar-search">
                <i class="fas fa-search"></i>
                <input type="text" id="menuSearch" placeholder="Search" />
                <i class="fas fa-sliders"></i>
            </div>
            <p class="sidebar-title">MENU</p>
            <nav class="sidebar-nav">
                <a href="index.aspx" class="sidebar-link">
                    <i class="fas fa-home"></i>
                    <span>Home</span>
                </a>
                <a href="about.aspx" class="sidebar-link">
                    <i class="fas fa-circle-info"></i>
                    <span>About</span>
                </a>
                <a href="events.aspx" class="sidebar-link active">
                    <i class="fas fa-calendar"></i>
                    <span>Events</span>
                </a>
                <a href="gallery.aspx" class="sidebar-link">
                    <i class="fas fa-images"></i>
                    <span>Gallery</span>
                </a>
                <a href="team.aspx" class="sidebar-link">
                    <i class="fas fa-people-group"></i>
                    <span>Team</span>
                </a>
                <a href="member.aspx" class="sidebar-link">
                    <i class="fas fa-users"></i>
                    <span>Members</span>
                </a>
            </nav>
            <div class="sidebar-auth">
                <asp:Panel ID="pnlSidebarNotLoggedIn" runat="server" Visible="true">
                    <a href="login.aspx">Login</a>
                    <a href="register.aspx">Register</a>
                </asp:Panel>
                <asp:Panel ID="pnlSidebarLoggedIn" runat="server" Visible="false">
                    <asp:Label ID="lblSidebarUserName" runat="server" style="display: block; color: #672aa1; font-weight: bold; margin-bottom: 10px;"></asp:Label>
                    <a href="logout.aspx" style="background-color: #dc3545; color: white; padding: 8px; border-radius: 5px; display: inline-block;">Logout</a>
                </asp:Panel>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="content">
            <!-- Page Header -->
            <section class="page-header">
                <h1>Upcoming Events</h1>
                <p>Join us for exciting workshops and competitions</p>
                <!-- Management Controls for Approved Team Members -->
                <div id="teamMemberControls" style="display: none; margin-top: 20px;">
                    <button id="createEventBtn" type="button" class="event-manage-btn">
                        <i class="fas fa-plus"></i> Create Event
                    </button>
                </div>
            </section>

            <!-- Event Management Form (Hidden by default) -->
            <section id="eventManagementForm" class="event-management-section" style="display: none;">
                <div class="management-container">
                    <div class="form-header">
                        <h2 id="eventFormTitle">Create Event</h2>
                        <button type="button" id="closeFormBtn" class="close-form-btn" title="Close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <div id="eventForm" class="event-form">
                        <!-- Basic Information Section -->
                        <div class="form-section">
                            <h3 class="section-title">Event Details</h3>
                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="eventTitle">Event Title <span class="required">*</span></label>
                                    <input type="text" id="eventTitle" name="eventTitle" placeholder="e.g., Algorithm Bootcamp" required />
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="eventDescription">Description <span class="required">*</span></label>
                                    <textarea id="eventDescription" name="eventDescription" placeholder="Provide a detailed description of the event..." required rows="5"></textarea>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="eventType">Event Type <span class="required">*</span></label>
                                    <select id="eventType" name="eventType" required>
                                        <option value="">Select Type</option>
                                        <option value="normal">Normal Event</option>
                                        <option value="team">Team Event</option>
                                        <option value="contest">Contest</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="eventLocation">Location <span class="required">*</span></label>
                                    <input type="text" id="eventLocation" name="eventLocation" placeholder="e.g., Main Hall / Online" required />
                                </div>
                            </div>
                        </div>

                        <!-- Date and Time Section -->
                        <div class="form-section">
                            <h3 class="section-title">Date & Time</h3>
                            <div class="form-row three-cols">
                                <div class="form-group">
                                    <label for="eventDate">Event Date <span class="required">*</span></label>
                                    <input type="date" id="eventDate" name="eventDate" required />
                                    <small class="form-hint">Select the date when the event will occur</small>
                                </div>
                                <div class="form-group">
                                    <label for="startTime">Start Time <span class="required">*</span></label>
                                    <input type="time" id="startTime" name="startTime" required />
                                    <small class="form-hint">When the event starts</small>
                                </div>
                                <div class="form-group">
                                    <label for="endTime">End Time <span class="required">*</span></label>
                                    <input type="time" id="endTime" name="endTime" required />
                                    <small class="form-hint">When the event ends</small>
                                </div>
                            </div>
                        </div>

                        <!-- Registration Section -->
                        <div class="form-section">
                            <h3 class="section-title">Registration & Links</h3>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="registrationStatus">Registration Status <span class="required">*</span></label>
                                    <select id="registrationStatus" name="registrationStatus" required>
                                        <option value="">Select Status</option>
                                        <option value="open">Open</option>
                                        <option value="closed">Closed</option>
                                        <option value="coming-soon">Coming Soon</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="registrationLink">Registration Link</label>
                                    <input type="url" id="registrationLink" name="registrationLink" placeholder="https://forms.gle/..." />
                                    <small class="form-hint">Google Form or registration page link</small>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="contestLink">
                                        <i class="fas fa-trophy"></i> Contest/Judge Link
                                    </label>
                                    <input type="url" id="contestLink" name="contestLink" placeholder="https://vjudge.net/contest/... or https://codeforces.com/..." />
                                    <small class="form-hint">Link to online judge or contest platform (for contests only)</small>
                                </div>
                            </div>
                        </div>

                        <!-- Publication Section -->
                        <div class="form-section">
                            <h3 class="section-title">Publication</h3>
                            <div class="form-row">
                                <div class="form-group full-width">
                                    <label for="publishStatus">Publish Status <span class="required">*</span></label>
                                    <select id="publishStatus" name="publishStatus" required>
                                        <option value="published">Published</option>
                                        <option value="unpublished">Unpublished (Draft)</option>
                                    </select>
                                    <small class="form-hint">Published events are visible to all members</small>
                                </div>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="saveEventBtn" class="btn-primary">
                                <i class="fas fa-save"></i> Save Event
                            </button>
                            <button type="button" id="cancelEventBtn" class="btn-secondary">
                                <i class="fas fa-times"></i> Cancel
                            </button>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Events Grid -->
            <section class="events-section" id="eventsContainer">
                <!-- Dynamic events will be loaded here by JavaScript -->
            </section>

        </main>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2026 SGIPC. All rights reserved.</p>
        </footer>

    </form>

    <!-- jQuery Library for AJAX calls -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="Scripts2/index.js"></script>
    <script src="Scripts2/events.js?v=event-registration-dashboard-20260527"></script>
</body>
</html>
