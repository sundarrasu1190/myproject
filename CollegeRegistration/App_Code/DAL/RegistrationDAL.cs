using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CollegeRegistration.App_Code.DAL;
using CollegeRegistration.App_Code.BAL;
using CollegeRegistration.App_Code.Entity;
using System.Data;

/// <summary>
/// Summary description for RegistrationDAL
/// </summary>
/// 
namespace CollegeRegistration.App_Code.DAL
{
    public class RegistrationDAL
    {
        SqlServer objDAL = new SqlServer();
        #region public members
        public int getUniversity(DataTable dtUniversity)
        {
            int rowsAffected = 0;
            string Query = "SPGetUniversityMaster";
            return rowsAffected = objDAL.FillDataTable(Query, dtUniversity);
        }

        public int getZone(DataTable dtZone)
        {
            int rowsAffected = 0;
            string Query = "SPGetZoneMaster";
            return rowsAffected = objDAL.FillDataTable(Query, dtZone);
        }

        public int getAccomodation(DataTable dtAccomodation)
        {
            int rowsAffected = 0;
            string Query = "SPGetAccomodationMaster";
            return rowsAffected = objDAL.FillDataTable(Query, dtAccomodation);
        }
        public int getMaxCollegeId(DataTable dtMaxId)
        {
            int rowsAffected = 0;
            string Query = "SPGetMaxCollegeId";
            return rowsAffected = objDAL.FillDataTable(Query, dtMaxId);
        }
        public int saveAndUpdateDetails(RegistrationEntity objREntity)
        {
            int rowsAffected = 0;
            string Query = "SPSaveandUpdateCollegeMaster '" + objREntity.collegeCode + "','" + objREntity.collegeName + "','" + objREntity.collegeAddress + "','" + objREntity.dateOfReopening + "','" + objREntity.emailId + "','" + objREntity.website + "','" + objREntity.universityId + "','" + objREntity.zone + "','" + objREntity.phoneNo + "','" + objREntity.accomodationId + "'";
            return rowsAffected = objDAL.ExecuteNonQuery(Query);
        }
        public int getCollegeDetails(DataTable dtCollege)
        {
            int rowsAffected = 0;
            string Query = "SPGetCollegeMaster";
            return rowsAffected = objDAL.FillDataTable(Query, dtCollege);
        }
        public int getUniName(DataTable dtUniName)
        {
            int rowsAffected = 0;
            string Query = "SPGetUniName";
            return rowsAffected = objDAL.FillDataTable(Query, dtUniName);
        }
        public int getZoneName(DataTable dtZoneName)
        {
            int rowsAffected = 0;
            string Query = "SPGetZoneName";
            return rowsAffected = objDAL.FillDataTable(Query, dtZoneName);
        }
        public int getClgDet(RegistrationEntity objREntity, DataTable dtClgDet)
        {
            int rowsAffected = 0;
            string Query = "SPGetDetailsByName '" + objREntity.collegeName + "','" + objREntity.emailId + "','" + objREntity.collegeCode + "','" + objREntity.universityId + "'";
            return rowsAffected = objDAL.FillDataTable(Query, dtClgDet);
        }
        public int gridSorting(DataSet ds)
        {
            string Query = "SPGetCollegeMaster ";
            string tblName = "tblCollegeMaster";
            return objDAL.FillDataSet(Query, ds, tblName);
        }
        public int gridRowDelete(RegistrationEntity objREntity)
        {
            int rowsAffected = 0;
            string Query = "SPUpdateDetails '" + objREntity.CollegeId + "',0";
            return rowsAffected = objDAL.ExecuteNonQuery(Query);
        }
        public int getUniversity(DataSet dsUniversity)
        {
            string Query = "SPGetUniversityMaster ";
            string tblName = "tblUniversityMaster";
            return objDAL.FillDataSet(Query, dsUniversity, tblName);
        }

        public int getZone(DataSet dsZone)
        {
            string Query = "SPGetZoneMaster ";
            string tblName = "tblZoneMaster";
            return objDAL.FillDataSet(Query, dsZone, tblName);
        }
        public int getAccomodation(DataSet dsAcc)
        {
            string Query = "SPGetAccomodationMaster ";
            string tblName = "tblAccomodationMaster";
            return objDAL.FillDataSet(Query, dsAcc, tblName);
        }
        public int getClgDetById(RegistrationEntity objREntity, DataTable dtClgDetById)
        {
            int rowsAffected = 0;
            string Query = "SPGetCollegeMasterById '" + objREntity.CollegeId + "'";
            return rowsAffected = objDAL.FillDataTable(Query, dtClgDetById);
        }
        #endregion












        
    }
}