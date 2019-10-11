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

public partial class links : System.Web.UI.Page
{
    protected int RowCounter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        UpdateRepeater();
    }
    protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //Dette kode kører når man klikker på Rediger knappen.
        ViewState["Selected"] = e.CommandArgument;
        if (e.CommandName.ToString() == "Edit")
        {
            Edit(Convert.ToInt32(e.CommandArgument), ((TextBox)LoginView1.FindControl("TextBox1")), ((TextBox)LoginView1.FindControl("TextBox2")));

            ((Button)LoginView1.FindControl("Button1")).Visible = false;
            ((Button)LoginView1.FindControl("Button2")).Visible = true;
            ((Button)LoginView1.FindControl("Button3")).Visible = true;

            ((TextBox)LoginView1.FindControl("TextBox1")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button2")).UniqueID + "').click();return false;}} else {return true}; ");
            ((TextBox)LoginView1.FindControl("TextBox2")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button2")).UniqueID + "').click();return false;}} else {return true}; ");
        }
        else if (e.CommandName.ToString() == "Delete")
        {
            //Her "sletter" jeg et link.
            DataAccessLayer dal = new DataAccessLayer();
            dal.ExecuteNonQuery("UPDATE Links SET LinkDeleted = '" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Year.ToString() + "', LinkVisible = 0 WHERE LinkID = " + e.CommandArgument.ToString());

            ((Button)LoginView1.FindControl("Button1")).Visible = true;
            ((Button)LoginView1.FindControl("Button2")).Visible = false;
            ((Button)LoginView1.FindControl("Button3")).Visible = false;
            ((TextBox)LoginView1.FindControl("TextBox1")).Text = "";
            ((TextBox)LoginView1.FindControl("TextBox2")).Text = "";
            ((Label)LoginView1.FindControl("Label1")).Text = "Upload link:";

            UpdateRepeater();

            ((TextBox)LoginView1.FindControl("TextBox1")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");
            ((TextBox)LoginView1.FindControl("TextBox2")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");
        }
        else
        {
            //Her opdaterer jeg antal klik for et link.
            DataAccessLayer dal = new DataAccessLayer();
            dal.ExecuteNonQuery("UPDATE Links SET LinkClicked = (LinkClicked + 1) WHERE LinkID = " + e.CommandArgument.ToString());

            UpdateRepeater();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        //Følgende 6 linier indsætter et nyt link i databasen.

        string LinkName = ((TextBox)LoginView1.FindControl("TextBox1")).Text;
        string LinkUrl = ((TextBox)LoginView1.FindControl("TextBox2")).Text;

        if (!(LinkUrl.Length < 8))
        {
            if (!(LinkUrl.Substring(0,6) == "ftp://") && !(LinkUrl.Substring(0,7) == "http://") && !(LinkUrl.Substring(0,8) == "https://"))
            {
                LinkUrl = "http://" + LinkUrl;
            }
        }
        else
        {
            LinkUrl = "http://" + LinkUrl;
        }

        DataAccessLayer dal = new DataAccessLayer();
        dal.AddParameter("@LinkName", LinkName, DbType.String);
        dal.AddParameter("@LinkUrl", LinkUrl, DbType.String);
        dal.AddParameter("@Username", this.User.Identity.Name, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO Links (LinkName, LinkUrl, LinkUsername, LinkClicked, LinkCreated, LinkVisible) VALUES (@LinkName, @LinkUrl, @Username, '0', '" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Year.ToString() + "', 1)");
        dal.ClearParameters();

        ((TextBox)LoginView1.FindControl("TextBox1")).Text = "";
        ((TextBox)LoginView1.FindControl("TextBox2")).Text = "";
        ((TextBox)LoginView1.FindControl("TextBox1")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");
        ((TextBox)LoginView1.FindControl("TextBox2")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");

        UpdateRepeater();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        //Følgende kode kører når man gemmer et link efter man har redigeret det. De næste 6 linier opdaterer databasen med den nye data.

        string LinkName = ((TextBox)LoginView1.FindControl("TextBox1")).Text;
        string LinkUrl = ((TextBox)LoginView1.FindControl("TextBox2")).Text;

        if (!(LinkUrl.Length < 8))
        {
            if (!(LinkUrl.ToLower().Substring(0, 6) == "ftp://") && !(LinkUrl.ToLower().Substring(0, 7) == "http://") && !(LinkUrl.ToLower().Substring(0, 8) == "https://"))
            {
                LinkUrl = "http://" + LinkUrl;
            }
        }
        else
        {
            LinkUrl = "http://" + LinkUrl;
        }

        DataAccessLayer dal = new DataAccessLayer();
        dal.AddParameter("@LinkName", LinkName, DbType.String);
        dal.AddParameter("@LinkUrl", LinkUrl, DbType.String);
        dal.ExecuteNonQuery("UPDATE Links SET LinkName = @LinkName, LinkUrl = @LinkUrl WHERE LinkID = " + ViewState["Selected"].ToString());

        UpdateRepeater();

        ((Label)LoginView1.FindControl("Label1")).Text = "Upload link:";
        ((TextBox)LoginView1.FindControl("TextBox1")).Text = "";
        ((TextBox)LoginView1.FindControl("TextBox2")).Text = "";
        ((Button)LoginView1.FindControl("Button1")).Visible = true;
        ((Button)LoginView1.FindControl("Button2")).Visible = false;
        ((Button)LoginView1.FindControl("Button3")).Visible = false;
        ((TextBox)LoginView1.FindControl("TextBox1")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");
        ((TextBox)LoginView1.FindControl("TextBox2")).Attributes.Add("onKeyDown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + ((Button)LoginView1.FindControl("Button1")).UniqueID + "').click();return false;}} else {return true}; ");
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Edit(Convert.ToInt32(ViewState["Selected"]), ((TextBox)LoginView1.FindControl("TextBox1")), ((TextBox)LoginView1.FindControl("TextBox2")));
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (!this.User.IsInRole("Admin"))
            {
                bool showButtons = DataBinder.Eval(e.Item.DataItem, "LinkUsername").ToString() == this.User.Identity.Name;

                Control c1 = e.Item.FindControl("EditButton");
                c1.Visible = showButtons;
                Control c2 = e.Item.FindControl("DeleteButton");
                c2.Visible = showButtons;
            }
        }
    }

    //----------------------------------------Methods------------------------------------

    private void Edit(int id, TextBox t1, TextBox t2)
    {
        //Denne method kører når man trykker på Rediger.
        DataAccessLayer dal = new DataAccessLayer();
        SqlDataReader Reader = dal.ExecuteReader("SELECT LinkName, LinkUrl FROM Links WHERE LinkID = " + id);

        if (Reader.Read())
        {
            //Her fylder jeg de to tekstboxe op med dataen om linket.
            ((Label)LoginView1.FindControl("Label1")).Text = "Rediger link:";
            t1.Text = Reader["LinkName"].ToString();
            t2.Text = Reader["LinkUrl"].ToString();
        }
    }
    private void UpdateRepeater()
    {
        //Her opdaterer jeg repeateren med data fra databasen.
        DataAccessLayer dal = new DataAccessLayer();
        SqlDataReader Reader = dal.ExecuteReader("SELECT LinkID, LinkName, LinkUrl, LinkUsername, LinkClicked FROM Links WHERE LinkVisible = 1");

        if (Reader.HasRows)
        {
            Label2.Visible = false;
            ((Repeater)LoginView1.FindControl("Repeater1")).Visible = true;
            ((Repeater)LoginView1.FindControl("Repeater1")).DataSource = Reader;
            ((Repeater)LoginView1.FindControl("Repeater1")).DataBind();
        }
        else
        {
            ((Repeater)LoginView1.FindControl("Repeater1")).Visible = false;
            Label2.Visible = true;
        }
    }
}