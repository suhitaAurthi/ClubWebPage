<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="logout.aspx.cs" Inherits="SGIPC_Website2.logout" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Logging Out...</title>
    <script type="text/javascript">
        window.onload = function() {
            // Redirect to index after 1 second as fallback
            setTimeout(function() {
                window.location.href = 'index.aspx';
            }, 1000);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center; padding: 50px; font-family: Arial, sans-serif;">
            <h2>Logging Out...</h2>
            <p>Redirecting to home page. Please wait...</p>
            <p><a href="index.aspx">Click here if page doesn't redirect automatically</a></p>
        </div>
    </form>
</body>
</html>
