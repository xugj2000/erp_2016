<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplaintDo.aspx.cs" Inherits="Warehousing.Complaint.ComplaintDo" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>������Ʒ¼��</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script src="../js/jquery.js"></script>
<SCRIPT>
function checkLoginId(LoginId) 
{	 
	$.ajax
	({
		url:"../handler/checkLoginId.ashx?nocache=" + Math.random(),
		type:"get",
		data:"loginId="+LoginId,
		dataType:"json",
		success:function(jsonStr){
			var obj=eval(jsonStr);
			if (obj.isExist=="0")
			{
			alert("["+LoginId+"]��������");
			$("#txtdoOperator").val('');
			$("#txtdoOperator").focus();
			}
			} 
	});  
}
</script>
    </head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    ���ߵǼ�</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" 
      style="margin-left:5px; ">
  	  <tr>
        <td width="89">����ʱ�䣺</td>
        <td width="671">
            <asp:Label ID="txtComplaintTime" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>�������ͣ�</td>
        <td>
            <asp:Label ID="ddtypeId" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>�ͻ�ID�� </td>       <td>
        <asp:Label ID="txtUserId" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>�ͻ�������</td>
        <td>
           <asp:Label ID="txtUserName" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td>�������飺</td>
        <td>
        <asp:Label ID="txtComplaintDetail" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>��ϵ��ʽ��<td>
        <asp:Label ID="txtuserTel" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>�����˹��ţ�        <td>
        <asp:Label ID="txtaddOperator" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>�����˹��ţ�</td>
        <td>
            <asp:TextBox ID="txtdoOperator" runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>��������</td>
        <td>
            <asp:TextBox ID="txtdoContent" runat="server" TextMode="MultiLine"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>����״̬��</td>
        <td>
            <asp:DropDownList ID="ddStatus" runat="server">
            <asp:ListItem Value="">�봦��</asp:ListItem>
            </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="fromUrl" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="ȷ���ύ" onclick="Button1_Click" />
            <input name="b1" type="button" onClick="javascript:history.back();" value="����">
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>