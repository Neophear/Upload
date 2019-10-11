<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Søgning | Search | Buscar</h1>
    <center>
        <div style="width:650px;text-align:left;">
            Skriv hvad du vil søge efter. Fx "Prodigy" eller "Scooter ramp" uden "".<br />
            Hvis du vil angive hvilke filtyper du vil have skal du skrive det efter "filetype:'%typer
            adskildt af mellemrum%'". Fx<br />
            <code>Prodigy filetype:'mp3 avi mpg'</code><br />
            Hvis ikke du angiver nogle filtyper søger den automatisk efter mp3, avi og mpg-filer.<br />
            <br />
            Type the item you want to search for. Ie: "Prodigy" or "Scooter ramp". With no quotation marks.<br />
            If you want to specify a particular type of file add this to the query: "filetype:'%different types of files separated with a space%'". For example<br />
            <code>Prodigy filetype:'mp3 avi mpg'</code><br />
            If you don't specify any files it will automaticaly search for mp3, avi and mpgfiles.<br />
            <br />
            Escriba en el recuadro lo que desee buscar. Por ejemplo "Prodigy" o "Scooter ramp" sin las comillas.<br />
            Si desea buscar un tipo de archivo en concreto escriba lo siguiente "filetype:'%los tipos de archivos separados por un espacio%'".<br />
            Por ejemplo<br />
            <code>Prodigy filetype:'mp3 avi mpg'</code><br />
            Si no especificas el tipo de archivo, por defecto se buscaran archivos avi, mp3 y mpg.<br />
            <div style="color:#FFFFFF;">For 200 years :)</div>
            <br />
            <div style="text-align:center;">
                <asp:TextBox ID="txtSearchQuery" runat="server" Width="470px"></asp:TextBox><br />
                <asp:Button ID="btnSearchSubmit" runat="server" Text="Søg | Search | Buscar" OnClick="btnSearchSubmit_Click" />
            </div>
        </div>
    </center>
</asp:Content>