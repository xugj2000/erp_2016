<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductIn.aspx.cs" Inherits="Warehousing.Storage.ProductIn" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ����¼</title>
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
<td  align="center"><b><strong>��Ʒ����¼</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="16" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%if (my_warehouse_id == 0 || myStorageInfo.is_caigou == 1)
                                                                                                      {%><a href="addproductin.aspx" style="color:red;font-size:16px;text-decoration:underline">������Ʒ���</a><%} %>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="16" align="left" bgcolor="#FFFFFF">
            ��ⵥ��<asp:TextBox ID="sm_sn" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
            ����<asp:TextBox ID="p_serial" runat="server" Width="70px"></asp:TextBox>
            &nbsp;
            ����<asp:TextBox ID="p_txm" runat="server" Width="80px"></asp:TextBox>
            &nbsp;
         <asp:DropDownList ID="sm_type" runat="server">
        <asp:ListItem Text="�������" Value=""></asp:ListItem>
        <asp:ListItem Text="�ɹ����" Value="1"></asp:ListItem>
        <asp:ListItem Text="�޲�����" Value="2"></asp:ListItem>
        <asp:ListItem Text="�������" Value="3"></asp:ListItem>
        <asp:ListItem Text="�������" Value="9"></asp:ListItem>   
        <asp:ListItem Text="�������" Value="4"></asp:ListItem>   
         </asp:DropDownList>
        <asp:DropDownList ID="sm_supplierid" runat="server" style="width:60px;">
          <asp:ListItem Value="">��Ӧ��</asp:ListItem>
        </asp:DropDownList>
           <asp:DropDownList ID="warehouse_id" runat="server" style="width:50px;">
           <asp:ListItem Value="0">�ֿ�</asp:ListItem>
                  </asp:DropDownList>
            <asp:DropDownList ID="sm_status" runat="server" style="width:50px;">
            <asp:ListItem Value="">״̬</asp:ListItem>
           <asp:ListItem Value="0">δ��</asp:ListItem>
           <asp:ListItem Value="1">����</asp:ListItem>
           <asp:ListItem Value="2">����</asp:ListItem>
           <asp:ListItem Value="3">�뷽����</asp:ListItem>
           <asp:ListItem Value="4">�뷽�ܾ�</asp:ListItem>
            </asp:DropDownList>

            
            ���ʱ��:��<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="60px"></asp:TextBox> ��
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="60px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="����" onclick="Button4_Click" />
            </td>
		</tr>        

		<tr align="center">
                    <th>ID</th>
                    <th class="align1 width2">��ⵥ��</th>
                    <th>�������</th>
                    <th>��ǰ��</th>
                    <th>sku</th>
                    <th>����</th>
                     <th>�ܼ�</th>
                      <th>�ѽ��</th>
                    <th>��Դ</th>
					<th>��������</th>
					<th>¼��ʱ��</th>
					<th>�ջ�Ա</th>
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
           <td align="center"><%#Eval("sku")%></td>
           <td align="center"><%#Convert.ToDouble(Eval("procount"))%></td>
           <td align="center"><%#Convert.ToDouble(Eval("pvolume"))%></td>
            <td align="center"><%# Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.������� && Convert.ToInt32(Eval("sm_type")) != (int)Warehousing.Business.StorageType.�޲����� ? Warehousing.Business.StorageHelper.getAlreadyPayMoney(Convert.ToInt32(Eval("sm_id"))).ToString() : "-"%></td>
          <td align="left" style="width:80px;"><%#Warehousing.Business.PublicHelper.subStr(getFromInfo(Eval("sm_supplierid"), Eval("warehouse_id_from")),6)%></td>
		  <td><%#Convert.ToDateTime(Eval("sm_date")).ToShortDateString()%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Eval("sm_operator")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("sm_adminid")))%></td>
          <td><%#Warehousing.Business.StorageHelper.getStutusText(Convert.ToInt32(Eval("sm_status")))%></td>
		  <td><a href="addproductin.aspx?id=<%#Eval("sm_id")%>" <%#getStyletext(Convert.ToInt32(Eval("sm_status")))%>>�޸�&nbsp;</a>
              <a href="productinone.aspx?id=<%#Eval("sm_id")%>">��Ʒ&nbsp;</a>
              <a href="ProductInDetail.aspx?id=<%#Eval("sm_id")%>">�鿴&nbsp;</a>
              <a href="addProductOut.aspx?outType=10&direct_id=<%#Eval("sm_id")%>" <%#Convert.ToInt32(Eval("sm_status")) != 1||Convert.ToInt32(Eval("is_direct")) != 0 ? "style='display:none;'" : ""%>>ת��</a>
              <a href="AddShelfNo.aspx?id=<%#Eval("sm_id")%>">��λ&nbsp;</a>
              &nbsp;<a href="ProductFinance.aspx?id=<%#Eval("sm_id")%>" <%# Convert.ToInt32(Eval("sm_type")) == (int)Warehousing.Business.StorageType.������� ? "style='display:none;'" : ""%>>����</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="16" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
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
