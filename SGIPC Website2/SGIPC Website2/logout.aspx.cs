using System;

namespace SGIPC_Website2
{
    public partial class logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                // Clear session
                if (Session != null)
                {
                    Session.Clear();
                    Session.Abandon();
                }
                
                // Clear cookies
                if (Request.Cookies["UserEmail"] != null)
                {
                    Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(-1);
                }
                
                // Redirect to home page with absolute path
                Response.Redirect("~/index.aspx", false);
                System.Web.HttpContext.Current.ApplicationInstance.CompleteRequest();
            }
            catch
            {
                // If redirect fails, try alternative approach
                Response.Redirect("index.aspx", true);
            }
        }
    }
}
