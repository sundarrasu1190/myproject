using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using CollegeRegistration.App_Code.DAL;
using System.Globalization;
/// <summary>
/// Summary description for SqlServer
/// </summary>
/// 
namespace CollegeRegistration.App_Code.DAL
{
    #region public methods
    public class SqlServer
    {
        // variable declaration
        SqlConnection con = new SqlConnection();
        SqlCommand cmd = new SqlCommand();
        SqlDataAdapter da = new SqlDataAdapter();

        public void getSqlConnection()
        {
            try
            {
                con = new SqlConnection(ConfigurationManager.ConnectionStrings["CollegeRegConnection"].ConnectionString);
                con.Open();
            }
            catch (Exception ex)
            {
                WriteError(GetType().Name + ": GetSqlServerConnection code: Error in: " + ex.Message);
            }
        }
        public int ExecuteNonQuery(string storeProc)
        {
            int rowsAffected = 0;
            try
            {
                getSqlConnection();
                cmd = new SqlCommand(storeProc, con);
                cmd.CommandType = CommandType.Text;
                rowsAffected = cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                WriteError(GetType().Name + ": ExecuteNonQuery code: Error in: " + ex.Message);
            }
            finally
            {
                con.Dispose();
                con.Close();
            }
            return rowsAffected;
        }
        public int FillDataTable(string storeProc, DataTable dt)
        {
            int filledCount = 0;
            try
            {
                getSqlConnection();
                cmd = new SqlCommand(storeProc, con);
                da = new SqlDataAdapter(cmd);
                filledCount = da.Fill(dt);
            }
            catch (Exception ex)
            {
                WriteError(GetType().Name + ": FillDataTable code: Error in: " + ex.Message);
            }
            finally
            {
                con.Dispose();
                con.Close();

            }
            return filledCount;
        }
       
        public int FillDataSet(string storeProc, DataSet ds, string tblName)
        {

            int filledDataset = 0;
            DataView dv = new DataView();
            try
            {
                getSqlConnection();
                cmd = new SqlCommand(storeProc, con);
                da = new SqlDataAdapter(cmd);
                filledDataset = da.Fill(ds, tblName);

            }
            catch (Exception ex)
            {
                WriteError(GetType().Name + ": FillDataSet code Error in: " + ex.Message);
            }
            finally
            {
                con.Dispose();
                con.Close();
            }
            return filledDataset;
        }

        public void WriteError(string catchError)
        {
            string filePath = "~/ErrorCapture/ErrorHandler.txt";
            System.IO.StreamWriter file = System.IO.File.AppendText(System.Web.HttpContext.Current.Server.MapPath(filePath));
            try
            {
                file.WriteLine("\r\nLog Entry  : ");
                file.WriteLine("Date & Time: {0}", DateTime.Now.ToString(CultureInfo.InvariantCulture));
                file.WriteLine(catchError);
                file.WriteLine("****************************************************************************");
            }
            catch (Exception ex)
            {
                WriteError(GetType().Name + ": WriteError code: Error in: " + ex.Message);
            }
            finally
            {
                file.Flush();
                file.Dispose();

            }
        }
    }

    #endregion
}