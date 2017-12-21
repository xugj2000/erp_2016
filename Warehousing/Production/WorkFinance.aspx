<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkFinance.aspx.cs" Inherits="Warehousing.Production.WorkFinance" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>����⹤�������¼</title>
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
                title: '����Ǽ�',
                top:'30%',
                max: false,
                min: false,
                lock: true,
                content: 'url:/Storage/addFinance.aspx?work_id=' + <%=work_id %> +'&id=' + $(this).attr("data") + '&r=' + (new Date()).toUTCString(),
                ok: false,
                cancelVal: '�ر�',
                cancel: true, /*Ϊtrue�ȼ���function(){}*/
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
<td  align="center"><b><strong>�ӹ�����鿴</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            ������<asp:TextBox ID="pro_txm" runat="server" Width="100px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />

            <button id="paybutton" style="float:right;display:block;width:120px;" data="0" class="DoFinance">����Ǽ�</button>&nbsp;&nbsp;
            </td>
		</tr>   
		<tr align="center">
             <td width=100>��������</td>
              <td width=100>������</td>
			<td width=80>�տ���</td>
            <td width=80>������</td>
            <td width=120>�Ǽ�����</td>
            <td width=80>�Ǽ���</td>
            <td width=40>״̬</td>
            <td>���ע</td>
            <td width=40>����</td>
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
          <td> <a href="#" class="DoFinance" data="<%#Eval("id")%>">�޸�</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="9" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
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
