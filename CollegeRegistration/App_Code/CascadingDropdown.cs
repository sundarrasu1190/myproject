using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using AjaxControlToolkit;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using CollegeRegistration.App_Code.BAL;
using CollegeRegistration.App_Code.DAL;


/// <summary>
/// Summary description for CascadingDropdown
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 [System.Web.Script.Services.ScriptService]
public class CascadingDropdown : System.Web.Services.WebService {

    SqlServer objException = new SqlServer();
    RegistrationBAL objRBAL = new RegistrationBAL();
    RegistrationDAL objRDAL = new RegistrationDAL();
        

    public CascadingDropdown () {
        
        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

   
    [WebMethod]
    public CascadingDropDownNameValue[] Binduniversitydropdown(string knownCategoryValues, string category)
    {// Binding the values to dropdown
        List<CascadingDropDownNameValue> universitydetails = new List<CascadingDropDownNameValue>();
        try
        {
            DataSet dsUniversity = new DataSet();
            objRBAL.getUniversity(dsUniversity);
            foreach (DataRow dtrow in dsUniversity.Tables[0].Rows)
            {
                string UniversityId = dtrow["UniversityId"].ToString();
                string UniversityName = dtrow["UniversityName"].ToString();
                universitydetails.Add(new CascadingDropDownNameValue(UniversityName, UniversityId));
            }
            
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getUniversity code Error in: " + ex.Message);
        }
        return universitydetails.ToArray();
        
    }
    [WebMethod]
    public CascadingDropDownNameValue[] Bindzonedropdown(string knownCategoryValues, string category)
    {// Binding the values to dropdown
        List<CascadingDropDownNameValue> zonedetails = new List<CascadingDropDownNameValue>();
        try
        {
            DataSet dsZone = new DataSet();
            objRBAL.getZone(dsZone);
            foreach (DataRow dtrow in dsZone.Tables[0].Rows)
            {
                string ZoneId = dtrow["ZoneId"].ToString();
                string ZoneName = dtrow["ZoneName"].ToString();
                zonedetails.Add(new CascadingDropDownNameValue(ZoneName, ZoneId));
            }

        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getZone code Error in: " + ex.Message);
        }
        return zonedetails.ToArray();

    }
    [WebMethod]
    public CascadingDropDownNameValue[] Bindaccomdropdown(string knownCategoryValues, string category)
    {// Binding the values to dropdown
        List<CascadingDropDownNameValue> accomodationdetails = new List<CascadingDropDownNameValue>();
        try
        {
            DataSet dsAcc = new DataSet();
            objRBAL.getAccomodation(dsAcc);
            foreach (DataRow dtrow in dsAcc.Tables[0].Rows)
            {
                string AccomodationId = dtrow["AccomodationId"].ToString();
                string AccomodationName = dtrow["AccomodationName"].ToString();
                accomodationdetails.Add(new CascadingDropDownNameValue(AccomodationName, AccomodationId));
            }

        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getAccomodation code Error in: " + ex.Message);
        }
        return accomodationdetails.ToArray();

    }
    
}
