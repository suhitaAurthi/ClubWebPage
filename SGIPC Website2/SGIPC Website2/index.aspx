<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SGIPC_Website2.index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>SGIPC - Welcome</title>

    <link rel="stylesheet" href="Content2/index.css" />
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

            <span class="close-icon">
                Close <i class="fas fa-times"></i>
            </span>
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

                <a href="index.aspx" class="sidebar-link active">
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

            <!-- Hero Section -->
            <section class="hero">

                <div class="hero-content">
                    <span class="hero-badge">WELCOME TO SGIPC</span>

                    <h2>Welcome to Our Club</h2>

                    <p>
                        SGIPC arranges workshops and contests regularly to develop the skills of the members.
                        Moreover, it offers a platform to the Competitive Programming Community of KUET by
                        training members on algorithms, data structure, mathematics, geometry, probability theory,
                        game theory and different problem-solving paradigms which helps them in their academic
                        and professional life.
                    </p>

                    <button type="button" class="cta-button">Learn More</button>
                </div>

                <div class="hero-image">
                    <img src="Images2/hero.png" alt="Club Hero Image" />
                </div>

            </section>

            <!-- Features Section -->
            <section class="features">

                <div class="feature-card">
                    <h3>Our Mission</h3>
                    <p>
                        To foster a vibrant community of passionate individuals dedicated to growth and excellence.
                    </p>
                </div>

                <div class="feature-card">
                    <h3>What We Do</h3>
                    <p>
                        We organize events, workshops, and networking sessions to help our members succeed.
                    </p>
                </div>

                <div class="feature-card">
                    <h3>Join Us</h3>
                    <p>
                        Be part of a dynamic community. Membership is open to all who share our values.
                    </p>
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