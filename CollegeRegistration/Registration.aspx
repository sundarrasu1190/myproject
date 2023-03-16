<%@ Page Title="" Language="C#" MasterPageFile="~/CollegeReg.master" AutoEventWireup="true"  EnableEventValidation="false" CodeFile="Registration.aspx.cs" Inherits="Registration" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="Styles/Registration.css" rel="stylesheet" type="text/css" />
    <script src="Scripts/Validation.js" type="text/javascript"></script>
    <script type="text/javascript">
        function checkDate(sender, args) {
            if (sender._selectedDate > new Date()) {
                alert("You cannot select a day earlier than today!");
                sender._selectedDate = new Date();
                sender._textbox.set_Value(sender._selectedDate.format(sender._format))
            }
        }
    </script>
     
   <style type="text/css">
.modalBackground
{
background-color: Gray;
filter: alpha(opacity=80);
opacity: 0.8;
z-index: 10000;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cph" Runat="Server">
<asp:ScriptManager ID="smDORO" runat="server" />
<div>
<div>
<table>
<tr><td><asp:Label ID="lblClgNameSearch" runat="server" Text="College Name"></asp:Label></td>
<td><asp:TextBox ID="txtClgNameSearch" runat="server" MaxLength="50" CssClass="stextBoxStyle" onkeypress="return IsValidCollName(event,this.id);"></asp:TextBox></td>
<td><asp:Label ID="lblClgCode" runat="server" Text="Code"></asp:Label></td>
<td align="left"><asp:TextBox ID="txtClgCodeSearch" runat="server" MaxLength="30" CssClass="stextBoxStyle"></asp:TextBox></td>

<td><asp:Label ID="lblClgMail" runat="server" Text="Emailid"></asp:Label></td>
<td align="left"><asp:TextBox ID="txtEmailIdSearch" runat="server" MaxLength="30" CssClass="stextBoxStyle" ></asp:TextBox></td>
<td align="left"><asp:regularexpressionvalidator id="revMail" runat="server" errormessage="Email is invalid." controltovalidate="txtEmailIdSearch" display="None" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" validationgroup="test"></asp:regularexpressionvalidator></td>
<td><asp:ValidatorCalloutExtender ID="vceMail" TargetControlID="revMail" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>

<td><asp:Label ID="lblUni" runat="server" Text="University"></asp:Label></td>
<td align="left"><div class="dropdownStyle"><asp:DropDownList ID="ddlUniversityS" runat="server" ></asp:DropDownList></div>
<asp:CascadingDropDown ID="ccdUni" runat="server" Category="University" TargetControlID="ddlUniversitys" LoadingText="Loading University..." PromptText="Select University" ServiceMethod="Binduniversitydropdown" ServicePath="~/CascadingDropdown.asmx"></asp:CascadingDropDown>
</td>
<td><asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn_Style" 
        onclick="btnSearch_Click" CausesValidation="False" 
        UseSubmitBehavior="False" /></td>
<td><asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn_Style" 
        CausesValidation="False" onclick="btnClear_Click" /></td>
<td><asp:Button ID="btnAdd" runat="server" Text="Add" CausesValidation="False" UseSubmitBehavior="false" CssClass="btn_Style" onclick="btnAdd_Click" /></td>
</tr>
</table>
</div>
<div>
   
   
    <asp:GridView ID="gvRegistration" runat="server" 
         DataKeyNames="CollegeId"
                    AutoGenerateColumns="False"  OnRowDeleting="gvRegistration_RowDeleting"
                     OnRowCancelingEdit="gvRegistration_RowCancelingEdit"
                    OnRowEditing="gvRegistration_RowEditing" AllowPaging="True" OnPageIndexChanging="gvRegistration_PageIndexChanging"
                    CssClass="mGrid" PagerStyle-CssClass="pgr" 
        AlternatingRowStyle-CssClass="alt" AllowSorting="True" 
        onsorting="gvRegistration_Sorting1">
                    <AlternatingRowStyle CssClass="alt"></AlternatingRowStyle>
                    <Columns>
                        <asp:TemplateField HeaderText="College ID" Visible="false" SortExpression="CollegeID">
                            
                            <ItemTemplate>
                                <asp:Label ID="lblCollegeId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeId") %>'></asp:Label>
                                
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCollegeId" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeId") %>'></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="College ID" Visible="false" SortExpression="CollegeID">
                            
                            <ItemTemplate>
                                
                                <asp:Label ID="lblCollegeCode1" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeCode") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCollegeCode" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeCode") %>'></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="College Name" SortExpression="CollegeName">
                          
                            <ItemTemplate>
                                <asp:Label ID="lblCollegeName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeName") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCollegeName" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeName") %>'></asp:TextBox>
                                 <%--<asp:RegularExpressionValidator ID="rxv" runat="server" ControlToValidate="txtCollegeName" Display="None"
                                    ValidationExpression="^(0|1\d?|2[0-3]?).?[0|5]?$"  ErrorMessage="*"></asp:RegularExpressionValidator>--%>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="College Code" SortExpression="CollegeCode">
                          
                            <ItemTemplate>
                                <asp:Label ID="lblCollegeCode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeCode") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCollegeCode" ReadOnly="true" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeCode") %>'></asp:TextBox>
                                
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="College Address" SortExpression="CollegeAddress">
                           
                            <ItemTemplate>
                                <asp:Label ID="lblCollegeAddress" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeAddress") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtCollegeAddress" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "CollegeAddress") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date Of Reopening" SortExpression="DateOfReopening" >
                            
                            <ItemTemplate>
                                <asp:Label ID="lblDateOfReopening" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "DateOfReopening") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtDateOfReopening" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "DateOfReopening") %>'></asp:TextBox>
                                <%--<asp:CalendarExtender ID="ceDR" runat="server" Format="dd-MM-yyyy" TargetControlID="txtDateOfReopening" OnClientDateSelectionChanged="checkDate" PopupButtonID="CaleIcon1" PopupPosition="TopRight">
                                    </asp:CalendarExtender>
                                    <img id="CaleIcon1" src="Images/Calendar.png" alt="Click to Open Calendar" class="calendarStyle" />--%>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Email Id" SortExpression="EmailId">
                           
                            <ItemTemplate>
                                <asp:Label ID="lblEmailId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "EmailId") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtEmailId" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "EmailId") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Website" SortExpression="Website">
                           
                            <ItemTemplate>
                                <asp:Label ID="lblWebsite" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "Website") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtWebsite" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "Website") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="University Name" SortExpression="UniversityName">
                                <ItemTemplate>
                                    <asp:Label ID="lblUniName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "UniversityName") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlUniName" runat="server" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Zone" SortExpression="ZoneName">
                                <ItemTemplate>
                                    <asp:Label ID="lblZone" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "ZoneName") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlZoneName" runat="server" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                        <asp:TemplateField HeaderText="Phone Number" SortExpression="PhoneNumber">
                            <ItemTemplate>
                                <asp:Label ID="lblPhoneNumber" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "PhoneNumber") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="input" Text='<%#DataBinder.Eval(Container.DataItem, "PhoneNumber") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                       <asp:TemplateField HeaderText="Accomodation" SortExpression="AccomodationName">
                                <ItemTemplate>
                                    <asp:Label ID="lblAccName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "AccomodationName") %>'></asp:Label>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:DropDownList ID="ddlAccName" runat="server" AppendDataBoundItems="true">
                                    </asp:DropDownList>
                                </EditItemTemplate>
                            </asp:TemplateField>
                    <asp:TemplateField ItemStyle-Width="120px">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgbtnEdit" runat="server" CommandName="Edit" ImageUrl="~/Images/pencil.png" CausesValidation="False"
                                    ToolTip="Edit" CssClass="Action" />
                                <asp:ImageButton ID="imgbtnDelete" runat="server" CommandName="Delete" ImageUrl="~/Images/bin.png" CausesValidation="False"
                                    ToolTip="Delete" />
                               
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="imgbtnUpdate" runat="server" CommandName="Update" ImageUrl="~/Images/stiffy.png" CausesValidation="False"
                                    ToolTip="Update" CssClass="Action" />
                                <asp:ImageButton ID="imgbtnCancel" runat="server" CommandName="Cancel" ImageUrl="~/Images/return.png" CausesValidation="False"
                                    ToolTip="Cancel" />
                                
                            </EditItemTemplate>
                            <FooterStyle Width="180px" />
                            <HeaderStyle Width="180px" />
                            <ItemStyle Width="180px" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle CssClass="pgr"></PagerStyle>
                </asp:GridView>

</div>

<asp:Label ID="lblresult" runat="server"/>
<asp:Button ID="btnShowPopup" runat="server" style="display:none" />
<asp:ModalPopupExtender ID="mpePanel" runat="server" TargetControlID="btnAdd" PopupControlID="pnlpopup"
CancelControlID="btnCancel" BackgroundCssClass="modalBackground">
</asp:ModalPopupExtender>
<asp:Panel ID="pnlpopup" runat="server" BackColor="White" Height="500px" Width="500px" style="display:none">

    <div id="egr">
<table cellpadding="3" cellspacing="3">
<tr>
    <td align="left"><asp:Label ID="lblClgName" runat="server" Text="College Name *"></asp:Label></td>
    <td align="left"><asp:TextBox ID="txtClgName" runat="server" MaxLength="50" CssClass="textBoxStyle" onkeypress="return IsValidCollName(event,this.id);"></asp:TextBox></td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvClgName" runat="server" ControlToValidate="txtClgName" Display="None" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceClgName" TargetControlID="rfvClgName" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblClgAddress" runat="server" Text="College Address *"></asp:Label></td>
    <td align="left"><asp:TextBox ID="txtClgAddress" runat="server" MaxLength="250" TextMode="MultiLine" CssClass="mtextBoxStyle" onkeypress="return IsValidCollAddress(event,this.id);"></asp:TextBox></td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvClgAddress" runat="server" ControlToValidate="txtClgAddress" EnableClientScript="true" Display="None" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceClgAddress" TargetControlID="rfvClgAddress" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblDORO" runat="server" Text="Date of reopening *"></asp:Label></td>
    <td align="left">
        <asp:TextBox ID="txtDORO" runat="server" MaxLength="50" CssClass="textBoxStyle" onkeypress="return IsValidDORO(event,this.id);"></asp:TextBox><img id="CaleIcon" src="Images/Calendar.png" alt="Click to Open Calendar" class="calendarStyle" />
        <asp:CalendarExtender ID="ceDORO" Format="dd-MM-yyyy" TargetControlID="txtDORO" runat="server" OnClientDateSelectionChanged="checkDate" PopupButtonID="CaleIcon" PopupPosition="BottomLeft">
    </asp:CalendarExtender>
        </td>
        <td align="left"><asp:RequiredFieldValidator ID="rfvDORO" runat="server" ControlToValidate="txtDORO" EnableClientScript="true" ErrorMessage="shouldn't empty" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
        <td><asp:ValidatorCalloutExtender ID="vceDORO" TargetControlID="rfvDORO" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblEmailid" runat="server" Text="Emailid *"></asp:Label></td>
    <td align="left"><asp:TextBox ID="txtEmailid" runat="server" MaxLength="30" CssClass="textBoxStyle" ></asp:TextBox></td>
    <td align="left"><asp:regularexpressionvalidator id="revEmailid" runat="server" errormessage="Email is invalid." controltovalidate="txtEmailid" display="None" validationexpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" validationgroup="test"></asp:regularexpressionvalidator>
    <asp:RequiredFieldValidator ID="rfvEmailid" runat="server" ControlToValidate="txtEmailid" Display="None" EnableClientScript="true" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceEmailid" TargetControlID="rfvEmailid" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
    <td><asp:ValidatorCalloutExtender ID="vceEmail" TargetControlID="revEmailid" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblWebsite" runat="server" Text="Website *"></asp:Label></td>
    <td align="left"><asp:TextBox ID="txtWebsite" runat="server" MaxLength="30" CssClass="textBoxStyle"></asp:TextBox></td>
    <td align="left"><asp:RegularExpressionValidator ID="revWebsite" runat="server" ControlToValidate="txtWebsite" Display="None" ErrorMessage="Not valid" SetFocusOnError="True" ValidationExpression="http(s)?://([\w-]+\.)+[\w-]+(/[\w- ./?%&amp;=]*)?" ValidationGroup="yourgroup"></asp:RegularExpressionValidator>
    <asp:RequiredFieldValidator ID="rfvWebsite" runat="server" ControlToValidate="txtWebsite" EnableClientScript="true" Display="None" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceWebsite" TargetControlID="rfvWebsite" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
    <td><asp:ValidatorCalloutExtender ID="vceweb" TargetControlID="revWebsite" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblUniversity" runat="server" Text="University Name *"></asp:Label></td>
    <td align="left"><div class="dropdownStyle"><asp:DropDownList ID="ddlUniversity" runat="server" ></asp:DropDownList></div>
    <asp:CascadingDropDown ID="ccddUniversity" runat="server" Category="University" TargetControlID="ddlUniversity" LoadingText="Loading University..." PromptText="Select University" ServiceMethod="Binduniversitydropdown" ServicePath="~/CascadingDropdown.asmx"></asp:CascadingDropDown>
    </td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvUniversity" runat="server" ControlToValidate="ddlUniversity" EnableClientScript="true" Display="None" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceUniversity" TargetControlID="rfvUniversity" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>

</tr>
<tr>
    <td align="left"><asp:Label ID="lblZone" runat="server" Text="Zone *"></asp:Label></td>
    <td align="left"><div class="dropdownStyle"><asp:DropDownList ID="ddlZone" runat="server" ></asp:DropDownList></div>
    <asp:CascadingDropDown ID="ccdZone" runat="server" Category="Zone" TargetControlID="ddlZone" LoadingText="Loading Zone..." PromptText="Select Zone" ServiceMethod="Bindzonedropdown" ServicePath="~/CascadingDropdown.asmx"></asp:CascadingDropDown>
    </td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvZone" runat="server" ControlToValidate="ddlZone" EnableClientScript="true" Display="None" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceZone" TargetControlID="rfvZone" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblPhoneno" runat="server" Text="Phone Number *"></asp:Label></td>
    <td align="left"><asp:TextBox ID="txtPhoneno" runat="server" MaxLength="20" CssClass="textBoxStyle" onkeypress="return IsValidPhoneno(event,this.id);"></asp:TextBox></td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvPhoneno" runat="server" ControlToValidate="txtPhoneno" Display="None" EnableClientScript="true" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vcePhoneno" TargetControlID="rfvphoneno" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr>
    <td align="left"><asp:Label ID="lblAccomodation" runat="server" Text="Accomodation *"></asp:Label></td>
    <td align="left"><asp:RadioButtonList ID="rblAccomodation" runat="server" RepeatDirection="Horizontal"  ></asp:RadioButtonList></td>
    <td align="left"><asp:RequiredFieldValidator ID="rfvAccomodation" runat="server" ControlToValidate="rblAccomodation" Display="None" EnableClientScript="true" ErrorMessage="shouldn't empty" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
    <td><asp:ValidatorCalloutExtender ID="vceAccomodation" TargetControlID="rfvAccomodation" HighlightCssClass="CustomValidatorCalloutStyle" runat="server"></asp:ValidatorCalloutExtender></td>
</tr>
<tr><td colspan="2" align="center"><asp:Button ID="btnSave" runat="server" 
        Text="Save" CssClass="btn_Style" onclick="btnSave_Click" />

<asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn_Style"/>
</td></tr>
</table>
</div>

</asp:Panel>
    </div>
</asp:Content>

