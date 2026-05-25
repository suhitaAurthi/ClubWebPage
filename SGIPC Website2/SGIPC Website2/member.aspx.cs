using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SGIPC_Website2
{
    public partial class member : System.Web.UI.Page
    {
        /// <summary>
        /// Registered Member class
        /// </summary>
        public class RegisteredMember
        {
            public int UserId { get; set; }
            public string Username { get; set; }
            public string Email { get; set; }
            public string Roll { get; set; }
            public DateTime CreatedDate { get; set; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    LoadRegisteredMembers();
                }
                else
                {
                    // Handle POST requests for update/delete
                    string action = Request.Form["action"];
                    if (action == "update")
                    {
                        int userId = int.Parse(Request.Form["userId"]);
                        string username = Request.Form["username"];
                        string email = Request.Form["email"];
                        string roll = Request.Form["roll"];
                        UpdateMember(userId, username, email, roll);
                    }
                    else if (action == "delete")
                    {
                        int userId = int.Parse(Request.QueryString["userId"]);
                        DeleteMember(userId);
                    }
                }

                // Check login status and update UI
                CheckLoginStatus();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in Page_Load: " + ex.Message);
            }
        }

        /// <summary>
        /// Check if user is logged in and update UI accordingly
        /// </summary>
        private void CheckLoginStatus()
        {
            if (Session["UserId"] != null)
            {
                pnlNotLoggedIn.Visible = false;
                pnlLoggedIn.Visible = true;
                pnlSidebarNotLoggedIn.Visible = false;
                pnlSidebarLoggedIn.Visible = true;

                lblUserName.Text = Session["Username"]?.ToString() ?? "User";
                lblSidebarUserName.Text = Session["Username"]?.ToString() ?? "User";
            }
            else
            {
                pnlNotLoggedIn.Visible = true;
                pnlLoggedIn.Visible = false;
                pnlSidebarNotLoggedIn.Visible = true;
                pnlSidebarLoggedIn.Visible = false;
            }
        }

        /// <summary>
        /// Load all registered members (non-team members)
        /// </summary>
        private void LoadRegisteredMembers()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    string query = @"SELECT UserId, Username, Email, Roll, CreatedDate FROM Users WHERE IsTeamMember = 0 ORDER BY CreatedDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtMembers = new DataTable();
                        adapter.Fill(dtMembers);

                        if (rptRegisteredMembers != null)
                        {
                            List<RegisteredMember> memberList = new List<RegisteredMember>();

                            foreach (DataRow row in dtMembers.Rows)
                            {
                                memberList.Add(new RegisteredMember
                                {
                                    UserId = (int)row["UserId"],
                                    Username = row["Username"].ToString(),
                                    Email = row["Email"].ToString(),
                                    Roll = row["Roll"].ToString(),
                                    CreatedDate = (DateTime)row["CreatedDate"]
                                });
                            }

                            rptRegisteredMembers.DataSource = memberList;
                            rptRegisteredMembers.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in LoadRegisteredMembers: " + ex.Message + " | " + ex.StackTrace);
            }
        }

        /// <summary>
        /// Update a registered member's information
        /// </summary>
        private void UpdateMember(int userId, string username, string email, string roll)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"UPDATE Users SET Username = @Username, Email = @Email, Roll = @Roll WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.Parameters.AddWithValue("@Username", username);
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Roll", roll);

                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in UpdateMember: " + ex.Message);
            }
        }

        /// <summary>
        /// Delete a registered member
        /// </summary>
        private void DeleteMember(int userId)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"DELETE FROM Users WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in DeleteMember: " + ex.Message);
            }
        }
    }
}