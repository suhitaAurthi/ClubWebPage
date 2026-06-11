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
                <asp:Panel ID="pnlNotLoggedIn" runat="server" Visible="true">
                    <a href="login.aspx">Login</a>
                    <a href="register.aspx">Register</a>
                </asp:Panel>
                <asp:Panel ID="pnlLoggedIn" runat="server" Visible="false">
                    <div class="user-profile-header">
                        <div class="profile-icon">
                            <i class="fas fa-user-circle"></i>
                        </div>
                        <span class="welcome-text">Welcome, <asp:Label ID="lblUserName" runat="server"></asp:Label></span>
                    </div>
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
                <a href="gallery.aspx" class="sidebar-link">
                    <i class="fas fa-images"></i>
                    <span>Gallery</span>
                </a>
                <a href="team.aspx" class="sidebar-link active">
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
                <h1>Meet Our Team</h1>
                <p>The dedicated members who make SGIPC great</p>
            </section>

            <!-- Dynamic Team Sections -->
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <section class="team-section">
                        <h2><%# Eval("CategoryName") %></h2>
                        <div class="team-grid">
                            <asp:Repeater ID="rptMembers" DataSource='<%# ((SGIPC_Website2.TeamCategory)Container.DataItem).Members %>' runat="server">
                                <ItemTemplate>
                                    <div class="team-member">
                                        <div class="member-image">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <h3><%# Eval("FirstName") %> <%# Eval("LastName") %></h3>
                                        <p class="member-position"><%# Eval("Role") %></p>
                                        <p class="member-bio">Roll: <%# Eval("RollNumber") %> | CSE | <%# Eval("BatchYear") %></p>
                                        <div class="member-socials">
                                            <a href="#"><i class="fab fa-linkedin"></i></a>
                                            <a href="#"><i class="fab fa-github"></i></a>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                        </div>
                    </section>
                </ItemTemplate>
            </asp:Repeater>

            <!-- Senior Mentors -->
            <section class="team-section">
                <h2>Senior Mentor for Boys</h2>
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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
                <div class="team-grid">
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

        <!-- Edit Member Modal -->
        <div id="editMemberModal" class="modal" style="display: none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Edit Member</h3>
                    <button class="close-btn" onclick="closeEditModal()">&times;</button>
                </div>
                <form id="editForm" style="display: none;">
                    <input type="hidden" id="editUserId" />
                    <div class="form-group">
                        <label for="editUsername">Full Name</label>
                        <input type="text" id="editUsername" required />
                    </div>
                    <div class="form-group">
                        <label for="editEmail">Email</label>
                        <input type="email" id="editEmail" required />
                    </div>
                    <div class="form-group">
                        <label for="editRoll">Roll Number</label>
                        <input type="text" id="editRoll" required />
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn-primary">Save Changes</button>
                        <button type="button" class="btn-secondary" onclick="closeEditModal()">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Show User Events Modal -->
        <div id="userEventsModal" class="modal" style="display: none;">
            <div class="modal-content modal-large">
                <div class="modal-header">
                    <h3>Registered Contests & Workshops - <span id="eventUserName"></span></h3>
                    <button class="close-btn" onclick="closeEventsModal()">&times;</button>
                </div>
                <div class="modal-body">
                    <div id="eventsList" class="events-list">
                        <p class="loading-text">Loading events...</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <footer class="footer">
            <p>&copy; 2026 SGIPC. All rights reserved.</p>
        </footer>

    </form>

    <script src="Scripts2/index.js"></script>
    <script>
        // Members management functions
        function editMember(userId, username, email, roll) {
            var editUserIdInput = document.getElementById('editUserId');
            var editUsernameInput = document.getElementById('editUsername');
            var editEmailInput = document.getElementById('editEmail');
            var editRollInput = document.getElementById('editRoll');
            var editMemberModal = document.getElementById('editMemberModal');
            var editForm = document.getElementById('editForm');
            
            if (editUserIdInput) {
                (editUserIdInput).value = userId;
            }
            if (editUsernameInput) {
                (editUsernameInput).value = username;
            }
            if (editEmailInput) {
                (editEmailInput).value = email;
            }
            if (editRollInput) {
                (editRollInput).value = roll;
            }
            if (editMemberModal) {
                editMemberModal.style.display = 'block';
            }
            if (editForm) {
                editForm.style.display = 'block';
            }
        }

        function closeEditModal() {
            var editMemberModal = document.getElementById('editMemberModal');
            var editForm = document.getElementById('editForm');
            
            if (editMemberModal) {
                editMemberModal.style.display = 'none';
            }
            if (editForm) {
                (editForm).reset();
            }
        }

        function showUserEvents(userId, userName) {
            var userEventsModal = document.getElementById('userEventsModal');
            var eventUserName = document.getElementById('eventUserName');
            var eventsList = document.getElementById('eventsList');
            
            if (eventUserName) {
                eventUserName.textContent = userName;
            }
            if (eventsList) {
                eventsList.innerHTML = '<p class="loading-text">Loading events...</p>';
            }
            if (userEventsModal) {
                userEventsModal.style.display = 'block';
            }
        }

        function closeEventsModal() {
            var userEventsModal = document.getElementById('userEventsModal');
            if (userEventsModal) {
                userEventsModal.style.display = 'none';
            }
        }

        function deleteMember(userId) {
            if (confirm('Are you sure you want to delete this member?')) {
                fetch('team.aspx?action=delete&userId=' + userId, { method: 'POST' })
                    .then(function(response) {
                        if (response.ok) {
                            alert('Member deleted successfully!');
                            location.reload();
                        }
                    })
                    .catch(function(error) {
                        alert('Error deleting member: ' + error);
                    });
            }
        }

        // Handle edit form submission
        document.addEventListener('DOMContentLoaded', function() {
            var editForm = document.getElementById('editForm');
            if (editForm) {
                editForm.addEventListener('submit', function(e) {
                    e.preventDefault();
                    var userIdInput = document.getElementById('editUserId');
                    var usernameInput = document.getElementById('editUsername');
                    var emailInput = document.getElementById('editEmail');
                    var rollInput = document.getElementById('editRoll');
                    
                    var userId = (userIdInput).value;
                    var username = (usernameInput).value;
                    var email = (emailInput).value;
                    var roll = (rollInput).value;

                    var formData = new FormData();
                    formData.append('action', 'update');
                    formData.append('userId', userId);
                    formData.append('username', username);
                    formData.append('email', email);
                    formData.append('roll', roll);

                    fetch('team.aspx', { method: 'POST', body: formData })
                        .then(function(response) {
                            if (response.ok) {
                                alert('Member updated successfully!');
                                location.reload();
                            }
                        })
                        .catch(function(error) {
                            alert('Error updating member: ' + error);
                        });
                });
            }

            // Close modal when clicking outside of it
            window.onclick = function(event) {
                var editModal = document.getElementById('editMemberModal');
                var eventsModal = document.getElementById('userEventsModal');
                if (event.target === editModal && editModal) {
                    editModal.style.display = 'none';
                }
                if (event.target === eventsModal && eventsModal) {
                    eventsModal.style.display = 'none';
                }
            };
        });
    </script>
</body>

            <!-- Join Us Section -->
            <!-- <section class="join-section">
                <h2>Interested in Joining?</h2>
                <p>We're always looking for passionate programmers and enthusiasts to join our team!</p>
                <a href="register.aspx" class="register-button">Register Now</a>
            </section>

        </main>  -->

       <!--Footer-->
        <footer class="footer">
            <p>&copy; 2026 SGIPC. All rights reserved.</p>
        </footer>

    </form>

    <script src="Scripts2/index.js"></script>
</body>
</html>
