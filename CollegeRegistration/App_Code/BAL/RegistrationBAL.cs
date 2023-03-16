using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CollegeRegistration.App_Code.BAL;
using CollegeRegistration.App_Code.DAL;
using CollegeRegistration.App_Code.Entity;
using System.Data;
/// <summary>
/// Summary description for RegistrationBAL
/// </summary>
/// 
namespace CollegeRegistration.App_Code.BAL
{
    public class RegistrationBAL
    {
        RegistrationDAL objRDAL = new RegistrationDAL();
        #region public members
        public int getUniversity(DataTable dtUniversity)
        {
            return objRDAL.getUniversity(dtUniversity);
        }

        public int getZone(DataTable dtZone)
        {
            return objRDAL.getZone(dtZone);
        }

        public int getAccomodation(DataTable dtAccomodation)
        {
            return objRDAL.getAccomodation(dtAccomodation);
        }
        public int getMaxCollegeId(DataTable dtMaxId)
        {
            return objRDAL.getMaxCollegeId(dtMaxId);
        }
        public int saveAndUpdateDetails(RegistrationEntity objREntity)
        {
            return objRDAL.saveAndUpdateDetails(objREntity);
        }
        public int getCollegeDetails(DataTable dtCollege)
        {
            return objRDAL.getCollegeDetails(dtCollege);
        }
        public int getUniName(DataTable dtUniName)
        {
            return objRDAL.getUniName(dtUniName);
        }
        public int getZoneName(DataTable dtZoneName)
        {
            return objRDAL.getZoneName(dtZoneName);
        }

        public int getClgDet(RegistrationEntity objREntity, DataTable dtClgDet)
        {
            return objRDAL.getClgDet(objREntity,dtClgDet);
        }
        public int gridSorting(DataSet ds)
        {
            return objRDAL.gridSorting(ds);
        }
        public int gridRowDelete(RegistrationEntity objREntity)
        {
            return objRDAL.gridRowDelete(objREntity);
        }
        public int getUniversity(DataSet dsUniversity)
        {
            return objRDAL.getUniversity(dsUniversity);
        }
        public int getZone(DataSet dsZone)
        {
            return objRDAL.getZone(dsZone);
        }

        public int getAccomodation(DataSet dsAcc)
        {
            return objRDAL.getAccomodation(dsAcc);
        }
        public int getClgDetById(RegistrationEntity objREntity, DataTable dtClgDetById)
        {
            return objRDAL.getClgDetById(objREntity,dtClgDetById);
        }
        #endregion











       
    }
}