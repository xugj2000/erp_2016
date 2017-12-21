<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkFinance.aspx.cs" Inherits="Warehousing.Production.WorkFinance" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>出入库工单付款记录</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="javascript" type="text/javascript" src="/js/jquery-1.7.2.min.js"></script>
<script src="/js/lhgdialog.min.js" type="text/javascript" language="javascript"></script>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<link href="/css/igreen.css" rel="stylesheet" type="text/css" /> 
<script>
    $(function () {
        $('.DoFinance').click(function () {
            $.dialog({
                id: 'a15',
                title: '付款登记',
                top:'30%',
                max: false,
                min: false,
                lock: true,
                content: 'url:/Storage/addFinance.aspx?work_id=' + <%=work_id %> +'&id=' + $(this).attr("data") + '&r=' + (new Date()).toUTCString(),
                ok: false,
                cancelVal: '关闭',
                cancel: true, /*为true等价于function(){}*/
                padding: 0
            });
            return false;
        });

    });    
</script>
</head>
<body>
<form runat="server" id="form1" action="WorkFinance.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>加工付款查看</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            工单号<asp:TextBox ID="pro_txm" runat="server" Width="100px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />

            <button id="paybutton" style="float:right;display:block;width:120px;" data="0" class="DoFinance">付款登记</button>&nbsp;&nbsp;
            </td>
		</tr>   
		<tr align="center">
             <td width=100>付款日期</td>
              <td width=100>付款金额</td>
			<td width=80>收款人</td>
            <td width=80>付款人</td>
            <td width=120>登记日期</td>
            <td width=80>登记人</td>
            <td width=40>状态</td>
            <td>付款备注</td>
            <td width=40>操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#Convert.ToDateTime(Eval("pay_date")).ToShortDateString()%></td>
        <td><%#Eval("pay_money")%></td>
          <td><%#Eval("receive_worker")%></td>
          <td><%#Eval("pay_worker")%></td>
          <td><%#Eval("add_time")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("admin_id")))%></td>
          <td><%#getWorkStatusText(Convert.ToInt16(Eval("is_cancel")))%></td>
          <td><%#Eval("remark")%></td>
          <td> <a href="#" class="DoFinance" data="<%#Eval("id")%>">修改</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="9" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductFinance.aspx?page={0}" ShowCustomInfoSection="Left">
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
