<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addComplaint.aspx.cs" Inherits="Warehousing.Complaint.addComplaint" %>

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
			$("#txtaddOperator").val('');
			$("#txtaddOperator").focus();
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
        <td>����ʱ�䣺</td>
        <td>
            <asp:TextBox ID="txtComplaintTime" runat="server"  MaxLength="50"  onClick="return Calendar('txtComplaintTime','');"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>�������ͣ�</td>
        <td>
            
            <asp:DropDownList ID="ddtypeId" runat="server"></asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td>�ͻ�ID��        <td>
            <asp:TextBox ID="txtUserId" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>�ͻ�������        <td>
            <asp:TextBox ID="txtUserName" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>�������飺</td>
        <td>
            <asp:TextBox ID="txtComplaintDetail" runat="server" TextMode="MultiLine" Width="240px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>��ϵ��ʽ��<td>
            <asp:TextBox ID="txtuserTel" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>�����˹��ţ�        <td>
            <asp:TextBox ID="txtaddOperator" runat="server" MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtaddOperator" ErrorMessage="�����˲���Ϊ��"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="fromUrl" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="ȷ���ύ" onclick="Button1_Click" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>