using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;
using Stiig;

public partial class User : System.Web.UI.Page
{
    public DataAccessLayer dal = new DataAccessLayer();

    protected void Page_Load(object sender, EventArgs e)
    {
        string user = Request.QueryString["user"];
        string dir = "Main";

        if (Membership.FindUsersByName(user).Count == 0)
        {
            Response.Redirect("Default.aspx", true);
        }

        if (Request.QueryString["dir"] != null)
        {
            dir = Request.QueryString["dir"];
        }
        
        string count;

        dal.AddParameter("@Username", user, DbType.String);
        dal.AddParameter("@Directory", dir, DbType.String);
        count = dal.ExecuteScalar("SELECT COUNT(*) FROM Directories WHERE Username = @Username AND Directory = @Directory").ToString();
        dal.ClearParameters();

        if (count != "1")
        {
            Response.Redirect("user.aspx?user=" + user + "&dir=Main", true);
        }

        Label1.Text = user;
        DataTable table;

        if (user == this.User.Identity.Name || this.User.IsInRole("Admin"))
        {
            MultiView1.ActiveViewIndex = 1;

            if (dir != "Main")
            {
                Panel1.Visible = false;

                HyperLink1.NavigateUrl = "user.aspx?user=" + user + "&dir=Main";
            }
            else
            {
                Panel1.Visible = true;

                dal.AddParameter("@Username", user, DbType.String);
                table = dal.ExecuteDataTable("SELECT Directory FROM Directories WHERE Username = @Username AND Directory <> 'Main'");
                dal.ClearParameters();

                Repeater3.DataSource = table;
                Repeater3.DataBind();

                HyperLink1.NavigateUrl = "Default.aspx";
            }

            dal.AddParameter("@Username", user, DbType.String);
            dal.AddParameter("@Directory", dir, DbType.String);
            count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory").ToString();
            dal.ClearParameters();

            if (count != "0")
            {
                dal.AddParameter("@Username", user, DbType.String);
                dal.AddParameter("@Directory", dir, DbType.String);
                table = dal.ExecuteDataTable("SELECT FileName, Count FROM Files WHERE Username = @Username AND Directory = @Directory");
                dal.ClearParameters();

                Repeater4.DataSource = table;
                Repeater4.DataBind();
                Repeater4.Visible = true;

                Label8.Visible = true;
                Label9.Visible = false;
            }
            else
            {
                Repeater4.Visible = false;
                Label8.Visible = false;
                Label9.Visible = true;
            }
        }
        else
        {
            MultiView1.ActiveViewIndex = 0;

            if (dir != "Main")
            {
                Label2.Visible = false;
                Label3.Visible = false;
                Repeater1.Visible = false;
                HyperLink1.NavigateUrl = "user.aspx?user=" + user + "&dir=Main";
            }
            else
            {
                dal.AddParameter("@Username", user, DbType.String);
                dal.AddParameter("@Directory", dir, DbType.String);
                count = dal.ExecuteScalar("SELECT COUNT(*) FROM Directories WHERE Username = @Username").ToString();
                dal.ClearParameters();

                if (count != "2")
                {
                    dal.AddParameter("@Username", user, DbType.String);
                    dal.AddParameter("@Directory", dir, DbType.String);
                    table = dal.ExecuteDataTable("SELECT Directory FROM Directories WHERE Username = @Username AND Directory <> 'Main' AND Directory <> 'Privat'");
                    dal.ClearParameters();

                    Repeater1.DataSource = table;
                    Repeater1.DataBind();

                    Label2.Visible = true;
                    Label3.Visible = false;
                    Repeater1.Visible = true;
                }
                else
                {
                    Repeater1.Visible = false;
                    Label2.Visible = false;
                    Label3.Visible = true;
                }

                HyperLink1.NavigateUrl = "Default.aspx";
            }

            dal.AddParameter("@Username", user, DbType.String);
            dal.AddParameter("@Directory", dir, DbType.String);
            count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory").ToString();
            dal.ClearParameters();

            if (count != "0")
            {
                dal.AddParameter("@Username", user, DbType.String);
                dal.AddParameter("@Directory", dir, DbType.String);
                table = dal.ExecuteDataTable("SELECT FileName, Count FROM Files WHERE Username = @Username AND Directory = @Directory");
                dal.ClearParameters();

                Repeater2.DataSource = table;
                Repeater2.DataBind();

                Label4.Visible = true;
                Label5.Visible = false;
                Repeater2.Visible = true;
            }
            else
            {
                Repeater2.Visible = false;
                Label4.Visible = false;
                Label5.Visible = true;
            }
        }
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        string directory = TextBox1.Text.Replace(@"\", "").Replace("/", "").Replace(":", "").Replace(";","").Replace("*", "").Replace("?", "").Replace("\"", "").Replace("<", "").Replace(">", "").Replace("|", "").Replace("&", "").Replace("%", "");

        dal.AddParameter("@Directory", directory, DbType.String);
        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        string count = dal.ExecuteScalar("SELECT COUNT(*) FROM Directories WHERE Username = @Username AND Directory = @Directory").ToString();
        dal.ClearParameters();

        if (count == "0")
        {
            dal.AddParameter("@Directory", directory, DbType.String);
            dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
            dal.ExecuteNonQuery("INSERT INTO Directories (Directory, Username) VALUES(@Directory, @Username)");
            dal.ClearParameters();
            Label12.Visible = false;
            TextBox1.Text = "";
        }
        else
        {
            Label12.Visible = true;
            TextBox1.Text = directory;
        }

        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        DataTable table = dal.ExecuteDataTable("SELECT Directory FROM Directories WHERE Username = @Username AND Directory <> 'Main'");
        dal.ClearParameters();
        
        Repeater3.DataSource = table;
        Repeater3.DataBind();
    }
    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            dal.AddParameter("@Directory", DataBinder.Eval(e.Item.DataItem, "Directory").ToString(), DbType.String);
            dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
            ((Label)e.Item.FindControl("Label13")).Text = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory").ToString();
            dal.ClearParameters();
            ((HyperLink)e.Item.FindControl("HyperLink3")).NavigateUrl = "user.aspx?user=" + Request.QueryString["user"] + "&dir=" + DataBinder.Eval(e.Item.DataItem, "Directory").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink3")).Text = DataBinder.Eval(e.Item.DataItem, "Directory").ToString();
        }
    }
    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string dir = "Main";

            if (Request.QueryString["dir"] != null)
            {
                dir = Request.QueryString["dir"];
            }

            ((HyperLink)e.Item.FindControl("HyperLink2")).NavigateUrl = "download.ashx?user=" + Request.QueryString["user"] + "&dir=" + dir + "&file=" + DataBinder.Eval(e.Item.DataItem, "FileName").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink2")).Text = DataBinder.Eval(e.Item.DataItem, "FileName").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink2")).Target = "_blank";
            FileInfo fi = new FileInfo(Server.MapPath("upload/") + Request.QueryString["user"] + "¤" + dir + "¤" + DataBinder.Eval(e.Item.DataItem, "FileName").ToString());
            ((Label)e.Item.FindControl("Label15")).Text = Utilities.ConvertSize(fi.Length);
        }
    }
    protected void Repeater3_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            if (DataBinder.Eval(e.Item.DataItem, "Directory").ToString() == "Privat")
            {
                ((LinkButton)e.Item.FindControl("DeleteButton")).Visible = false;
            }
            dal.AddParameter("@Directory", DataBinder.Eval(e.Item.DataItem, "Directory").ToString(), DbType.String);
            dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
            ((Label)e.Item.FindControl("Label14")).Text = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory").ToString();
            dal.ClearParameters();
            ((HyperLink)e.Item.FindControl("HyperLink4")).NavigateUrl = "user.aspx?user=" + Request.QueryString["user"] + "&dir=" + DataBinder.Eval(e.Item.DataItem, "Directory").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink4")).Text = DataBinder.Eval(e.Item.DataItem, "Directory").ToString();
        }
    }
    protected void Repeater3_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string dir = "Main";

        if (Request.QueryString["dir"] != null)
        {
            dir = Request.QueryString["dir"];
        }

        dal.AddParameter("@Directory", e.CommandArgument.ToString(), DbType.String);
        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        SqlDataReader reader = dal.ExecuteReader("SELECT * FROM Files WHERE Username = @Username AND Directory = @Directory");
        dal.ClearParameters();

        while (reader.Read())
        {
            File.Delete(Server.MapPath("upload/") + Request.QueryString["user"] + "¤" + dir + "¤" + reader[0].ToString());
        }

        reader.Close();

        dal.AddParameter("@Directory", e.CommandArgument.ToString(), DbType.String);
        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Files WHERE Username = @Username AND Directory = @Directory");
        dal.ClearParameters();
        
        dal.AddParameter("@Directory", e.CommandArgument.ToString(), DbType.String);
        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Directories WHERE Username = @Username AND Directory = @Directory");
        dal.ClearParameters();

        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        DataTable table = dal.ExecuteDataTable("SELECT Directory FROM Directories WHERE Username = @Username AND Directory <> 'Main'");
        dal.ClearParameters();

        Repeater3.DataSource = table;
        Repeater3.DataBind();
    }
    protected void Repeater4_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            string dir = "Main";

            if (Request.QueryString["dir"] != null)
            {
                dir = Request.QueryString["dir"];
            }

            ((HyperLink)e.Item.FindControl("HyperLink2")).NavigateUrl = "download.ashx?user=" + Request.QueryString["user"] + "&dir=" + dir + "&file=" + DataBinder.Eval(e.Item.DataItem, "FileName").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink2")).Text = DataBinder.Eval(e.Item.DataItem, "FileName").ToString();
            ((HyperLink)e.Item.FindControl("HyperLink2")).Target = "_blank";

            FileInfo fi = new FileInfo(Server.MapPath("upload/") + Request.QueryString["user"] + "¤" + dir + "¤" + DataBinder.Eval(e.Item.DataItem, "FileName").ToString());
            ((Label)e.Item.FindControl("Label16")).Text = Utilities.ConvertSize(fi.Length);

            ((LinkButton)e.Item.FindControl("DeleteButton2")).CommandArgument = DataBinder.Eval(e.Item.DataItem, "FileName").ToString();
        }
    }
    protected void Repeater4_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        string dir = "Main";

        if (Request.QueryString["dir"] != null)
        {
            dir = Request.QueryString["dir"];
        }

        File.Delete(Server.MapPath("upload/" + Request.QueryString["user"] + "¤" + dir + "¤" + e.CommandArgument.ToString()));

        dal.AddParameter("@FileName", e.CommandArgument.ToString(), DbType.String);
        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        dal.AddParameter("@Directory", dir, DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Files WHERE FileName = @FileName AND Username = @Username AND Directory = @Directory");
        dal.ClearParameters();

        dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
        dal.AddParameter("@Directory", dir, DbType.String);
        string count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE Username = @Username AND Directory = @Directory").ToString();
        dal.ClearParameters();

        if (count != "0")
        {
            dal.AddParameter("@Username", Request.QueryString["user"], DbType.String);
            dal.AddParameter("@Directory", dir, DbType.String);
            DataTable table = dal.ExecuteDataTable("SELECT FileName, Count FROM Files WHERE Username = @Username AND Directory = @Directory");
            dal.ClearParameters();

            Repeater4.DataSource = table;
            Repeater4.DataBind();
        }
        else
        {
            Repeater4.Visible = false;
            Label8.Visible = false;
            Label9.Visible = true;
        }
    }
}