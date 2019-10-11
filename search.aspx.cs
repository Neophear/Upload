using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class search : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Page.Title = "Søgning | Search | Buscar";
    }
    protected void btnSearchSubmit_Click(object sender, EventArgs e)
    {
        Regex regex = new Regex("filetype:'(?<type>[\\w\\W]*?)'");

        string wholeSearch = "intitle:\"index.of\"";
        string searchQuery = txtSearchQuery.Text;
        string filetypes = " (mp3|mp4|avi) ";

        MatchCollection matches = regex.Matches(searchQuery);

        if (matches.Count > 0)
        {
            filetypes = " (";
        }

        foreach (Match match in matches)
        {
            foreach (string type in match.Groups["type"].Value.ToString().Split(new char[] { ' ', ',' }))
            {
                filetypes += type.Trim() + "|";
            }
        }

        if (matches.Count > 0)
        {
            filetypes = filetypes.Substring(0, filetypes.Length - 1) + ") ";
        }

        wholeSearch += filetypes + regex.Replace(txtSearchQuery.Text, "").Trim().Replace(" ", ".");
        wholeSearch += " -html -htm -php -asp -cf -jsp";

        Response.Redirect("http://www.google.dk/search?q=" + wholeSearch);
    }
}