using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace CIS3342TermProject
{
    public partial class AJAX_Data : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request["email"] != null)
            {
                UserServiceRef.UserService pxy = new UserServiceRef.UserService();
                bool emailExists = pxy.CheckForEmail(Request["email"]);
                if (emailExists)
                {
                    Response.Write("false");
                }
                else
                {
                    Response.Write("true");
                }
            }
            else if ((Request["chat_post"] != null) && (Request["chat_username"] != null))
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "PostChat";
                objCommand.Parameters.AddWithValue("@email", Request["chat_username"]);
                objCommand.Parameters.AddWithValue("@chat", Request["chat_post"]);

                DBConnect objDB = new DBConnect();
                objDB.DoUpdateUsingCmdObj(objCommand);
            }
            else if (Request["get_chat_username"] != null)
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetChat";
                objCommand.Parameters.AddWithValue("@email", Request["get_chat_username"]);

                DBConnect objDB = new DBConnect();
                DataSet myDS = objDB.GetDataSetUsingCmdObj(objCommand);

                string response = "";
                for (int i = 0; i < myDS.Tables[0].Rows.Count; i++)
                {
                    DataRow currRow = myDS.Tables[0].Rows[i];
                    response += "<p>" + currRow["chat"] + "</p>";
                }

                Response.Write(response);
            }
            else if (Request["get_chat_rooms"] != null)
            {
                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetChatRooms";

                DBConnect objDB = new DBConnect();
                DataSet myDS = objDB.GetDataSetUsingCmdObj(objCommand);

                string response = "";
                for (int i = 0; i < myDS.Tables[0].Rows.Count; i++)
                {
                    DataRow currRow = myDS.Tables[0].Rows[i];
                    response += "<option value='" + currRow["email"] + "'>" + currRow["email"] + "</option>";
                }

                Response.Write(response);
            }
        }
    }
}