<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductionList.aspx.cs" Inherits="Warehousing.Production.ProductionList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>加工列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script>
    $(function () {
        /* 全选 */
        $('.checkall').click(function () {
            var _self = this;
            $('.checkitem').each(function () {
                if (!this.disabled) {
                    $(this).attr('checked', _self.checked);
                }
            });
            $('.checkall').attr('checked', this.checked);
        });

        $("#Button2").click(function () {
            var selectflag = 0;
            $('.checkitem').each(function () {
                if ($(this).attr('checked') && selectflag == 0) {
                    selectflag = 1;
                }
            });
            if (selectflag == 0) {
                alert("请至少选中一款产品模板！");
                return false;
            }
        });
    });
</script>
</head>
<body>
<form runat="server" id="form1" action="ProductionList.Aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>加工工单列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="17" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                     <a href="Template.Aspx" style="color:red;font-size:16px;text-decoration:underline">新下工单</a>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="17" align="left" bgcolor="#FFFFFF">
             工单号<asp:TextBox ID="work_sn" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
             货号<asp:TextBox ID="pro_code" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
        <asp:DropDownList ID="factory_id" runat="server" style="width:100px;">
          <asp:ListItem Value="">匹配工厂</asp:ListItem>
        </asp:DropDownList>
            <asp:DropDownList ID="work_status" runat="server" style="width:50px;">
           <asp:ListItem Value="">状态</asp:ListItem>
           <asp:ListItem Value="0">待审工单</asp:ListItem>
           <asp:ListItem Value="1">工单确认</asp:ListItem>
           <asp:ListItem Value="3">送厂加工</asp:ListItem>
           <asp:ListItem Value="4">成品返库</asp:ListItem>
           <asp:ListItem Value="8">工单结束</asp:ListItem>
           <asp:ListItem Value="2">作废</asp:ListItem>
            </asp:DropDownList>
           <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />

           <span style="display:block;float:right;margin-right:40px;">
           <a href="WorkingCart.Aspx">预选</a>
           </span>

           
            </td>
		</tr>        
		<tr align="center">
                    <th>ID</th>
                    <th>工单编号</th>
                    <th>工厂</th>
                    <th>工厂负责</th>
                    <th>我方负责</th>
                    <th>开始时间<br />~预交日期</th>
                    <th>成衣款号</th>
                    <th>计划数</th>
                    <th>已交数</th>
                    <th>未交数</th>
                    <th>应付款</th>
                    <th>已付款</th>
                    <th>差欠款</th>
					<th style="width:70px;">录入时间</th>
                    <th>操作员</th>
					<th>状态</th>
					<th></th>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
         <td><%#Eval("work_id")%></td>
          <td align="center"><%#Eval("work_sn")%></td>
          <td><%#Warehousing.Business.ProductionHelper.getFactoryName(Convert.ToInt32(Eval("factory_id")))%></td>
          <td align="center"><%#Eval("factory_manager")%></td>
          <td align="center"><%#Eval("our_manager")%></td>
           <td align="center"><%#Convert.ToDateTime(Eval("start_date")).ToShortDateString()%><br />~<%#Convert.ToDateTime(Eval("end_date")).ToShortDateString()%></td>
           <td><%#Eval("pcode")%></td>
           <td><%#Convert.ToDouble(Eval("pquantity"))%></td>
           <td><%#Convert.ToDouble(Eval("receivedNum"))%></td>
           <td><%#Convert.ToDouble(Eval("doingNum"))%></td>
           <td><%#Convert.ToDouble(Eval("needPayMoney"))%></td>
           <td><%#Convert.ToDouble(Eval("AlreadyPayMoney"))%></td>
           <td><%#Convert.ToDouble(Eval("willPayMoney"))%></td>
		  <td style="width:70px;"><%#Eval("add_time")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("operator_id")))%></td>
          <td><%#Warehousing.Business.ProductionHelper.getWorkStatusText(Convert.ToInt32(Eval("work_status")))%></td>
		  <td><a href="WorkingCart.Aspx?work_id=<%#Eval("work_id")%>" <%#getStyletext(Convert.ToInt32(Eval("work_status")))%>>修改&nbsp;</a>
              <a href="WorkingDetail.aspx?work_id=<%#Eval("work_id")%>">查看&nbsp;</a>
              <a href="ReturnProductIn.aspx?work_id=<%#Eval("work_id")%>" <%#getStyletext2(Convert.ToInt32(Eval("work_status")))%>>入库&nbsp;</a>
              &nbsp;<a href="WorkFinance.aspx?id=<%#Eval("work_id")%>">帐务</a>
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
                    UrlRewritePattern="ProductionList.Aspx?page={0}">
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
