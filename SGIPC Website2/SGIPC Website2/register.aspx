<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="register.aspx.cs" Inherits="SGIPC_Website2.register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Register Page</title>

    <!-- Fixed Google Fonts Link -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />

    <link rel="stylesheet" href="Content2/register.css?v=3" />
    <script src="Scripts2/register.js?v=3" defer></script>
</head>

<body>
    <form id="form2" runat="server">
        <div class="register-container">
            <h2>Create Account</h2>

            <!-- Full Name Field -->
            <div class="form-group">
                <span class="material-symbols-outlined">badge</span>
                <label for="fullname">Full Name:</label>
                <input type="text" id="fullname" runat="server" clientidmode="Static" />
            </div>

            <!-- Username Field -->
            <div class="form-group">
                <span class="material-symbols-outlined">school</span>
                <label for="roll">Roll:</label>
                <input type="text" id="roll" runat="server" clientidmode="Static" />
            </div>

            <!-- Email Field -->
            <div class="form-group">
                <span class="material-symbols-outlined">mail</span>
                <label for="email">Email:</label>
                <input type="email" id="email" runat="server" clientidmode="Static" />
            </div>

            <!-- Password Field -->
            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="password">Password:</label>
                <input type="password" id="password" runat="server" clientidmode="Static" />
                <button type="button" class="password-toggle" data-target="password" aria-label="Show password">
                    <span class="material-symbols-outlined" aria-hidden="true">visibility</span>
                </button>
            </div>

            <!-- Confirm Password Field -->
            <div class="form-group">
                <span class="material-symbols-outlined">key_vertical</span>
                <label for="confirmPassword">Confirm:</label>
                <input type="password" id="confirmPassword" runat="server" clientidmode="Static" />
                <button type="button" class="password-toggle" data-target="confirmPassword" aria-label="Show confirm password">
                    <span class="material-symbols-outlined" aria-hidden="true">visibility</span>
                </button>
            </div>

            <small id="confirmPasswordError" class="error"></small>

            <!-- Register Button -->
            <asp:Button 
                ID="btnRegister" 
                runat="server" 
                Text="Register" 
                CssClass="btn" 
                OnClick="btnRegister_Click" />

            <!-- Login Link -->
            <div class="login-link">
                <p>Already have an account? <a href="login.aspx">Login!</a></p>
            </div>
        </div>
    </form>
</body>
</html>
