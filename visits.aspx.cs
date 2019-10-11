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
using Stiig;

public partial class visits : System.Web.UI.Page
{
    protected int RowCounter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        Repeater1.DataSource = dal.ExecuteDataTable("SELECT VisitUsername, VisitCount FROM Visits WHERE VisitUsername <> 'AnonymousUser' ORDER BY VisitUsername ASC");
        Repeater1.DataBind();

        object scalar = dal.ExecuteScalar("SELECT VisitCount FROM Visits WHERE VisitUsername = 'AnonymousUser'");

        if (scalar != null)
        {
            if (scalar.ToString().Equals(string.Empty))
            {
                Label1.Text = "Der skete en fejl. Prøv venligst igen.";
            }
            else
            {
                Label1.Text = "Anonyme brugere: " + scalar.ToString();
            }
        }
        else
        {
            Label1.Text = "Der skete en fejl. Prøv venligst igen.";
        }

        object scalar2 = dal.ExecuteScalar("SELECT SUM(VisitCount) FROM Visits");

        if (scalar2 != null)
        {
            if (scalar2.ToString().Equals(string.Empty))
            {
                Label2.Text = "Der skete en fejl. Prøv venligst igen.";
            }
            else
            {
                Label2.Text = "I alt: " + scalar2.ToString();
            }
        }
        else
        {
            Label2.Text = "Der skete en fejl. Prøv venligst igen.";
        }
    }
}