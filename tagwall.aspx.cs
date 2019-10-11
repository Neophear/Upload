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

public partial class tagwall : System.Web.UI.Page
{
    protected int RowCounter = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        UpdateRepeater();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        dal.AddParameter("@Username", User.Identity.Name, DbType.String);
        dal.AddParameter("@Message", ((TextBox)LoginView1.FindControl("TextBox1")).Text, DbType.String);
        dal.ExecuteNonQuery("INSERT INTO Tagwall (Username, Message, Created, Visible) VALUES(@Username, @Message, '" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Year.ToString() + " " + DateTime.Now.Hour.ToString() + ":" + DateTime.Now.Minute.ToString() + ":" + DateTime.Now.Second.ToString() + "', 1)");
        dal.ClearParameters();

        UpdateRepeater();

        ((TextBox)LoginView1.FindControl("TextBox1")).Text = "";
    }
    protected void Repeater2_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.ExecuteNonQuery("UPDATE Tagwall SET Visible = 0 WHERE ID = " + e.CommandArgument.ToString());

        UpdateRepeater();
    }
    private void UpdateRepeater()
    {
        DataAccessLayer dal = new DataAccessLayer();

        if (User.IsInRole("Admin"))
        {
            Repeater2.DataSource = dal.ExecuteDataTable("SELECT ID, Username, Message, Created FROM Tagwall WHERE Visible = 1 ORDER BY Created Desc");
            Repeater2.DataBind();
        }
        else
        {
            Repeater1.DataSource = dal.ExecuteDataTable("SELECT Username, Message, Created FROM Tagwall WHERE Visible = 1 ORDER BY Created Desc");
            Repeater1.DataBind();
        }
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            ((Label)e.Item.FindControl("Label1")).Text = Utilities.GetSmileys(DataBinder.Eval(e.Item.DataItem, "Message").ToString());
        }
    }
    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            ((Label)e.Item.FindControl("Label1")).Text = Utilities.GetSmileys(DataBinder.Eval(e.Item.DataItem, "Message").ToString());
        }
    }
}