<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SGIPC_Website.index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>SGIPC - Welcome</title>

    <link rel="stylesheet" href="Content/index.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
</head>

<body>
    <form id="form1" runat="server">

        <!-- Fixed Header -->
        <header class="header">
            <img src="Images/sgipc_logo.png" alt="SGIPC Logo" class="club-logo" />

            <h1 class="club-branding" style="color: blueviolet;">|</h1>
            <h1 class="club-branding" style="color: rgb(80, 26, 88);">SGIPC</h1>
        </header>

        <!-- Hamburger Menu -->
        <input type="checkbox" id="hamburger-toggle" class="hamburger-toggle" />

        <label for="hamburger-toggle" class="hamburger">
            <div class="dot"></div>
            <div class="dot"></div>
            <div class="dot"></div>

            <span class="close-icon">
                Close <i class="fas fa-times"></i>
            </span>
        </label>

        <!-- Sidebar Navigation -->
        <aside class="sidebar">
            <nav class="sidebar-nav" style="border-radius: 10px;">

                <div class="sidebar-link-wrapper">
                    <a href="index.aspx" class="sidebar-link">
                        <i class="fas fa-home"></i> Home
                    </a>
                </div>

                <div class="sidebar-link-wrapper">
                    <a href="about.aspx" class="sidebar-link">
                        <i class="fas fa-circle-info"></i> About
                    </a>
                </div>

                <div class="sidebar-link-wrapper">
                    <a href="event.aspx" class="sidebar-link">
                        <i class="fas fa-calendar"></i> Events
                    </a>
                </div>

                <div class="sidebar-link-wrapper">
                    <a href="gallery.aspx" class="sidebar-link">
                        <i class="fas fa-images"></i> Gallery
                    </a>
                </div>

                <div class="sidebar-link-wrapper">
                    <a href="team.aspx" class="sidebar-link">
                        <i class="fas fa-people-group"></i> Team
                    </a>
                </div>

            </nav>
        </aside>

        <!-- Main Content -->
        <main class="content">

            <!-- Hero Section -->
            <section class="hero">
                <div class="hero-content">
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
                    <img src="Images/hero.png" alt="Club Hero Image" />
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
</body>
</html>