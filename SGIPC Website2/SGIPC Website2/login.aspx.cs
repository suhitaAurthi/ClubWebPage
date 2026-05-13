using System;
    
namespace SGIPC_Website2
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userInput = username.Value.Trim();
            string userPassword = password.Value.Trim();

            if (string.IsNullOrWhiteSpace(userInput) || string.IsNullOrWhiteSpace(userPassword))
            {
                lblMessage.Text = "Please enter username/email and password.";
                return;
            }

            // Demo login check
            // Replace this part with database checking later
            if (userInput == "admin@gmail.com" && userPassword == "123456")
            {
                Session["User"] = userInput;

                if (fgc.Checked)
                {
                    Response.Cookies["UserEmail"].Value = userInput;
                    Response.Cookies["UserEmail"].Expires = DateTime.Now.AddDays(7);
                }

                Response.Redirect("dashboard.aspx");
            }
            else
            {
                lblMessage.Text = "Invalid username/email or password.";
            }
        }
    }
}