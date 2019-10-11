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

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.User.Identity.IsAuthenticated)
        {
            if (Membership.FindUsersByName(Page.User.Identity.Name).Count == 0)
            {
                FormsAuthentication.SignOut();
            }
        }

        DataAccessLayer dal = new DataAccessLayer();

        //Tjek referrer
        if (Request.UrlReferrer != null)
        {
            if (Request.UrlReferrer.Host != "www.cyber-blade.dk")
            {
                if (Request.UrlReferrer.Host != "cyber-blade.dk")
                {
                    if (Request.UrlReferrer.Host != "upload.cyber-blade.dk")
                    {
                        dal.AddParameter("@Referrer", Request.UrlReferrer.ToString(), DbType.String);
                        object count = dal.ExecuteScalar("SELECT COUNT(*) FROM Referrers WHERE Referrer LIKE @Referrer");
                        dal.ClearParameters();

                        if (count != null)
                        {
                            if (count.ToString() == "0")
                            {
                                dal.AddParameter("@Referrer", Request.UrlReferrer.ToString(), DbType.String);
                                dal.AddParameter("@Site", Request.RawUrl, DbType.String);
                                dal.ExecuteNonQuery("INSERT INTO Referrers (Referrer, Site, [Count]) VALUES(@Referrer, @Site, 1)");
                                dal.ClearParameters();
                            }
                            else
                            {
                                dal.AddParameter("@Referrer", Request.UrlReferrer.ToString(), DbType.String);
                                dal.ExecuteNonQuery("UPDATE Referrers SET [Count] = ((SELECT [Count] FROM Referrers WHERE Referrer LIKE @Referrer) + 1) WHERE Referrer LIKE @Referrer");
                                dal.ClearParameters();
                            }
                        }
                    }
                }
            }
        }

        if (Session["Visited"] == null)
        {
            if (this.Page.User.Identity.IsAuthenticated == false)
            {
                dal.ExecuteNonQuery("UPDATE Visits SET VisitCount = (VisitCount + 1) WHERE VisitUsername = 'AnonymousUser'");
            }
            else
            {
                dal.AddParameter("@Username", this.Page.User.Identity.Name, DbType.String);
                dal.ExecuteNonQuery("UPDATE Visits SET VisitCount = (VisitCount + 1) WHERE VisitUsername = @Username");
                dal.ClearParameters();
            }

            Session["Visited"] = "true";
        }
        else
        {
            if (this.Page.User.Identity.IsAuthenticated)
            {
                if (Session["HasLoggedIn"] == null)
                {
                    dal.ExecuteNonQuery("UPDATE Visits SET VisitCount = (VisitCount - 1) WHERE VisitUsername = 'AnonymousUser'");
                    
                    dal.AddParameter("@Username", this.Page.User.Identity.Name, DbType.String);
                    dal.ExecuteNonQuery("UPDATE Visits SET VisitCount = (VisitCount + 1) WHERE VisitUsername = @Username");
                    dal.ClearParameters();

                    Session["HasLoggedIn"] = true;
                }

                if (this.Page.GetType().ToString().Contains("visits"))
                {
                    ((Repeater)this.ContentPlaceHolder1.FindControl("Repeater1")).DataSource = dal.ExecuteDataTable("SELECT VisitUsername, VisitCount FROM Visits WHERE NOT VisitUsername = 'AnonymousUser'");
                    ((Repeater)this.ContentPlaceHolder1.FindControl("Repeater1")).DataBind();

                    object scalar = dal.ExecuteScalar("SELECT VisitCount FROM Visits WHERE VisitUsername = 'AnonymousUser'");

                    if (scalar != null)
                    {
                        if (scalar.ToString().Equals(string.Empty))
                        {
                            ((Label)this.ContentPlaceHolder1.FindControl("Label1")).Text = "Der skete en fejl. Prøv venligst igen.";
                        }
                        else
                        {
                            ((Label)this.ContentPlaceHolder1.FindControl("Label1")).Text = "<b>Anonyme brugere: " + scalar.ToString() + "</b>";
                        }
                    }
                    else
                    {
                        ((Label)this.ContentPlaceHolder1.FindControl("Label1")).Text = "<b>Der skete en fejl. Prøv venligst igen.</b>";
                    }
                }
            }
        }

        Title.Text = "Cyber-Blade.dk - Upload";
        lblTitle.Text = dal.ExecuteScalar("SELECT Text FROM Text WHERE Name = 'Title'").ToString();
    }
    protected void Menu1_DataBound1(object sender, EventArgs e)
    {
        Menu menu = (Menu)sender;
        menu.Items[menu.Items.Count - 1].Text = menu.Items[menu.Items.Count - 1].Text.Replace("<span style='color:#000000;'>|</span>", "");
    }
}