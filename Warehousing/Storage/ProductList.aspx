<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductList.aspx.cs" Inherits="Warehousing.Storage.ProductList" %>
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
<form runat="server" id="form1" action="ProductList.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="15" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addproduct.aspx" style="color:red;font-size:16px;text-decoration:underline">新增商品</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="15" align="left" bgcolor="#FFFFFF">
            条码<asp:TextBox ID="pro_txm" runat="server" Width="80px"></asp:TextBox>
            货号<asp:TextBox ID="pro_code" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
            商品名<asp:TextBox ID="pro_name" runat="server" Width="60px"></asp:TextBox>
            &nbsp;
            供应商：
        <asp:DropDownList ID="pro_supplierid" runat="server">
          <asp:ListItem Value="">所有供应商</asp:ListItem>
        </asp:DropDownList>        
            价<asp:TextBox ID="pro_outprice" runat="server" Width="30px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>商品名称</td>
            <td>类别</td>
            <td>货号</td>
            <td>条码</td>
          	<td>供应商</td>
		  	<td>规格</td>
			<td>型号</td>
            <td>市场价</td>
            <td>直营零售价</td>
            <td>一级批发价</td>
            <td>二级批发价</td>
            <td>加盟结算价</td>
            <td>采购价</td>
            
            <td> </td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
        <td><%#Eval("pro_id")%></td>
          <td><%#Eval("pro_name")%></td>
          <td><%#Warehousing.Business.StorageHelper.getTypeName(Convert.ToInt32(Eval("type_id")))%></td>
          <td><%#Eval("pro_code")%></td>
          <td><%#Eval("pro_txm")%></td>
          <td title='<%#Eval("supplierName")%>'><%#Eval("shortSupplierName")%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><%#Convert.ToDouble(Eval("pro_price"))%></td>
          <td><%#Convert.ToDouble(Eval("pro_marketprice"))%></td>
           <td><%#Convert.ToDouble(Eval("pro_outprice_advanced"))%></td>
          <td><%#Convert.ToDouble(Eval("pro_outprice"))%></td>
          <td><%#Convert.ToDouble(Eval("pro_settleprice"))%></td>
          <td><%#dispInPrice(Eval("pro_inprice"))%></td>
		  <td><a href="addproduct.aspx?id=<%#Eval("pm_id")%>">修改</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="15" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductList.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
