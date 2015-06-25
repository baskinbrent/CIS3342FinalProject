using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CIS3342TermProject
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    Response.Redirect("Home.aspx");
                }

                loginAlert.Visible = false;
            }

            int loginCount = 0;
            if (Session["LoginCount"] != null)
            {
                loginCount = (int)Session["LoginCount"];
            }

            if (loginCount > 2)
            {
                loginAlert.InnerHtml = "Too many tries, you are not allowed to login again for a while.";
                loginAlert.Visible = true;
                txtUserName.Enabled = false;
                txtPassword.Enabled = false;
            }

            if (Request.Cookies["UserEmail"] != null)
            {
                HttpCookie emailCookie = Request.Cookies["UserEmail"];
                txtUserName.Text = emailCookie.Value.ToString();
                chkRememberMe.Checked = true;
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtUserName.Text;
            string password = txtPassword.Text;

            UserServiceRef.UserService pxy = new UserServiceRef.UserService();
            if (pxy.ValidateLogin(email, password))
            {
                if (chkRememberMe.Checked)
                {
                    HttpCookie emailCookie = new HttpCookie("UserEmail");
                    emailCookie.Value = email;
                    emailCookie.Expires = new DateTime(2024, 1, 1);
                    Response.Cookies.Add(emailCookie);
                }
                else
                {
                    Response.Cookies.Remove("UserEmail");
                }

                Session.Remove("LoginCount");
                Session["UserName"] = email;

                Serialize objSerialize = new Serialize();
                VacationPackage vacation = (VacationPackage)objSerialize.ReadCartFromDB(email);
                if (vacation != null)
                {
                    Session["VacationPackage"] = vacation;
                }
                else
                {
                    Session["VacationPackage"] = new VacationPackage();
                }

                Response.Redirect("Home.aspx");
            }
            else
            {
                txtUserName.Text = "";
                txtPassword.Text = "";

                int loginCount = 0;
                if (Session["LoginCount"] != null)
                {
                    loginCount = (int)Session["LoginCount"];
                }
                Session["LoginCount"] = loginCount + 1;

                if (loginCount > 2)
                {
                    loginAlert.InnerHtml = "Too many tries, you are not allowed to login again for a while.";
                    txtUserName.Enabled = false;
                    txtPassword.Enabled = false;
                }
                else
                {
                    loginAlert.InnerHtml = "Invalid credentials, please try again!";
                }

                loginAlert.Visible = true;
            }
        }
    }
}