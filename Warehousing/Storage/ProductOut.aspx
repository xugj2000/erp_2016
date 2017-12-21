<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductOut.aspx.cs" Inherits="Warehousing.Storage.ProductOut" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ�����¼</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="ProductOut.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ�����¼</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="17" align="right" bgcolor="#FFFFFF"><a href="addProductOutType.aspx" style="color:red;font-size:16px;text-decoration:underline">������Ʒ����</a>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="17" align="left" bgcolor="#FFFFFF" style="line-height:25px;">
            ���ⵥ��<asp:TextBox ID="sm_sn" runat="server" Width="80px"></asp:TextBox>
            &nbsp; 
            ����<asp:TextBox ID="p_serial" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            �ͻ�<asp:TextBox ID="consumer_name" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            ����<asp:TextBox ID="p_txm" runat="server" Width="80px"></asp:TextBox>
            &nbsp;����ʱ��:��<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="60px"></asp:TextBox> ��
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="60px"></asp:TextBox>
            <br />
            <asp:DropDownList ID="sm_type" runat="server">
                <asp:ListItem Text="��������" Value=""></asp:ListItem>
                <asp:ListItem Text="������" Value="10"></asp:ListItem>
                <asp:ListItem Text="��������" Value="11"></asp:ListItem>
                <asp:ListItem Text="��������" Value="12"></asp:ListItem>
                <asp:ListItem Text="���˹���" Value="13"></asp:ListItem>
                <asp:ListItem Text="���۳���" Value="14"></asp:ListItem>
                <asp:ListItem Text="�˻�����" Value="5"></asp:ListItem>
                <asp:ListItem Text="ά�޷���" Value="7"></asp:ListItem>
                <asp:ListItem Text="��������" Value="6"></asp:ListItem>
            </asp:DropDownList>
        <asp:DropDownList ID="sm_supplierid" runat="server" style="width:60px;">
          <asp:ListItem Value="">��Ӧ��</asp:ListItem>
        </asp:DropDownList>
           <asp:DropDownList ID="warehouse_id" runat="server" style="width:60px;">
           <asp:ListItem Value="">������</asp:ListItem>
            </asp:DropDownList>
            &nbsp;
            <asp:DropDownList ID="to_warehouse_id" runat="server" style="width:60px;">
            <asp:ListItem Value="">Ŀ���</asp:ListItem>
                  </asp:DropDownList>
             &nbsp;
            <asp:DropDownList ID="sm_status" runat="server" style="width:50px;">
            <asp:ListItem Value="">״̬</asp:ListItem>
           <asp:ListItem Value="0">δ��</asp:ListItem>
           <asp:ListItem Value="1">����</asp:ListItem>
           <asp:ListItem Value="2">����</asp:ListItem>
           <asp:ListItem Value="3">�뷽����</asp:ListItem>
           <asp:ListItem Value="4">�뷽�ܾ�</asp:ListItem>
            </asp:DropDownList>
            
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="����" onclick="Button4_Click" />
            </td>
		</tr>        

		<tr align="center">
                    <th>ID</th>
                    <th class="align1 width2">���ⵥ��</th>
                    <th>��������</th>
                    <th>����</th>
                    <th>Ŀ���</th>
                    <th>�ͻ�/��Ӧ��</th>
                    <th>sku</th>
                    <th>����</th>
                    <th>�ܼ�</th>
                    <th>�ѽ��</th>
					<th>��������</th>
					<th>¼��ʱ��</th>
					<th>����Ա</th>
                    <th>����Ա</th>
					<th>״̬</th>
					<th></th>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
         <td><%#Eval("sm_id")%></td>
          <td align="center"><%#Eval("sm_sn")%></td>
           <td><%#Warehousing.Business.StorageHelper.getTypeText(Convert.ToInt32(Eval("sm_type")))%></td>
           <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getWarehouseName(Convert.ToInt32(Eval("warehouse_id_to")))%></td>
          <td align="center"><%#Eval("consumer_name")%>
          <%#Convert.ToInt32(Eval("sm_supplierid"))>0?Warehousing.Business.StorageHelper.getSupplierName(Convert.ToInt32(Eval("sm_supplierid"))):""%>
          
          </td>
           <td align="center"><%#Eval("sku")%></td>
           <td align="center"><%#Convert.ToDouble(Eval("procount"))%></td>
           <td align="center"><%#Convert.ToDouble(Eval("pvolume"))%></td>
           <td align="center"><%# Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.�������� && Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.ά�޷��� ? Warehousing.Business.StorageHelper.getAlreadyPayMoney(Convert.ToInt32(Eval("sm_id"))).ToString() : "-"%></td>
		  <td><%#Convert.ToDateTime(Eval("sm_date")).ToShortDateString()%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Eval("sm_operator")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("sm_adminid")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getStutusText(Convert.ToInt32(Eval("sm_status")))%>
		  <td>
              <a href="addProductOut.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>�޸�</a>
              &nbsp;<a href="ProductOutOne.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>��Ʒ</a>
              &nbsp;<a href="ProductOutDetail.aspx?id=<%#Eval("sm_id")%>">�鿴</a>
              &nbsp;<a href="ProductFinance.aspx?id=<%#Eval("sm_id")%>" <%# Convert.ToInt32(Eval("sm_type")) == (int)Warehousing.Business.StorageType.�������� ? "style='display:none;'" : ""%>>����</a>
              &nbsp;<a href="ProductReturn.aspx?return_id=<%#Eval("sm_id")%>" <%# Convert.ToInt32(Eval("sm_type")) == (int)Warehousing.Business.StorageType.�������� ? "style='display:none;'" : ""%>>�˻�</a>
            <a href="addProductOut.aspx?direct_id=<%#Eval("sm_id")%>&outType=<%#Eval("sm_type")%>" <%#Convert.ToInt32(Eval("sm_status")) != 2 ? "style='display:none;'" : ""%>>�س�</a>
            
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="17" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductOut.aspx?page={0}">
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
