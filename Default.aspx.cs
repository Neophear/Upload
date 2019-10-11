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
using System.IO;
using Stiig;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Repeater1.DataSource = Membership.GetAllUsers();
        Repeater1.DataBind();
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            dal.AddParameter("@Username", DataBinder.Eval(e.Item.DataItem, "Username").ToString(), DbType.String);

            if (DataBinder.Eval(e.Item.DataItem, "Username").ToString() == User.Identity.Name || User.IsInRole("Admin"))
            {
                ((Label)e.Item.FindControl("Label1")).Text = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username").ToString();
            }
            else
            {
                ((Label)e.Item.FindControl("Label1")).Text = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory <> 'Privat'").ToString();
            }

            ((HyperLink)e.Item.FindControl("HyperLink1")).Text = DataBinder.Eval(e.Item.DataItem, "Username").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink1")).NavigateUrl = "user.aspx?user=" + DataBinder.Eval(e.Item.DataItem, "Username").ToString();

            dal.ClearParameters();
        }
    }
}