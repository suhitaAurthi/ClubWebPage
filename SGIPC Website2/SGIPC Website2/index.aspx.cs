using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;

namespace SGIPC_Website2
{
    public partial class index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Check if user is logged in
                if (Session["UserId"] != null)
                {
                    // User is logged in - display username
                    int userId = Convert.ToInt32(Session["UserId"]);
                    string userName = Session["UserName"] != null ? Session["UserName"].ToString() : "User";
                    string userEmail = Session["UserEmail"] != null ? Session["UserEmail"].ToString() : "";
                    
                    // Hide login/register panels
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = false;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = false;
                    
                    // Show logged-in panels
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = true;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = true;
                    
                    // Set username labels
                    if (lblUserName != null) lblUserName.Text = userName;
                    if (lblSidebarUserName != null) lblSidebarUserName.Text = "Logged in as: " + userName;
                    
                    // Load member registrations if the panel exists
                    if (pnlMemberRegistrations != null)
                    {
                        pnlMemberRegistrations.Visible = true;
                        LoadMemberRegistrations(userId);
                    }
                }
                else
                {
                    // User is not logged in
                    if (pnlNotLoggedIn != null) pnlNotLoggedIn.Visible = true;
                    if (pnlSidebarNotLoggedIn != null) pnlSidebarNotLoggedIn.Visible = true;
                    if (pnlLoggedIn != null) pnlLoggedIn.Visible = false;
                    if (pnlSidebarLoggedIn != null) pnlSidebarLoggedIn.Visible = false;
                    
                    // Hide registrations panel for non-logged-in users
                    if (pnlMemberRegistrations != null)
                    {
                        pnlMemberRegistrations.Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                // Silent exception handling - controls may not exist yet
            }
        }

        private void LoadMemberRegistrations(int userId)
        {
            try
            {
                string connString = ConfigurationManager.ConnectionStrings["SGIPCConnection"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    
                    string query = @"SELECT 
                                        r.RegistrationId, 
                                        e.EventName, 
                                        e.EventDate, 
                                        e.EventType,
                                        r.RegistrationDate,
                                        r.Status
                                    FROM Registrations r
                                    INNER JOIN Events e ON r.EventId = e.EventId
                                    WHERE r.UserId = @UserId
                                    ORDER BY e.EventDate DESC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@UserId", userId);
                        SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                        DataTable dtRegistrations = new DataTable();
                        adapter.Fill(dtRegistrations);

                        if (dtRegistrations.Rows.Count > 0)
                        {
                            // Bind to GridView if it exists, otherwise just set visibility
                            if (gvMemberRegistrations != null)
                            {
                                gvMemberRegistrations.DataSource = dtRegistrations;
                                gvMemberRegistrations.DataBind();
                            }
                        }
                        else
                        {
                            // No registrations found
                            if (lblNoRegistrations != null)
                            {
                                lblNoRegistrations.Visible = true;
                            }
                        }
                    }
                }
            }
            catch (SqlException sqlEx)
            {
                // Handle SQL errors silently or log them
            }
            catch (Exception ex)
            {
                // Handle other errors silently
            }
        }
    }
}