<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="gallery.aspx.cs" Inherits="SGIPC_Website2.gallery" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SGIPC - Gallery</title>
    <link rel="stylesheet" href="Content2/index.css" />
    <link rel="stylesheet" href="Content2/gallery.css" />
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
                <a href="events.aspx" class="sidebar-link">
                    <i class="fas fa-calendar"></i>
                    <span>Events</span>
                </a>
                <a href="gallery.aspx" class="sidebar-link active">
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
                <h1>Gallery</h1>
                <p>Explore our club's achievements, events, and memorable moments</p>
            </section>

            <!-- Achievements Section -->
            <section class="gallery-section">
                <h2>Achievements</h2>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv.jpg" alt="Achievement" />
                            <div class="gallery-overlay">
                                <h4>Best Programming Club Award</h4>
                                <p>Excellence in technical training and innovation</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv2.jpg" alt="Achievement 2" />
                            <div class="gallery-overlay">
                                <h4>National Coding Championship</h4>
                                <p>1st place in regional competition</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv3.jpg" alt="Achievement 3" />
                            <div class="gallery-overlay">
                                <h4>Members Published Papers</h4>
                                <p>Research contributions recognized internationally</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv4.jpg" alt="Achievement 4" />
                            <div class="gallery-overlay">
                                <h4>Algorithm Mastery Certificate</h4>
                                <p>Training completion milestone reached</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv5.jpg" alt="Achievement 5" />
                            <div class="gallery-overlay">
                                <h4>Community Service Recognition</h4>
                                <p>Outstanding contribution to tech education</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv6.jpg" alt="Achievement 6" />
                            <div class="gallery-overlay">
                                <h4>Innovation Excellence Award</h4>
                                <p>Pioneering solutions in technology</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv7.jpg" alt="Achievement 7" />
                            <div class="gallery-overlay">
                                <h4>Student Leadership Recognition</h4>
                                <p>Exemplary leadership and mentorship</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Workshop Events Section -->
            <section class="gallery-section">
                <h2>Workshop Events</h2>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/ws1.jpg" alt="Workshop 1" />
                            <div class="gallery-overlay">
                                <h4>Web Development Workshop</h4>
                                <p>Hands-on training with React and Node.js</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/ws2.jpg" alt="Workshop 2" />
                            <div class="gallery-overlay">
                                <h4>Machine Learning Bootcamp</h4>
                                <p>Introduction to AI and neural networks</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/ws3.jpg" alt="Workshop 3" />
                            <div class="gallery-overlay">
                                <h4>Competitive Programming Course</h4>
                                <p>Algorithm optimization and problem solving</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/ws4.jpg" alt="Workshop 4" />
                            <div class="gallery-overlay">
                                <h4>Database Design Mastery</h4>
                                <p>SQL optimization and database architecture</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Team Events Section -->
            <section class="gallery-section">
                <h2>Team Events</h2>
                <div class="gallery-grid">
                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv4.jpg" alt="Team Event 1" />
                            <div class="gallery-overlay">
                                <h4>Team Building Activity</h4>
                                <p>Members bonding and networking session</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv5.jpg" alt="Team Event 2" />
                            <div class="gallery-overlay">
                                <h4>Hackathon Challenge</h4>
                                <p>24-hour coding competition with prizes</p>
                            </div>
                        </div>
                    </div>

                    <div class="gallery-item">
                        <div class="gallery-image">
                            <img src="Images2/acv.jpg" alt="Team Event 3" />
                            <div class="gallery-overlay">
                                <h4>Annual Club Gathering</h4>
                                <p>Celebration and awards ceremony</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2026 SGIPC. All rights reserved.</p>
        </footer>

    </form>

    <script src="Scripts2/gallery.js"></script>
    <script src="Scripts2/index.js"></script>
</body>
</html>
