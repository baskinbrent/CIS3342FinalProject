using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TermProjectWS
{
    public class Requirements
    {
        public float price;
        public string gps;
        public string type;
        public string carClass;
        public string electric;
        public int passengers;
        public int luggage;
        public int doors;
        public int mileage;

        public Requirements()
        {
            price = 0;
            gps = "";
            type = "";
            carClass = "";
            electric = "";
            passengers = 0;
            luggage = 0;
            doors = 0;
            mileage = 0;
        }

    }

    

}