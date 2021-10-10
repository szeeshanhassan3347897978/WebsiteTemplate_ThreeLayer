using BusinessLayer;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
//using BusinessLayer;

public partial class Admin_AdminControls_Purchase : System.Web.UI.UserControl
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

        //db_pos_htEntities context = new db_pos_htEntities();

        //var result = (from x in context.TBL_ACCOUNT where x.ACC_TYPE == 1 && x.IS_ACTIVE == true select x).ToList();

        ////setting the company account and balance dropdown
        //string html = "<select class='form-control' id='txtAccount' onchange='setAccountChange()'>  ";
        //foreach (var item in result)
        //{
        //    html += "<option class='form-control' name='" + item.ACC_CURR_BAL + "' value='" + item.ACC_ID + "'>" + item.ACC_NAME + " </option>";
        //}
        //html += " </select>";
        //divAccount.InnerHtml = html;
    }


}