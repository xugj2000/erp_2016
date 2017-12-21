<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnToExcel.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnToExcel" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品管理</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货商品列表</strong></div>
  
  <asp:Repeater ID="GoodsList" runat="server">
    <HeaderTemplate>
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE" border="1" bordercolor="#333333">
    <tr>
    <td bgcolor="#F6F6F6">返货日期</td>
      <td bgcolor="#F6F6F6">商品名</td>
      <td bgcolor="#F6F6F6">数量</td>
      <td bgcolor="#F6F6F6">条形码</td>
      <td bgcolor="#F6F6F6">所属代理</td>
      <td bgcolor="#F6F6F6">收货人</td>
      <td bgcolor="#F6F6F6">电话</td>
      <td bgcolor="#F6F6F6">省</td>
      <td bgcolor="#F6F6F6">运费</td>
      <td align="center" bgcolor="#F6F6F6">处理状态</td>
    </tr>
     </HeaderTemplate>
     <ItemTemplate>
    <tr>
    <td  align="left"><%#Eval("AddTime")%></td>
      <td width="23%" align="left"><%#Eval("ProductName")%><%#Warehousing.Business.GoodsReturnHelper.checkIsChange(Eval("ChangeFlag"))%></td>
      <td  align="left"><%#Eval("ProductCount")%></td>
      <td align="left"><%#Eval("ProductTxm")%></td>
      <td align="left"><%#Eval("AgentId")%></td>
      <td align="left"><%#Eval("UserName")%></td>
      <td align="left"><%#Eval("UserTel")%></td>
      <td align="left"><%#Eval("UserProvince")%></td>
      <td align="left"><%#Eval("PostFee")%></td>
      <td align="center"><%#Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(Eval("Status")))%></td>
      </tr>
        </ItemTemplate>
     <FooterTemplate>
  </table>
  </FooterTemplate>
  </asp:Repeater>
</body>
</html>
