<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SGIPC_Website.register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Register Page</title>

    <link rel="stylesheet" href="Content/register.css" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&amp;icon_names=badge,person,mail,key_vertical&amp;display=block" />
</head>

<body>
    <form id="form1" runat="server">
        <div class="register-container">

            <h2>Create Account</h2>

            <div class="form-group">
                <span class="material-symbols-outlined">badge</span>
                <label for="fullname">Full Name:</label>
                <input type="text" id="fullname" runat="server" />
            </div>

            <div class="form-group">
                <span class="material-symbols-outlined">person</span>
                <label for="username">Username:</label>
                <input type="text" id="username" runat="server" />
            </div>

            <div class="form-group">
                <span class="material-symbols-outlined">mail</span>
                <label for="email">Email:</label>
                <input type="email" id="email" runat="server" />
            </div>

            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="password">Password:</label>
                <input type="password" id="password" runat="server" />
            </div>

            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="confirmPassword">Confirm:</label>
                <input type="password" id="confirmPassword" runat="server" />
            </div>

            <button type="submit" class="btn">Register</button>

            <div class="login-link">
                <p>Already have an account? <a href="login.aspx">Login!</a></p>
            </div>

        </div>
    </form>
</body>
</html>