using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SGIPC_Website2
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string token = Request.QueryString["token"];

                if (string.IsNullOrWhiteSpace(token))
                {
                    ShowError("Invalid reset link.");
                    pnlResetForm.Visible = false;
                    return;
                }

                if (!IsValidToken(token))
                {
                    ShowError("Reset link is invalid or expired.");
                    pnlResetForm.Visible = false;
                    return;
                }

                lblMessage.Text = "";
                pnlResetForm.Visible = true;
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string token = Request.QueryString["token"];
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(token))
            {
                ShowError("Invalid reset link.");
                return;
            }

            if (string.IsNullOrWhiteSpace(newPassword) || newPassword.Length < 6)
            {
                ShowError("Password must be at least 6 characters.");
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowError("Passwords do not match.");
                return;
            }

            string tokenHash = Sha256Base64(token);
            string newPasswordHash = HashPassword(newPassword);

            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                SqlTransaction tran = conn.BeginTransaction();

                try
                {
                    string findTokenQuery = @"
                        SELECT TOP 1
                            TokenId,
                            UserId
                        FROM dbo.PasswordResetTokens
                        WHERE TokenHash = @TokenHash
                          AND IsUsed    = 0
                          AND ExpiresAt > GETDATE()";

                    int tokenId = 0;
                    int userId = 0;

                    using (SqlCommand cmd = new SqlCommand(findTokenQuery, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@TokenHash", tokenHash);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                tokenId = Convert.ToInt32(reader["TokenId"]);
                                userId = Convert.ToInt32(reader["UserId"]);
                            }
                        }
                    }

                    if (tokenId == 0 || userId == 0)
                    {
                        tran.Rollback();
                        ShowError("Reset link is invalid or expired.");
                        pnlResetForm.Visible = false;
                        return;
                    }

                    string updatePasswordQuery = @"
                        UPDATE dbo.Users
                        SET PasswordHash = @Password
                        WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(updatePasswordQuery, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@Password", newPasswordHash);
                        cmd.Parameters.AddWithValue("@UserId", userId);

                        int affectedRows = cmd.ExecuteNonQuery();

                        if (affectedRows == 0)
                        {
                            tran.Rollback();
                            ShowError("Password could not be updated.");
                            return;
                        }
                    }

                    string markTokenUsedQuery = @"
                        UPDATE dbo.PasswordResetTokens
                        SET IsUsed = 1
                        WHERE TokenId = @TokenId";

                    using (SqlCommand cmd = new SqlCommand(markTokenUsedQuery, conn, tran))
                    {
                        cmd.Parameters.AddWithValue("@TokenId", tokenId);
                        cmd.ExecuteNonQuery();
                    }

                    tran.Commit();

                    pnlResetForm.Visible = false;
                    ShowSuccess("Password reset successful. You can now login.");
                }
                catch (Exception ex)
                {
                    tran.Rollback();
                    ShowError("Error: " + ex.Message);
                }
            }
        }

        private bool IsValidToken(string token)
        {
            string tokenHash = Sha256Base64(token);
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                string query = @"
                    SELECT COUNT(*)
                    FROM dbo.PasswordResetTokens
                    WHERE TokenHash = @TokenHash
                      AND IsUsed    = 0
                      AND ExpiresAt > GETDATE()";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TokenHash", tokenHash);
                    return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                }
            }
        }

        private static string HashPassword(string password)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(password);
                byte[] hash = sha.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        private static string Sha256Base64(string input)
        {
            using (SHA256 sha = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = sha.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        private void ShowError(string message)
        {
            lblMessage.ForeColor = System.Drawing.Color.Red;
            lblMessage.Text = message;
        }

        private void ShowSuccess(string message)
        {
            lblMessage.ForeColor = System.Drawing.Color.Green;
            lblMessage.Text = message;
        }
    }
}
