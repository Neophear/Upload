<%@ Page Language="C#" EnableEventValidation="false" MasterPageFile="~/MasterPage.master"
    AutoEventWireup="true" CodeFile="links.aspx.cs" Inherits="links" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h1>Links:</h1>
    Her kan man uploade links.<br />
    Jeg tager ikke ansvar for nogle af linksene og hvad de henviser til.<br />
    <asp:Label ID="Label2" runat="server" Text="<br />Der er ingen links i øjeblikket.<br />"
        Visible="False"></asp:Label><br />
    <center>
        <asp:LoginView ID="LoginView1" runat="server">
            <LoggedInTemplate>
                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand"
                    OnItemDataBound="Repeater1_ItemDataBound">
                    <HeaderTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td align="center">
                                    <b>Navn:</b>
                                </td>
                                <td align="center">
                                    <b>Antal klik:</b>
                                </td>
                                <td align="center">
                                    <b>Uploadet af:</b>
                                </td>
                                <td align="center">
                                    <b>Rediger:</b>
                                </td>
                                <td align="center">
                                    <b>Slet:</b>
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr style="<%# RowCounter++ % 2 != 0 ? "": "background-color:#CCCCCC;" %>">
                            <td>
                                <a title="<%# Eval("LinkUrl") %>" href='<%# "linkredirect.aspx?id=" + Eval("LinkID") %>' target="_blank"><%# Eval("LinkName") %></a>
                            </td>
                            <td>
                                <%# Eval("LinkClicked") %>
                            </td>
                            <td>
                                <%# Eval("LinkUsername") %>
                            </td>
                            <td align="center">
                                <asp:LinkButton CausesValidation="false" ID="EditButton" runat="server" CommandName="Edit"
                                    CommandArgument='<%# Eval("LinkID") %>'><img style="border:none;" alt="Rediger <%# Eval("LinkName") %>" src="images/edit.gif" /></asp:LinkButton>
                            </td>
                            <td align="center">
                                <asp:LinkButton CausesValidation="false" ID="DeleteButton" runat="server" CommandName="Delete"
                                    CommandArgument='<%# Eval("LinkID") %>'><img style="border:none;" alt="Slet <%# Eval("LinkName") %>" src="images/delete.gif" /></asp:LinkButton>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
                &nbsp;
                <br />
                <asp:Label ID="Label1" runat="server">Upload link:</asp:Label><br />
                <table>
                    <tr>
                        <td>
                            Navn:<br />
                            &nbsp;
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                ErrorMessage="Du skal skrive et navn." SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td>
                            Url:<br />
                            <br />
                            &nbsp;</td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                                ErrorMessage="Du skal skrive en adresse." SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                    </tr>
                </table>
                <asp:Button ID="Button1" runat="server" Text="Upload" OnClick="Button1_Click" />
                <asp:Button ID="Button2" runat="server" Text="Gem" OnClick="Button2_Click" Visible="False" />
                <asp:Button ID="Button3" runat="server" Text="Nulstil" OnClick="Button3_Click" Visible="False" /><br />
            </LoggedInTemplate>
            <AnonymousTemplate>
                <asp:Repeater ID="Repeater1" runat="server" OnItemCommand="Repeater1_ItemCommand">
                    <HeaderTemplate>
                        <table cellpadding="5">
                            <tr>
                                <td align="center">
                                    <b>Navn:</b>
                                </td>
                                <td align="center">
                                    <b>Antal klik:</b>
                                </td>
                                <td align="center">
                                    <b>Uploadet af:</b>
                                </td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr style="<%# RowCounter++ % 2 != 0 ? "": "background-color:#CCCCCC;" %>">
                            <td>
                                <a title="<%# Eval("LinkUrl") %>" href='<%# "linkredirect.aspx?id=" + Eval("LinkID") %>' target="_blank"><%# Eval("LinkName") %></a>
                            </td>
                            <td>
                                <%# Eval("LinkClicked") %>
                            </td>
                            <td>
                                <%# Eval("LinkUsername") %>
                            </td>
                        </tr>
                    </ItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </AnonymousTemplate>
        </asp:LoginView>
    </center>
</asp:Content>