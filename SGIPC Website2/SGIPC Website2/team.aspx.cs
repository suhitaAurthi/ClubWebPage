using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace SGIPC_Website2
{
    // Helper class for individual team member
    public class TeamMember
    {
        public int TeamMemberId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Role { get; set; }
        public string RollNumber { get; set; }
        public string BatchYear { get; set; }
    }

    // Helper class for team categories
    public class TeamCategory
    {
        public string CategoryName { get; set; }
        public List<TeamMember> Members { get; set; }
    }

    public partial class team : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Handle AJAX requests for update/delete
                if (Request.HttpMethod == "POST")
                {
                    string action = Request.Form["action"];
                    if (!string.IsNullOrEmpty(action))
                    {
                        if (action == "update")
                        {
                            int userId = Convert.ToInt32(Request.Form["userId"]);
                            string username = Request.Form["username"];
                            string email = Request.Form["email"];
                            string roll = Request.Form["roll"];
                            UpdateMember(userId, username, email, roll);
                        }
                    }
                }

                // Handle delete via query string
                if (!string.IsNullOrEmpty(Request.QueryString["action"]) && Request.QueryString["action"] == "delete")
                {
                    if (!string.IsNullOrEmpty(Request.QueryString["userId"]))
                    {
                        int userId = Convert.ToInt32(Request.QueryString["userId"]);
                        DeleteMember(userId);
                    }
                    return;
                }

                // Check login status
                if (Session["UserId"] != null)
                {
                    string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = false;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = false;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = true;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = true;
                    if (lblUserName != null) lblUserName.Text = userName;
                    if (lblSidebarUserName != null) lblSidebarUserName.Text = "Logged in as: " + userName;
                }
                else
                {
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = true;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = true;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = false;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = false;
                }

                // Load team members from database
                if (!IsPostBack)
                {
                    LoadTeamMembers();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in Page_Load: " + ex.Message);
            }
        }

        private void LoadTeamMembers()
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    string query = @"SELECT 
                                        Category, 
                                        TeamMemberId,
                                        FirstName,
                                        LastName,
                                        Role,
                                        RollNumber,
                                        BatchYear
                                    FROM TeamMembers 
                                    WHERE IsActive = 1 
                                    ORDER BY 
                                        CASE Category
                                            WHEN 'Club Leadership' THEN 1
                                            WHEN 'Core Team Members' THEN 2
                                            WHEN 'Performance Analyzers' THEN 3
                                            WHEN 'Batch Representatives' THEN 4
                                            WHEN 'Senior Mentor for Boys' THEN 5
                                            WHEN 'Junior Mentor For Boys' THEN 6
                                            WHEN 'Contest Manager' THEN 7
                                            WHEN 'Assistant Contest Manager' THEN 8
                                            WHEN 'Workshop Manager' THEN 9
                                            WHEN 'Assistant Workshop Manager' THEN 10
                                            ELSE 11
                                        END,
                                        Role,
                                        FirstName";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtTeamMembers = new DataTable();
                        adapter.Fill(dtTeamMembers);

                        // Group data by category first
                        var categoryGroups = dtTeamMembers.AsEnumerable()
                            .GroupBy(row => row["Category"].ToString())
                            .ToList();

                        if (rptCategories != null)
                        {
                            rptCategories.DataSource = categoryGroups.Select(g => new TeamCategory
                            {
                                CategoryName = g.Key,
                                Members = g.Select(row => new TeamMember
                                {
                                    TeamMemberId = (int)row["TeamMemberId"],
                                    FirstName = row["FirstName"].ToString(),
                                    LastName = row["LastName"].ToString(),
                                    Role = row["Role"].ToString(),
                                    RollNumber = row["RollNumber"].ToString(),
                                    BatchYear = row["BatchYear"].ToString()
                                }).ToList()
                            }).ToList();
                            rptCategories.DataBind();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error in LoadTeamMembers: " + ex.Message + " | " + ex.StackTrace);
            }
        }

        /// <summary>
        /// Update a registered member's information
        /// </summary>
        protected void UpdateMember(int userId, string username, string email, string roll)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string query = @"UPDATE Users 
                                     SET Username = @Username, Email = @Email, Roll = @Roll 
                                     WHERE UserId = @UserId";

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
        protected void DeleteMember(int userId)
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

        /// <summary>
        /// Get user's registered events/contests as JSON
        /// </summary>
        [System.Web.Services.WebMethod]
        public static string GetUserRegisteredEvents(int userId)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
                List<Dictionary<string, string>> events = new List<Dictionary<string, string>>();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    
                    // This queries Events table - you may need to adjust based on your registration schema
                    string query = @"SELECT 
                                        EventId,
                                        EventName,
                                        EventType,
                                        EventDate,
                                        StartTime,
                                        EndTime
                                    FROM Events 
                                    WHERE IsPublished = 1
                                    ORDER BY EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            events.Add(new Dictionary<string, string>
                            {
                                { "id", reader["EventId"].ToString() },
                                { "name", reader["EventName"].ToString() },
                                { "type", reader["EventType"].ToString() },
                                { "date", Convert.ToDateTime(reader["EventDate"]).ToString("dd MMM yyyy") },
                                { "time", reader["StartTime"].ToString() }
                            });
                        }
                    }
                }

                System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
                return serializer.Serialize(events);
            }
            catch (Exception ex)
            {
                return "[]";
            }
        }
    }
}