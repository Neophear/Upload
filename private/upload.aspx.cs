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
using System.IO;
using Stiig;

public partial class upload : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            DataAccessLayer dal = new DataAccessLayer();

            dal.AddParameter("@Username", User.Identity.Name, DbType.String);
            DropDownList1.DataSource = dal.ExecuteDataTable("SELECT Directory FROM Directories WHERE Username = @Username");
            DropDownList1.DataTextField = "Directory";
            DropDownList1.DataValueField = "Directory";
            DropDownList1.DataBind();
            dal.ClearParameters();

            Repeater1.DataSource = dal.ExecuteDataTable("SELECT * FROM AllowedExtensions ORDER BY Extension");
            Repeater1.DataBind();
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        DataAccessLayer dal = new DataAccessLayer();
        string filename = FileUpload1.FileName.Replace("¤", "").Replace("&", "");
        string dir = DropDownList1.SelectedValue;
        string extension = new FileInfo(filename).Extension;

        if (FileUpload1.HasFile)
        {
            dal.AddParameter("@Extension", extension, DbType.String); 
            string count = dal.ExecuteScalar("SELECT COUNT(*) FROM AllowedExtensions WHERE Extension = @Extension").ToString();
            dal.ClearParameters();

            if (count != "0")
            {
                dal.AddParameter("@FileName", filename, DbType.String);
                dal.AddParameter("@Directory", dir, DbType.String);
                dal.AddParameter("@Username", User.Identity.Name, DbType.String);
                count = dal.ExecuteScalar("SELECT COUNT(*) FROM Files WHERE FileName = @FileName AND Directory = @Directory AND Username = @Username").ToString();
                dal.ClearParameters();

                if (count == "0")
                {
                    FileUpload1.SaveAs(Server.MapPath("../upload/") + User.Identity.Name + "¤" + dir + "¤" + filename);

                    dal.AddParameter("@FileName", filename, DbType.String);
                    dal.AddParameter("@Username", User.Identity.Name, DbType.String);
                    dal.AddParameter("@Directory", dir, DbType.String);
                    dal.ExecuteNonQuery("INSERT INTO Files (FileName, Username, Directory, Count) VALUES(@FileName, @Username, @Directory, 0)");
                    dal.ClearParameters();
                    
                    HyperLink1.NavigateUrl = ResolveClientUrl("../download.ashx?user=" + User.Identity.Name + "&dir=" + dir + "&file=" + filename);
                    HyperLink1.Text = "http://www.cyber-blade.dk/" + ResolveClientUrl("download.ashx?user=" + User.Identity.Name + "&dir=" + dir + "&file=" + filename);
                    HyperLink1.Visible = true;
                    Label2.Visible = true;
                    Label1.Visible = false;
                    Label3.Visible = false;
                    Label4.Visible = false;
                }
                else
                {
                    Label1.Visible = false;
                    HyperLink1.Visible = false;
                    Label2.Visible = false;
                    Label3.Visible = true;
                    Label4.Visible = false;
                }
            }
            else
            {
                Label1.Visible = true;
                HyperLink1.Visible = false;
                Label2.Visible = false;
                Label3.Visible = false;
                Label4.Visible = false;
            }
        }
        else
        {
            Label1.Visible = false;
            HyperLink1.Visible = false;
            Label2.Visible = false;
            Label3.Visible = false;
            Label4.Visible = true;
        }
    }
}