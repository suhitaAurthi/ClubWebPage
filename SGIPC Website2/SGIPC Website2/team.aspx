<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="team.aspx.cs" Inherits="SGIPC_Website2.team" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SGIPC - Our Team</title>
    <link rel="stylesheet" href="Content2/index.css" />
    <link rel="stylesheet" href="Content2/team.css" />
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
                <a href="events.aspx" class="sidebar-link">
                    <i class="fas fa-calendar"></i>
                    <span>Events</span>
                </a>
                <a href="gallery.aspx" class="sidebar-link">
                    <i class="fas fa-images"></i>
                    <span>Gallery</span>
                </a>
                <a href="team.aspx" class="sidebar-link active">
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
                <h1>Meet Our Team</h1>
                <p>The dedicated members who make SGIPC great</p>
            </section>

            <!-- Leadership Section -->
            <section class="team-section">
                <h2>Club Leadership</h2>
                <div class="team-grid">
                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💼</div>
                        </div>
                        <h3>John Doe</h3>
                        <p class="member-position">President</p>
                        <p class="member-bio">Passionate about competitive programming with 3 years of experience.</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💻</div>
                        </div>
                        <h3>Jane Smith</h3>
                        <p class="member-position">Vice President</p>
                        <p class="member-bio">Expert in algorithms and data structures, loves mentoring newcomers.</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👩‍💼</div>
                        </div>
                        <h3>Sarah Johnson</h3>
                        <p class="member-position">Secretary</p>
                        <p class="member-bio">Organized and detail-oriented, manages all club activities and events.</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💻</div>
                        </div>
                        <h3>Michael Chen</h3>
                        <p class="member-position">Treasurer</p>
                        <p class="member-bio">Financial planning and budgeting expert for club activities.</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Core Team Section -->
            <section class="team-section">
                <h2>Core Team Members</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👩‍💻</div>
                        </div>
                        <h3>Emma Wilson</h3>
                        <p class="member-position">Event Coordinator</p>
                        <p class="member-bio">Organizes workshops and competitions.</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💻</div>
                        </div>
                        <h3>David Lee</h3>
                        <p class="member-position">Technical Lead</p>
                        <p class="member-bio">Oversees coding challenges and technical workshops.</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👩‍💼</div>
                        </div>
                        <h3>Lisa Anderson</h3>
                        <p class="member-position">Mentorship Lead</p>
                        <p class="member-bio">Coordinates mentorship programs and guidance.</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💼</div>
                        </div>
                        <h3>Alex Rodriguez</h3>
                        <p class="member-position">Marketing Lead</p>
                        <p class="member-bio">Promotes club activities and handles social media.</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👩‍💻</div>
                        </div>
                        <h3>Sophie Martin</h3>
                        <p class="member-position">Logistics Lead</p>
                        <p class="member-bio">Manages resources and facilities for events.</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <div class="placeholder-avatar">👨‍💻</div>
                        </div>
                        <h3>James Park</h3>
                        <p class="member-position">Community Manager</p>
                        <p class="member-bio">Builds and nurtures the club community.</p>
                    </div>
                </div>
            </section>

            <!-- Join Us Section -->
            <section class="join-section">
                <h2>Interested in Joining?</h2>
                <p>We're always looking for passionate programmers and enthusiasts to join our team!</p>
                <a href="register.aspx" class="cta-button">Register Now</a>
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
