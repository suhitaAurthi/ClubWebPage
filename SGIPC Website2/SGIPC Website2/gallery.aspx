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
                <a href="gallery.aspx" class="sidebar-link active">
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
                <h1>Photo Gallery</h1>
                <p>Explore moments from our events and activities</p>
            </section>

            <!-- Gallery Filter -->
            <section class="gallery-filter">
                <button class="filter-btn active" data-filter="all">All</button>
                <button class="filter-btn" data-filter="workshops">Workshops</button>
                <button class="filter-btn" data-filter="contests">Contests</button>
                <button class="filter-btn" data-filter="team">Team</button>
                <button class="filter-btn" data-filter="social">Social</button>
            </section>

            <!-- Gallery Grid -->
            <section class="gallery-grid">
                <div class="gallery-item" data-category="workshops">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Workshop Session" />
                        <div class="gallery-overlay">
                            <h4>Algorithm Workshop</h4>
                            <p>March 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="contests">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Contest Day" />
                        <div class="gallery-overlay">
                            <h4>Weekly Contest</h4>
                            <p>April 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="workshops">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Training Session" />
                        <div class="gallery-overlay">
                            <h4>Data Structure Training</h4>
                            <p>April 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="team">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Team Photo" />
                        <div class="gallery-overlay">
                            <h4>Team Gathering</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="contests">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Hackathon" />
                        <div class="gallery-overlay">
                            <h4>24-Hour Hackathon</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="social">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Social Event" />
                        <div class="gallery-overlay">
                            <h4>Club Social Event</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="workshops">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Web Development" />
                        <div class="gallery-overlay">
                            <h4>Web Dev Workshop</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="team">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Leadership Meeting" />
                        <div class="gallery-overlay">
                            <h4>Leadership Meeting</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="contests">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Competition" />
                        <div class="gallery-overlay">
                            <h4>Inter-College Competition</h4>
                            <p>April 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="social">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Networking Event" />
                        <div class="gallery-overlay">
                            <h4>Networking Mixer</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="workshops">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Code Review" />
                        <div class="gallery-overlay">
                            <h4>Code Review Session</h4>
                            <p>May 2026</p>
                        </div>
                    </div>
                </div>

                <div class="gallery-item" data-category="team">
                    <div class="gallery-image">
                        <img src="Images2/hero.png" alt="Club Members" />
                        <div class="gallery-overlay">
                            <h4>All Members Photo</h4>
                            <p>May 2026</p>
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
