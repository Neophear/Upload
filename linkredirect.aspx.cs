using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Stiig;

public partial class linkredirect : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.UrlReferrer != null)
	    {
            if (Request.UrlReferrer.Host == "www.cyber-blade.dk" || Request.UrlReferrer.Host == "cyber-blade.dk")
            {
                DataAccessLayer dal = new DataAccessLayer();

                dal.AddParameter("@ID", Request.QueryString["id"], DbType.Int32);
                string url = dal.ExecuteScalar("SELECT LinkUrl FROM Links WHERE LinkID = @ID AND LinkVisible = 1").ToString();
                dal.ClearParameters();

                if (Request.UserHostAddress != "194.255.108.253")
                {
                    dal.AddParameter("@ID", Request.QueryString["id"], DbType.Int32);
                    dal.ExecuteNonQuery("UPDATE Links SET LinkClicked = (LinkClicked + 1) WHERE LinkID = @ID");
                    dal.ClearParameters();
                }

                Response.Redirect(url);
            }
            else
            {
                Response.Redirect("http://www.cyber-blade.dk/links.aspx");
            }
	    }
        else
        {
            Response.Redirect("http://www.cyber-blade.dk/links.aspx");
        }
    }
}
