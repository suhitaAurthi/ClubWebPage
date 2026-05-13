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
                <a href="login.aspx">Login</a>
                <a href="register.aspx">Register</a>
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
                <a href="login.aspx">Login</a>
                <a href="register.aspx">Register</a>
            </div>
        </aside>

        <!-- Main Content -->
        <main class="content">
            <!-- Page Header -->
            <section class="page-header">
                <h1>Upcoming Events</h1>
                <p>Join us for exciting workshops and competitions</p>
            </section>

            <!-- Events Grid -->
            <section class="events-section">
                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">22</span>
                        <span class="date-month">May</span>
                    </div>
                    <div class="event-content">
                        <h3>Algorithm Bootcamp</h3>
                        <p class="event-description">
                            Master advanced algorithms and data structures. Learn sorting, graph theory, dynamic programming and more.
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 2:00 PM - 5:00 PM</span>
                            <span><i class="fas fa-map-pin"></i> Main Hall</span>
                        </div>
                        <button class="event-btn">Register Now</button>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">29</span>
                        <span class="date-month">May</span>
                    </div>
                    <div class="event-content">
                        <h3>Weekly Contest</h3>
                        <p class="event-description">
                            Test your skills in our weekly competitive programming contest. Compete with peers and climb the leaderboard.
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 6:00 PM - 8:00 PM</span>
                            <span><i class="fas fa-map-pin"></i> Online</span>
                        </div>
                        <button class="event-btn">Join Contest</button>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">05</span>
                        <span class="date-month">Jun</span>
                    </div>
                    <div class="event-content">
                        <h3>Industry Expert Talk</h3>
                        <p class="event-description">
                            Learn from professionals working at leading tech companies. Gain insights into career development and opportunities.
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 3:00 PM - 4:30 PM</span>
                            <span><i class="fas fa-map-pin"></i> Auditorium</span>
                        </div>
                        <button class="event-btn">Register Now</button>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">12</span>
                        <span class="date-month">Jun</span>
                    </div>
                    <div class="event-content">
                        <h3>Web Development Workshop</h3>
                        <p class="event-description">
                            Learn modern web development with HTML, CSS, and JavaScript. Build responsive web applications from scratch.
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 2:00 PM - 5:00 PM</span>
                            <span><i class="fas fa-map-pin"></i> Lab A</span>
                        </div>
                        <button class="event-btn">Register Now</button>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">19</span>
                        <span class="date-month">Jun</span>
                    </div>
                    <div class="event-content">
                        <h3>Team Hackathon</h3>
                        <p class="event-description">
                            24-hour hackathon event where teams collaborate to build innovative solutions. Code, create, and compete!
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 10:00 AM - 10:00 AM (Next Day)</span>
                            <span><i class="fas fa-map-pin"></i> Main Campus</span>
                        </div>
                        <button class="event-btn">Register Team</button>
                    </div>
                </div>

                <div class="event-card">
                    <div class="event-date">
                        <span class="date-day">26</span>
                        <span class="date-month">Jun</span>
                    </div>
                    <div class="event-content">
                        <h3>Code Review Session</h3>
                        <p class="event-description">
                            Get your code reviewed by experienced developers. Learn best practices and improve your programming skills.
                        </p>
                        <div class="event-meta">
                            <span><i class="fas fa-clock"></i> 4:00 PM - 6:00 PM</span>
                            <span><i class="fas fa-map-pin"></i> Meeting Room 3</span>
                        </div>
                        <button class="event-btn">Register Now</button>
                    </div>
                </div>
            </section>

        </main>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2026 SGIPC. All rights reserved.</p>
        </footer>

    </form>

    <script src="Scripts2/index.js"></script>
</body>
</html>
