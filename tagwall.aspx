<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="tagwall.aspx.cs" Inherits="tagwall" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>
        Tagwall</h1>
    Her kan du skrive med andre medlemmer af siden.<br />
    <center>
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <br />
                Skriv besked:<br />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                    ErrorMessage="Du skal indtaste en besked." SetFocusOnError="True"></asp:RequiredFieldValidator><br />
                <asp:TextBox ID="TextBox1" runat="server" Height="62px" TextMode="MultiLine" Width="300px"
                    MaxLength="255"></asp:TextBox><br />
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Send besked" /><br />
            </LoggedInTemplate>
            <AnonymousTemplate>
                Du skal være logget ind for at kunne skrive her.<br />
            </AnonymousTemplate>
        </asp:LoginView>
        <br />
        <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
            <HeaderTemplate>
                <table>
                    <tr style="border: 1px;">
                        <td style="width: 150px;">
                            <b>Bruger:</b>
                        </td>
                        <td style="width: 200px;">
                            <b>Besked:</b>
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr style="<%# RowCounter++ % 2 != 0 ? "": "background-color:#CCCCCC;" %>">
                    <td style="width: 150px;">
                        <%# Eval("Username") %>
                        <br />
                        <span style="font-size: 8pt;">
                            <%# Eval("Created") %>
                        </span>
                    </td>
                    <td style="width: 200px;">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Message") %>'></asp:Label>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
        <asp:Repeater ID="Repeater2" runat="server" OnItemCommand="Repeater2_ItemCommand"
            OnItemDataBound="Repeater2_ItemDataBound">
            <HeaderTemplate>
                <table>
                    <tr style="border: 1px;">
                        <td style="width: 150px;">
                            <b>Bruger:</b>
                        </td>
                        <td style="width: 200px;">
                            <b>Besked:</b>
                        </td>
                        <td>
                            <b>Slet:</b>
                        </td>
                    </tr>
            </HeaderTemplate>
            <ItemTemplate>
                <tr style="<%# RowCounter++ % 2 != 0 ? "": "background-color:#CCCCCC;" %>">
                    <td style="width: 150px;">
                        <%# Eval("Username") %>
                        <br />
                        <span style="font-size: 8pt;">
                            <%# Eval("Created") %>
                        </span>
                    </td>
                    <td style="width: 200px;">
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Message") %>'></asp:Label>
                    </td>
                    <td>
                        <asp:LinkButton CausesValidation="false" ID="DeleteButton" runat="server" CommandName="Delete"
                            CommandArgument='<%# Eval("ID") %>'><img style="border:none;" alt="Slet '<%# Eval("Message") %>'" src="images/delete.gif" /></asp:LinkButton>
                    </td>
                </tr>
            </ItemTemplate>
            <FooterTemplate>
                </table>
            </FooterTemplate>
        </asp:Repeater>
    </center>
    <br />
</asp:Content>