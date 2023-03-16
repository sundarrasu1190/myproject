using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using CollegeRegistration.App_Code.Entity;
/// <summary>
/// Summary description for RegistrationEntity
/// </summary>
/// 

namespace CollegeRegistration.App_Code.Entity
{
    public class RegistrationEntity
    {
        #region Public members
        public string collegeCode { get; set; }
        public string collegeName { get; set; }
        public string collegeAddress { get; set; }
        public string dateOfReopening { get; set; }
        public string emailId { get; set; }
        public string website { get; set; }
        public int universityId { get; set; }
        public string universityName { get; set; }
        public int zone { get; set; }
        public string phoneNo { get; set; }
        public int accomodationId { get; set; }
        public int CollegeId { get; set; }
        #endregion
    }
}