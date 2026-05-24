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
    public partial class team : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
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
                // Control handling
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

                        // Group data by category
                        var categories = dtTeamMembers.AsEnumerable()
                            .GroupBy(row => row["Category"].ToString())
                            .ToList();

                        rptCategories.DataSource = categories.Select(g => new
                        {
                            CategoryName = g.Key,
                            Members = g.ToList()
                        }).ToList();
                        rptCategories.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle error
            }
        }
    }
}