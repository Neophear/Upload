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

public partial class error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string error;

        if (Request.QueryString["error"] != null)
        {
            error = Request.QueryString["error"].ToString();
        }
        else
	    {
            error = "";
	    }

        switch (error)
        {
            case "401":
                Label1.Text = "Du har ikke rettigheder til at se denne side/fil.";
                break;
            case "403":
                Label1.Text = "Du har ikke adgang til denne side/fil.";
                break;
            case "404":
                Label1.Text = "Du har efterspurgt en side/fil som ikke eksisterer.";
                break;
            case "408":
                Label1.Text = "Din forespørgsel udløb. Prøv igen.";
                break;
            default:
                Label1.Text = "Der skete en fejl.";
                break;
        }
    }
}