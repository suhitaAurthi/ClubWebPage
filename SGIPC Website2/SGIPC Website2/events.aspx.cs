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
    public partial class events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEvents();
            }

            try
            {
                if (Session["UserId"] != null)
                {
                    int userId = Convert.ToInt32(Session["UserId"]);
                    string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
                    string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "";
                    
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = false;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = false;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = true;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = true;
                    if (lblUserName != null) lblUserName.Text = userName;
                    if (lblSidebarUserName != null) lblSidebarUserName.Text = "Logged in as: " + userName;
                    
                    // Check if user is a team member for event creation access
                    bool isTeamMember = IsTeamMember(userId);
                    // Pass user info to JavaScript so events.js has accurate currentUser data
                    string userScript = $@"var isCurrentUserTeamMember = {(isTeamMember ? "true" : "false")};
                    var currentUser = {{ name: '{EscapeJsString(userName)}', email: '{EscapeJsString(userEmail)}' }};";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "isTeamMember", userScript, true);
                }
                else
                {
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = true;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = true;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = false;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = false;
                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "isTeamMember",
                        "var isCurrentUserTeamMember = false;", true);
                }
            }
            catch (Exception)
            {
                // Control handling
            }
        }

        private void LoadEvents()
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    string query = @"SELECT 
                                        EventId, 
                                        EventName, 
                                        EventType, 
                                        EventDate, 
                                        StartTime,
                                        EndTime,
                                        Description, 
                                        Location,
                                        RegistrationStatus,
                                        RegistrationLink,
                                        ContestLink,
                                        IsPublished,
                                        CreatedByUserId,
                                        CreatedDate
                                    FROM Events 
                                    ORDER BY EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        // Store in session for now to pass to JavaScript if needed
                        // Events are typically loaded dynamically via JavaScript from localStorage
                        // For now, the HTML form handles display through JavaScript
                    }
                }
                catch (Exception)
                {
                    // Log error
                }
            }
        }

        /// <summary>
        /// Check if a user is a team member based on IsTeamMember flag in Users table
        /// </summary>
        private bool IsTeamMember(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    
                    string query = @"SELECT IsTeamMember FROM Users 
                                    WHERE UserId = @UserId";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        object result = cmd.ExecuteScalar();
                        
                        if (result != null && result != DBNull.Value)
                        {
                            return Convert.ToBoolean(result);
                        }
                        return false;
                    }
                }
                catch (Exception)
                {
                    return false;
                }
            }
        }

        /// <summary>
        /// Get all team members - can be called from AJAX endpoint
        /// </summary>
        [WebMethod]
        public static string GetTeamMembers()
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
            List<Dictionary<string, string>> teamMembers = new List<Dictionary<string, string>>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    
                    string query = @"SELECT 
                                        UserId,
                                        Username,
                                        Email,
                                        Roll,
                                        CreatedDate
                                    FROM Users 
                                    WHERE IsTeamMember = 1
                                    ORDER BY CreatedDate ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var member = new Dictionary<string, string>
                            {
                                { "id", reader["UserId"].ToString() },
                                { "name", reader["Username"].ToString() },
                                { "email", reader["Email"].ToString() },
                                { "roll", reader["Roll"].ToString() },
                                { "joinDate", Convert.ToDateTime(reader["CreatedDate"]).ToString("yyyy-MM-dd") }
                            };
                            teamMembers.Add(member);
                        }
                    }
                }
                catch (Exception)
                {
                    // Return error
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(teamMembers);
        }

        /// <summary>
        /// Get all published events - can be called from AJAX endpoint
        /// </summary>
        [WebMethod]
        public static string GetPublishedEvents()
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
            List<Dictionary<string, string>> events = new List<Dictionary<string, string>>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    
                    string query = @"SELECT 
                                        EventId,
                                        EventName,
                                        EventType,
                                        EventDate,
                                        StartTime,
                                        EndTime,
                                        Description,
                                        Location,
                                        RegistrationStatus,
                                        RegistrationLink,
                                        ContestLink,
                                        IsPublished,
                                        CreatedDate
                                    FROM Events 
                                    WHERE IsPublished = 1
                                    ORDER BY EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var eventItem = new Dictionary<string, string>
                            {
                                { "id", reader["EventId"].ToString() },
                                { "title", reader["EventName"].ToString() },
                                { "eventType", reader["EventType"].ToString() },
                                { "eventDate", Convert.ToDateTime(reader["EventDate"]).ToString("yyyy-MM-dd") },
                                { "startTime", reader["StartTime"].ToString() },
                                { "endTime", reader["EndTime"].ToString() },
                                { "description", reader["Description"].ToString() },
                                { "location", reader["Location"].ToString() },
                                { "registrationStatus", reader["RegistrationStatus"].ToString() },
                                { "registrationLink", reader["RegistrationLink"]?.ToString() ?? "" },
                                { "contestLink", reader["ContestLink"]?.ToString() ?? "" }
                            };
                            events.Add(eventItem);
                        }
                    }
                }
                catch (Exception)
                {
                    // Return error
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(events);
        }

        /// <summary>
        /// Escapes special characters in a string for safe JavaScript literal use
        /// </summary>
        private string EscapeJsString(string str)
        {
            if (string.IsNullOrEmpty(str))
                return "";
            
            return str.Replace("\\", "\\\\")
                      .Replace("\"", "\\\"")
                      .Replace("'", "\\'")
                      .Replace("\n", "\\n")
                      .Replace("\r", "\\r")
                      .Replace("\t", "\\t");
        }
    }
}