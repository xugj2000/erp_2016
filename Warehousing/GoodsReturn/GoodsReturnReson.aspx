<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnReson.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnReson" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品管理</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货原因管理</strong></div>
<form id="myform" runat="server">
  <p>
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>返货原因
       
        <asp:TextBox ID="txtTypeName" runat="server" Width="127px"></asp:TextBox> &nbsp; 
            <asp:RadioButtonList ID="rbIsHidden" runat="server" 
                RepeatDirection="Horizontal" RepeatLayout="Flow">
            <asp:ListItem Value="0">启用</asp:ListItem>
            <asp:ListItem Value="1">停用</asp:ListItem>
            </asp:RadioButtonList>
        
            <asp:HiddenField ID="hdTypeId" runat="server" />
            &nbsp;<asp:Button ID="Button1" runat="server" Text="增加原因" OnClick="Button1_Click" />
        </td>
      </tr>
  </table>
  
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE">
    <tr>
      <td bgcolor="#F6F6F6">返货原因</td>
      <td width="19%" align="center" bgcolor="#F6F6F6">启用</td>
      <td width="21%" align="center" bgcolor="#F6F6F6">添加日期</td>
      <td width="12%" align="center" bgcolor="#F6F6F6">操作</td>
    </tr>
      <asp:Repeater ID="GoodsList" runat="server" onitemcommand="GoodsList_ItemCommand">
     <ItemTemplate>
    <tr>
      <td width="48%"><%#Eval("typeName")%></td>
      <td width="19%" align="center"><%#getHiddenText(Eval("isHidden"))%></td>
      <td align="center"><%#Eval("addTime")%></td>
      <td align="center">
          <asp:Button ID="Button2" runat="server" Text="更改" CommandName="edit" CommandArgument='<%#Eval("typeId")%>' /></td>
      </tr>
        </ItemTemplate>
     </asp:Repeater>
  </table>
  </p>
</form>
</body>
</html>
