<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RecoverPassword.aspx.cs" Inherits="RecoverPassword" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center>
        <asp:PasswordRecovery ID="PasswordRecovery1" runat="server" AnswerLabelText="Svar:"
            AnswerRequiredErrorMessage="Indtast dit svar." GeneralFailureText="Dit forsøg på at nulstille dit password mislykkedes."
            QuestionFailureText="Dit svar var forkert." QuestionInstructionText="Svar på følgende spørgsmål for at nulstille dit password."
            QuestionLabelText="Spørgsmål:" QuestionTitleText="<h1>Glemt password</h1>" SubmitButtonText=" OK "
            SuccessText="<h1>Glemt password</h1>Dit nye password er sendt til din email."
            UserNameFailureText="Dit brugernavn existerer ikke." UserNameInstructionText="Indtast dit brugernavn for at nulstille dit password."
            UserNameLabelText="Brugernavn:" UserNameRequiredErrorMessage="Indtast dit brugernavn."
            UserNameTitleText="<h1>Glemt password</h1>">
        </asp:PasswordRecovery>
    </center>
</asp:Content>