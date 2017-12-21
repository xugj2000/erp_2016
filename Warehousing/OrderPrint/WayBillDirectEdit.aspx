<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WayBillDirectEdit.aspx.cs" Inherits="Warehousing.OrderPrint.WayBillDirectEdit" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品录入</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
    <style type="text/css">
        .style1
        {
            height: 14px;
        }
    </style>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>货运单录入</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-left:5px;">
  	  <tr>
        <td width="97" class="style1">所属订单：</td>
        <td width="663" class="style1">
            <asp:Label ID="lbOrderSn" runat="server" Text="Label"></asp:Label>
              </td>
      </tr>
      <tr>
        <td>物流公司：        <td>
            <asp:TextBox ID="txtExpressName" runat="server" Width="254px" MaxLength="100"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ControlToValidate="txtExpressName" ErrorMessage="物流公司不能为空"></asp:RequiredFieldValidator>
        </td>
      </tr>
      <tr>
        <td>货运单号：</td>
        <td>
            <asp:TextBox ID="txtWaybill" runat="server"  MaxLength="50"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ControlToValidate="txtWaybill" ErrorMessage="货运单号不能为空"></asp:RequiredFieldValidator>
        </td>
      </tr>
      
      <tr>
        <td>物流电话： </td>
        <td>
            <asp:TextBox ID="txtExpressTel" runat="server"></asp:TextBox>
        </td>
      </tr>
      <tr>
        <td>留言：</td>
        <td>
            <asp:TextBox ID="txtMsg" runat="server" Height="99px" Width="258px" 
                TextMode="MultiLine"></asp:TextBox>
            <input id="fromurl" name="fromurl" type="hidden" value="<%=fromUrl%>" />
            <input id="dingdan" name="dingdan" type="hidden" value="<%=dingdan%>" />
        </td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text="确认提交" onclick="Button1_Click" />
        </td>
      </tr>
  </table>
  </p>
</form>
</body>
</html>