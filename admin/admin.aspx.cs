using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Data.SqlClient;
using System.IO;
using Stiig;

public partial class admin_admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        TextBox1.Focus();

        if (!IsPostBack)
        {
            MembershipUserCollection members = Membership.GetAllUsers();
            members.Remove("Cyber-Blade");

            DropDownList1.DataSource = members;
            DropDownList1.DataBind();

            List<string> members2 = new List<string>();

            members2.Add("-Alle brugere-");

            foreach (MembershipUser user in Membership.GetAllUsers())
            {
                members2.Add(user.UserName);
            }

            DropDownList3.DataSource = members2;
            DropDownList3.DataBind();

            DataAccessLayer dal = new DataAccessLayer();

            DataTable extensions = dal.ExecuteDataTable("SELECT Extension FROM AllowedExtensions ORDER BY Extension");

            DropDownList2.DataSource = extensions;
            DropDownList2.DataTextField = "Extension";
            DropDownList2.DataValueField = "Extension";
            DropDownList2.DataBind();

            TextBox6.Text = Utilities.ToggleHtmlBR(dal.ExecuteScalar("SELECT [Text] FROM [Text] WHERE Name = 'Title'").ToString(), false);

            if (this.User.Identity.Name == "Cyber-Blade")
            {
                GridView2.DataSource = members;
                GridView2.DataBind();

                FreeTextBox1.Text = dal.ExecuteScalar("SELECT [Text] FROM [Text] WHERE Name = 'About'").ToString();

                Panel1.Visible = true;
                Panel2.Visible = true;
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        if (TextBox1.Text.Substring(0, 6).ToLower() == "select")
        {
            GridView1.DataSource = dal.ExecuteDataTable(TextBox1.Text);
            GridView1.DataBind();
            GridView1.Visible = true;

            Label1.Visible = false;
        }
        else
        {
            Label1.Text = dal.ExecuteNonQuery(TextBox1.Text).ToString() + " rows affected!";
            Label1.Visible = true;

            GridView1.Visible = false;
        }
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        Membership.DeleteUser(DropDownList1.SelectedValue, true);

        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("UPDATE Links SET LinkDeleted = '" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Year.ToString() + "', LinkVisible = 0 WHERE LinkUsername = @Username");
        dal.ClearParameters();

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("UPDATE Visits SET VisitCount = ((SELECT VisitCount FROM Visits WHERE VisitUsername = @Username) + (SELECT VisitCount FROM Visits WHERE VisitUsername = 'AnonymousUser')) WHERE VisitUsername = 'AnonymousUser'");
        dal.ClearParameters();

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Visits WHERE VisitUsername = @Username");
        dal.ClearParameters();

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        DataTable files = dal.ExecuteDataTable("SELECT FileName, Directory FROM Files WHERE Username = @Username");
        dal.ClearParameters();

        foreach (DataRow row in files.Rows)
        {
            File.Delete(Server.MapPath("../upload/") + DropDownList1.SelectedValue + "¤" + row["Directory"].ToString() + "¤" + row["FileName"].ToString());
        }

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Files WHERE Username = @Username");
        dal.ClearParameters();

        dal.AddParameter("@Username", DropDownList1.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("DELETE FROM Directories WHERE Username = @Username");
        dal.ClearParameters();

        MembershipUserCollection members = Membership.GetAllUsers();
        members.Remove("Cyber-Blade");

        DropDownList1.DataSource = members;
        DropDownList1.DataBind();

        List<string> members2 = new List<string>();

        members2.Add("-Alle brugere-");

        foreach (MembershipUser user in Membership.GetAllUsers())
        {
            members2.Add(user.UserName);
        }

        DropDownList3.DataSource = members2;
        DropDownList3.DataBind();

        if (this.User.Identity.Name == "Cyber-Blade")
        {
            GridView2.DataSource = members;
            GridView2.DataBind();

            FreeTextBox1.Text = dal.ExecuteScalar("SELECT [Text] FROM [Text] WHERE Name = 'About'").ToString();

            Panel1.Visible = true;
            Panel2.Visible = true;
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@Extension", TextBox2.Text, DbType.String);
        dal.AddParameter("@Type", TextBox3.Text, DbType.String);
        string count = dal.ExecuteScalar("SELECT COUNT(*) FROM AllowedExtensions WHERE Extension = @Extension").ToString();
        dal.ClearParameters();

        if (count == "0")
        {
            dal.AddParameter("@Extension", TextBox2.Text, DbType.String);
            dal.AddParameter("@Type", TextBox3.Text, DbType.String);
            dal.ExecuteNonQuery("INSERT INTO AllowedExtensions (Extension, Type) VALUES(@Extension, @Type)");
            dal.ClearParameters();

            DropDownList2.DataSource = dal.ExecuteDataTable("SELECT Extension FROM AllowedExtensions ORDER BY Extension");
            DropDownList2.DataTextField = "Extension";
            DropDownList2.DataValueField = "Extension";
            DropDownList2.DataBind();

            TextBox2.Text = "";
            TextBox3.Text = "";
            Label2.Visible = false;
        }
        else
        {
            Label2.Visible = true;
        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@Extension", DropDownList2.SelectedValue, DbType.String);
        dal.ExecuteNonQuery("DELETE FROM AllowedExtensions WHERE Extension = @Extension");
        dal.ClearParameters();

        DropDownList2.DataSource = dal.ExecuteDataTable("SELECT Extension FROM AllowedExtensions ORDER BY Extension");
        DropDownList2.DataTextField = "Extension";
        DropDownList2.DataValueField = "Extension";
        DropDownList2.DataBind();
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        MailMessage mail = new MailMessage();

        if (DropDownList3.SelectedValue == "-Alle brugere-")
        {
            foreach (MembershipUser user in Membership.GetAllUsers())
            {
                mail.Bcc.Add(user.Email);
            }
        }
        else
        {
            MembershipUser user = Membership.GetUser(DropDownList3.SelectedValue);
            mail.To.Add(user.Email);
        }

        mail.From = new MailAddress("upload@cyber-blade.dk");
        mail.Subject = TextBox4.Text;
        mail.IsBodyHtml = true;
        mail.Body = TextBox5.Text;
        SmtpClient client = new SmtpClient();
        client.Send(mail);

        TextBox4.Text = "";
        TextBox5.Text = "";
    }
    protected void Button6_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        dal.AddParameter("@Text", Utilities.ToggleHtmlBR(TextBox6.Text, true), DbType.String);
        dal.ExecuteNonQuery("UPDATE [Text] SET [Text] = @Text WHERE Name = 'Title'");
        dal.ClearParameters();

        ((Label)Master.FindControl("lblTitle")).Text = dal.ExecuteScalar("SELECT [Text] FROM [Text] WHERE Name = 'Title'").ToString();
    }
    protected void Button7_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.ExecuteNonQuery("DELETE FROM Links WHERE LinkVisible = 0");
    }
    protected void Button8_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.ExecuteNonQuery("DELETE FROM Tagwall WHERE Visible = 0");
    }
    protected void Button9_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();

        dal.AddParameter("@Text", FreeTextBox1.Text, DbType.String);
        dal.ExecuteNonQuery("UPDATE [Text] SET [Text] = @Text WHERE Name = 'About'");
        dal.ClearParameters();

        FreeTextBox1.Text = dal.ExecuteScalar("SELECT [Text] FROM [Text] WHERE Name = 'About'").ToString();
    }
    protected void Button10_Click(object sender, EventArgs e)
    {
        foreach (GridViewRow row in GridView2.Rows)
        {
            Label lbl = ((Label)row.FindControl("Label1"));
            CheckBox ckbx = ((CheckBox)row.FindControl("CheckBox1"));

            if (ckbx.Checked)
            {
                if (!Roles.IsUserInRole(lbl.Text, "Admin"))
                {
                    Roles.AddUserToRole(lbl.Text, "Admin");
                }
            }
            else
            {
                if (Roles.IsUserInRole(lbl.Text, "Admin"))
                {
                    Roles.RemoveUserFromRole(lbl.Text, "Admin");
                }
            }
        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex != -1)
        {
            Label lbl = ((Label)e.Row.FindControl("Label1"));
            CheckBox ckbx = ((CheckBox)e.Row.FindControl("CheckBox1"));

            if (Roles.IsUserInRole(lbl.Text, "Admin"))
            {
                ckbx.Checked = true;
            }
        }
    }
}