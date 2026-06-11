<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="reset-password.aspx.cs" Inherits="SGIPC_Website2.ResetPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Reset Password</title>
    <link rel="stylesheet" href="Content2/login.css?v=3" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&icon_names=visibility,visibility_off&display=block" />
    <script src="Scripts2/login.js?v=3" defer></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">

            <h2 style="text-align: center; font-size: 15px; color: #672aa1;">Reset Password</h2>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message-label">
            </asp:Label>

            <asp:Panel ID="pnlResetForm" runat="server">

                <div class="form-group">
                    <label for="txtNewPassword">New Password:</label>
                    <asp:TextBox
                        ID="txtNewPassword"
                        runat="server"
                        TextMode="Password"
                        ClientIDMode="Static"
                        CssClass="input-field">
                    </asp:TextBox>
                    <button type="button" class="password-toggle" data-target="txtNewPassword" aria-label="Show new password">
                        <span class="material-symbols-outlined" aria-hidden="true">visibility</span>
                    </button>
                </div>

                <div class="form-group">
                    <label for="txtConfirmPassword">Confirm Password:</label>
                    <asp:TextBox
                        ID="txtConfirmPassword"
                        runat="server"
                        TextMode="Password"
                        ClientIDMode="Static"
                        CssClass="input-field">
                    </asp:TextBox>
                    <button type="button" class="password-toggle" data-target="txtConfirmPassword" aria-label="Show confirm password">
                        <span class="material-symbols-outlined" aria-hidden="true">visibility</span>
                    </button>
                </div>

                <p class="password-note">Password must be at least 6 characters.</p>

                <asp:Button
                    ID="btnResetPassword"
                    runat="server"
                    Text="Reset Password"
                    CssClass="btn"
                    OnClick="btnResetPassword_Click"
                    CausesValidation="false" />

            </asp:Panel>

            <div class="reg-link">
                <a href="login.aspx">Back to Login</a>
            </div>

        </div>
    </form>
</body>
</html>
