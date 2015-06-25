using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.IO;
using System.Runtime.Serialization.Formatters.Binary;
using System.Data;
using System.Data.SqlClient;


namespace CIS3342TermProject
{
    public class Serialize
    {
        DBConnect objDB = new DBConnect();

        // This function uses binary serialization to serialize an Object to a MemoryStream
        public MemoryStream SerializeToMemoryStream(Object objToSerialize)
        {
            BinaryFormatter serializer = new BinaryFormatter();
            MemoryStream memoryStream = new MemoryStream();
            serializer.Serialize(memoryStream, objToSerialize);
            return memoryStream;
        }

        // This function uses binary deserialization to reconstruct an Object from a MemoryStream
        public Object DeserializeFromMemoryStream(MemoryStream memoryStream)
        {
            BinaryFormatter deserializer = new BinaryFormatter();
            Object deserializedObject;
            memoryStream.Position = 0;
            deserializedObject = deserializer.Deserialize(memoryStream);
            return deserializedObject;
        }

        // This function uses binary serialization to serialize an Object to a Byte Array
        public Byte[] SerializeToByteArray(Object objToSerialize)
        {
            BinaryFormatter serializer = new BinaryFormatter();
            MemoryStream memoryStream = new MemoryStream();
            Byte[] byteArray;
            serializer.Serialize(memoryStream, objToSerialize);
            byteArray = memoryStream.ToArray();
            return byteArray;
        }

        // This function uses binary deserialization to reconstruct an Object from a Byte Array
        public Object DeserializeFromByteArray(Byte[] byteArray)
        {
            BinaryFormatter deserializer = new BinaryFormatter();
            MemoryStream memoryStream = new MemoryStream(byteArray);
            Object deserializedObject;
            deserializedObject = deserializer.Deserialize(memoryStream);
            return deserializedObject;
        }


        // This function writes the cart to the database.
        public int WriteCartToDB(Object cart, Object loginID)
        {
            // First, you must create a Stored Procedure, "UpdateCart" that will provide the
            // functionality to store the byte array for an object in your database
            Byte[] byteArray;
            SqlCommand objCommand = new SqlCommand();
            int returnValue;

            byteArray = SerializeToByteArray(cart);

            objCommand.CommandText = "UpdateCart";          // *** CHANGE NAME TO YOUR STORED PROCEDURE'S NAME
            objCommand.CommandType = CommandType.StoredProcedure;

            // Parameter names "Cart" and "LoginID" are the names I used in my Stored Procedure
            // *** CHANGE PARAMETER NAMES TO THE ONES IN YOUR PROCEDURE
            objCommand.Parameters.AddWithValue("@cart", byteArray);
            objCommand.Parameters.AddWithValue("@email", loginID);
            returnValue = objDB.DoUpdateUsingCmdObj(objCommand);
            return returnValue;
        }

        // This function reads the cart from the database.
        public Object ReadCartFromDB(Object LoginID)
        {
            // First, you must provide a Stored Procedure named "ReadCart" that will return a byte array 
            SqlCommand objCommand = new SqlCommand();
            DataSet ds;
            Byte[] byteArray;

            objCommand.CommandText = "ReadCart";            // *** CHANGE NAME TO YOUR STORED PROCEDURE'S NAME
            objCommand.CommandType = CommandType.StoredProcedure;

            // Parameter names "Cart" and "LoginID" are the names I used in my Stored Procedure
            // *** CHANGE PARAMETER NAMES TO THE ONES IN YOUR PROCEDURE
            objCommand.Parameters.AddWithValue("@email", LoginID);
            ds = objDB.GetDataSetUsingCmdObj(objCommand);

            if (ds.Tables[0].Rows.Count > 0)
            {
                DataRow record = ds.Tables[0].Rows[0];

                if (record["cart"] != DBNull.Value)
                {
                    byteArray = (Byte[])record["cart"];
                    return DeserializeFromByteArray(byteArray);
                }
                else
                {
                    return null;
                }
            }
            else
            {
                return null;
            }
        }

        // This function uses binary deserialization to deserialize an object that was previously stored it in a text file
        public Object ReadCartFromFile(String userlogin)
        {
            FileStream fs = null;
            BinaryFormatter deserializer = new BinaryFormatter();
            Object cart = null;

            try
            {
                fs = new FileStream("C:\\some_path" + userlogin + ".dat", FileMode.OpenOrCreate);

                if (fs.Length > 0)
                    cart = deserializer.Deserialize(fs);

                fs.Close();
                fs = null;
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (fs != null) {
                    fs.Close();
                    fs = null;
                }
            }

            return cart;
        }

        // This function uses binary serialization to serialize an object and store it in a text file.
        public Boolean WriteCartToFile(Object cart, String userlogin)
        {
            FileStream fs = null;
            BinaryFormatter serializer = new BinaryFormatter();

            try
            {
                fs = new FileStream("C:\\some_path" + userlogin + ".dat", FileMode.Create);
                serializer.Serialize(fs, cart);
                fs.Close();
                fs = null;
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally 
            {
                if (fs != null) {
                    fs.Close();
                    fs = null;
                }
            }
        }

    }
}
