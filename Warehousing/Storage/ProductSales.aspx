<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductSales.aspx.cs" Inherits="Warehousing.Storage.ProductSales" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>商品列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<style>
#pro_supplierid {width:90px;}
#warehouse_id {width:50px;}
</style>
</head>
<body>
<form runat="server" id="form1" action="ProductSales.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品销售列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="11" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" style="color:red;font-size:16px;text-decoration:underline">销售汇总</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="11" align="left" bgcolor="#FFFFFF">
            条码<asp:TextBox ID="pro_txm" runat="server" Width="80px"></asp:TextBox>
            商品名<asp:TextBox ID="pro_name" runat="server" Width="60px"></asp:TextBox>
            商品分类<asp:DropDownList ID="type_id" runat="server">
           <asp:ListItem Value="0">所有类别</asp:ListItem>
                  </asp:DropDownList>
            &nbsp;
            <%if (my_warehouse_id == 0)
                                                                                                      {%>供应商：<%} %>
        <asp:DropDownList ID="pro_supplierid" runat="server">
          <asp:ListItem Value="">所有供应商</asp:ListItem>
        </asp:DropDownList>   
           <asp:DropDownList ID="warehouse_id" runat="server">
           <asp:ListItem Value="">所有仓库</asp:ListItem>
                  </asp:DropDownList>
            日期:从<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="91px"></asp:TextBox> 至
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="83px"></asp:TextBox>
           <asp:DropDownList ID="DD_GroupBy" runat="server">
           <asp:ListItem Value="txm">按条码</asp:ListItem>
           <asp:ListItem Value="huohao">按货号</asp:ListItem>
                  </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>商品名称</td>
            <td>货号</td>
            <td>条码</td>
          	<td>供应商</td>
		  	<td>规格</td>
			<td>型号</td>
			<td>销售数量</td>
            <td>涉退换数</td>
            <td>零售价</td>
            <td>采购价</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#(currentPage - 1) * AspNetPager1.PageSize + Container.ItemIndex + 1%> </td>
         <td><%#Eval("pro_name")%></td>
         <td><%#Eval("pro_code")%></td>
          <td><%#Eval("txm")%></td>
          <td title='<%#Eval("supplierName")%>'><%#Eval("shortSupplierName")%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><%#Eval("pcount")%></td>
          <td><%#Eval("return_count")%></td>
          <td><%#Eval("danjia")%></td>
		  <td><%#getInPrice(Eval("pro_inprice"))%></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="11" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductSales.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
        <tr bgcolor="#FFFFFF" align="center">
        <td colspan=7>合计</td>
          <td><%=totalCount%></td>
          <td><%=totalCount_return%></td>
          <td><%=totalSales%></td>
		  <td><%=totalSales_in%></td>
           
          </tr>
          
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
