<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SGIPC_Website.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Login Page</title>

    <link rel="stylesheet" href="Content/login.css" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&amp;icon_names=key_vertical,person&amp;display=block" />
</head>

    <!--Simple login page-->
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2 style="text-align: center; font-size: 15px; color: #672aa1;">Login</h2>
            <div class="form-group">
                <span class="material-symbols-outlined">person</span>
                <label for="username">Username/E-mail:</label>
                <input type="text" id="username" runat="server" />
            </div>
            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="password">Password:</label>
                <input type="password" id="password" runat="server" />

            </div>
            <div class="forgot">
                <label for="fgc">
                    <input type="checkbox" id="fgc" runat="server" />Remember me.
                </label>
                <a href="#">Forgot Password?</a>
            </div>

            <button type="submit" class="btn">Login</button>
            <div class="reg-link">
                <p>Don't have an account?<a href="register.aspx">Register!</a> </p>

            </div>
        </div>

    </form>
</body>
</html>
