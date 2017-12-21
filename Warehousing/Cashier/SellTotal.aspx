<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SellTotal.aspx.cs" Inherits="Warehousing.Cashier.SellTotal" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<style>
#pro_supplierid {width:90px;}
#warehouse_id {width:50px;}
</style>
</head>
<body>
<form runat="server" id="form1" action="SellTotal.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ�����б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            ����<asp:TextBox ID="pro_txm" runat="server" Width="80px"></asp:TextBox>
            ��Ʒ��<asp:TextBox ID="pro_name" runat="server" Width="60px"></asp:TextBox>
            ��Ʒ����<asp:DropDownList ID="type_id" runat="server">
           <asp:ListItem Value="0">�������</asp:ListItem>
                  </asp:DropDownList>
            &nbsp;
            ����:��<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="91px"></asp:TextBox> ��
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="83px"></asp:TextBox>
           <asp:DropDownList ID="DD_GroupBy" runat="server">
           <asp:ListItem Value="txm">������</asp:ListItem>
           <asp:ListItem Value="huohao">������</asp:ListItem>
                  </asp:DropDownList>
            <asp:Button ID="Button1" runat="server" Text="����" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="����" onclick="Button4_Click" />
            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>��Ʒ����</td>
            <td>����</td>
            <td>����</td>
		  	<td>���</td>
			<td>�ͺ�</td>
			<td>��������</td>
            <td>���˻���</td>
            <td>���ۼ�</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#(currentPage - 1) * AspNetPager1.PageSize + Container.ItemIndex + 1%> </td>
         <td><%#Eval("pro_name")%></td>
         <td><%#Eval("pro_code")%></td>
          <td><%#Eval("txm")%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><%#Eval("pcount")%></td>
          <td><%#Eval("return_count")%></td>
          <td><%#Eval("danjia")%></td>
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
                    UrlRewritePattern="SellTotal.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
        <tr bgcolor="#FFFFFF" align="center">
        <td colspan=6>�ϼ�</td>
          <td><%=totalCount%></td>
          <td><%=totalCount_return%></td>
          <td><%=totalSales%></td>
          </tr>
          
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
