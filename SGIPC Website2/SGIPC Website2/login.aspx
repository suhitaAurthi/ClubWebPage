<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SGIPC_Website2.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>Login Page</title>

    <link rel="stylesheet" href="Content2/login.css?v=3" />

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=key_vertical,person,visibility,visibility_off&display=block" />

    <!-- CHANGED: Added external JavaScript file for client-side validation -->
    <script src="Scripts2/login.js?v=3" defer></script>
</head>

<body>
    <form id="form2" runat="server">
        <div class="login-container">

            <h2 style="text-align: center; font-size: 15px; color: #672aa1;">Login</h2>

            <!-- CHANGED: Added ASP.NET Label to show login error/success message from C# -->
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="form-group">
                <span class="material-symbols-outlined">person</span>
                <label for="roll">Roll/E-mail:</label>

                <!-- CHANGED: Added ClientIDMode="Static" so JavaScript can easily find this input by id="roll" -->
                <input type="text" id="roll" runat="server" ClientIDMode="Static" />

                <!-- CHANGED: Added small tag to show roll/email validation error using JavaScript -->
                <small id="rollError" class="error"></small>
            </div>

            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="password">Password:</label>

                <!-- CHANGED: Added ClientIDMode="Static" so JavaScript can easily find this input by id="password" -->
                <input type="password" id="password" runat="server" ClientIDMode="Static" />
                <button type="button" class="password-toggle" data-target="password" aria-label="Show password">
                    <span class="material-symbols-outlined" aria-hidden="true">visibility</span>
                </button>

                <!-- CHANGED: Added small tag to show password validation error using JavaScript -->
                <small id="passwordError" class="error"></small>
            </div>

            <div class="forgot forgot-single">
                <a href="ForgotPassword.aspx">Forgot Password?</a>
            </div>

            <!-- CHANGED: Replaced normal HTML button with ASP.NET Button so C# OnClick event can work -->
            <asp:Button 
                ID="btnLogin" 
                runat="server" 
                Text="Login" 
                CssClass="btn" 
                OnClick="btnLogin_Click" />

            <div class="reg-link">
                <p>Don't have an account? <a href="register.aspx">Register!</a></p>
            </div>

        </div>
    </form>
</body>
</html>
