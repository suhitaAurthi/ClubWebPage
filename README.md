# SGIPC Website

## Overview
A responsive ASP.NET web application built for SGIPC featuring member management, event coordination, and community engagement.

## Features
- **User Management** - Login, registration, and authentication system with role-based access control
- **Event Management** - Create, view, and manage upcoming events with visibility controls
- **Team Management** - Manage team members with dedicated team page
- **Gallery** - Photo gallery for browsing community images
- **Member Dashboard** - Personalized member information and profile page
-  **Forget password and Reset password** - User can change password if needed
-  
-  ---

## Security Features

- **Password Hashing** – All passwords are securely hashed using SHA-256 before storage.
- **Session Management** – User sessions automatically expire after 30 minutes of inactivity.
- **SQL Injection Prevention** – Parameterized queries are used throughout the application to prevent SQL injection attacks.
- **Role-Based Access Control** – Team member authorization is required for event management operations.
- **Self-Edit Restriction** – Users can only edit or delete their own accounts.
- **Input Validation** – Both client-side and server-side validation are implemented for all forms.

---
   
## Technology Stack
- **Backend** - ASP.NET (C#)
- **Frontend** - JavaScript, HTML, CSS
- **Database** - SQL Server
- **Architecture** - Web Forms (ASP.NET)

---

## Project Structure
- `/SGIPC Website2/` - Main application directory with ASPX pages
- `/Content2/` - Stylesheets for each page
- `/Scripts2/` - JavaScript functionality
- `/Images2/` - Image assets including gallery content
- `/Properties/` - Assembly configuration

---

## Pages
- Index (Homepage)
- About
- Team
- Events
- Gallery
- Member Dashboard
- Login/Register/Logout
- ForgotPassword
- ResetPassword
---
## Complete User Flow

### 1. Anonymous User

- Visits the Home page (`index.aspx`).
- Can browse:
  - Events
  - Gallery
  - About
  - Team pages
- Cannot register for events.
- Sees **Login** and **Register** buttons in the navigation bar.

### 2. User Registration

1. User fills out the registration form:
   - Full Name
   - Roll Number
   - Email Address
   - Password
2. Password is hashed using SHA-256.
3. A new user record is created in the database.
4. User is redirected to the Login page.

### 3. User Login

1. User enters:
   - Roll Number or Email
   - Password
2. Password is hashed and compared with the stored hash in the database.
3. On successful authentication:
   - Session variables are created:
     - `UserId`
     - `UserName`
     - `UserEmail`
   - `LastLogin` timestamp is updated.
4. User is redirected to the Home page.

### 4. Logged-in User

- Sees **Welcome, [Name]** and a **Logout** button.
- Can register for events.
- Can view their event registrations on the Home page.
- Can edit their own profile on the Member page.
- Can delete their own account.

### 5. Team Member

Team members have all standard user privileges, plus:

- Create new events (`events.aspx`).
- Edit existing events.
- Delete events.
- View all registered members (`member.aspx`).

### 6. Logout

1. Session data is cleared.
2. Session is abandoned.
3. Authentication cookies are expired.
4. User is redirected to the Home page.
