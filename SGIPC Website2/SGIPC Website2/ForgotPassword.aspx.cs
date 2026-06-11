using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

namespace SGIPC_Website2
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblMessage.Text = "";
            }
        }

        protected void lnkResetPassword_Click(object sender, EventArgs e)
        {
            string input = txtRollOrEmail.Text.Trim();

            if (string.IsNullOrWhiteSpace(input))
            {
                ShowError("Please enter your roll or email.");
                return;
            }

            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    string query = @"
                        SELECT TOP 1
                            u.UserId,
                            u.Username,
                            u.Email,
                            u.Roll
                        FROM dbo.Users u
                        WHERE
                            (
                                LTRIM(RTRIM(u.Email)) = LTRIM(RTRIM(@Input))
                                OR LTRIM(RTRIM(u.Roll)) = LTRIM(RTRIM(@Input))
                            )
                            AND ISNULL(u.PasswordHash, '') <> ''";

                    int userId = 0;

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Input", input);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                userId = Convert.ToInt32(reader["UserId"]);
                            }
                        }
                    }

                    if (userId == 0)
                    {
                        ShowError("No account found for this roll or email.");
                        return;
                    }

                    // Generate a secure random token and store its hash in the DB.
                    // FIX: was using Session to pass userId — ResetPassword.aspx reads
                    //      a token from ?token= query string, so Session was never used.
                    string plainToken = GenerateToken();
                    string tokenHash = Sha256Base64(plainToken);

                    string insertTokenQuery = @"
                        INSERT INTO dbo.PasswordResetTokens (UserId, TokenHash, IsUsed, ExpiresAt)
                        VALUES (@UserId, @TokenHash, 0, DATEADD(HOUR, 1, GETDATE()))";

                    using (SqlCommand cmd = new SqlCommand(insertTokenQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@TokenHash", tokenHash);
                        cmd.ExecuteNonQuery();
                    }

                    Response.Redirect("~/reset-password.aspx?token=" + Uri.EscapeDataString(plainToken), false);
                    Context.ApplicationInstance.CompleteRequest();
                }
                catch (Exception ex)
                {
                    ShowError("Error: " + ex.Message);
                }
            }
        }

        private static string GenerateToken()
        {
            byte[] bytes = new byte[32];
            using (RandomNumberGenerator rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(bytes);
            }
            return Convert.ToBase64String(bytes);
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
    }
}
