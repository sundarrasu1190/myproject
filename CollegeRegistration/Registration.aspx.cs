using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using CollegeRegistration.App_Code.BAL;
using CollegeRegistration.App_Code.DAL;
using CollegeRegistration.App_Code.Entity;

public partial class Registration : System.Web.UI.Page
{
    SqlServer objException = new SqlServer();
    RegistrationBAL objRBAL = new RegistrationBAL();
    RegistrationDAL objRDAL = new RegistrationDAL();
    RegistrationEntity objREntity = new RegistrationEntity();
    public string collegeCode = string.Empty;
    public string currentDate = string.Empty;
    public string date = string.Empty;
    public string month = string.Empty;
    public string year = string.Empty;
    public string displayDate = string.Empty;
    public string sortDirec = "CollegeName ASC";

    #region protected members
    protected void Page_Load(object sender, EventArgs e)
    {//page load 
        try
        {
            if (!IsPostBack)
            {
                ViewState["sortExpr"] = sortDirec;
                //getUniversity();
                //getZone();
                getAccomodation();
                getCollegeDetails();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " Page_Load code Error in: "+ex.Message);
        }
    }
   
    #endregion
    #region private members
    private void getUniversity()
    {
        // data getting from database
        try
        {
            DataTable dtUniversity = new DataTable();
            objRBAL.getUniversity(dtUniversity);
            if (dtUniversity.Rows.Count != 0)
            {
                ddlUniversity.DataSource = dtUniversity;
                ddlUniversity.DataTextField = "UniversityName";
                ddlUniversity.DataValueField = "UniversityId";
                ddlUniversity.DataBind();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getUniversity code Error in: " + ex.Message);
        }  
    }

    private void getZone()
    {
        // data getting from database
        try
        {
            DataTable dtZone = new DataTable();
            objRBAL.getZone(dtZone);
            if (dtZone.Rows.Count != 0)
            {
                ddlZone.DataSource = dtZone;
                ddlZone.DataTextField = "ZoneName";
                ddlZone.DataValueField = "ZoneId";
                ddlZone.DataBind();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getZone code Error in: " + ex.Message);
        }
    }


    private void getAccomodation()
    {
        // data getting from database
        try
        {
            DataTable dtAccomodation = new DataTable();
            objRBAL.getAccomodation(dtAccomodation);
            if (dtAccomodation.Rows.Count != 0)
            {
                rblAccomodation.DataSource = dtAccomodation;
                rblAccomodation.DataTextField = "AccomodationName";
                rblAccomodation.DataValueField = "AccomodationId";
                rblAccomodation.DataBind();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getAccomodation code Error in: " + ex.Message);
        }
    }
    private void displayDateFormat()
    {
        //currentDate = Request.Form[txtDORO.UniqueID];
        currentDate = txtDORO.Text;
        date = currentDate.Substring(0, 2);
        month = currentDate.Substring(3, 2);
        year = currentDate.Substring(6, 4);
        displayDate = year + '-' + month + '-' + date;
    }
    private void getMaxCollegeId()
    {
        // data getting from database
        try
        {
            DataTable dtMaxId = new DataTable();
            objRBAL.getMaxCollegeId(dtMaxId);
            if (dtMaxId.Rows.Count != 0)
            {
               collegeCode=dtMaxId.Rows[0]["CollegeId"].ToString();
               if (txtClgName.Text.Length >= 4)
               {
                   collegeCode = txtClgName.Text.Substring(0,4).ToString() + collegeCode.PadLeft(4, '0');
               }
               else
               {
                   collegeCode = txtClgName.Text.ToString() + collegeCode.PadLeft(4, '0');
               }
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getMaxCollegeId code Error in: " + ex.Message);
        }
    }
    private void clear()
    {
        try
        {
            txtClgAddress.Text = string.Empty;
            txtClgName.Text = string.Empty;
            txtClgNameSearch.Text = string.Empty;
            txtDORO.Text = string.Empty;
            txtEmailid.Text = string.Empty;
            txtPhoneno.Text = string.Empty;
            txtWebsite.Text = string.Empty;
            ccddUniversity.SelectedValue = string.Empty;
            ccdZone.SelectedValue = string.Empty;
            getAccomodation();
            
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " Clear code Error in: " + ex.Message);
        }
    }
    private void getCollegeDetails()
    {
        // data getting from database
        try
        {
            DataTable dtCollege = new DataTable();
            objRBAL.getCollegeDetails(dtCollege);
            if (dtCollege.Rows.Count != 0)
            {
                gvRegistration.DataSource = dtCollege;
                gvRegistration.DataBind();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getCollegeDetails code Error in: " + ex.Message);
        }
    }
    private void getGridview()
    {//sorting grid based on sort expression 
        try
        {
            DataView dv = new DataView();
            DataSet ds = new DataSet();
            objRBAL.gridSorting(ds);
            dv = ds.Tables["tblCollegeMaster"].DefaultView;

            dv.Sort = ViewState["sortExpr"].ToString();
            gvRegistration.DataSource = dv;

            gvRegistration.DataBind();
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " getGridview code Error in: " + ex.Message);
        }
    }
    #endregion
    #region button click events

    
    protected void btnAdd_Click(object sender, EventArgs e)
    {//save functionality 
        this.mpePanel.Show();
       
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            objREntity.collegeName = txtClgName.Text.Trim().ToString();
            objREntity.collegeAddress = txtClgAddress.Text.Trim().ToString();
            displayDateFormat();
            objREntity.dateOfReopening = displayDate.ToString();
            objREntity.emailId = txtEmailid.Text.Trim().ToString();
            objREntity.website = txtWebsite.Text.Trim().ToString();
            objREntity.universityId = Convert.ToInt32(ddlUniversity.SelectedValue.ToString());
            objREntity.zone = Convert.ToInt32(ddlZone.SelectedValue.ToString());
            objREntity.phoneNo = txtPhoneno.Text.Trim().ToString();
            objREntity.accomodationId = Convert.ToInt32(rblAccomodation.SelectedValue.ToString());
            if (btnSave.Text == "Save")
            {
                getMaxCollegeId();
                objREntity.collegeCode = collegeCode.ToString();
                
                objRBAL.saveAndUpdateDetails(objREntity);
                getCollegeDetails();
                clear();
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Details added successfully');", true);
            }
            else
            {
                
                objREntity.collegeCode = ViewState["CollegeCode"].ToString();
                objREntity.CollegeId =Convert.ToInt32(ViewState["CollegeId"].ToString());
                
                objRBAL.saveAndUpdateDetails(objREntity);
                btnSave.Text = "Save";
                getCollegeDetails();
                clear();
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Details updated successfully');", true);
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " btnAdd_Click code Error in: " + ex.Message);
        }
    }
   
    protected void btnSearch_Click(object sender, EventArgs e)
    {//search data
        try {
            objREntity.collegeName = txtClgNameSearch.Text.Trim().ToString();
            objREntity.emailId = txtEmailIdSearch.Text.Trim().ToString();
            objREntity.collegeCode = txtClgCodeSearch.Text.Trim().ToString();
            if (ccdUni.SelectedValue != string.Empty)
            {
                objREntity.universityId = Convert.ToInt32(ddlUniversityS.SelectedValue.ToString());
            }
            else
            {
                objREntity.universityId =Convert.ToInt32(ccdUni.SelectedValue);
            }
            DataTable dtClgDet = new DataTable();
            objRBAL.getClgDet(objREntity, dtClgDet);
            if (dtClgDet.Rows.Count != 0)
            {
                gvRegistration.DataSource = dtClgDet;
                gvRegistration.DataBind();
            }
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + " btnSearch_Click code Error in: " + ex.Message);
        }
    }
    protected void btnClear_Click(object sender, EventArgs e)
    {// clear the data
        txtClgNameSearch.Text = string.Empty;
        txtClgCodeSearch.Text = string.Empty;
        txtEmailIdSearch.Text = string.Empty;        
        ccdUni.SelectedValue = string.Empty;
        getCollegeDetails();
    }
    #endregion

    #region grid events

    
    protected void gvRegistration_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {//page indexing
        try
        {
            gvRegistration.PageIndex = e.NewPageIndex;
            getCollegeDetails();
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + ": gvRegistration_PageIndexChanging code:" + ex.Message);
        }
    }
    protected void gvRegistration_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {//grid view data deleting
        try
        {
            GridViewRow row = (GridViewRow)gvRegistration.Rows[e.RowIndex];
            objREntity.CollegeId = Convert.ToInt32(gvRegistration.DataKeys[e.RowIndex].Value.ToString());
            objRBAL.gridRowDelete(objREntity);
            getCollegeDetails();
            ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Details are deleted');", true);
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + ": gvRegistration_RowDeleting code:" + ex.Message);
        }
    }
    protected void gvRegistration_RowEditing(object sender, GridViewEditEventArgs e)
    {//row editing
        try
        {
            objREntity.CollegeId = Convert.ToInt32(gvRegistration.DataKeys[e.NewEditIndex].Value.ToString());
            DataTable dtClgDetById = new DataTable();
            objRBAL.getClgDetById(objREntity,dtClgDetById);
            if (dtClgDetById.Rows.Count != 0)
            {
                ViewState["CollegeCode"] = dtClgDetById.Rows[0]["CollegeCode"].ToString();
                ViewState["CollegeId"] =Convert.ToInt32(dtClgDetById.Rows[0]["CollegeId"].ToString());
                txtClgName.Text = dtClgDetById.Rows[0]["CollegeName"].ToString();
                txtClgAddress.Text = dtClgDetById.Rows[0]["CollegeAddress"].ToString();
                txtDORO.Text = dtClgDetById.Rows[0]["DateOfReopening"].ToString();
                txtEmailid.Text = dtClgDetById.Rows[0]["EmailId"].ToString();
                txtWebsite.Text = dtClgDetById.Rows[0]["Website"].ToString();
                ccddUniversity.SelectedValue = dtClgDetById.Rows[0]["UniversityId"].ToString();
                ccdZone.SelectedValue = dtClgDetById.Rows[0]["ZoneId"].ToString();
                txtPhoneno.Text = dtClgDetById.Rows[0]["PhoneNumber"].ToString();
                rblAccomodation.SelectedValue = dtClgDetById.Rows[0]["AccomodationId"].ToString();
                btnSave.Text = "Update";

            }
            this.mpePanel.Show();

          
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + ": gvRegistration_RowEditing code:" + ex.Message);
        }
    }
   
   
    protected void gvRegistration_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {//row edit cancel
        try
        {
            gvRegistration.EditIndex = -1;
            getCollegeDetails();
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + ": gvRegistration_RowCancelingEdit code:" + ex.Message);
        }
    }
    #endregion


    protected void gvRegistration_Sorting1(object sender, GridViewSortEventArgs e)
    {//row sorting asc/desc
        try
        {
            string[] sortOrder = ViewState["sortExpr"].ToString().Split(' ');
            if (sortOrder[0] == e.SortExpression)
            {
                if (sortOrder[1] == "ASC")
                {
                    ViewState["sortExpr"] = e.SortExpression + " " + "DESC";
                }
                else
                {
                    ViewState["sortExpr"] = e.SortExpression + " " + "ASC";
                }
            }
            else
            {
                ViewState["sortExpr"] = e.SortExpression + " " + "ASC";
            }

            getGridview();
        }
        catch (Exception ex)
        {
            objException.WriteError(GetType().Name + ": gvRegistration_Sorting code:" + ex.Message);
        }
    }
    
}