<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="edituser.aspx.cs" Inherits="private_edituser" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1>Bruger</h1>
    Her kan du konfigurere din bruger.<br />
    <br />
    <center>
        <asp:ChangePassword ID="ChangePassword1" runat="server" CancelButtonText=""
            ChangePasswordButtonText="Skift password" ChangePasswordFailureText="Forkert password eller nyt password er forkert. Nyt password længde minimum: {0}."
            ChangePasswordTitleText="Skift dit password" ConfirmNewPasswordLabelText="Bekræft nyt password:"
            ConfirmPasswordCompareErrorMessage="De to passwords skal være ens." ConfirmPasswordRequiredErrorMessage="Du skal bekræfte dit password."
            ContinueButtonText="Fortsæt" NewPasswordLabelText="Nyt password:" NewPasswordRegularExpressionErrorMessage="Indtast venligst et andet password."
            NewPasswordRequiredErrorMessage="Du skal indtaste et nyt password." PasswordRequiredErrorMessage="Password er påkrævet."
            SuccessPageUrl="~/Default.aspx" SuccessText="Dit password er blevet ændret!"
            SuccessTitleText="Færdig" UserNameLabelText="Brugernavn:" UserNameRequiredErrorMessage="Brugernavn er påkrævet.">
            <ChangePasswordTemplate>
                <table border="0" cellpadding="1" cellspacing="0" style="border-collapse: collapse">
                    <tr>
                        <td>
                            <table border="0" cellpadding="0">
                                <tr>
                                    <td align="center" colspan="2">
                                        <strong>
                                        Skift dit password</strong></td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="CurrentPasswordLabel" runat="server" AssociatedControlID="CurrentPassword">Password:</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="CurrentPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                                            ErrorMessage="Password er påkrævet." ToolTip="Password er påkrævet." ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="NewPasswordLabel" runat="server" AssociatedControlID="NewPassword">Nyt password:</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="NewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                                            ErrorMessage="Du skal indtaste et nyt password." ToolTip="Du skal indtaste et nyt password."
                                            ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right">
                                        <asp:Label ID="ConfirmNewPasswordLabel" runat="server" AssociatedControlID="ConfirmNewPassword">Bekræft nyt password:</asp:Label></td>
                                    <td>
                                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                                            ErrorMessage="Du skal bekræfte dit password." ToolTip="Du skal bekræfte dit password."
                                            ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2">
                                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword"
                                            ControlToValidate="ConfirmNewPassword" Display="Dynamic" ErrorMessage="De to passwords skal være ens."
                                            ValidationGroup="ChangePassword1"></asp:CompareValidator>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" colspan="2" style="color: red">
                                        <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" colspan="2">
                                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword"
                                            Text="Skift password" ValidationGroup="ChangePassword1" />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </ChangePasswordTemplate>
        </asp:ChangePassword>
    </center>
    <br />
</asp:Content>