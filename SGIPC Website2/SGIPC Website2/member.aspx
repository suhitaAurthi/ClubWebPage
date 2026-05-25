<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member.aspx.cs" Inherits="SGIPC_Website2.member" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="en">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Members - SGIPC</title>
    <link rel="stylesheet" href="Content2/index.css" />
    <link rel="stylesheet" href="Content2/team.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
    <style>
        .members-list {
            max-width: 900px;
            margin: 0 auto;
            background: linear-gradient(135deg, rgba(255, 255, 255, 0.05), rgba(255, 255, 255, 0.015));
            border: 1px solid rgba(190, 120, 255, 0.2);
            border-radius: 16px;
            backdrop-filter: blur(14px);
            -webkit-backdrop-filter: blur(14px);
            overflow: hidden;
        }

        .member-item {
            display: flex;
            align-items: center;
            padding: 18px 24px;
            border-bottom: 1px solid rgba(190, 120, 255, 0.1);
            transition: 0.3s ease;
            gap: 16px;
        }

        .member-item:last-child {
            border-bottom: none;
        }

        .member-item:hover {
            background: rgba(138, 43, 226, 0.1);
        }

        .member-checkbox {
            flex-shrink: 0;
        }

        .member-check {
            width: 18px;
            height: 18px;
            cursor: pointer;
            accent-color: rgb(138, 43, 226);
        }

        .member-avatar {
            flex-shrink: 0;
            font-size: 32px;
            color: rgb(138, 43, 226);
        }

        .member-info {
            flex: 1;
            min-width: 0;
        }

        .member-info h4 {
            margin: 0;
            font-size: 15px;
            color: #ffffff;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .member-email {
            margin: 0;
            font-size: 13px;
            color: rgba(255, 255, 255, 0.6);
        }

        .member-roll {
            margin: 4px 0 0 0;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.5);
        }

        .member-actions {
            display: flex;
            gap: 8px;
            flex-shrink: 0;
        }

        .action-btn {
            background: transparent;
            border: 1px solid rgba(190, 120, 255, 0.3);
            color: rgba(255, 255, 255, 0.7);
            padding: 8px 10px;
            border-radius: 6px;
            cursor: pointer;
            transition: 0.3s ease;
            font-size: 12px;
            min-width: 32px;
            height: 32px;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .action-btn:hover {
            background: rgba(190, 120, 255, 0.2);
            color: #ffffff;
            border-color: rgba(190, 120, 255, 0.5);
        }

        .btn-edit:hover {
            color: #87ceeb;
        }

        .btn-show:hover {
            color: #90ee90;
        }

        .btn-delete:hover {
            color: #ff6b6b;
        }

        .member-date {
            flex-shrink: 0;
            text-align: right;
        }

        .update-date {
            margin: 0;
            font-size: 12px;
            color: rgba(255, 255, 255, 0.5);
        }

        .registered-members-section {
            margin-bottom: 70px;
            margin-top: 70px;
        }

        .registered-members-section h2 {
            text-align: center;
            font-size: 36px;
            color: #ffffff;
            margin-bottom: 45px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
                <a href="gallery.aspx" class="sidebar-link">
                    <i class="fas fa-images"></i>
                    <span>Gallery</span>
                </a>
                <a href="team.aspx" class="sidebar-link">
                    <i class="fas fa-people-group"></i>
                    <span>Team</span>
                </a>
                <a href="member.aspx" class="sidebar-link active">
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
                <h1>Registered Members</h1>
                <p>Manage and view all registered club members</p>
            </section>

            <!-- Members Section -->
            <section class="registered-members-section">
                <div class="members-list">
                    <asp:Repeater ID="rptRegisteredMembers" runat="server">
                        <ItemTemplate>
                            <div class="member-item">
                                <div class="member-checkbox">
                                    <input type="checkbox" class="member-check" data-user-id='<%# Eval("UserId") %>' />
                                </div>
                                <div class="member-avatar">
                                    <i class="fas fa-user-circle"></i>
                                </div>
                                <div class="member-info">
                                    <h4><%# Eval("Username") %></h4>
                                    <p class="member-email"><%# Eval("Email") %></p>
                                    <p class="member-roll">Roll: <%# Eval("Roll") %></p>
                                </div>
                                <div class="member-actions">
                                    <button type="button" class="action-btn btn-edit" data-user-id='<%# Eval("UserId") %>' data-username='<%# Eval("Username") %>' data-email='<%# Eval("Email") %>' data-roll='<%# Eval("Roll") %>' title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button type="button" class="action-btn btn-show" data-user-id='<%# Eval("UserId") %>' data-username='<%# Eval("Username") %>' title="Show Events">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button type="button" class="action-btn btn-delete" data-user-id='<%# Eval("UserId") %>' title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                                <div class="member-date">
                                    <p class="update-date"><%# ((DateTime)Eval("CreatedDate")).ToString("dd MMM yyyy, HH:mm") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </section>
        </main>

        <!-- Edit Member Modal -->
        <div id="editMemberModal" class="modal" style="display: none;">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Edit Member</h3>
                    <button type="button" class="close-btn" onclick="closeEditModal()">&times;</button>
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
                    <button type="button" class="close-btn" onclick="closeEventsModal()">&times;</button>
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
                fetch('member.aspx?action=delete&userId=' + userId, { method: 'POST' })
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

                    fetch('member.aspx', { method: 'POST', body: formData })
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
</html>
