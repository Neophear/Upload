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

public partial class questionnaire_Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (ValidatePage())
        {
            DataAccessLayer dal = new DataAccessLayer();

            string question2 = "";
            string question4 = "";
            string question5 = "";

            if (RadioButtonList1.SelectedIndex == 0)
            {
                foreach (ListItem checkbox in CheckBoxList1.Items)
                {
                    if (checkbox.Selected)
                    {
                        question2 += checkbox.Text + ", ";
                    }
                }
                question2 = question2.Remove(question2.Length - 2);
            }

            if (RadioButtonList2.SelectedIndex == 0)
            {
                foreach (ListItem checkbox in CheckBoxList2.Items)
                {
                    if (checkbox.Selected)
                    {
                        question4 += checkbox.Text + ", ";
                    }
                }
                question4 = question4.Remove(question4.Length - 2);
            }

            foreach (ListItem checkbox in CheckBoxList3.Items)
            {
                if (checkbox.Selected)
                {
                    question5 += checkbox.Text + ", ";
                }
            }
            question5 = question5.Remove(question5.Length - 2);

            dal.AddParameter("@Question1", RadioButtonList1.SelectedValue, DbType.String);
            dal.AddParameter("@Question2", question2, DbType.String);
            dal.AddParameter("@Question3", RadioButtonList2.SelectedValue, DbType.String);
            dal.AddParameter("@Question4", question4, DbType.String);
            dal.AddParameter("@Question5", question5, DbType.String);
            dal.AddParameter("@Age", RadioButtonList3.SelectedValue, DbType.String);
            dal.AddParameter("@Gender", RadioButtonList4.SelectedValue, DbType.String);
            dal.AddParameter("@Created", DateTime.Now, DbType.DateTime);
            dal.ExecuteNonQuery("INSERT INTO [lp_questionnaire] (Question1, Question2, Question3, Question4, Question5, Age, Gender, Created) VALUES(@Question1, @Question2, @Question3, @Question4, @Question5, @Age, @Gender, @Created)");
            dal.ClearParameters();

            Panel1.Visible = false;
            Label1.Visible = true;
        }
    }
    private bool ValidatePage()
    {
        bool validated = false;

        if (RadioButtonList1.SelectedIndex == 0)
        {
            if (CheckBoxList1.SelectedItem == null)
            {
                lblQ2.Visible = true;
                validated = false;
            }
            else
            {
                lblQ2.Visible = false;
                validated = true;
            }
        }
        else
        {
            lblQ2.Visible = false;
        }

        if (RadioButtonList2.SelectedIndex == 0)
        {
            if (CheckBoxList2.SelectedItem == null)
            {
                lblQ4.Visible = true;
                validated = false;
            }
            else
            {
                lblQ4.Visible = false;
            }
        }
        else
        {
            lblQ4.Visible = false;
        }

        if (CheckBoxList3.SelectedItem == null)
        {
            lblQ5.Visible = true;
            validated = false;
        }
        else
        {
            lblQ5.Visible = false;
        }

        return validated;
    }
}