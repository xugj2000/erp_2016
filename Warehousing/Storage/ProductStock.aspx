<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductStock.aspx.cs" Inherits="Warehousing.Storage.ProductStock" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<style>
#pro_supplierid {width:90px;}
#warehouse_id {width:50px;}
</style>
</head>
<body>
<form runat="server" id="form1" action="ProductStock.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品库存查看</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
        <tr align="center">
			<td colspan="16" align="right" bgcolor="#FFFFFF" style="text-align:right">&nbsp;&nbsp;&nbsp;&nbsp;<a href="ProductStockChange.aspx" style="color:red;font-size:16px;text-decoration:underline">库存变动</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="16" align="left" bgcolor="#FFFFFF">
            条码<asp:TextBox ID="pro_txm" runat="server" Width="80px"></asp:TextBox>
            货号<asp:TextBox ID="pro_code" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
            商品名<asp:TextBox ID="pro_name" runat="server" Width="60px"></asp:TextBox>
            &nbsp;
            <%if (my_warehouse_id == 0)
                                                                                                      {%>供应商：<%} %>
        <asp:DropDownList ID="pro_supplierid" runat="server">
          <asp:ListItem Value="">所有供应商</asp:ListItem>
        </asp:DropDownList>        
           <asp:DropDownList ID="warehouse_id" runat="server">
           <asp:ListItem Value="">所有仓库</asp:ListItem>
                  </asp:DropDownList>
            库存:
            <asp:TextBox ID="kc1" runat="server" Width="30px"></asp:TextBox>
            至
            <asp:TextBox ID="kc2" runat="server" Width="30px"></asp:TextBox>
            价格:<asp:TextBox ID="pro_outprice" runat="server" Width="30px"></asp:TextBox>
            至
            <asp:TextBox ID="pro_outprice2" runat="server" Width="30px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>商品名称</td>
            <td>条码</td>
            <td>仓库</td>
          	<td>供应商</td>
		  	<td>规格</td>
			<td>型号</td>
            <td>库存</td>
            <td>在途</td>
            <td style="width:40px;">市场价</td>
            <td style="width:40px;">直营零售价<br />(建议)</td>
            <td style="width:40px;">直营零售价<br />(实价)</td>
            <td style="width:40px;">采购价</td>
            <td style="width:40px;">采购价<br />(带税)</td>
            <td>仓位</td>
            <td> </td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
        <td><%#Eval("pro_id")%></td>
          <td><%#Eval("pro_name")%></td>
          <td><%#Eval("pro_txm")%></td>
         <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td title='<%#Eval("supplierName")%>'><%#Eval("shortSupplierName")%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><a href="editStockPm.aspx?id=<%#Eval("stock_id")%>" style="text-decoration:underline;color:Navy">&nbsp;<%#Convert.ToDouble(Eval("kc_nums"))%>&nbsp;</a></td>
          <td><%#Convert.ToDouble(Eval("do_nums"))%></td>
          <td><%#Convert.ToDouble(Eval("pro_price"))%></td>
          <td><%#Convert.ToDouble(Eval("pro_marketprice"))%></td>
          <td><a href="editStockPrice.aspx?id=<%#Eval("stock_id")%>" style="text-decoration:underline;color:Navy">&nbsp;<%#Convert.ToDouble(Eval("stock_price"))%>&nbsp;</a></td>
           <td><%#dispInPrice(Eval("pro_inprice"))%></td>
           <td><%#dispInPrice(Eval("pro_inprice_tax"))%></td>
           <td><a href="editShelfNo.aspx?id=<%#Eval("stock_id")%>"><%#String.IsNullOrEmpty(Eval("shelf_no").ToString()) ? "<font style='color:#666;font-size:16px'> + </font>" : Eval("shelf_no")%></a></td>
		  <td>
          <a href="ProductStockChange.aspx?pro_id=<%#Eval("pro_id")%>&warehouse_id=<%#Eval("warehouse_id")%>">明细</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="16" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductStock.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
		<tr align="center" bgcolor="#FFFFFF" align="center">
             <td colspan=7>合计</td>
            <td><%=total_kucun%></td>
            <td></td>
            <td></td>
            <td><%//=total_amount%></td>
            <td><%//=total_amount%></td>
            <td><%//=dispInPrice(total_amount_base)%></td>
             <td><%//=dispInPrice(total_amount_base_tax)%></td>
            <td> </td>
            <td> </td>
		</tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
