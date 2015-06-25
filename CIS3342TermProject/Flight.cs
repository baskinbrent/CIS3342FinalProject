using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CIS3342TermProject
{
    [Serializable]
    public class Flight
    {
        public string departureCity;
        public string departureState;
        public string destinationCity;
        public string destinationState;
        public string carrierName;
        public double price;
        public int carrierID;
        public int flightID;
    }
}