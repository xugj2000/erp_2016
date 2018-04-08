<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductDoing.aspx.cs" Inherits="Warehousing.Storage.ProductDoing" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>商品出入库记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="ProductDoing.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>商品出入库记录</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="17" align="right" bgcolor="#FFFFFF">&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="17" align="left" bgcolor="#FFFFFF" style="line-height:25px;">
            出入库单号<asp:TextBox ID="sm_sn" runat="server" Width="80px"></asp:TextBox>
            &nbsp; 
            货号<asp:TextBox ID="p_serial" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            客户<asp:TextBox ID="consumer_name" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            条码<asp:TextBox ID="p_txm" runat="server" Width="80px"></asp:TextBox>
            &nbsp;出入库时间:从<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="60px"></asp:TextBox> 至
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="60px"></asp:TextBox>
            <br />
        <asp:DropDownList ID="sm_direction" runat="server" style="width:60px;">
          <asp:ListItem Value="">出入库</asp:ListItem>
          <asp:ListItem Value="入库">入库</asp:ListItem>
          <asp:ListItem Value="出库">出库</asp:ListItem>
        </asp:DropDownList>
            <asp:DropDownList ID="sm_type" runat="server">
                <asp:ListItem Text="出入库类型" Value=""></asp:ListItem>
                <asp:ListItem Text="采购入库" Value="1"></asp:ListItem>
                <asp:ListItem Text="修补返库" Value="2"></asp:ListItem>
                <asp:ListItem Text="调货入库" Value="3"></asp:ListItem>
                <asp:ListItem Text="生产入库" Value="9"></asp:ListItem>   
                <asp:ListItem Text="其它入库" Value="4"></asp:ListItem>   
                <asp:ListItem Text="库间调货" Value="10"></asp:ListItem>
                <asp:ListItem Text="生产出库" Value="11"></asp:ListItem>
                <asp:ListItem Text="批发出库" Value="12"></asp:ListItem>
                <asp:ListItem Text="加盟供货" Value="13"></asp:ListItem>
                <asp:ListItem Text="零售出库" Value="14"></asp:ListItem>
                <asp:ListItem Text="退货返厂" Value="5"></asp:ListItem>
                <asp:ListItem Text="维修返厂" Value="7"></asp:ListItem>
                <asp:ListItem Text="其它出库" Value="6"></asp:ListItem>
            </asp:DropDownList>
        <asp:DropDownList ID="sm_supplierid" runat="server" style="width:60px;">
          <asp:ListItem Value="">供应商</asp:ListItem>
        </asp:DropDownList>
           <asp:DropDownList ID="warehouse_id" runat="server" style="width:60px;">
           <asp:ListItem Value="">出货仓</asp:ListItem>
            </asp:DropDownList>
            &nbsp;
            <asp:DropDownList ID="to_warehouse_id" runat="server" style="width:60px;">
            <asp:ListItem Value="">目标仓</asp:ListItem>
                  </asp:DropDownList>
             &nbsp;
            <asp:DropDownList ID="sm_status" runat="server" style="width:50px;">
            <asp:ListItem Value="">状态</asp:ListItem>
           <asp:ListItem Value="0">未审</asp:ListItem>
           <asp:ListItem Value="1">已审</asp:ListItem>
           <asp:ListItem Value="2">作废</asp:ListItem>
           <asp:ListItem Value="3">入方待审</asp:ListItem>
           <asp:ListItem Value="4">入方拒绝</asp:ListItem>
            </asp:DropDownList>
            
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" />
            </td>
		</tr>        

		<tr align="center">
                    <th>ID</th>
                    <th class="align1 width2">出库单号</th>
                    <th>出库类型</th>
                    <th>出仓</th>
                    <th>目标仓</th>
                    <th>客户/供应商</th>
                    <th>sku</th>
                    <th>数量</th>
                    <th>总价</th>
                    <th>已结款</th>
					<th>出入货日期</th>
					<th>录入时间</th>
					<th>出入货员</th>
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
           <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id_from")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id_to")))%></td>
          <td align="center"><%#Eval("consumer_name")%>
          <%#Convert.ToInt32(Eval("sm_supplierid"))>0?Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(Eval("sm_supplierid"))):""%>
          
          </td>
           <td align="center"><%#Eval("sku")%></td>
           <td align="center"><%#Convert.ToDouble(Eval("procount"))%></td>
           <td align="center"><%#Convert.ToDouble(Eval("pvolume"))%></td>
           <td align="center"><%# Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.生产出库 && Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.维修返厂 ? Warehousing.Business.StorageHelper.getAlreadyPayMoney(Convert.ToInt32(Eval("sm_id"))).ToString() : "-"%></td>
		  <td><%#Convert.ToDateTime(Eval("sm_date")).ToShortDateString()%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Eval("sm_operator")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("sm_adminid")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getStutusText(Convert.ToInt32(Eval("sm_status")))%>
		  <td>
          <!--
              <a href="addProductOut.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>修改</a>
              &nbsp;<a href="ProductOutOne.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>产品</a>
              &nbsp;<a href="ProductOutDetail.aspx?id=<%#Eval("sm_id")%>">查看</a>
              &nbsp;<a href="ProductFinance.aspx?id=<%#Eval("sm_id")%>" <%# Convert.ToInt32(Eval("sm_type")) == (int)Warehousing.Business.StorageType.生产出库 ? "style='display:none;'" : ""%>>帐务</a>
            -->
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="17" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductDoing.aspx?page={0}">
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