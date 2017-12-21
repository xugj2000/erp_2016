<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductPlanDetail.aspx.cs" Inherits="Warehousing.Storage.ProductPlanDetail" %>

<html><head><title>采购计划管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="/js/jquery.validate.js"></script>
<style type="text/css">
.width2,.width3,.width4,.width6{height:30px;line-height:30px;border:solid 1px #CCC;border-bottom:solid 1px #666}
.width2{width:60px;margin:0px;}
.width3{width:80px;margin:0px;}
.width4{width:40px;margin:0px;text-align:center;}
.width6{width:120px;margin:0px;}
.add_link{color:red;margin:4px;display:block}
</style>
</head>
<body>
<form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>采购计划详情</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  供应商名称：</td>
              <td width="86%">
              <%=Warehousing.Business.StorageHelper.getSupplierName(sm_supplierid)%>
               </td>
          </tr>
          <tr>
              <td width="14%">
                  采购类型：</td>
              <td width="86%">
              
              <%=Warehousing.Business.StorageHelper.getPlanTypeText(sm_type)%>
              

               </td>
          </tr>
          <tr>
              <td>
                  税率：</td>
              <td>
              <%=sm_tax%>
              </td>
          </tr>
          <tr>
              <td>
                  采购单号：</td>
              <td>
              <%=sm_sn%>
              </td>
          </tr>
          <tr>
              <td>
                  到货日期：</td>
              <td>
              <%=sm_date %>
              </td>
          </tr>
          <tr>
              <td>
                  跟单员姓名：</td>
              <td>
              <%=sm_operator %>
              </td>
          </tr>
          <tr>
              <td>
                  采购备注:：</td>
              <td>
              <%=sm_remark%>
              </td>
          </tr>
                    <tr>
              <td colspan=2>
<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC" id="mytable">
  <tr bgcolor="#FFFFFF" align="center">
    <td colspan="12">商品清单</td>
  </tr>
  <tr align="center">
    <td>条码</td>
  	<td>名称</td>
    <td>款号</td>
    <td>品牌</td>
    <td>单位</td>
    <td>规格</td>
    <td>型号</td>
    <td>数量</td>
	<td>零售价</td>
    <td>零售额</td>
	<td>采购价</td>
    <td>采购额</td>

  </tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
  <tr bgcolor="#FFFFFF" align="center">
    <td><input type=hidden name="p_id" value='<%#Eval("p_id")%>' /><%#Eval("p_txm")%></td>
  	<td><%#Eval("p_name")%></td>
    <td><%#Eval("p_serial")%></td>
    <td><%#Eval("p_brand")%></td>
    <td><%#Eval("p_unit")%></td>
    <td><%#Eval("p_spec")%></td>
    <td><%#Eval("p_model")%></td>
	<td><%#Eval("p_quantity")%></td>
	<td><%#Eval("p_price")%></td>
    <td><%#Eval("moneyall")%></td>
	<td><%#getInPrice(Eval("p_baseprice"), Eval("p_baseprice_tax"))%></td>
    <td><%#getInPrice(Eval("basemoneyall"), Eval("basemoneyall_tax"))%></td>
  </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="12" align=center>
			</td>
		  </tr>
	</table>
                  </td>
          </tr>
<tr bgcolor="#FFFFFF"<%if (current_sm_status>0){Response.Write("style='display:none;'");} %>> 
<td height="30"  align="left" colspan=2>

                  <asp:DropDownList ID="sm_status" runat="server">
                  <asp:ListItem Text="等待审核" Value="0"></asp:ListItem>
                  <asp:ListItem Text="通过" Value="1"></asp:ListItem>
                  <asp:ListItem Text="作废" Value="2"></asp:ListItem>
                  </asp:DropDownList>

<asp:Button ID="Button1" runat="server" Text=" 审 核 " onclick="Button1_Click" />
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
