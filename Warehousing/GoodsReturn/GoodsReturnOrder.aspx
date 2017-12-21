<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnOrder.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnOrder" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品管理</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
</head>
<script src="../js/jquery.js"></script>
<script src="../js/js.js"></script>
<script>
$(function(){
$('#selectAll').click(function(){
var thischeck=$(this).attr("checked");
$("[name='id']").each(function(){
$(this).attr("checked",thischeck);
});

});
});
</script>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货订单管理</strong></div>
<form id="myform" runat="server">
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>代理ID：</td>
        <td><asp:TextBox ID="txtAgentId" runat="server" Width="108px"></asp:TextBox></td>
		        <td>返货订单号： </td>
        <td>
            <asp:TextBox ID="txtOrderId" runat="server" Width="127px"></asp:TextBox>        </td>
        <td>订单状态：</td>
        <td><asp:DropDownList ID="ddStatus" runat="server">
          <asp:ListItem Value="0">所有订单</asp:ListItem>
        </asp:DropDownList></td>
        <td><asp:Button ID="Button1" runat="server" Text="订单查找" OnClick="Button1_Click" /></td>
        <td>&nbsp;</td>
      </tr>
  </table>
  <br />
  <table width="780" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#EEEEEE">
      <asp:Repeater ID="OrderList" runat="server" onitemdatabound="OrderList_ItemDataBound" >
     <ItemTemplate>
    <tr>
      <td bgcolor="#F6F6F6"><%#Eval("OrderId")%></td>
      <td bgcolor="#F6F6F6"><%#Eval("AddTime")%></td>
      <td bgcolor="#F6F6F6"><%#Eval("DeliverTime")%></td>
      <td bgcolor="#F6F6F6"><%#Eval("AgentId")%></td>
      <td bgcolor="#F6F6F6"><%#Eval("ReveivedName")%>(收)</td>
      <td bgcolor="#F6F6F6"><%#Eval("province")%>-<%#Eval("city")%>-<%#Eval("xian")%>-<%#Eval("PostAddress")%></td>
      <td bgcolor="#F6F6F6"><%#Warehousing.Business.GoodsReturnHelper.getOrderStutusText(Convert.ToInt32(Eval("OrderStatus")))%></td>
      <td>
          <input id="Button1" type="button" value="处理" onclick="location.href='GoodsReturnDetail.aspx?orderid=<%#Eval("OrderId")%>&url=<%=thisUrl%>'" /></td>
      </tr>

    <tr>
      <td colspan="8"><table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
        <tr>
          <td width="14%" bgcolor="#F6F6F6">序号</td>
          <td width="33%" bgcolor="#F6F6F6">商品名称</td>
          <td width="12%" bgcolor="#F6F6F6">订购数量</td>
          <td width="41%" bgcolor="#F6F6F6">条形码</td>
        </tr>
          <asp:Repeater ID="OrderDetail" runat="server">
         <ItemTemplate>
                <tr>
				<td bgcolor="#FFFFFF"><%#Eval("sortid")%></td>
          <td bgcolor="#FFFFFF"><a href="javascript:openWin('GoodsDetail.aspx?id=<%#Eval("ID")%>',600,400)"><%#Eval("ProductName")%></a><%#Warehousing.Business.GoodsReturnHelper.checkIsChange(Eval("ChangeFlag"))%></td>
          <td bgcolor="#FFFFFF"><%#Eval("ProductCount")%></td>
          <td bgcolor="#FFFFFF"><%#Eval("ProductTxm")%></td>
                </tr>
        </ItemTemplate>
         </asp:Repeater>
      </table></td>
    </tr>
    <tr><td colspan="8"></td></tr>
        </ItemTemplate>
     </asp:Repeater>
    <tr>
      <td colspan="8"><webdiyer:aspnetpager ID="Pager" FirstPageText="[首页]" LastPageText="[末页]" NextPageText="[下一页]" PrevPageText="[上一页]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="每页[%PageSize%]条  第[%CurrentPageIndex%]页/共[%PageCount%]页" 
                runat="server" PageSize="20" 
              EnableUrlRewriting="True" UrlPaging="True" UrlRewritePattern="GoodsReturnAdd.aspx?page={0}">
          </webdiyer:aspnetpager></td>
    </tr>
  </table>
</form>
</body>
</html>
