<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplaintDo.aspx.cs" Inherits="Warehousing.Complaint.ComplaintDo" %>

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
    客诉登记</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" 
      style="margin-left:5px; ">
  	  <tr>
        <td width="89">客诉时间：</td>
        <td width="671">
            <asp:Label ID="txtComplaintTime" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>客诉类型：</td>
        <td>
            <asp:Label ID="ddtypeId" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>客户ID： </td>       <td>
        <asp:Label ID="txtUserId" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>客户姓名：</td>
        <td>
           <asp:Label ID="txtUserName" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td>客诉详情：</td>
        <td>
        <asp:Label ID="txtComplaintDetail" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>联系方式：<td>
        <asp:Label ID="txtuserTel" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>接诉人工号：        <td>
        <asp:Label ID="txtaddOperator" runat="server" Text="Label"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>处理人工号：</td>
        <td>
            <asp:TextBox ID="txtdoOperator" runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>处理结果：</td>
        <td>
            <asp:TextBox ID="txtdoContent" runat="server" TextMode="MultiLine"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>处理状态：</td>
        <td>
            <asp:DropDownList ID="ddStatus" runat="server">
            <asp:ListItem Value="">请处理</asp:ListItem>
            </asp:DropDownList>
        </td>
      </tr>
      <tr>
        <td></td>
        <td>
            <asp:HiddenField ID="fromUrl" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="确认提交" onclick="Button1_Click" />
            <input name="b1" type="button" onClick="javascript:history.back();" value="返回">
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>