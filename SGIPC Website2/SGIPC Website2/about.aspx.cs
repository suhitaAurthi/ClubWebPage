using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SGIPC_Website2
{
    public partial class about : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
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
            }
            catch (Exception)
            {
                // Control handling
            }
        }
    }
}