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
using System.Data.SqlClient;
using System.IO;
using Stiig;

public partial class createuser : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["error"] != null)
        {
            Label lbl = ((Label)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Label1"));
            lbl.Visible = true;

            if (Request.QueryString["error"] == "1")
            {
                lbl.Text = "<span style=\"color:#FF0000\">Du har brugt et forkert tegn i dit brugernavn.</span>";
            }
            else if (Request.QueryString["error"] == "2")
            {
                lbl.Text = "<span style=\"color:#FF0000\">Du må ikke bruge det navn.</span>";
            }
        }
        else
        {
            Label lbl2 = ((Label)CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("Label1"));
            lbl2.Visible = false;
        }
    }
    protected void CreateUserWizard1_CreatingUser(object sender, LoginCancelEventArgs e)
    {
        string username = CreateUserWizard1.UserName.ToLower();
        if (username.Contains(@"\") || username.Contains("/") || username.Contains(":") || username.Contains("*") || username.Contains("?") || username.Contains("\"") || username.Contains("<") || username.Contains(">") || username.Contains("|") || username.Contains("&") || username.Contains("%"))
        {
            Response.Redirect("createuser.aspx?error=1", true);
        }
        if (username.Contains("stiig") || username.Contains("cyberblade") || username.Contains("cyber-blade") || username.Contains("admin"))
        {
            Response.Redirect("createuser.aspx?error=2", true);
        }
    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@Username", CreateUserWizard1.UserName, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO Visits (VisitUsername, VisitCount) VALUES(@Username, 0)");
        dal.ClearParameters();
        dal.AddParameter("@Username", CreateUserWizard1.UserName, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO Directories (Directory, Username) VALUES('Main', @Username)");
        dal.ClearParameters();
        dal.AddParameter("@Username", CreateUserWizard1.UserName, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO Directories (Directory, Username) VALUES('Privat', @Username)");
        dal.ClearParameters();
    }
}