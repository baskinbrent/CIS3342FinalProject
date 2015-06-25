using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace CIS3342TermProject
{
    public partial class TestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnTestGetCars_Click(object sender, EventArgs e)
        {
            CarServiceRef.Agency agency = new CarServiceRef.Agency();
            agency.agencyID = 1;
            agency.name = "Hertz";
            agency.phone = "";
            agency.email = "";
            agency.city = "";
            agency.state = "";

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            DataSet myDS = pxy.GetCars(agency, "Philadelphia", "PA");
            gvDisplayResults.DataSource = myDS;
            gvDisplayResults.DataBind();
        }

        protected void btnTestFindCars_Click(object sender, EventArgs e)
        {
            CarServiceRef.Requirements requirements = new CarServiceRef.Requirements();
            requirements.price = 100000000;
            requirements.gps = "";
            requirements.type = "";
            requirements.carClass = "";
            requirements.electric = "";
            requirements.passengers = 0;
            requirements.luggage = 0;
            requirements.doors = 0;
            requirements.mileage = 10000000;

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            DataSet myDS = pxy.FindCars(requirements, "Las Vegas", "NV");
            gvDisplayResults.DataSource = myDS;
            gvDisplayResults.DataBind();
        }

        protected void btnTestReserve_Click(object sender, EventArgs e)
        {
            CarServiceRef.Car car = new CarServiceRef.Car();
            CarServiceRef.Customer customer = new CarServiceRef.Customer();

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            car.carID = 1;
            bool result = pxy.Reserve(customer, car);
            lblReserveResult.Text = "Reserve method executed: " + result.ToString();
        }

        protected void btnTestGetRentalCarAgencies_Click(object sender, EventArgs e)
        {
            CarServiceRef.Agency agency = new CarServiceRef.Agency();

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            DataSet myDS = pxy.GetRentalCarAgencies("Philadelphia", "PA");
            gvDisplayResults.DataSource = myDS;
            gvDisplayResults.DataBind();
        }

        protected void btnTestValidateLogin_Click(object sender, EventArgs e)
        {
            UserServiceRef.UserService pxy = new UserServiceRef.UserService();
            lblReserveResult.Text = "TestValidate method executed successfully: " 
                + pxy.ValidateLogin("tud15864@temple.edu", "jwwieorhu3h59823rndjf");
        }

        protected void btnTestCheckEmail_Click(object sender, EventArgs e)
        {
            UserServiceRef.UserService pxy = new UserServiceRef.UserService();
            lblReserveResult.Text = "TestCheckEmail method executed successfully (SHOULD RETURN FALSE SINCE USER EXISTS): " 
                + pxy.CheckForEmail("tud15864@temple.edu");
        }

        protected void btnTestAddUser_Click(object sender, EventArgs e)
        {
            UserServiceRef.User user = new UserServiceRef.User();
            UserServiceRef.UserService pxy = new UserServiceRef.UserService();

            user.firstName = "Cool";
            user.lastName = "Guy";
            user.email = "coolguy@hotmail.com";
            string password = "coolguyspassword";
            user.password = password.GetHashCode().ToString();
            lblReserveResult.Text = "TestValidate method executed successfully: " 
                + pxy.AddUser(user);
        }
    }
}