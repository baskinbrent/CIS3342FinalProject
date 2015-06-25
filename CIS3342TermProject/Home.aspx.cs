using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace CIS3342TermProject
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["UserName"] == null)
                {
                    Response.Redirect("Login.aspx");
                }
                else
                {
                    UserServiceRef.UserService pxy = new UserServiceRef.UserService();
                    string userEmail = Session["UserName"].ToString();
                    lblUserName.InnerHtml = pxy.GetUserFullName(userEmail);
                    chatUserName.Value = Session["UserName"].ToString();
                }

                divCarDetails.Visible = false;
                divCarResults.Visible = false;
                divEventDetails.Visible = false;
                divEventResults.Visible = false;
                divHotelDetails.Visible = false;
                divCartBody.Visible = false;

                displayCartCount();
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

        protected void btnCarSearch_Click(object sender, EventArgs e)
        {
            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            CarServiceRef.Requirements reqs = new CarServiceRef.Requirements();

            reqs.gps = ddlCarGps.SelectedValue;
            reqs.price = Convert.ToInt32(txtMaxCarPrice.Text);

            DataSet myDS = pxy.FindCars(reqs, txtCarCity.Text, ddlCarState.SelectedValue);
        }

        protected void btnFlightSearch_Click(object sender, EventArgs e)
        {
            AirServiceRef.AirService pxy = new AirServiceRef.AirService();

            //reqs.privateFlight = ddlFlightType.SelectedItem.Value;

            //DataSet myDS = pxy.FindFlights(reqs, txtDepartureCity.Text, ddlDepartureState.SelectedValue,
            //    txtDestinationCity.Text, ddlDestinationState.SelectedValue);

        }

        protected void btnHotelCityStateSearch_Click(object sender, EventArgs e)
        {
            HotelServiceRef.HotelService pxy = new HotelServiceRef.HotelService();
            DataSet myDS = pxy.GetHotels(txtHotelCity.Text, ddlHotelState.SelectedValue);
            ddlHotelNames.DataSource = myDS;
            ddlHotelNames.DataValueField = "HotelID";
            ddlHotelNames.DataTextField = "Name";
            ddlHotelNames.DataBind();
            divHotelDetails.Visible = true;
        }

        protected void btnHotelSearch_Click(object sender, EventArgs e)
        {
            HotelServiceRef.Amenities reqs = new HotelServiceRef.Amenities();

            reqs.FreeBreakfast = Convert.ToInt32(ddlBreakfast.SelectedValue);
            reqs.Gym = Convert.ToInt32(ddlGym.SelectedValue);
            reqs.PoolsideBar = Convert.ToInt32(ddlPoolBar.SelectedValue);
            reqs.Smoking = Convert.ToInt32(ddlSmoking.SelectedValue);
            reqs.ValetParking = Convert.ToInt32(ddlValet.SelectedValue);
            reqs.Wifi = Convert.ToInt32(ddlWifi.SelectedValue);

        }

        protected void btnCarSelectCity_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtCarCity.Text))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Alert", "alert('Please enter a valid city.')", true);
                return;
            }

            if (ddlCarState.SelectedValue == "Select state")
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Alert", "alert('Please select a state.')", true);
                return;
            }

            CarServiceRef.CarService carService = new CarServiceRef.CarService();
            DataSet agencies = carService.GetRentalCarAgencies(txtCarCity.Text, ddlCarState.SelectedValue);
            ddlAgencies.DataSource = agencies;
            ddlAgencies.DataTextField = "name";
            ddlAgencies.DataValueField = "name";
            ddlAgencies.DataBind();

            divCarDetails.Visible = true;
        }

        protected void btnSearchCarAgencies_Click(object sender, EventArgs e)
        {
            CarServiceRef.CarService carService = new CarServiceRef.CarService();
            DataSet agencies = carService.GetRentalCarAgencies(txtCarCity.Text, ddlCarState.SelectedValue);
            CarServiceRef.Agency agency = new CarServiceRef.Agency();
            agency.agencyID = (int)agencies.Tables[0].Rows[ddlAgencies.SelectedIndex]["agencyID"];
            agency.name = ddlAgencies.SelectedValue;
            agency.phone = (string)agencies.Tables[0].Rows[ddlAgencies.SelectedIndex]["phone"];
            agency.email = (string)agencies.Tables[0].Rows[ddlAgencies.SelectedIndex]["email"];
            agency.city = (string)agencies.Tables[0].Rows[ddlAgencies.SelectedIndex]["city"];
            agency.state = (string)agencies.Tables[0].Rows[ddlAgencies.SelectedIndex]["state"];

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            DataSet myDS = pxy.GetCars(agency, txtCarCity.Text, ddlCarState.SelectedValue);
            rptCars.DataSource = myDS;
            rptCars.DataBind();

            divCarForm.Visible = false;
            divCarResults.Visible = true;
        }

        protected void btnSearchCarReqs_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtMaxCarPrice.Text))
            {
                txtMaxCarPrice.Text = "999999999";
            }

            if (String.IsNullOrEmpty(txtMaxCarMileage.Text))
            {
                txtMaxCarMileage.Text = "999999999";
            }

            CarServiceRef.Requirements requirements = new CarServiceRef.Requirements();
            requirements.price = float.Parse(txtMaxCarPrice.Text);
            requirements.gps = ddlCarGps.SelectedValue;
            requirements.type = ddlCarType.SelectedValue;
            requirements.carClass = ddlCarClass.SelectedValue;
            requirements.electric = ddlCarElectric.SelectedValue;
            requirements.passengers = int.Parse(ddlPassengers.SelectedValue);
            requirements.luggage = int.Parse(ddlLuggage.SelectedValue);
            requirements.doors = int.Parse(ddlDoors.SelectedValue);
            requirements.mileage = int.Parse(txtMaxCarMileage.Text);

            CarServiceRef.CarService pxy = new CarServiceRef.CarService();
            DataSet myDS = pxy.FindCars(requirements, txtCarCity.Text, ddlCarState.SelectedValue);
            rptCars.DataSource = myDS;
            rptCars.DataBind();

            divCarForm.Visible = false;
            divCarResults.Visible = true;
        }

        protected void btnClearCarSearch_Click(object sender, EventArgs e)
        {
            divCarForm.Visible = true;
            divCarDetails.Visible = false;
            divCarResults.Visible = false;

            rptCars.DataSource = null;
            rptCars.DataBind();
        }

        protected void rptCars_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Retrieve the row index for the item that fired the ItemCommand event
            int rowIndex = e.Item.ItemIndex;

            // Retrieve a value from a control in the Repeater's Items collection
            Label carID = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnID");
            Label make = (Label)rptCars.Items[rowIndex].FindControl("lblCarMake");
            Label model = (Label)rptCars.Items[rowIndex].FindControl("lblCarModel");
            Label year = (Label)rptCars.Items[rowIndex].FindControl("lblCarYear");
            Label city = (Label)rptCars.Items[rowIndex].FindControl("lblCarCity");
            Label state = (Label)rptCars.Items[rowIndex].FindControl("lblCarState");
            Label price = (Label)rptCars.Items[rowIndex].FindControl("lblCarPrice");
            Label gps = (Label)rptCars.Items[rowIndex].FindControl("lblCarGps");
            Label type = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnType");
            Label carClass = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnClass");
            Label electric = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnElectric");
            Label passengers = (Label)rptCars.Items[rowIndex].FindControl("lblCarPassengers");
            Label luggage = (Label)rptCars.Items[rowIndex].FindControl("lblCarLuggage");
            Label doors = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnDoors");
            Label mileage = (Label)rptCars.Items[rowIndex].FindControl("lblCarMileage");
            Label agencyID = (Label)rptCars.Items[rowIndex].FindControl("lblCarHdnAgency");

            CarServiceRef.Car currCar = new CarServiceRef.Car();
            currCar.carID = int.Parse(carID.Text);
            currCar.make = make.Text;
            currCar.model = model.Text;
            currCar.year = year.Text;
            currCar.price = float.Parse(price.Text);
            currCar.gps = gps.Text;
            currCar.type = type.Text;
            currCar.carClass = carClass.Text;
            currCar.electric = electric.Text;
            currCar.passengers = int.Parse(passengers.Text);
            currCar.luggage = int.Parse(luggage.Text);
            currCar.doors = int.Parse(doors.Text);
            currCar.mileage = int.Parse(mileage.Text);

            VacationPackage vacationPackage;
            if (Session["VacationPackage"] != null)
            {
                vacationPackage = (VacationPackage)Session["VacationPackage"];
            }
            else
            {
                vacationPackage = new VacationPackage();
            }

            vacationPackage.cars.Add(currCar);
            vacationPackage.carsQuantity.Add(1);
            incrementCartNumber();
            Session["VacationPackage"] = vacationPackage;
        }

        private void incrementCartNumber()
        {
            int currCartCount = int.Parse(cartCountDisplay.InnerHtml);
            cartCountDisplay.InnerHtml = (currCartCount + 1) + "";
        }

        protected void btnEventSelectCity_Click(object sender, EventArgs e)
        {
            if (String.IsNullOrEmpty(txtEventCity.Text))
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Alert", "alert('Please enter a valid city.')", true);
                return;
            }

            if (ddlEventState.SelectedValue == "Select state")
            {
                Page.ClientScript.RegisterClientScriptBlock(GetType(), "Alert", "alert('Please select a state.')", true);
                return;
            }

            EventServiceRef.EventService eventService = new EventServiceRef.EventService();
            DataSet agencies = eventService.GetEventAgencies(txtEventCity.Text, ddlEventState.SelectedValue);
            ddlEventAgencies.DataSource = agencies;
            ddlEventAgencies.DataTextField = "agencyName";
            ddlEventAgencies.DataValueField = "agencyName";
            ddlEventAgencies.DataBind();

            divEventDetails.Visible = true;
        }

        protected void btnEventSearchByAgency_Click(object sender, EventArgs e)
        {
            EventServiceRef.EventService eventService = new EventServiceRef.EventService();
            DataSet agencies = eventService.GetEventAgencies(txtEventCity.Text, ddlEventState.SelectedValue);
            EventServiceRef.Agency agency = new EventServiceRef.Agency();
            agency.ID = (int)agencies.Tables[0].Rows[ddlEventAgencies.SelectedIndex]["agencyID"];
            agency.name = ddlEventAgencies.SelectedValue;
            agency.phone = (string)agencies.Tables[0].Rows[ddlEventAgencies.SelectedIndex]["agencyPhone"];
            agency.email = (string)agencies.Tables[0].Rows[ddlEventAgencies.SelectedIndex]["agencyEmail"];
            agency.city = (string)agencies.Tables[0].Rows[ddlEventAgencies.SelectedIndex]["agencyCity"];
            agency.state = (string)agencies.Tables[0].Rows[ddlEventAgencies.SelectedIndex]["agencyState"];

            DataSet myDS = eventService.GetEvents(agency, txtEventCity.Text, ddlEventState.SelectedValue);
            rptEvents.DataSource = myDS;
            rptEvents.DataBind();

            divEventForm.Visible = false;
            divEventResults.Visible = true;
        }

        protected void btnEventSearchByActivity_Click(object sender, EventArgs e)
        {
            EventServiceRef.Activity activities = new EventServiceRef.Activity();
            activities.type = ddlEventType.SelectedValue;
            activities.time = ddlEventTime.SelectedValue;
            activities.day = ddlEventDay.SelectedValue;

            EventServiceRef.EventService pxy = new EventServiceRef.EventService();
            DataSet myDS = pxy.FindEvents(activities, txtEventCity.Text, ddlEventState.SelectedValue);
            rptEvents.DataSource = myDS;
            rptEvents.DataBind();

            divEventForm.Visible = false;
            divEventResults.Visible = true;
        }

        protected void btnEventsClear_Click(object sender, EventArgs e)
        {
            divEventForm.Visible = true;
            divEventDetails.Visible = false;
            divEventResults.Visible = false;

            rptEvents.DataSource = null;
            rptEvents.DataBind();
        }

        protected void btnCart_Click(object sender, EventArgs e)
        {
            displayCart();
        }

        private void displayCart()
        {
            divReservationsBody.Visible = false;
            divCartBody.Visible = true;
            divCart.InnerHtml = "";
            double totalVacationPrice = 0;
            lblTotalPrice.Text = "";
            if (Session["VacationPackage"] != null)
            {
                VacationPackage vacation = (VacationPackage)Session["VacationPackage"];

                divCart.InnerHtml += "<div class='page-header'><h3>Cars</h3></div><div class='row' style='text-align: center;'>";
                for (int i = 0; i < vacation.cars.Count; i++)
                {
                    CarServiceRef.Car currCar = vacation.cars[i];
                    totalVacationPrice += (Convert.ToDouble(currCar.price) * vacation.carsQuantity[i]);
                    divCart.InnerHtml += "<div class='col-md-3'><div class='panel panel-default'><div class='panel-body'><h4>";
                    divCart.InnerHtml += currCar.year + " ";
                    divCart.InnerHtml += currCar.make + " ";
                    divCart.InnerHtml += currCar.model + "</h4><p>";
                    divCart.InnerHtml += "Seats: " + currCar.passengers + "<br />";
                    divCart.InnerHtml += "GPS available: " + currCar.gps + "<br />";
                    divCart.InnerHtml += "Bags: " + currCar.luggage + "<br />";
                    divCart.InnerHtml += "Price: $" + currCar.price + "<br />";
                    divCart.InnerHtml += "Mileage: " + currCar.mileage + "</p>";
                    divCart.InnerHtml += "<br />Quantity: <input type='number' class='form-control' id='cartCar" + currCar.carID + "' name='cartCar" + currCar.carID + "' value='" + vacation.carsQuantity[i] + "'></div></div></div>";
                }

                divCart.InnerHtml += "</div><div class='page-header'><h3>Vacations</h3></div><div class='row' style='text-align: center;'>";
                for (int i = 0; i < vacation.events.Count; i++)
                {
                    EventServiceRef.Event currEvent = vacation.events[i];
                    totalVacationPrice += (currEvent.Price * vacation.eventsQuantity[i]);
                    divCart.InnerHtml += "<div class='col-md-3'><div class='panel panel-default'><div class='panel-body'><h4>";
                    divCart.InnerHtml += currEvent.Name + " <small>";
                    divCart.InnerHtml += currEvent.City + ", " + currEvent.State + "</small></h4><p>";
                    divCart.InnerHtml += currEvent.Time + ", " + currEvent.Day + "<br />";
                    divCart.InnerHtml += "Type: " + currEvent.Type + "<br />";
                    divCart.InnerHtml += "Price: $" + currEvent.Price + "</p>";
                    divCart.InnerHtml += "<br />Quantity: <input type='number' class='form-control' id='cartEvent" + currEvent.ID + "' name='cartEvent" + currEvent.ID + "' value='" + vacation.eventsQuantity[i] + "'></div></div></div>";
                }


                divCart.InnerHtml += "</div><div class='page-header'><h3>Rooms</h3></div><div class='row' style='text-align: center;'>";
                for (int i = 0; i < vacation.rooms.Count; i++)
                {
                    HotelServiceRef.Room currRooms = vacation.rooms[i];
                    totalVacationPrice += (currRooms.Price * vacation.roomsQuantity[i]);
                    divCart.InnerHtml += "<div class='col-md-3'><div class='panel panel-default'><div class='panel-body'><h4>";
                    divCart.InnerHtml += txtHotelCity.Text + ", " + ddlHotelState.SelectedItem.Text + "</small></h4><p>";
                    divCart.InnerHtml += "Price: $" + currRooms.Price + "</p>";
                    divCart.InnerHtml += "<br />Quantity: <input type='number' class='form-control' id='cartRooms" + currRooms.RoomID + "' name='cartRooms" + currRooms.RoomID + "' value='" + vacation.roomsQuantity[i] + "'></div></div></div>";
                }

                divCart.InnerHtml += "</div><div class='page-header'><h3>Flights</h3></div><div class='row' style='text-align: center;'>";
                for (int i = 0; i < vacation.flights.Count; i++)
                {
                    Flight currFlight = vacation.flights[i];
                    totalVacationPrice += (currFlight.price * vacation.flightsQuantity[i]);
                    divCart.InnerHtml += "<div class='col-md-3'><div class='panel panel-default'><div class='panel-body'><h4>";
                    divCart.InnerHtml += txtFlightDepCity.Text + ", " + ddlFlightDepState.SelectedItem.Text + "</small></h4><p>";
                    divCart.InnerHtml += "Price: $" + currFlight.price + "</p>";
                    divCart.InnerHtml += "<br />Quantity: <input type='number' class='form-control' id='cartFlights" + currFlight.carrierID + "' name='cartFlights" + currFlight.flightID + "' value='" + vacation.flightsQuantity[i] + "'></div></div></div>";
                }

                divCart.InnerHtml += "</div>";

                lblTotalPrice.Text += "Total Price: $" + totalVacationPrice.ToString();

            }
        }

        protected void rptEvents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Retrieve the row index for the item that fired the ItemCommand event
            int rowIndex = e.Item.ItemIndex;

            // Retrieve a value from a control in the Repeater's Items collection
            Label eventID = (Label)rptEvents.Items[rowIndex].FindControl("lblEventHdnID");
            Label eventName = (Label)rptEvents.Items[rowIndex].FindControl("lblEventName");
            Label eventType = (Label)rptEvents.Items[rowIndex].FindControl("lblEventType");
            Label eventDay = (Label)rptEvents.Items[rowIndex].FindControl("lblEventDay");
            Label eventTime = (Label)rptEvents.Items[rowIndex].FindControl("lblEventTime");
            Label eventCity = (Label)rptEvents.Items[rowIndex].FindControl("lblEventCity");
            Label eventState = (Label)rptEvents.Items[rowIndex].FindControl("lblEventState");
            Label eventPrice = (Label)rptEvents.Items[rowIndex].FindControl("lblEventPrice");
            Label agencyID = (Label)rptEvents.Items[rowIndex].FindControl("lblEventHdnAgency");

            EventServiceRef.Event currEvent = new EventServiceRef.Event();
            currEvent.ID = int.Parse(eventID.Text);
            currEvent.Name = eventName.Text;
            currEvent.Type = eventType.Text;
            currEvent.Day = eventDay.Text;
            currEvent.Time = eventTime.Text;
            currEvent.City = eventCity.Text;
            currEvent.State = eventState.Text;
            currEvent.Price = double.Parse(eventPrice.Text);
            currEvent.AgencyID = int.Parse(agencyID.Text);

            VacationPackage vacationPackage;
            if (Session["VacationPackage"] != null)
            {
                vacationPackage = (VacationPackage)Session["VacationPackage"];
            }
            else
            {
                vacationPackage = new VacationPackage();
            }

            vacationPackage.events.Add(currEvent);
            vacationPackage.eventsQuantity.Add(1);
            incrementCartNumber();
            Session["VacationPackage"] = vacationPackage;
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            if (Session["VacationPackage"] != null)
            {
                VacationPackage vacation = (VacationPackage)Session["VacationPackage"];

                SqlCommand objCommand = new SqlCommand();
                objCommand.CommandType = CommandType.StoredProcedure;
                objCommand.CommandText = "GetUser";
                objCommand.Parameters.AddWithValue("@email", Session["UserName"]);
                DBConnect objDB = new DBConnect();
                DataSet myDS = objDB.GetDataSetUsingCmdObj(objCommand);
                DataRow user = myDS.Tables[0].Rows[0];


                CarServiceRef.Customer carCustomer = new CarServiceRef.Customer();
                carCustomer.customerID = (int)user["UserID"];
                carCustomer.firstName = (string)user["firstName"];
                carCustomer.lastName = (string)user["lastName"];
                carCustomer.email = (string)user["email"];
                carCustomer.address = "";
                carCustomer.age = 0;
                carCustomer.phoneNumber = "";

                EventServiceRef.Customer eventCustomer = new EventServiceRef.Customer();
                eventCustomer.ID = (int)user["UserID"];
                eventCustomer.CustomerFirstName = (string)user["firstName"];
                eventCustomer.CustomerLastName = (string)user["lastName"];
                eventCustomer.CustomerEmail = (string)user["email"];
                eventCustomer.CustomerPhone = "";

                HotelServiceRef.Customer hotelCustomer = new HotelServiceRef.Customer();
                hotelCustomer.CustID = (int)user["UserID"];
                hotelCustomer.FirstName = (string)user["firstName"];
                hotelCustomer.LastName = (string)user["lastName"];
                hotelCustomer.Address = (string)user["email"];

                CarServiceRef.CarService carService = new CarServiceRef.CarService();
                EventServiceRef.EventService eventService = new EventServiceRef.EventService();
                HotelServiceRef.HotelService hotelService = new HotelServiceRef.HotelService();
                AirServiceRef.AirService airService = new AirServiceRef.AirService();
                string emailBody = "<h1>You have reserved</h1>";
                emailBody += "<h2>Cars</h2>";
                bool reservedCars = true;
                for (int i = 0; i < vacation.cars.Count; i++)
                {
                    CarServiceRef.Car currCar = vacation.cars[i];
                    if (!carService.Reserve(carCustomer, currCar))
                    {
                        reservedCars = false;
                    }
                    else
                    {
                        emailBody += "<p>" + currCar.year + " " + currCar.make + " " + currCar.model + " ($" + currCar.price + ")</p>";
                    }
                }

                emailBody += "<h2>Events</h2>";
                bool reservedEvents = true;
                for (int i = 0; i < vacation.events.Count; i++)
                {
                    EventServiceRef.Event currEvent = vacation.events[i];
                    if (!eventService.Reserve(currEvent, eventCustomer))
                    {
                        reservedEvents = false;
                    }
                    else
                    {
                        emailBody += "<p>" + currEvent.Name + " ($" + currEvent.Price + ")</p>";
                    }
                }

                emailBody += "<h2>Hotels</h2>";
                bool reservedHotels = true;
                for (int i = 0; i < vacation.rooms.Count; i++)
                {
                    HotelServiceRef.Room currRoom = vacation.rooms[i];
                    if (!hotelService.Reserve(currRoom, hotelCustomer))
                    {
                        reservedHotels = false;
                    }
                    else
                    {
                        emailBody += "<p>" + currRoom.RoomNumber + " ($" + currRoom.Price + ")</p>";
                    }
                }

                emailBody += "<h2>Flights</h2>";
                bool reservedFlights = true;
                for (int i = 0; i < vacation.flights.Count; i++)
                {
                    Flight currFlight = vacation.flights[i];

                    emailBody += "<p>" + currFlight.carrierName + " ($" + currFlight.price + ") could not be reserved because the AirService does not accept reservations</p>";
                }

                emailBody += "<br><br><p>Thank you,<br>Vacation-O-City Team</p>";

                if (reservedCars)
                {
                    vacation.cars.Clear();
                    vacation.carsQuantity.Clear();
                }

                if (reservedEvents)
                {
                    vacation.events.Clear();
                    vacation.eventsQuantity.Clear();
                }

                if (reservedHotels)
                {
                    vacation.events.Clear();
                    vacation.roomsQuantity.Clear();
                }

                if (reservedFlights)
                {
                    vacation.flights.Clear();
                    vacation.flightsQuantity.Clear();
                }

                Email emailSender = new Email();
                emailSender.SendMail((string)Session["UserName"], "no-reply@vacationocity.com", "Reservation Confirmation", emailBody, "chitnisviraj@gmail.com");

                clearCartCount();

                Session["VacationPackage"] = vacation;
                vacation = (VacationPackage)Session["VacationPackage"];
                Serialize objSerialize = new Serialize();
                objSerialize.WriteCartToDB(vacation, Session["UserName"]);
            }

            displayCart();
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            divReservationsBody.Visible = true;
            divCartBody.Visible = false;
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            if (Session["VacationPackage"] != null)
            {
                VacationPackage vacation = (VacationPackage)Session["VacationPackage"];
                vacation.cars.Clear();
                vacation.carsQuantity.Clear();
                vacation.events.Clear();
                vacation.eventsQuantity.Clear();
                vacation.rooms.Clear();
                vacation.roomsQuantity.Clear();
                vacation.flights.Clear();
                vacation.flightsQuantity.Clear();

                clearCartCount();

                Session["VacationPackage"] = vacation;
                Serialize objSerialize = new Serialize();
                objSerialize.WriteCartToDB(vacation, Session["UserName"]);

                displayCart();
            }
        }

        private void clearCartCount()
        {
            cartCountDisplay.InnerHtml = "0";
        }

        protected void btnUpdateCart_Click(object sender, EventArgs e)
        {
            cartCountDisplay.InnerHtml = "0";

            VacationPackage vacation = (VacationPackage)Session["VacationPackage"];

            for (int i = 0; i < vacation.cars.Count; i++)
            {
                CarServiceRef.Car currCar = vacation.cars[i];
                int currCarQuantity = int.Parse(Request["cartCar" + currCar.carID]);
                vacation.carsQuantity[i] = currCarQuantity;

                updateCartCount(currCarQuantity);
            }

            for (int i = 0; i < vacation.events.Count; i++)
            {
                EventServiceRef.Event currEvent = vacation.events[i];
                int currEventQuantity = int.Parse(Request["cartEvent" + currEvent.ID]);
                vacation.eventsQuantity[i] = currEventQuantity;

                updateCartCount(currEventQuantity);
            }

            for (int i = 0; i < vacation.rooms.Count; i++)
            {
                HotelServiceRef.Room currRoom = vacation.rooms[i];
                int currRoomQuantity = int.Parse(Request["cartRooms" + currRoom.RoomID]);
                vacation.roomsQuantity[i] = currRoomQuantity;

                updateCartCount(currRoomQuantity);
            }

            for (int i = 0; i < vacation.flights.Count; i++)
            {
                Flight flight = vacation.flights[i];
                int currFlightQuantity = int.Parse(Request["cartFlights" + flight.flightID]);
                vacation.flightsQuantity[i] = currFlightQuantity;

                updateCartCount(currFlightQuantity);
            }

            displayCart();
        }

        private void updateCartCount(int countToAdd)
        {
            int currCartCount = int.Parse(cartCountDisplay.InnerHtml);
            cartCountDisplay.InnerHtml = (currCartCount + countToAdd) + "";
        }

        private void displayCartCount()
        {
            cartCountDisplay.InnerHtml = "0";

            VacationPackage vacation = (VacationPackage)Session["VacationPackage"];

            for (int i = 0; i < vacation.cars.Count; i++)
            {
                updateCartCount(vacation.carsQuantity[i]);
            }

            for (int i = 0; i < vacation.events.Count; i++)
            {
                updateCartCount(vacation.eventsQuantity[i]);
            }

            for (int i = 0; i < vacation.rooms.Count; i++)
            {
                updateCartCount(vacation.roomsQuantity[i]);
            }

            for (int i = 0; i < vacation.flights.Count; i++)
            {
                updateCartCount(vacation.flightsQuantity[i]);
            }
        }

        protected void btnHotelNameSearch_Click(object sender, EventArgs e)
        {
            HotelServiceRef.HotelService pxy = new HotelServiceRef.HotelService();
            HotelServiceRef.Hotel hotel = new HotelServiceRef.Hotel();

            hotel.City = txtHotelCity.Text;
            hotel.Id = Convert.ToInt32(ddlHotelNames.SelectedValue);
            hotel.Name = ddlHotelNames.SelectedItem.Text;
            hotel.State = ddlHotelState.SelectedItem.Text;

            DataSet myDS = pxy.GetRooms(hotel);
            rptHotelResults.DataSource = myDS;
            rptHotelResults.DataBind();
            divHotelResults.Visible = true;
        }

        protected void btnHotelAmenitiesSearch_Click(object sender, EventArgs e)
        {
            HotelServiceRef.HotelService pxy = new HotelServiceRef.HotelService();
            HotelServiceRef.Amenities amenities = new HotelServiceRef.Amenities();

            amenities.FreeBreakfast = Convert.ToInt32(ddlBreakfast.SelectedValue);
            amenities.Gym = Convert.ToInt32(ddlGym.SelectedValue);
            amenities.PoolsideBar = Convert.ToInt32(ddlPoolBar.SelectedValue);
            amenities.Smoking = Convert.ToInt32(ddlSmoking.SelectedValue);
            amenities.ValetParking = Convert.ToInt32(ddlValet.SelectedValue);
            amenities.Wifi = Convert.ToInt32(ddlWifi.SelectedValue);

            DataSet myDS = pxy.GetRoomsByAmenities(amenities, txtHotelCity.Text, ddlHotelState.SelectedItem.Text);
            rptHotelResults.DataSource = myDS;
            rptHotelResults.DataBind();
            divHotelResults.Visible = true;
        }

        protected void btnHotelsClear_Click(object sender, EventArgs e)
        {
            divHotelView.Visible = true;
            divHotelDetails.Visible = false;
            divHotelResults.Visible = false;

            rptHotelResults.DataSource = null;
            rptHotelResults.DataBind();
        }

        protected void rptHotels_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Retrieve the row index for the item that fired the ItemCommand event
            int rowIndex = e.Item.ItemIndex;

            // Retrieve a value from a control in the Repeater's Items collection
            Label roomID = (Label)rptHotelResults.Items[rowIndex].FindControl("lblRoomID");
            Label hotelName = (Label)rptHotelResults.Items[rowIndex].FindControl("lblHotelName");
            Label roomPrice = (Label)rptHotelResults.Items[rowIndex].FindControl("lblHotelPrice");

            HotelServiceRef.Room currRoom = new HotelServiceRef.Room();
            currRoom.Price = Convert.ToInt32(roomPrice.Text);
            currRoom.RoomID = Convert.ToInt32(roomID.Text);

            VacationPackage vacationPackage;
            if (Session["VacationPackage"] != null)
            {
                vacationPackage = (VacationPackage)Session["VacationPackage"];
            }
            else
            {
                vacationPackage = new VacationPackage();
            }

            vacationPackage.rooms.Add(currRoom);
            vacationPackage.roomsQuantity.Add(1);
            incrementCartNumber();
            Session["VacationPackage"] = vacationPackage;
        }

        protected void btnFlightCityStateSearch_Click(object sender, EventArgs e)
        {
            AirServiceRef.AirService pxy = new AirServiceRef.AirService();

            DataSet myDS = pxy.GetAirCarriers(txtFlightDepCity.Text, ddlFlightDepState.SelectedItem.Text,
                txtFlightDestCity.Text, ddlFlightDestState.SelectedItem.Text);

            ddlFlightCarriers.DataSource = myDS;
            ddlFlightCarriers.DataTextField = "carrierName";
            ddlFlightCarriers.DataValueField = "carrierID";
            ddlFlightCarriers.DataBind();

        }

        protected void btnCarrierNameSearch_Click(object sender, EventArgs e)
        {
            AirServiceRef.AirService pxy = new AirServiceRef.AirService();

            DataSet myDS = pxy.GetFlights(Convert.ToInt32(ddlFlightCarriers.SelectedValue), txtFlightDepCity.Text, ddlFlightDepState.SelectedItem.Text,
                txtFlightDestCity.Text, ddlFlightDestState.SelectedItem.Text);

        }

        protected void btnFlightTypeSearch_Click(object sender, EventArgs e)
        {
            AirServiceRef.AirService pxy = new AirServiceRef.AirService();
            string[] reqs = { ddlFlightType.SelectedItem.Text };

            DataSet myDS = pxy.FindFlights(reqs, txtFlightDepCity.Text, ddlFlightDepState.SelectedItem.Text,
                txtFlightDestCity.Text, ddlFlightDestState.SelectedItem.Text);
            rptFlights.DataSource = myDS;
            rptFlights.DataBind();
            divFlightResults.Visible = true;

        }

        protected void rptFlights_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            // Retrieve the row index for the item that fired the ItemCommand event
            int rowIndex = e.Item.ItemIndex;

            // Retrieve a value from a control in the Repeater's Items collection
            Label flightID = (Label)rptFlights.Items[rowIndex].FindControl("lblflightID");
            Label carrierName = (Label)rptFlights.Items[rowIndex].FindControl("lblCarrierName");
            Label flightPrice = (Label)rptFlights.Items[rowIndex].FindControl("lblFlightPrice");

            Flight currFlight = new Flight();
            currFlight.price = Convert.ToDouble(flightPrice.Text);
            currFlight.flightID = Convert.ToInt32(flightID.Text);

            VacationPackage vacationPackage;
            if (Session["VacationPackage"] != null)
            {
                vacationPackage = (VacationPackage)Session["VacationPackage"];
            }
            else
            {
                vacationPackage = new VacationPackage();
            }

            vacationPackage.flights.Add(currFlight);
            vacationPackage.flightsQuantity.Add(1);
            incrementCartNumber();
            Session["VacationPackage"] = vacationPackage;
        }

        protected void btnFlightsClear_Click(object sender, EventArgs e)
        {
            divFlightView.Visible = true;
            divFlightDetails.Visible = false;
            divFlightResults.Visible = false;

            rptFlights.DataSource = null;
            rptFlights.DataBind();
        }

    }
}