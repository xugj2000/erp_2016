<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductIn.aspx.cs" Inherits="Warehousing.Storage.ProductIn" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>商品入库记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="ProductIn.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品入库记录</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="16" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if (my_warehouse_id == 0 || myStorageInfo.is_caigou == 1)
                                                                                                      {%><a href="addproductin.aspx" style="color:red;font-size:16px;text-decoration:underline">新增商品入库</a><%} %>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="16" align="left" bgcolor="#FFFFFF">
            入库单号<asp:TextBox ID="sm_sn" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
            货号<asp:TextBox ID="p_serial" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            条码<asp:TextBox ID="p_txm" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
         <asp:DropDownList ID="sm_type" runat="server">
        <asp:ListItem Text="入库类型" Value=""></asp:ListItem>
        <asp:ListItem Text="采购入库" Value="1"></asp:ListItem>
        <asp:ListItem Text="修补返库" Value="2"></asp:ListItem>
        <asp:ListItem Text="调货入库" Value="3"></asp:ListItem>
        <asp:ListItem Text="生产入库" Value="9"></asp:ListItem>   
        <asp:ListItem Text="其它入库" Value="4"></asp:ListItem>   
         </asp:DropDownList>
        <asp:DropDownList ID="sm_supplierid" runat="server" style="width:60px;">
          <asp:ListItem Value="">供应商</asp:ListItem>
        </asp:DropDownList>
           <asp:DropDownList ID="warehouse_id" runat="server" style="width:50px;">
           <asp:ListItem Value="0">仓库</asp:ListItem>
                  </asp:DropDownList>
            <asp:DropDownList ID="sm_status" runat="server" style="width:50px;">
            <asp:ListItem Value="">状态</asp:ListItem>
           <asp:ListItem Value="0">未审</asp:ListItem>
           <asp:ListItem Value="1">已审</asp:ListItem>
           <asp:ListItem Value="2">作废</asp:ListItem>
           <asp:ListItem Value="3">入方待审</asp:ListItem>
           <asp:ListItem Value="4">入方拒绝</asp:ListItem>
            </asp:DropDownList>

            
            入库时间:从<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="60px"></asp:TextBox> 至
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="60px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>        

		<tr align="center">
                    <th>ID</th>
                    <th class="align1 width2">入库单号</th>
                    <th>入库类型</th>
                    <th>当前仓</th>
                    <th>sku</th>
                    <th>数量</th>
                     <th>总价</th>
                      <th>已结款</th>
                    <th>来源</th>
					<th>到货日期</th>
					<th>录入时间</th>
					<th>收货员</th>
                    <th>操作员</th>
					<th>状态</th>
					<th></th>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
         <td><%#Eval("sm_id")%></td>
          <td align="center"><%#Eval("sm_sn")%></td>
           <td><%#Warehousing.Business.StorageHelper.getTypeText(Convert.ToInt32(Eval("sm_type")))%></td>
           <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
           <td align="center"><%#Eval("sku")%></td>
           <td align="center"><%#Convert.ToDouble(Eval("procount"))%></td>
           <td align="center"><%#Convert.ToDouble(Eval("pvolume"))%></td>
            <td align="center"><%# Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.生产入库 && Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.修补返库 ? Warehousing.Business.StorageHelper.getAlreadyPayMoney(Convert.ToInt32(Eval("sm_id"))).ToString() : "-"%></td>
          <td align="left" style="width:80px;"><%#Warehousing.Business.PublicHelper.subStr(getFromInfo(Eval("sm_supplierid"), Eval("warehouse_id_from")),6)%></td>
		  <td><%#Convert.ToDateTime(Eval("sm_date")).ToShortDateString()%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Eval("sm_operator")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("sm_adminid")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getStutusText(Convert.ToInt32(Eval("sm_status")))%></td>
		  <td><a href="addproductin.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>修改&nbsp;</a>
              <a href="productinone.aspx?id=<%#Eval("sm_id")%>">产品&nbsp;</a>
              <a href="ProductInDetail.aspx?id=<%#Eval("sm_id")%>">查看&nbsp;</a>
              <a href="addProductOut.aspx?outType=10&direct_id=<%#Eval("sm_id")%>" <%#Convert.ToInt32(Eval("sm_status")) != 1||Convert.ToInt32(Eval("is_direct")) != 0 ? "style='display:none;'" : ""%>>转出</a>
              <a href="AddShelfNo.aspx?id=<%#Eval("sm_id")%>">仓位&nbsp;</a>
              &nbsp;<a href="ProductFinance.aspx?id=<%#Eval("sm_id")%>" <%# Convert.ToInt32(Eval("sm_type")) == (int)Warehousing.Business.StorageType.生产入库 ? "style='display:none;'" : ""%>>帐务</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="16" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductIn.aspx?page={0}">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
	</table>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">&nbsp;</td>
</tr>
</table>
</div>
				
</form>
</body>
</html>
