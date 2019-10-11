<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="questionnaire_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Spørgeskema</title>
    <link href="style.css" rel="stylesheet" type="text/css" />
    
</head>
    <body>
        <form id="form1" runat="server">
            <asp:Panel ID="Panel1" runat="server" Width="100%">
                Vi er en gruppe på 2 elever fra Aalborg Tekniske Gymnasium, der er
                i gang med et projekt vedrørende politiets nye 114 nummer. I dette projekt er det
                vigtigt, at vi får klarlagt vores målgruppe og det her vi skal bruge din viden vedrørende
                det nye 114 nummer.<br />
                <br />
                På forhånd tak...<br />
                <br />
                <strong>1. Har du hørt om politiets nye 114 nummer?<br />
                </strong>
                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                    <asp:ListItem>Ja</asp:ListItem>
                    <asp:ListItem>Nej</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="RadioButtonList1"
                    ErrorMessage="Du skal svare på dette spørgsmål."></asp:RequiredFieldValidator><br />
                <br />
                <strong>2. Hvis ja, hvor har du hørt om det? (Sæt gerne flere krydser)<br />
                </strong><asp:CheckBoxList ID="CheckBoxList1" runat="server">
                    <asp:ListItem>Internet</asp:ListItem>
                    <asp:ListItem>Radio</asp:ListItem>
                    <asp:ListItem>TV/tekst-tv</asp:ListItem>
                    <asp:ListItem>Avis/Blade</asp:ListItem>
                    <asp:ListItem>Venner/bekendte</asp:ListItem>
                </asp:CheckBoxList><asp:Label ID="lblQ2" Visible="False" runat="server" CssClass="error" Text="Du skal svare på dette spørgsmål."></asp:Label><br />
                <br />
                <strong>3. Ved du hvornår du skal benytte det nye 114 nummer frem for 112?<br />
                </strong>
                <asp:RadioButtonList ID="RadioButtonList2" runat="server">
                    <asp:ListItem>Ja</asp:ListItem>
                    <asp:ListItem>Nej</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="RadioButtonList2"
                    ErrorMessage="Du skal svare på dette spørgsmål."></asp:RequiredFieldValidator><br />
                <br />
                <strong>4. Hvis ja, ved du i hvilke(n) situation(er) du skal benytte 114 nummer frem for 112?<br />
                </strong>
                <asp:CheckBoxList ID="CheckBoxList2" runat="server">
                    <asp:ListItem>Brand</asp:ListItem>
                    <asp:ListItem>Tyveri</asp:ListItem>
                    <asp:ListItem>Vold</asp:ListItem>
                    <asp:ListItem>L&#230;gehj&#230;lp</asp:ListItem>
                </asp:CheckBoxList><asp:Label ID="lblQ4" Visible="false" runat="server" CssClass="error" Text="Du skal svare på dette spørgsmål"></asp:Label><br />
                <br />
                <strong>5. Hvor søger du normalt informationer vedrørende din hverdag? (Sæt gerne flere krydser)</strong><br />
                <asp:CheckBoxList ID="CheckBoxList3" runat="server">
                    <asp:ListItem>Internet</asp:ListItem>
                    <asp:ListItem>Radio</asp:ListItem>
                    <asp:ListItem>TV/tekst-tv</asp:ListItem>
                    <asp:ListItem>Avis/Blade</asp:ListItem>
                    <asp:ListItem>Venner/bekendte</asp:ListItem>
                </asp:CheckBoxList>
                <asp:Label ID="lblQ5" Visible="false" runat="server" CssClass="error" Text="Du skal svare på dette spørgsmål"></asp:Label><br />
                <br />
                <strong>6. Alder:<br />
                </strong>
                <asp:RadioButtonList ID="RadioButtonList3" runat="server">
                    <asp:ListItem>15 &#229;r eller yngre</asp:ListItem>
                    <asp:ListItem>16 &#229;r</asp:ListItem>
                    <asp:ListItem>17 &#229;r</asp:ListItem>
                    <asp:ListItem>18 &#229;r</asp:ListItem>
                    <asp:ListItem>19 &#229;r</asp:ListItem>
                    <asp:ListItem>20 &#229;r</asp:ListItem>
                    <asp:ListItem>21 &#229;r eller &#230;ldre</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="RadioButtonList3"
                    ErrorMessage="Du skal svare på dette spørgsmål."></asp:RequiredFieldValidator><br />
                <br />
                <strong>7. Køn:<br />
                </strong>
                <asp:RadioButtonList ID="RadioButtonList4" runat="server">
                    <asp:ListItem>Mand</asp:ListItem>
                    <asp:ListItem>Kvinde</asp:ListItem>
                </asp:RadioButtonList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="RadioButtonList4"
                    ErrorMessage="Du skal svare på dette spørgsmål."></asp:RequiredFieldValidator><br />
                <br />
                <asp:Button ID="btnSubmit" runat="server" Text="Svar" OnClick="btnSubmit_Click" />
            </asp:Panel>
            <asp:Label ID="Label1" runat="server" Text="Mange tak for din besvarelse." Visible="False"></asp:Label>
        </form>
    </body>
</html>