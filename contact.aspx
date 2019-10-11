<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="contact.aspx.cs" Inherits="contact" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Kontakt:</h1>
    Her kan du kontakte mig. Bare udfyld nedenstående skema og tryk send.<br />
    Du kan også sende mig en mail på <a href="mailto:upload@cyber-blade.dk">upload@cyber-blade.dk</a>.<br />
    <br />
    <asp:Label ID="Label1" runat="server" Visible="false"></asp:Label><br />
    <asp:LoginView ID="LoginView1" runat="server">
        <AnonymousTemplate>
    Dit navn:<br />
    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
        ErrorMessage="Du skal angive dit navn."></asp:RequiredFieldValidator><br />
    <br />
    Evt. din mail hvis jeg skal kontakte dig:<br />
    <asp:TextBox ID="TextBox3" runat="server" Width="175px"></asp:TextBox><br />
    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox3"
        ErrorMessage="Du skal angive en gyldig mail." ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
        </AnonymousTemplate>
    </asp:LoginView>
    <br />
    Din besked:<br />
    <asp:TextBox ID="TextBox1" runat="server" Height="122px" Width="233px" TextMode="MultiLine"></asp:TextBox><br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
        ErrorMessage="Du skal skrive en besked."></asp:RequiredFieldValidator><br />
    <br />
    <asp:Button ID="Button1" runat="server" Text="Send" OnClick="Button1_Click" /><br />
</asp:Content>