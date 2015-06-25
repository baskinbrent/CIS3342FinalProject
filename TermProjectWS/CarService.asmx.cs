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
    /// Summary description for CarService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class CarService : System.Web.Services.WebService
    {
        [WebMethod]
        public DataSet GetCars(Agency agency, string city, string state)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetCars";
            objCommand.Parameters.AddWithValue("@agencyID", agency.agencyID);
            objCommand.Parameters.AddWithValue("@city", city);
            objCommand.Parameters.AddWithValue("@state", state);

            DBConnect objDB = new DBConnect();
            return objDB.GetDataSetUsingCmdObj(objCommand);
        }

        [WebMethod]
        public DataSet FindCars(Requirements requirements, string city, string state)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "FindCars";
            objCommand.Parameters.AddWithValue("@price", requirements.price);
            objCommand.Parameters.AddWithValue("@gps", requirements.gps);
            objCommand.Parameters.AddWithValue("@type", requirements.type);
            objCommand.Parameters.AddWithValue("@carClass", requirements.carClass);
            objCommand.Parameters.AddWithValue("@electric", requirements.electric);
            objCommand.Parameters.AddWithValue("@passengers", requirements.passengers);
            objCommand.Parameters.AddWithValue("@luggage", requirements.luggage);
            objCommand.Parameters.AddWithValue("@doors", requirements.doors);
            objCommand.Parameters.AddWithValue("@mileage", requirements.mileage);
            objCommand.Parameters.AddWithValue("@city", city);
            objCommand.Parameters.AddWithValue("@state", state);

            DBConnect objDB = new DBConnect();
            return objDB.GetDataSetUsingCmdObj(objCommand);
        }

        [WebMethod]
        public DataSet GetRentalCarAgencies(string city, string state)
        {
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "GetRentalCarAgencies";
            objCommand.Parameters.AddWithValue("@city", city);
            objCommand.Parameters.AddWithValue("@state", state);

            DBConnect objDB = new DBConnect();
            return objDB.GetDataSetUsingCmdObj(objCommand);
        }

        [WebMethod]
        public bool Reserve(Customer customer, Car car)
        {
            DBConnect objDB = new DBConnect();
            SqlCommand objCommand = new SqlCommand();
            objCommand.CommandType = CommandType.StoredProcedure;
            objCommand.CommandText = "InsertCustomer";
            objCommand.Parameters.AddWithValue("@firstName", customer.firstName);
            objCommand.Parameters.AddWithValue("@lastName", customer.lastName);
            objCommand.Parameters.AddWithValue("@age", customer.age);
            objCommand.Parameters.AddWithValue("@email", customer.email);
            objCommand.Parameters.AddWithValue("@address", customer.address);
            objCommand.Parameters.AddWithValue("@phoneNumber", customer.phoneNumber);
            objDB.DoUpdateUsingCmdObj(objCommand);

            SqlCommand objCommandReserve = new SqlCommand();
            objCommandReserve.CommandType = CommandType.StoredProcedure;
            objCommandReserve.CommandText = "Reserve";
            objCommandReserve.Parameters.AddWithValue("@carID", car.carID);
            int result = objDB.DoUpdateUsingCmdObj(objCommandReserve);

            if (!(result <= 0))
                return true;
            else
                return false;
        }

        

    }
}
