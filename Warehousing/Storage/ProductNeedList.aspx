<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductNeedList.aspx.cs" Inherits="Warehousing.Storage.ProductNeedList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ�����¼</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="ProductNeedList.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ�����¼</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="12" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addProductNeed.aspx" style="color:red;font-size:16px;text-decoration:underline">�������</a>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="12" align="left" bgcolor="#FFFFFF">
            ���뵥��<asp:TextBox ID="sm_sn" runat="server" Width="80px"></asp:TextBox>
            &nbsp; 
            ����<asp:TextBox ID="p_serial" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            ����<asp:TextBox ID="p_txm" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
            ������
           <asp:DropDownList ID="warehouse_id_from" runat="server" style="width:60px;">
           <asp:ListItem Value="">��ѡ��</asp:ListItem>
            </asp:DropDownList>
            ���������
           <asp:DropDownList ID="warehouse_id_base" runat="server" style="width:60px;">
           <asp:ListItem Value="">��ѡ��</asp:ListItem>
            </asp:DropDownList>
            ����ʱ��:��<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="60px"></asp:TextBox> ��
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="60px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            
            </td>
		</tr>        

		<tr align="center">
                    <th>ID</th>
                    <th class="align1 width2">���뵥��</th>
                    <th>���뱾��</th>
                    <th>������</th>
                    <th>sku</th>
                    <th>��Ʒ����</th>
					<th>��������</th>
					<th>¼��ʱ��</th>
					<th>����Ա</th>
					<th>״̬</th>
					<th></th>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
         <td><%#Eval("sm_id")%></td>
          <td align="center"><%#Eval("sm_sn")%></td>
           <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id_from")))%></td>
           <td align="center"><%#Eval("sku")%></td>
           <td align="center"><%#Eval("procount")%></td>
		  <td><%#Convert.ToDateTime(Eval("sm_date")).ToShortDateString()%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Eval("sm_operator")%></td>
          <td><%#Warehousing.Business.StorageHelper.getStutusText(Convert.ToInt32(Eval("sm_status")))%>
		  <td>
              <a href="addProductNeed.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>�޸�</a>
              &nbsp;<a href="ProductNeedOne.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>��Ʒ</a>
              &nbsp;<a href="ProductNeedDetail.aspx?id=<%#Eval("sm_id")%>">�鿴</a>
              &nbsp;<a href="addProductOut.aspx?outType=10&apply_id=<%#Eval("sm_id")%>" <%#getPeihuotext(Eval("sm_status"),Eval("warehouse_id_from"))%>>���</a>
              
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="12" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductNeedList.aspx?page={0}">
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
