<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="SGIPC_Website2.about" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SGIPC - About Us</title>
    <link rel="stylesheet" href="Content2/index.css" />
    <link rel="stylesheet" href="Content2/about.css" />
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
                <a href="about.aspx" class="sidebar-link active">
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
                <h1>About SGIPC</h1>
                <p>Learn more about our mission and community</p>
            </section>

            <!-- About Section -->
            <section class="about-section">
                <div class="about-content">
                    <h2>Who We Are</h2>
                    <p>
                        SGIPC (Programming Club) is a vibrant community of passionate programmers and technology enthusiasts 
                        dedicated to fostering excellence in competitive programming and software development. Our club serves 
                        as a platform for members to enhance their skills, collaborate on exciting projects, and grow both 
                        professionally and personally.
                    </p>
                </div>
            </section>

            <!-- Mission, Vision, Values -->
            <section class="mvv-section">
                <div class="mvv-card">
                    <h3><i class="fas fa-bullseye"></i> Our Mission</h3>
                    <p>
                        To empower students through quality education in programming, fostering a community where innovation, 
                        collaboration, and excellence are paramount. We aim to develop skilled programmers who can tackle 
                        real-world challenges and make meaningful contributions to society.
                    </p>
                </div>
                <div class="mvv-card">
                    <h3><i class="fas fa-telescope"></i> Our Vision</h3>
                    <p>
                        To establish SGIPC as the leading hub for competitive programming and software development excellence, 
                        inspiring the next generation of tech leaders and innovators through mentorship and opportunity.
                    </p>
                </div>
                <div class="mvv-card">
                    <h3><i class="fas fa-heart"></i> Our Values</h3>
                    <p>
                        We believe in continuous learning, teamwork, integrity, and innovation. We support each other's growth, 
                        celebrate achievements, and embrace challenges as opportunities to learn and improve.
                    </p>
                </div>
            </section>

            <!-- What We Do -->
            <section class="activities-section">
                <h2>What We Do</h2>
                <div class="activities-grid">
                    <div class="activity-card">
                        <i class="fas fa-graduation-cap"></i>
                        <h4>Workshops</h4>
                        <p>Regular training sessions on algorithms, data structures, and problem-solving techniques</p>
                    </div>
                    <div class="activity-card">
                        <i class="fas fa-trophy"></i>
                        <h4>Contests</h4>
                        <p>Competitive programming contests to challenge skills and foster healthy competition</p>
                    </div>
                    <div class="activity-card">
                        <i class="fas fa-users"></i>
                        <h4>Mentorship</h4>
                        <p>One-on-one guidance from experienced members and industry professionals</p>
                    </div>
                    <div class="activity-card">
                        <i class="fas fa-network-wired"></i>
                        <h4>Networking</h4>
                        <p>Connect with like-minded programmers and build lasting professional relationships</p>
                    </div>
                </div>
            </section>

            <!-- Stats Section -->
            <section class="stats-section">
                <div class="stat-item">
                    <h3>500+</h3>
                    <p>Active Members</p>
                </div>
                <div class="stat-item">
                    <h3>50+</h3>
                    <p>Events Hosted</p>
                </div>
                <div class="stat-item">
                    <h3>100%</h3>
                    <p>Dedication</p>
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
