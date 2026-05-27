using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;
using System.Web.Script.Serialization;

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
                        if (Session["UserId"] != null && Convert.ToInt32(Session["UserId"]) == userId)
                        {
                            string username = Request.Form["username"];
                            string email = Request.Form["email"];
                            string roll = Request.Form["roll"];
                            UpdateMember(userId, username, email, roll);
                        }
                    }
                    else if (action == "delete")
                    {
                        int userId = int.Parse(Request.QueryString["userId"]);
                        if (Session["UserId"] != null && Convert.ToInt32(Session["UserId"]) == userId)
                        {
                            DeleteMember(userId);
                        }
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
                int currentUserId = Convert.ToInt32(Session["UserId"]);
                pnlNotLoggedIn.Visible = false;
                pnlLoggedIn.Visible = true;
                pnlSidebarNotLoggedIn.Visible = false;
                pnlSidebarLoggedIn.Visible = true;

                lblUserName.Text = Session["UserName"]?.ToString() ?? "User";
                lblSidebarUserName.Text = Session["UserName"]?.ToString() ?? "User";

                Page.ClientScript.RegisterStartupScript(this.GetType(), "memberCurrentUser",
                    "var currentUserId = " + currentUserId + ";", true);
            }
            else
            {
                pnlNotLoggedIn.Visible = true;
                pnlLoggedIn.Visible = false;
                pnlSidebarNotLoggedIn.Visible = true;
                pnlSidebarLoggedIn.Visible = false;

                Page.ClientScript.RegisterStartupScript(this.GetType(), "memberCurrentUser",
                    "var currentUserId = null;", true);
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
        private static void UpdateMemberRecord(int userId, string username, string email, string roll)
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

        private void UpdateMember(int userId, string username, string email, string roll)
        {
            try
            {
                UpdateMemberRecord(userId, username, email, roll);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in UpdateMember: " + ex.Message);
            }
        }

        /// <summary>
        /// Delete a registered member
        /// </summary>
        private static void DeleteMemberRecord(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand("DELETE FROM EventRegistrations WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.ExecuteNonQuery();
                }

                using (SqlCommand cmd = new SqlCommand("DELETE FROM Users WHERE UserId = @UserId", conn))
                {
                    cmd.Parameters.AddWithValue("@UserId", userId);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void DeleteMember(int userId)
        {
            try
            {
                DeleteMemberRecord(userId);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in DeleteMember: " + ex.Message);
            }
        }

        [WebMethod(EnableSession = true)]
        public static string UpdateMemberAjax(int userId, string username, string email, string roll)
        {
            try
            {
                if (!IsCurrentSessionUser(userId))
                {
                    return "{\"success\": false, \"message\": \"You can only update your own details\"}";
                }

                if (string.IsNullOrWhiteSpace(username) || string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(roll))
                {
                    return "{\"success\": false, \"message\": \"Name, email, and roll are required\"}";
                }

                UpdateMemberRecord(userId, username.Trim(), email.Trim(), roll.Trim());

                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session["UserName"] = username.Trim();
                    HttpContext.Current.Session["UserEmail"] = email.Trim();
                }

                return "{\"success\": true, \"message\": \"Member updated successfully\"}";
            }
            catch (Exception ex)
            {
                return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        [WebMethod(EnableSession = true)]
        public static string DeleteMemberAjax(int userId)
        {
            try
            {
                if (!IsCurrentSessionUser(userId))
                {
                    return "{\"success\": false, \"message\": \"You can only delete your own account\"}";
                }

                DeleteMemberRecord(userId);

                if (HttpContext.Current != null && HttpContext.Current.Session != null)
                {
                    HttpContext.Current.Session.Clear();
                }

                return "{\"success\": true, \"message\": \"Member deleted successfully\"}";
            }
            catch (Exception ex)
            {
                return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        [WebMethod]
        public static string GetUserRegisteredEvents(int userId)
        {
            List<Dictionary<string, string>> events = new List<Dictionary<string, string>>();
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"SELECT e.EventId, e.EventName, e.EventType, e.EventDate, e.StartTime, e.EndTime, ISNULL(er.Status, 'registered') AS Status
                                    FROM EventRegistrations er
                                    INNER JOIN Events e ON e.EventId = er.EventId
                                    WHERE er.UserId = @UserId
                                    ORDER BY e.EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            while (reader.Read())
                            {
                                events.Add(new Dictionary<string, string>
                                {
                                    { "id", reader["EventId"].ToString() },
                                    { "name", reader["EventName"].ToString() },
                                    { "type", reader["EventType"].ToString() },
                                    { "date", Convert.ToDateTime(reader["EventDate"]).ToString("dd MMM yyyy") },
                                    { "time", reader["StartTime"].ToString() + " - " + reader["EndTime"].ToString() },
                                    { "status", reader["Status"].ToString() }
                                });
                            }
                        }
                    }
                }

                JavaScriptSerializer serializer = new JavaScriptSerializer();
                return serializer.Serialize(events);
            }
            catch (Exception ex)
            {
                return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
            }
        }

        private static bool IsCurrentSessionUser(int userId)
        {
            if (HttpContext.Current == null || HttpContext.Current.Session == null || HttpContext.Current.Session["UserId"] == null)
            {
                return false;
            }

            return Convert.ToInt32(HttpContext.Current.Session["UserId"]) == userId;
        }
    }
}
