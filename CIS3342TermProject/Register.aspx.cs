using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

namespace CIS3342TermProject
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserName"] != null)
                {
                    Response.Redirect("Home.aspx");
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            UserServiceRef.User newUser = new UserServiceRef.User();
            newUser.firstName = txtFirstName.Text;
            newUser.lastName = txtLastName.Text;
            newUser.email = txtEmail.Text;
            newUser.password = txtPassword1.Text;

            if (String.IsNullOrEmpty(newUser.firstName))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "ValidationAlertScript", "alert('First name must be at least 2 characters long.')", true);
                return;
            }

            if (String.IsNullOrEmpty(newUser.lastName))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "ValidationAlertScript", "alert('Last name must be at least 2 characters long.')", true);
                return;
            }

            if (String.IsNullOrEmpty(newUser.email))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "ValidationAlertScript", "alert('Please enter a valid email.')", true);
                return;
            }

            if (String.IsNullOrEmpty(newUser.password))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "ValidationAlertScript", "alert('Please enter a valid password.')", true);
                return;
            }

            UserServiceRef.UserService pxy = new UserServiceRef.UserService();
            bool emailUsed = pxy.CheckForEmail(newUser.email);

            if (emailUsed)
            {
                pxy.AddUser(newUser);
                Response.Redirect("Login.aspx");
            }
            else
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "ValidationAlertScript", "alert('The chosen email is already used, please login if you already have an account, or use another email id.')", true);
            }
        }
    }
}