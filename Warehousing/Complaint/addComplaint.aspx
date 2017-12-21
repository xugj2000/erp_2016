<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addComplaint.aspx.cs" Inherits="Warehousing.Complaint.addComplaint" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品录入</title>
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
			alert("["+LoginId+"]工号有误");
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
    客诉登记</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" 
      style="margin-left:5px; ">
  	  <tr>
        <td>客诉时间：</td>
        <td>
            <asp:TextBox ID="txtComplaintTime" runat="server"  MaxLength="50"  onClick="return Calendar('txtComplaintTime','');"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>客诉类型：</td>
        <td>
            
            <asp:DropDownList ID="ddtypeId" runat="server"></asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td>客户ID：        <td>
            <asp:TextBox ID="txtUserId" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>客户姓名：        <td>
            <asp:TextBox ID="txtUserName" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>客诉详情：</td>
        <td>
            <asp:TextBox ID="txtComplaintDetail" runat="server" TextMode="MultiLine" Width="240px"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>联系方式：<td>
            <asp:TextBox ID="txtuserTel" runat="server"  MaxLength="50"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>接诉人工号：        <td>
            <asp:TextBox ID="txtaddOperator" runat="server" MaxLength="30"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ControlToValidate="txtaddOperator" ErrorMessage="接诉人不能为空"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="fromUrl" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="确认提交" onclick="Button1_Click" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>