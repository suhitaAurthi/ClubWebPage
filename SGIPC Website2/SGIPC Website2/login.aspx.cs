using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace SGIPC_Website2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userInput = roll.Value.Trim();
            string userPassword = password.Value.Trim();

            if (string.IsNullOrWhiteSpace(userInput) || string.IsNullOrWhiteSpace(userPassword))
            {
                lblMessage.Text = "Please enter username/email and password.";
                return;
            }

            string hashedPassword = HashPassword(userPassword);
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    string checkQuery = @"
                        SELECT UserId, Email, Username, PasswordHash
                        FROM dbo.Users
                        WHERE Email = @Email OR Roll = @Roll";

                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Email", userInput);
                        checkCmd.Parameters.AddWithValue("@Roll", userInput);

                        using (SqlDataReader checkReader = checkCmd.ExecuteReader())
                        {
                            if (checkReader.Read())
                            {
                                int userId = Convert.ToInt32(checkReader["UserId"]);
                                string email = checkReader["Email"].ToString();
                                string username = checkReader["Username"].ToString();
                                string storedHash = checkReader["PasswordHash"].ToString();

                                if (storedHash == hashedPassword)
                                {
                                    Session["UserId"] = userId;
                                    Session["UserEmail"] = email;
                                    Session["UserName"] = username;
                                    Session.Timeout = 30;

                                    // Close reader before running the update on the same connection.
                                    checkReader.Close();

                                    string updateQuery = "UPDATE dbo.Users SET LastLogin = GETDATE() WHERE UserId = @UserId";
                                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, conn))
                                    {
                                        updateCmd.Parameters.AddWithValue("@UserId", userId);
                                        updateCmd.ExecuteNonQuery();
                                    }

                                    Response.Redirect("index.aspx", true);
                                }
                                else
                                {
                                    lblMessage.Text = "Incorrect password.";
                                }
                            }
                            else
                            {
                                lblMessage.Text = "User not found. Check your email/roll number.";
                            }
                        }
                    }
                }
                catch (SqlException sqlEx)
                {
                    lblMessage.Text = "Database error: " + sqlEx.Message;
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Error: " + ex.Message;
                }
            }
        }

        private static string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }
    }
}
