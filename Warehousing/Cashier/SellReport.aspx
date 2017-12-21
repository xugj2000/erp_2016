<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellReport.aspx.cs" Inherits="Warehousing.Cashier.SellReport" %>
<html><head><title>收银汇总</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="SellReport.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>收银汇总</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="right" bgcolor="#FFFFFF">
            </td>
		</tr>
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            导购员：
        <asp:DropDownList ID="guide_list" runat="server">
          <asp:ListItem Value="">所有导购员</asp:ListItem>
        </asp:DropDownList>    
            
            时间:从<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="80px"></asp:TextBox> 至
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="80px"></asp:TextBox>

            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            </td>
		</tr>   
		<tr align="center">
            <td>收银员</td>
            <td>订单数</td>
			<td>收款金额</td>
            <td>商品总额</td>
            <td>商品件数</td>
            <td>操作</td>
		</tr>
		<asp:Repeater ID="OrderList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#Eval("cashier_name")%></td>
        <td><%#Eval("allCount")%></td>
          <td><%#Eval("all_amount")%></td>
          <td><%#Eval("goods_amount")%></td>
          <td><%#Eval("goods_nums")%></td>
		  <td></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		<tr  bgcolor="#FFFFFF" align="center">
            <td>合计</td>
            <td><%=total_allCount%></td>
			<td><%=total_all_amount%></td>
            <td><%=total_goods_amount%></td>
            <td><%=total_goods_nums%></td>
            <td></td>
		</tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
