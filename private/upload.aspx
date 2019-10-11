<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload.aspx.cs" Inherits="upload" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <h1>Upload:</h1>
        Her kan du uploade filer. Vælg den fil og mappe du vil uploade til.<br />
        Hvis du uploader til din private mappe har du kun adgang til filerne når du er logget
        ind.</center>    
    <center>
        Jeg forbeholder mig retten til at slette filer uden varsel hvis jeg finder det passende.</center>
    <center>
        Porno og illegalt materiale er ikke tilladt.<br />
        <br />
        <asp:Label ID="Label1" runat="server" Text='<span style="color:#FF0000">Du må ikke uploade den filtype.</span>'
            Visible="False"></asp:Label><asp:Label ID="Label4" runat="server" Text='<span style="color:#FF0000">Du skal vælge en fil som eksisterer.</span>'
                Visible="False"></asp:Label><br />
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="FileUpload1"
            ErrorMessage="Du skal vælge en fil."></asp:RequiredFieldValidator><br />
        <asp:FileUpload ID="FileUpload1" runat="server" /><br />
        Upload til
        <asp:DropDownList ID="DropDownList1" runat="server">
        </asp:DropDownList><br />
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Upload" /><br />
        <br />
        <asp:Label ID="Label2" runat="server" Text="<b>Filen blev uploadet til:</b>" Visible="False"></asp:Label><asp:Label
            ID="Label3" runat="server" Text='<span style="color:#FF0000">Filen eksisterer i forvejen.</span>' Visible="False"></asp:Label><br />
        <asp:HyperLink ID="HyperLink1" runat="server" Target="_blank" Visible="False">HyperLink</asp:HyperLink><br />
        <br />
        Tilladte filtyper:<br />
        (<a href="../contact.aspx">Kontakt mig</a> hvis du vil have en ny type tilladt)<br />
        <br />
        <asp:Repeater ID="Repeater1" runat="server">
            <HeaderTemplate>
                <table>
                    <tr>
                        <td>
                            <b>Efternavn:</b>
                        </td>
                        <td>
                            <b>Type:</b>
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr>
                    <td>
                        <%# Eval("Extension") %>
                    </td>
                    <td>
                        <%# Eval("Type") %>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <br />
    </center>
</asp:Content>