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
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Niloy Das</h3>
                        <p class="member-position">President</p>
                        <p class="member-bio">Roll: 2007086 | CSE | 2k20</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md. Tanjimul Hasan</h3>
                        <p class="member-position">Vice President</p>
                        <p class="member-bio">Roll: 2007081 | CSE | 2k20</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Shah Md Khalil Ullah</h3>
                        <p class="member-position">Vice President</p>
                        <p class="member-bio">Roll: 2007090 | CSE | 2k20</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Khadimul Islam Mahi</h3>
                        <p class="member-position">General Secretary</p>
                        <p class="member-bio">Roll: 2107076 | CSE | 2k21</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Mohammad Abu Daud Sharif</h3>
                        <p class="member-position">Assistant General Secretary</p>
                        <p class="member-bio">Roll: 2107002 | CSE | 2k21</p>
                        <div class="member-socials">
                            <a href="#"><i class="fab fa-linkedin"></i></a>
                            <a href="#"><i class="fab fa-github"></i></a>
                        </div>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Umar Faruk</h3>
                        <p class="member-position">Treasurer</p>
                        <p class="member-bio">Roll: 2007016 | CSE | 2k20</p>
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
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Amit Kairy</h3>
                        <p class="member-position">Organizing Secretary</p>
                        <p class="member-bio">Roll: 2007069 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md. Ashraful Haque Sifat</h3>
                        <p class="member-position">Organizing Secretary</p>
                        <p class="member-bio">Roll: 2007082 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Siam Arif</h3>
                        <p class="member-position">Assistant Organizing Secretary</p>
                        <p class="member-bio">Roll: 2107062 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Siyam Khan</h3>
                        <p class="member-position">Assistant Organizing Secretary</p>
                        <p class="member-bio">Roll: 2107120 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Abdullah Al Saif</h3>
                        <p class="member-position">Assistant Organizing Secretary</p>
                        <p class="member-bio">Roll: 2107017 | CSE | 2k21</p>
                    </div>

                </div>
            </section>

            <!-- Performance Analyzers -->
            <section class="team-section">
                <h2>Performance Analyzers</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Sujoy Sadhu</h3>
                        <p class="member-position">Performance Analyzer</p>
                        <p class="member-bio">Roll: 2007019 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md. Asif Rahman</h3>
                        <p class="member-position">Performance Analyzer</p>
                        <p class="member-bio">Roll: 2007044 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Hafizur Rahman</h3>
                        <p class="member-position">Performance Analyzer</p>
                        <p class="member-bio">Roll: 2007080 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Rahul Sheikh</h3>
                        <p class="member-position">Performance Analyzer</p>
                        <p class="member-bio">Roll: 2107063 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Batch Representatives -->
            <section class="team-section">
                <h2>Batch Representatives</h2>
                <div class="team-grid large">
                    

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Saleque Bin Hossain</h3>
                        <p class="member-position">Batch Representative (2k21)</p>
                        <p class="member-bio">Roll: 2107026 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Alok Baul(Turjo)</h3>
                        <p class="member-position">Batch Representative (2k22)</p>
                        <p class="member-bio">Roll: 2207098 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Farhan Ishraq</h3>
                        <p class="member-position">Batch Representative (2k23)</p>
                        <p class="member-bio">Roll: 2307012 | CSE | 2k23</p>
                    </div>
                </div>
            </section>

            <!-- Senior Mentors -->
            <section class="team-section">
                <h2>Senior Mentor for Boys</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Babla Islam</h3>
                        <p class="member-position">Senior Mentor for Boys</p>
                        <p class="member-bio">Roll: 2007045 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Raihan Hossain Rakib</h3>
                        <p class="member-position">Senior Mentor for Boys</p>
                        <p class="member-bio">Roll: 2007005 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Rauful Islam Tamum</h3>
                        <p class="member-position">Senior Mentor for Boys</p>
                        <p class="member-bio">Roll: 2007009 | CSE | 2k20</p>
                    </div>
                </div>
            </section>

            <!-- Junior Mentors -->
            <section class="team-section">
                <h2>Junior Mentor For Boys</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Farid Ahmed</h3>
                        <p class="member-position">Junior Mentor For Boys</p>
                        <p class="member-bio">Roll: 2107043 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Mosaddek Ali</h3>
                        <p class="member-position">Junior Mentor For Boys</p>
                        <p class="member-bio">Roll: 2107027 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Contest Manager -->
            <section class="team-section">
                <h2>Contest Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Dipra Datta</h3>
                        <p class="member-position">Contest Manager</p>
                        <p class="member-bio">Roll: 2107070 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Ankon Roy</h3>
                        <p class="member-position">Contest Manager</p>
                        <p class="member-bio">Roll: 2107113 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Assistant Contest Manager -->
            <section class="team-section">
                <h2>Assistant Contest Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Sk.Nazmus Salehin Nirob</h3>
                        <p class="member-position">Assistant Contest Manager</p>
                        <p class="member-bio">Roll: 2207045 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Nurul Absar Shadik</h3>
                        <p class="member-position">Assistant Contest Manager</p>
                        <p class="member-bio">Roll: 2207065 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Sazzad Ahmed</h3>
                        <p class="member-position">Assistant Contest Manager</p>
                        <p class="member-bio">Roll: 2207026 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>MD Shahariar Emon Saikat</h3>
                        <p class="member-position">Assistant Contest Manager</p>
                        <p class="member-bio">Roll: 2207002 | CSE | 2k22</p>
                    </div>
                </div>
            </section>

            <!-- Workshop Manager -->
            <section class="team-section">
                <h2>Workshop Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Raihan Arefin</h3>
                        <p class="member-position">Workshop Manager</p>
                        <p class="member-bio">Roll: 2107065 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Naqibul Haque</h3>
                        <p class="member-position">Workshop Manager</p>
                        <p class="member-bio">Roll: 2107077 | CSE | 2k21</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Tariful Islam Jony</h3>
                        <p class="member-position">Workshop Manager</p>
                        <p class="member-bio">Roll: 2107119 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Assistant Workshop Manager -->
            <section class="team-section">
                <h2>Assistant Workshop Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Shah Makhdum Sharif</h3>
                        <p class="member-position">Assistant Workshop Manager</p>
                        <p class="member-bio">Roll: 2207089 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Taki Tahmid Saad</h3>
                        <p class="member-position">Assistant Workshop Manager</p>
                        <p class="member-bio">Roll: 2207022 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Ullas Biswas Shontu</h3>
                        <p class="member-position">Assistant Workshop Manager</p>
                        <p class="member-bio">Roll: 2207086 | CSE | 2k22</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Alif Al Ahad</h3>
                        <p class="member-position">Assistant Workshop Manager</p>
                        <p class="member-bio">Roll: 2207016 | CSE | 2k22</p>
                    </div>
                </div>
            </section>

            <!-- Editorial Manager -->
            <section class="team-section">
                <h2>Editorial Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Abir Rahman</h3>
                        <p class="member-position">Editorial Manager</p>
                        <p class="member-bio">Roll: 2007026 | CSE | 2k20</p>
                    </div>

                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Ahsanul Islam Emon</h3>
                        <p class="member-position">Editorial Manager</p>
                        <p class="member-bio">Roll: 2107115 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Assistant Editorial Manager -->
            <section class="team-section">
                <h2>Assistant Editorial Manager</h2>
                <div class="team-grid large">
                    <div class="team-member">
                        <div class="member-image">
                            <i class="fas fa-user"></i>
                        </div>
                        <h3>Md Tahmid Islam</h3>
                        <p class="member-position">Assistant Editorial Manager</p>
                        <p class="member-bio">Roll: 2107107 | CSE | 2k21</p>
                    </div>
                </div>
            </section>

            <!-- Join Us Section -->
            <section class="join-section">
                <h2>Interested in Joining?</h2>
                <p>We're always looking for passionate programmers and enthusiasts to join our team!</p>
                <a href="register.aspx" class="register-button">Register Now</a>
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
