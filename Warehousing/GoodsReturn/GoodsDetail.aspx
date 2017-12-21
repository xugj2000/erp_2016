<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsDetail.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsDetail" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品录入</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
    <style type="text/css">
        .style1
        {
            height: 16px;
        }
    </style>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货商品信息</strong></div>
  <table width="600" border="0" align="center" cellpadding="5" cellspacing="1" bgcolor="#EEEEEE" style="margin-left:5px;">
  	  <tr>
        <td width="86" bgcolor="#F6F6F6" class="style1">所属订单：</td>
        <td width="494" bgcolor="#FFFFFF" class="style1"><%=orderid%></td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">所属代理：</td>
        <td bgcolor="#FFFFFF"><%=agentid%>        </td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">商品名称：</td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtProductName" runat="server" Text="Label"></asp:Label> <%=Warehousing.Business.GoodsReturnHelper.checkIsChange(ChangeFlag)%>       </td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">商品条码：</td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtProductTxm" runat="server" Text="Label"></asp:Label>        </td>
      </tr>
      
      <tr>
        <td bgcolor="#F6F6F6">返货数量： </td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtProductCount" runat="server" Text="Label"></asp:Label>        </td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">返货时间：</td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtReturnTime" runat="server" Text="Label"></asp:Label>        </td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">返货原因：</td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtReturnReson" runat="server" Text="Label"></asp:Label>        </td>
      </tr>
            <tr>
        <td bgcolor="#F6F6F6">接收人：</td>
        <td bgcolor="#FFFFFF">
        <asp:Label ID="txtReceivedOpter" runat="server" Text="Label"></asp:Label>        </td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">录入时间：</td>
        <td bgcolor="#FFFFFF"> <asp:Label ID="txtAddTime" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">录入人：</td>
        <td bgcolor="#FFFFFF"> <asp:Label ID="txtOperator" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">处理状态：</td>
        <td bgcolor="#FFFFFF"><asp:Label ID="txtStatus" runat="server" Text="Label"></asp:Label></td>
      </tr>
      <tr>
        <td bgcolor="#F6F6F6">操作记录：</td>
        <td bgcolor="#FFFFFF">&nbsp;        </td>
      </tr>
</table>
  </p>
</body>
</html>
