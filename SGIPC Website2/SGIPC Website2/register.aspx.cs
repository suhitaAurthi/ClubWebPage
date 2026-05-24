using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace SGIPC_Website2
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] != null)
            {
                Response.Redirect("index.aspx");
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                string fullName = fullname.Value.Trim();
                string rollNumber = roll.Value.Trim();
                string emailInput = email.Value.Trim();
                string pwd = password.Value.Trim();
                string confirmPwd = confirmPassword.Value.Trim();

                // Validation
                if (string.IsNullOrWhiteSpace(fullName) || string.IsNullOrWhiteSpace(rollNumber) || 
                    string.IsNullOrWhiteSpace(emailInput) || string.IsNullOrWhiteSpace(pwd))
                {
                    return;
                }

                if (pwd != confirmPwd)
                {
                    return;
                }

                if (pwd.Length < 6)
                {
                    return;
                }

                string hashedPassword = HashPassword(pwd);
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"INSERT INTO Users (Email, Username, Roll, PasswordHash, CreatedDate) 
                                     VALUES (@Email, @Username, @Roll, @Password, GETDATE())";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", emailInput);
                        cmd.Parameters.AddWithValue("@Username", fullName);
                        cmd.Parameters.AddWithValue("@Roll", rollNumber);
                        cmd.Parameters.AddWithValue("@Password", hashedPassword);

                        int result = cmd.ExecuteNonQuery();
                        if (result > 0)
                        {
                            Response.Redirect("login.aspx?success=1");
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                // Handle SQL errors
            }
            catch (Exception ex)
            {
                // Handle other errors
            }
        }

        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] hashedBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                return Convert.ToBase64String(hashedBytes);
            }
        }
    }
}