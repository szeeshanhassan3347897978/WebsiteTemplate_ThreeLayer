using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace DataAccessLayer
{
    public class DBManager
    {
        

        public string queryString;
        private string connString = "";
        private SqlConnection dbConnection = new SqlConnection();
        private SqlDataAdapter dbAdapter = new SqlDataAdapter();
        private SqlCommand dbCommand = new SqlCommand();
        private string GlobalConnectionString = ConfigurationManager.ConnectionStrings["connAssuieGreen"].ConnectionString;
        public DBManager()
        {
            queryString = GlobalConnectionString;
            connString = GlobalConnectionString;
          
        }





        public void setConnectionString(string connStr)
        {

            try
            {
                connString = connStr;
            }
            catch (Exception ex)
            {

                throw ex;
            }


        }
        public string getConnectionString()
        {

            try
            {
                return connString;
            }
            catch (Exception ex)
            {

                throw ex;
            }


        }
        public void createConnection()
        {

            try
            {
                dbConnection.ConnectionString = connString;
                dbConnection.Open();
            }
            catch (Exception ex)
            {

                throw ex;
            }


        }
        public void closeConnection()
        {

            try
            {
                if (dbConnection.State != 0)
                    dbConnection.Close();
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

        public DataTable showRecords(string query)
        {
            DataTable table = new DataTable();
            try
            {
                if (dbConnection.State == 0)
                {
                    createConnection();
                }
                dbCommand.Connection = dbConnection;
                dbCommand.CommandText = query;
                dbCommand.CommandType = CommandType.Text;
                dbAdapter = new SqlDataAdapter(dbCommand);
                dbAdapter.Fill(table);

            }
            catch (Exception )
            {

                dbAdapter.Dispose();
                dbConnection.Close();
            }
            finally
            {
                dbAdapter.Dispose();
                dbConnection.Close();
            }
            return table;
        }

        public void getData(DataTable dt, string query)
        {

            try
            {
                if (dbConnection.State == 0)
                {
                    createConnection();
                }
                dbCommand.Connection = dbConnection;
                dbCommand.CommandText = query;
                dbCommand.CommandType = CommandType.Text;
                dbAdapter = new SqlDataAdapter(dbCommand);
                dbAdapter.Fill(dt);
            }
            catch (Exception)
            {
                dbAdapter.Dispose();
                dbConnection.Close();

            }

            finally
            {
                dbAdapter.Dispose();
                dbConnection.Close();
            }

        }

        public int executeQuery(string query)
        {
            try
            {
                if (dbConnection.State == 0)
                {
                    createConnection();
                }
                dbCommand.Connection = dbConnection;
                dbCommand.CommandText = query;
                dbCommand.CommandType = CommandType.Text;
                return dbCommand.ExecuteNonQuery();
            }
            catch (Exception exp)
            {
                throw exp;
            }
            finally
            {
                dbAdapter.Dispose();
                dbConnection.Close();
            }
        }
        public int executeQuery(string query,SqlConnection conn,ref SqlTransaction sqlTran)
        {                           
                dbCommand.Connection = conn;
                dbCommand.CommandText = query;
                dbCommand.CommandType = CommandType.Text;
                dbCommand.Transaction = sqlTran;
                return dbCommand.ExecuteNonQuery();           
            
        }
        public Int64 getMaxID(string query)
        {
            try
            {
                if (dbConnection.State == 0)
                {
                    createConnection();
                }
                dbCommand.Connection = dbConnection;
                dbCommand.CommandText = query;
                dbCommand.CommandType = CommandType.Text;
                return (Int32)dbCommand.ExecuteScalar();
            }
            catch (Exception exp)
            {
                throw exp;
            }
        }
        public Int64 getMaxID(string query, SqlConnection conn, ref SqlTransaction sqltran)
        {

            dbCommand.Connection = conn;
            dbCommand.CommandText = query;
            dbCommand.Transaction = sqltran;
            dbCommand.CommandType = CommandType.Text;
            return (Int64)dbCommand.ExecuteScalar();

        }
        public decimal getLastAmount(string query,SqlConnection conn, ref SqlTransaction sqltran)
        {
            
                dbCommand.Connection = conn;
                dbCommand.CommandText = query;
                dbCommand.Transaction = sqltran;
                dbCommand.CommandType = CommandType.Text;
                return (decimal)dbCommand.ExecuteScalar();
           
        }


        public DataTable GetRecords(string getQuery)
        {
            SqlConnection conn = new SqlConnection(queryString);
            SqlCommand command = new SqlCommand(getQuery, conn);
            using (conn)
            {
                conn.Open();
                SqlDataReader reader = command.ExecuteReader();
                DataTable table = new DataTable();
                table.Load(reader);
                return table;
            }
        }

       
    }
}
