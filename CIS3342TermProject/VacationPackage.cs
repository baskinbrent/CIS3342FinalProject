using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CIS3342TermProject
{
    [Serializable]
    public class VacationPackage
    {
        public List<EventServiceRef.Event> events;
        public List<int> eventsQuantity;
        public List<Flight> flights;
        public List<int> flightsQuantity;
        public List<CarServiceRef.Car> cars;
        public List<int> carsQuantity;
        public List<HotelServiceRef.Room> rooms;
        public List<int> roomsQuantity;

        public VacationPackage()
        {
            events = new List<EventServiceRef.Event>();
            eventsQuantity = new List<int>();
            flights = new List<Flight>();
            flightsQuantity = new List<int>();
            cars = new List<CarServiceRef.Car>();
            carsQuantity = new List<int>();
            rooms = new List<HotelServiceRef.Room>();
            roomsQuantity = new List<int>();
        }

    }
}