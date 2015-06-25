using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TermProjectWS
{
    [Serializable]
    public class Car
    {
        public int carID;
        public string year;
        public string make;
        public string model;
        public float price;
        public string gps;
        public string carClass;
        public string type;
        public string electric;
        public int passengers;
        public int luggage;
        public int doors;
        public int mileage;
    }
}