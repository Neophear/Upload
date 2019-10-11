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
using System.Net.Mail;

public partial class contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        string username;
        string email = "";

        if (this.User.Identity.IsAuthenticated)
        {
            username = this.User.Identity.Name;
            email = Membership.GetUser(this.User.Identity.Name).Email;
        }
        else
        {
            username = ((TextBox)LoginView1.FindControl("TextBox2")).Text;
            if (((TextBox)LoginView1.FindControl("TextBox3")).Text != "")
            {
                email = ((TextBox)LoginView1.FindControl("TextBox3")).Text;
            }
            ((TextBox)LoginView1.FindControl("TextBox2")).Text = "";
            ((TextBox)LoginView1.FindControl("TextBox3")).Text = "";
        }

        MailMessage mail = new MailMessage();
        string body;
        mail.To.Add(new MailAddress("stiiggade@gmail.com"));
        mail.From = new MailAddress("contact@cyber-blade.dk");
        mail.Subject = "Kommentar fra min upload-side";
        mail.IsBodyHtml = true;
        body = "<b>Navn: " + username + "</b><br />";
        
        if (email != "")
        {
            body += "<b>Email: <a href='mailto:" + email + "'>" + email + "</a></b><br />";
        }

        body += "<br />" + TextBox1.Text;
        mail.Body = body;
        SmtpClient client = new SmtpClient();
        client.Send(mail);

        TextBox1.Text = "";

        Label1.Text = "<br />Tak for din kommentar<br />";
        Label1.Visible = true;
    }
}
