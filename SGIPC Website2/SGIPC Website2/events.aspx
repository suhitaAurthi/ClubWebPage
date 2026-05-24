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
                    <button id="createEventBtn" class="event-manage-btn">
                        <i class="fas fa-plus"></i> Create Event
                    </button>
                </div>
            </section>

            <!-- Event Management Form (Hidden by default) -->
            <section id="eventManagementForm" class="event-management-section" style="display: none;">
                <div class="management-container">
                    <h2>Create/Edit Event</h2>
                    <form id="eventForm" class="event-form">
                        <div class="form-row">
                            <div class="form-group">
                                <label for="eventTitle">Event Title <span class="required">*</span></label>
                                <input type="text" id="eventTitle" placeholder="e.g., Algorithm Bootcamp" required />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="eventDescription">Description <span class="required">*</span></label>
                                <textarea id="eventDescription" placeholder="Event description..." required rows="4"></textarea>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="eventType">Event Type <span class="required">*</span></label>
                                <select id="eventType" required>
                                    <option value="">Select Type</option>
                                    <option value="normal">Normal Event</option>
                                    <option value="team">Team Event</option>
                                    <option value="contest">Contest</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="eventDate">Event Date <span class="required">*</span></label>
                                <input type="date" id="eventDate" required />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="startTime">Start Time <span class="required">*</span></label>
                                <input type="time" id="startTime" required />
                            </div>
                            <div class="form-group">
                                <label for="endTime">End Time <span class="required">*</span></label>
                                <input type="time" id="endTime" required />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="eventLocation">Location <span class="required">*</span></label>
                                <input type="text" id="eventLocation" placeholder="e.g., Main Hall" required />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="registrationStatus">Registration Status <span class="required">*</span></label>
                                <select id="registrationStatus" required>
                                    <option value="">Select Status</option>
                                    <option value="open">Open</option>
                                    <option value="closed">Closed</option>
                                    <option value="coming-soon">Coming Soon</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="registrationLink">Registration Link</label>
                                <input type="url" id="registrationLink" placeholder="https://forms.gle/..." />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="contestLink">Contest Link</label>
                                <input type="url" id="contestLink" placeholder="https://vjudge.net/..." />
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="publishStatus">Publish Status <span class="required">*</span></label>
                                <select id="publishStatus" required>
                                    <option value="published">Published</option>
                                    <option value="unpublished">Unpublished</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn-primary">Save Event</button>
                            <button type="button" id="cancelEventBtn" class="btn-secondary">Cancel</button>
                        </div>
                    </form>
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

    <script src="Scripts2/index.js"></script>
    <script src="Scripts2/events.js"></script>
</body>
</html>
