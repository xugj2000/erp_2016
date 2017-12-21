<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductEdit.aspx.cs" Inherits="Warehousing.Storage.ProductEdit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>本仓商品浏览</title>
        
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script src="../js/tjsetday.js" type="text/javascript"></script>
<script src="../js/js.js" type="text/javascript"></script>

</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>商品编辑</strong></div>
    <form id="form1" runat="server">
    <div>
    <br />
    <br />
  <table width="500" border="0" align="center" cellpadding="5" cellspacing="0" style="margin-left:5px;">
  	  <tr>
        <td width="124">商品名称:</td>
        <td width="356">&nbsp;<asp:Label ID="lbProductName" runat="server" Text="Label"></asp:Label>
                    </td>
      </tr>
      <tr>
        <td>样式名称:</td>
        <td>&nbsp;<asp:Label ID="lbStyleName" runat="server" Text="Label"></asp:Label>
                    </td>
      </tr>
      <tr>
        <td>条形码:</td>
        <td>&nbsp;<asp:TextBox 
                ID="txtTxm" runat="server"></asp:TextBox>
                    </td>
      </tr>
      
      
      <tr>
        <td>货架号:</td>
        <td>&nbsp;<asp:TextBox 
                ID="txtShelfNo" runat="server"></asp:TextBox><span style="font-size:12px; color:#F00;">*</span>
                    </td>
      </tr>
      
      
      <tr>
        <td>&nbsp;</td>
        <td>
            <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />&nbsp;
                    <input id="Button2" type="button" value=" 返 回 " onclick="history.back();" /></td>
      </tr>
  </table>

    </div>
    </form>
</body>
</html>