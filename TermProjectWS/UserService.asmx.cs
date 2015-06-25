using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data;
using System.Data.SqlClient;

namespace TermProjectWS
{
    /// <summary>
    /// Summary description for UserService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class UserService : System.Web.Services.WebService
    {
        [WebMethod]
        public bool ValidateLogin(string email, string password)
        {
            int hash = password.GetHashCode();
            password = hash.ToString();

            DataSet myDS = new DataSet();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "ValidateLogin";
            objCommand.Parameters.AddWithValue("@email", email);
            objCommand.Parameters.AddWithValue("@password", password);
            DBConnect objDB = new DBConnect();
            myDS = objDB.GetDataSetUsingCmdObj(objCommand);

            if (myDS.Tables[0].Rows.Count == 1)
                return true;
            else
                return false;
        }

        [WebMethod]
        public bool CheckForEmail(string email)
        {
            DataSet myDS = new DataSet();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "CheckForEmail";
            objCommand.Parameters.AddWithValue("@email", email);

            DBConnect objDB = new DBConnect();
            myDS = objDB.GetDataSetUsingCmdObj(objCommand);

            if (myDS.Tables[0].Rows.Count <= 0)
                return true;
            else
                return false;
        }

        [WebMethod]
        public bool AddUser(User newUser)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "AddUser";
            objCommand.Parameters.AddWithValue("@firstName", newUser.firstName);
            objCommand.Parameters.AddWithValue("@lastName", newUser.lastName);
            objCommand.Parameters.AddWithValue("@email", newUser.email);

            int hashPass = newUser.password.GetHashCode();
            objCommand.Parameters.AddWithValue("@password", hashPass.ToString());

            DBConnect objDB = new DBConnect();
            int result = objDB.DoUpdateUsingCmdObj(objCommand);

            if (!(result <= 0))
                return true;
            else
                return false;
        }

        [WebMethod]
        public string GetUserFullName(string email)
        {
            DataSet myDS = new DataSet();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetUserFullName";
            objCommand.Parameters.AddWithValue("@email", email);

            DBConnect objDB = new DBConnect();
            myDS = objDB.GetDataSetUsingCmdObj(objCommand);

            string firstName = myDS.Tables[0].Rows[0]["firstName"].ToString();
            string lastName = myDS.Tables[0].Rows[0]["lastName"].ToString();

            return firstName + " " + lastName;
        }
    }
}
