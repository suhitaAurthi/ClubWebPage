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
                    var currentUser = {{ name: '{EscapeJsString(userName)}', email: '{EscapeJsString(userEmail)}' }};
                    var currentUserId = {userId};";
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "isTeamMember", userScript, true);
                }
                else
                {
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = true;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = true;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = false;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = false;
                    
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "isTeamMember",
                        "var isCurrentUserTeamMember = false; var currentUserId = null;", true);
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
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("LoadEvents error: " + ex.Message);
                }
            }
        }

        /// <summary>
        /// Check if a user is a team member based on Users.IsTeamMember or active TeamMembers.RollNumber.
        /// </summary>
        private bool IsTeamMember(int userId)
        {
            return IsTeamMemberByUserId(userId);
        }

        private static bool IsTeamMemberByUserId(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();
                    
                    string query = @"SELECT COUNT(*)
                                    FROM Users u
                                    WHERE u.UserId = @UserId
                                      AND (
                                            ISNULL(u.IsTeamMember, 0) = 1
                                            OR EXISTS (
                                                SELECT 1
                                                FROM TeamMembers tm
                                                WHERE tm.IsActive = 1
                                                  AND LTRIM(RTRIM(tm.RollNumber)) = LTRIM(RTRIM(u.Roll))
                                            )
                                          )";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        return Convert.ToInt32(cmd.ExecuteScalar()) > 0;
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("IsTeamMemberByUserId error: " + ex.Message);
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
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("GetTeamMembers error: " + ex.Message);
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
            List<Dictionary<string, object>> events = new List<Dictionary<string, object>>();

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
                                        ISNULL(StartTime, '00:00:00') AS StartTime,
                                        ISNULL(EndTime, '00:00:00') AS EndTime,
                                        Description,
                                        Location,
                                        ISNULL(RegistrationStatus, 'open') AS RegistrationStatus,
                                        ISNULL(RegistrationLink, '') AS RegistrationLink,
                                        ISNULL(ContestLink, '') AS ContestLink,
                                        ISNULL(IsPublished, 0) AS IsPublished,
                                        ISNULL(CreatedByUserId, 0) AS CreatedByUserId,
                                        CreatedDate
                                    FROM Events 
                                    WHERE ISNULL(IsPublished, 0) = 1
                                    ORDER BY EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var eventItem = new Dictionary<string, object>
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
                                { "contestLink", reader["ContestLink"]?.ToString() ?? "" },
                                { "isPublished", true },
                                { "createdByUserId", reader["CreatedByUserId"].ToString() }
                            };
                            events.Add(eventItem);
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("GetPublishedEvents error: " + ex.Message);
                    return "{\"success\": false, \"message\": \"Error loading published events: " + ex.Message.Replace("\"", "'") + "\"}";
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(events);
        }

        /// <summary>
        /// Get all events (published + unpublished) for team members - can be called from AJAX endpoint
        /// </summary>
        [WebMethod]
        public static string GetAllEvents(int userId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;
            List<Dictionary<string, object>> events = new List<Dictionary<string, object>>();

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    // First check if user is team member
                    conn.Open();
                    bool isTeamMember = IsTeamMemberByUserId(userId);

                    if (!isTeamMember)
                    {
                        // Not a team member, return published events only
                        return GetPublishedEvents();
                    }

                    // Team member - return all events
                    string query = @"SELECT 
                                        EventId,
                                        EventName,
                                        EventType,
                                        EventDate,
                                        ISNULL(StartTime, '00:00:00') AS StartTime,
                                        ISNULL(EndTime, '00:00:00') AS EndTime,
                                        Description,
                                        Location,
                                        ISNULL(RegistrationStatus, 'open') AS RegistrationStatus,
                                        ISNULL(RegistrationLink, '') AS RegistrationLink,
                                        ISNULL(ContestLink, '') AS ContestLink,
                                        ISNULL(IsPublished, 0) AS IsPublished,
                                        ISNULL(CreatedByUserId, 0) AS CreatedByUserId,
                                        CreatedDate
                                    FROM Events 
                                    ORDER BY EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        SqlDataReader reader = cmd.ExecuteReader();
                        while (reader.Read())
                        {
                            var eventItem = new Dictionary<string, object>
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
                                { "contestLink", reader["ContestLink"]?.ToString() ?? "" },
                                { "isPublished", Convert.ToBoolean(reader["IsPublished"]) },
                                { "createdByUserId", reader["CreatedByUserId"].ToString() }
                            };
                            events.Add(eventItem);
                        }
                    }
                }
                catch (Exception ex)
                {
                    System.Diagnostics.Debug.WriteLine("GetAllEvents error: " + ex.Message);
                    return "{\"success\": false, \"message\": \"Error loading events: " + ex.Message.Replace("\"", "'") + "\"}";
                }
            }

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            return serializer.Serialize(events);
        }

        /// <summary>
        /// Create a new event in the database
        /// </summary>
        // [WebMethod]
        // public static string CreateEventInDatabase(int userId, string title, string description, string eventType, 
        //     string eventDate, string startTime, string endTime, string location, string registrationStatus, 
        //     string registrationLink, string contestLink, bool isPublished)
        // {
        //     string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

        //     using (SqlConnection conn = new SqlConnection(connString))
        //     {
        //         try
        //         {
        //             conn.Open();

        //             // Check if user is team member
        //             string checkTeamQuery = "SELECT IsTeamMember FROM Users WHERE UserId = @UserId";
        //             using (SqlCommand cmd = new SqlCommand(checkTeamQuery, conn))
        //             {
        //                 cmd.Parameters.AddWithValue("@UserId", userId);
        //                 object result = cmd.ExecuteScalar();
        //                 if (result == null || !Convert.ToBoolean(result))
        //                 {
        //                     return "{\"success\": false, \"message\": \"Only team members can create events\"}";
        //                 }
        //             }

        //             // Insert event
        //             string insertQuery = @"INSERT INTO Events 
        //                                 (EventName, Description, EventType, EventDate, StartTime, EndTime, 
        //                                  Location, RegistrationStatus, RegistrationLink, ContestLink, 
        //                                  IsPublished, CreatedByUserId, CreatedDate)
        //                                 VALUES 
        //                                 (@Title, @Description, @EventType, @EventDate, @StartTime, @EndTime,
        //                                  @Location, @RegistrationStatus, @RegistrationLink, @ContestLink,
        //                                  @IsPublished, @CreatedByUserId, GETDATE());
        //                                 SELECT SCOPE_IDENTITY();";

        //             using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
        //             {
        //                 cmd.Parameters.AddWithValue("@Title", title);
        //                 cmd.Parameters.AddWithValue("@Description", description);
        //                 cmd.Parameters.AddWithValue("@EventType", eventType);
        //                 cmd.Parameters.AddWithValue("@EventDate", DateTime.Parse(eventDate));
        //                 cmd.Parameters.AddWithValue("@StartTime", TimeSpan.Parse(startTime));
        //                 cmd.Parameters.AddWithValue("@EndTime", TimeSpan.Parse(endTime));
        //                 cmd.Parameters.AddWithValue("@Location", location);
        //                 cmd.Parameters.AddWithValue("@RegistrationStatus", registrationStatus);
        //                 cmd.Parameters.AddWithValue("@RegistrationLink", registrationLink ?? "");
        //                 cmd.Parameters.AddWithValue("@ContestLink", contestLink ?? "");
        //                 cmd.Parameters.AddWithValue("@IsPublished", isPublished);
        //                 cmd.Parameters.AddWithValue("@CreatedByUserId", userId);

        //                 object eventId = cmd.ExecuteScalar();
        //                 return "{\"success\": true, \"message\": \"Event created successfully\", \"eventId\": " + eventId + "}";
        //             }
        //         }
        //         catch (Exception ex)
        //         {
        //             return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
        //         }
        //     }
        // }
[WebMethod]
public static string CreateEventInDatabase(int userId, string title, string description, string eventType, 
    string eventDate, string startTime, string endTime, string location, string registrationStatus, 
    string registrationLink, string contestLink, bool isPublished)
{
    // === PARAMETER LOGGING ===
    System.Diagnostics.Debug.WriteLine("========== CreateEventInDatabase CALLED ==========");
    System.Diagnostics.Debug.WriteLine($"UserId: {userId}");
    System.Diagnostics.Debug.WriteLine($"Title: {title}");
    System.Diagnostics.Debug.WriteLine($"Description: {description}");
    System.Diagnostics.Debug.WriteLine($"EventType: {eventType}");
    System.Diagnostics.Debug.WriteLine($"EventDate: {eventDate}");
    System.Diagnostics.Debug.WriteLine($"StartTime: {startTime}");
    System.Diagnostics.Debug.WriteLine($"EndTime: {endTime}");
    System.Diagnostics.Debug.WriteLine($"Location: {location}");
    System.Diagnostics.Debug.WriteLine($"RegistrationStatus: {registrationStatus}");
    System.Diagnostics.Debug.WriteLine($"RegistrationLink: {registrationLink}");
    System.Diagnostics.Debug.WriteLine($"ContestLink: {contestLink}");
    System.Diagnostics.Debug.WriteLine($"IsPublished: {isPublished}");
    
    string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

    using (SqlConnection conn = new SqlConnection(connString))
    {
        try
        {
            conn.Open();
            System.Diagnostics.Debug.WriteLine("Database connection opened successfully");

            // Check if user is team member
            if (!IsTeamMemberByUserId(userId))
            {
                System.Diagnostics.Debug.WriteLine("Team member check failed - returning error");
                return "{\"success\": false, \"message\": \"Only team members can create events\"}";
            }
            System.Diagnostics.Debug.WriteLine("Team member check passed");

            // --- Robust DateTime and TimeSpan Parsing ---
            if (!DateTime.TryParse(eventDate, out DateTime parsedDate))
            {
                System.Diagnostics.Debug.WriteLine($"ERROR: DateTime parsing failed for: {eventDate}");
                return "{\"success\": false, \"message\": \"Invalid Event Date format.\"}";
            }
            System.Diagnostics.Debug.WriteLine($"Parsed EventDate successfully: {parsedDate:yyyy-MM-dd}");

            // Standardize HTML5 time inputs (HH:mm) to support TimeSpan parsing (HH:mm:ss)
            if (startTime.Length == 5) startTime += ":00";
            if (endTime.Length == 5) endTime += ":00";

            if (!TimeSpan.TryParse(startTime, out TimeSpan parsedStart) || 
                !TimeSpan.TryParse(endTime, out TimeSpan parsedEnd))
            {
                System.Diagnostics.Debug.WriteLine($"ERROR: TimeSpan parsing failed. StartTime: {startTime}, EndTime: {endTime}");
                return "{\"success\": false, \"message\": \"Invalid Start or End Time format.\"}";
            }
            System.Diagnostics.Debug.WriteLine($"Parsed times successfully - Start: {parsedStart}, End: {parsedEnd}");

            // Insert event
            string insertQuery = @"INSERT INTO Events 
                                (EventName, Description, EventType, EventDate, StartTime, EndTime, 
                                 Location, RegistrationStatus, RegistrationLink, ContestLink, 
                                 IsPublished, CreatedByUserId, CreatedDate)
                                VALUES 
                                (@Title, @Description, @EventType, @EventDate, @StartTime, @EndTime,
                                 @Location, @RegistrationStatus, @RegistrationLink, @ContestLink,
                                 @IsPublished, @CreatedByUserId, GETDATE());
                                SELECT SCOPE_IDENTITY();";

            using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
            {
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Description", description);
                cmd.Parameters.AddWithValue("@EventType", eventType);
                cmd.Parameters.AddWithValue("@EventDate", parsedDate);
                cmd.Parameters.AddWithValue("@StartTime", parsedStart);
                cmd.Parameters.AddWithValue("@EndTime", parsedEnd);
                cmd.Parameters.AddWithValue("@Location", location);
                cmd.Parameters.AddWithValue("@RegistrationStatus", registrationStatus);
                cmd.Parameters.AddWithValue("@RegistrationLink", registrationLink ?? "");
                cmd.Parameters.AddWithValue("@ContestLink", contestLink ?? "");
                cmd.Parameters.AddWithValue("@IsPublished", isPublished);
                cmd.Parameters.AddWithValue("@CreatedByUserId", userId);

                System.Diagnostics.Debug.WriteLine("Executing INSERT query...");
                object eventId = cmd.ExecuteScalar();
                System.Diagnostics.Debug.WriteLine($"INSERT successful! New EventId: {eventId}");
                
                // Return a properly structured JSON string
                return "{\"success\": true, \"message\": \"Event created successfully\", \"eventId\": " + eventId + "}";
            }
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine($"EXCEPTION in CreateEventInDatabase: {ex.GetType().Name}");
            System.Diagnostics.Debug.WriteLine($"Message: {ex.Message}");
            System.Diagnostics.Debug.WriteLine($"StackTrace: {ex.StackTrace}");
            
            // Escape inner quotes safely
            string safeMessage = ex.Message.Replace("\"", "\\\"");
            return "{\"success\": false, \"message\": \"" + safeMessage + "\"}";
        }
    }
}
        /// <summary>
        /// Register/Enroll a user for an event
        /// </summary>
        [WebMethod]
        public static string RegisterForEvent(int userId, int eventId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // Check if user already registered
                    string checkQuery = @"SELECT COUNT(*) FROM EventRegistrations 
                                        WHERE EventId = @EventId AND UserId = @UserId";
                    using (SqlCommand cmd = new SqlCommand(checkQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        int count = (int)cmd.ExecuteScalar();
                        if (count > 0)
                        {
                            return "{\"success\": false, \"message\": \"You are already registered for this event\"}";
                        }
                    }

                    // Check if event exists and is published
                    string eventCheckQuery = @"SELECT COUNT(*) FROM Events 
                                            WHERE EventId = @EventId AND IsPublished = 1";
                    using (SqlCommand cmd = new SqlCommand(eventCheckQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        int count = (int)cmd.ExecuteScalar();
                        if (count == 0)
                        {
                            return "{\"success\": false, \"message\": \"Event not found or not published\"}";
                        }
                    }

                    // Register user
                    string registerQuery = @"INSERT INTO EventRegistrations (EventId, UserId, RegistrationDate, Status)
                                            VALUES (@EventId, @UserId, GETDATE(), 'registered')";
                    using (SqlCommand cmd = new SqlCommand(registerQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        cmd.ExecuteNonQuery();
                    }

                    return "{\"success\": true, \"message\": \"Successfully registered for the event\"}";
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }
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

        /// <summary>
        /// Delete an event from the database (any team member can delete)
        /// </summary>
        [WebMethod]
        public static string DeleteEvent(int userId, int eventId)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // Check if user is team member
                    if (!IsTeamMemberByUserId(userId))
                    {
                        return "{\"success\": false, \"message\": \"Only team members can delete events\"}";
                    }

                    // Check if event exists
                    string checkEventQuery = "SELECT COUNT(*) FROM Events WHERE EventId = @EventId";
                    using (SqlCommand cmd = new SqlCommand(checkEventQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        int count = (int)cmd.ExecuteScalar();
                        if (count == 0)
                        {
                            return "{\"success\": false, \"message\": \"Event not found\"}";
                        }
                    }

                    // Delete event registrations first
                    string deleteRegistrationsQuery = "DELETE FROM EventRegistrations WHERE EventId = @EventId";
                    using (SqlCommand cmd = new SqlCommand(deleteRegistrationsQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        cmd.ExecuteNonQuery();
                    }

                    // Delete the event
                    string deleteQuery = "DELETE FROM Events WHERE EventId = @EventId";
                    using (SqlCommand cmd = new SqlCommand(deleteQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        cmd.ExecuteNonQuery();
                    }

                    return "{\"success\": true, \"message\": \"Event deleted successfully\"}";
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }
        }

        /// <summary>
        /// Update/Edit an existing event (any team member can edit)
        /// </summary>
        [WebMethod]
        public static string EditEvent(int userId, int eventId, string title, string description, string eventType, 
            string eventDate, string startTime, string endTime, string location, string registrationStatus, 
            string registrationLink, string contestLink, bool isPublished)
        {
            string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                try
                {
                    conn.Open();

                    // Check if user is team member
                    if (!IsTeamMemberByUserId(userId))
                    {
                        return "{\"success\": false, \"message\": \"Only team members can edit events\"}";
                    }

                    // Check if event exists
                    string checkEventQuery = "SELECT COUNT(*) FROM Events WHERE EventId = @EventId";
                    using (SqlCommand cmd = new SqlCommand(checkEventQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        int count = (int)cmd.ExecuteScalar();
                        if (count == 0)
                        {
                            return "{\"success\": false, \"message\": \"Event not found\"}";
                        }
                    }

                    if (!DateTime.TryParse(eventDate, out DateTime parsedDate))
                    {
                        return "{\"success\": false, \"message\": \"Invalid Event Date format.\"}";
                    }

                    if (startTime.Length == 5) startTime += ":00";
                    if (endTime.Length == 5) endTime += ":00";

                    if (!TimeSpan.TryParse(startTime, out TimeSpan parsedStart) ||
                        !TimeSpan.TryParse(endTime, out TimeSpan parsedEnd))
                    {
                        return "{\"success\": false, \"message\": \"Invalid Start or End Time format.\"}";
                    }

                    // Update event
                    string updateQuery = @"UPDATE Events SET
                                            EventName = @Title,
                                            Description = @Description,
                                            EventType = @EventType,
                                            EventDate = @EventDate,
                                            StartTime = @StartTime,
                                            EndTime = @EndTime,
                                            Location = @Location,
                                            RegistrationStatus = @RegistrationStatus,
                                            RegistrationLink = @RegistrationLink,
                                            ContestLink = @ContestLink,
                                            IsPublished = @IsPublished
                                        WHERE EventId = @EventId";

                    using (SqlCommand cmd = new SqlCommand(updateQuery, conn))
                    {
                        cmd.Parameters.AddWithValue("@EventId", eventId);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Description", description);
                        cmd.Parameters.AddWithValue("@EventType", eventType);
                        cmd.Parameters.AddWithValue("@EventDate", parsedDate);
                        cmd.Parameters.AddWithValue("@StartTime", parsedStart);
                        cmd.Parameters.AddWithValue("@EndTime", parsedEnd);
                        cmd.Parameters.AddWithValue("@Location", location);
                        cmd.Parameters.AddWithValue("@RegistrationStatus", registrationStatus);
                        cmd.Parameters.AddWithValue("@RegistrationLink", registrationLink ?? "");
                        cmd.Parameters.AddWithValue("@ContestLink", contestLink ?? "");
                        cmd.Parameters.AddWithValue("@IsPublished", isPublished);
                        cmd.ExecuteNonQuery();
                    }

                    return "{\"success\": true, \"message\": \"Event updated successfully\"}";
                }
                catch (Exception ex)
                {
                    return "{\"success\": false, \"message\": \"" + ex.Message.Replace("\"", "'") + "\"}";
                }
            }
        }
    }
}
