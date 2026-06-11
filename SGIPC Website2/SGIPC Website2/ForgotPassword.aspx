<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="SGIPC_Website2.ForgotPassword" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Forgot Password</title>
    <link rel="stylesheet" href="Content2/login.css?v=3" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">

            <h2 style="text-align: center; font-size: 15px; color: #672aa1;">Forgot Password</h2>

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message-label">
            </asp:Label>

            <div class="form-group">
                <label for="txtRollOrEmail">Roll or Email:</label>
                <asp:TextBox
                    ID="txtRollOrEmail"
                    runat="server"
                    CssClass="input-field">
                </asp:TextBox>
            </div>

            <div class="text-link-wrapper forgot-password-actions">
                <asp:LinkButton
                    ID="lnkResetPassword"
                    runat="server"
                    CssClass="btn"
                    OnClick="lnkResetPassword_Click"
                    CausesValidation="false">
                    Reset Password
                </asp:LinkButton>
            </div>

            <div class="reg-link">
                <a href="login.aspx">Back to Login</a>
            </div>

        </div>
    </form>
</body>
</html>
