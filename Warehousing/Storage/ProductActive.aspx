<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductActive.aspx.cs" Inherits="Warehousing.Storage.ProductActive" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>��Ʒ�б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<SCRIPT language="javascript" type=text/javascript src="/js/jquery.js"></SCRIPT>
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script>
    $(function () {
        //$("#pro_supplierid_span").css("display", "<%=pro_supplierid_span_css%>");
        $("#to_warehouse_id_span").css("display", "<%=to_warehouse_id_span_css%>");
        $("#direction").change(function () {
            $value = $(this).val();
            if ($value == "���") {
               // $("#pro_supplierid_span").css("display", "inline");
                $("#to_warehouse_id_span").css("display", "none");
            }
            if ($value == "����") {
               // $("#pro_supplierid_span").css("display", "none");
                $("#to_warehouse_id_span").css("display", "inline");
            }
            if ($value == "") {
               // $("#pro_supplierid_span").css("display", "none");
                $("#to_warehouse_id_span").css("display", "none");
            }
        });

    });

</script>
<style>
#pro_supplierid {width:90px;}
#warehouse_id {width:50px;}
</style>
</head>
<body>
<form runat="server" id="form1" action="ProductActive.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ʒ�����ͳ��</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="11" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" style="color:red;font-size:16px;text-decoration:underline">��������</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="11" align="left" bgcolor="#FFFFFF">
            ����<asp:TextBox ID="pro_txm" runat="server" Width="80px"></asp:TextBox>
            ����<asp:TextBox ID="pro_code" runat="server" Width="60px"></asp:TextBox>
            &nbsp;
        <asp:DropDownList ID="direction" runat="server">
           <asp:ListItem Value="">�����</asp:ListItem>
           <asp:ListItem Value="���">���</asp:ListItem>
           <asp:ListItem Value="����">����</asp:ListItem>
           <asp:ListItem Value="�ɹ����">�ɹ����</asp:ListItem>
        </asp:DropDownList>

         <asp:DropDownList ID="warehouse_id" runat="server" style="width:60px;">
           <asp:ListItem Value="">��ǰ��</asp:ListItem>
         </asp:DropDownList>
         <span style="display:inline;" id="pro_supplierid_span">
        <asp:DropDownList ID="pro_supplierid" runat="server" style="width:80px;">
          <asp:ListItem Value="">��Ӧ��</asp:ListItem>
        </asp:DropDownList>   
        </span>
        <span style="display:none;" id="to_warehouse_id_span">
            <asp:DropDownList ID="to_warehouse_id" runat="server" style="width:60px;">
            <asp:ListItem Value="">Ŀ���</asp:ListItem>
           </asp:DropDownList>
        </span>
        �ͻ�<asp:TextBox ID="consumer_name" runat="server" Width="60px"></asp:TextBox>
            <asp:DropDownList ID="sm_status" runat="server">
           <asp:ListItem Value="1">����</asp:ListItem>
           <asp:ListItem Value="0">δ��</asp:ListItem>
            </asp:DropDownList>
            �������:��<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="70px"></asp:TextBox> ��
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="70px"></asp:TextBox>

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
          	<td>��Ӧ��</td>
		  	<td>���</td>
			<td>�ͺ�</td>
			<td>����</td>
            <td>���ۼ�</td>
            <td>���۶�</td>
            <td>�ɹ���</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#(currentPage-1)*AspNetPager1.PageSize+Container.ItemIndex + 1%> </td>
         <td><%#Eval("pro_name")%></td>
         <td><%#Eval("pro_code")%></td>
          <td><%#Eval("txm")%></td>
          <td title='<%#Eval("supplierName")%>'><%#Eval("shortSupplierName")%></td>
		  <td><%#Eval("pro_spec")%></td>
		  <td><%#Eval("pro_model")%></td>
          <td><%#Eval("pcount")%></td>
          <td><%#Eval("pro_outprice")%></td>
          <td><%#Convert.ToDouble(Eval("pcount")) * Convert.ToDouble(Eval("pro_outprice"))%></td>
		  <td><%#getInPrice(Eval("pro_inprice"))%></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="11" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��"
            PageSize="20" CustomInfoHTML="��%CurrentPageIndex%ҳ����%PageCount%ҳ��ÿҳ%PageSize%��,��%RecordCount%��¼" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="ProductActive.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
        <tr bgcolor="#FFFFFF" align="center">
        <td colspan=7>�ϼ�</td>
          <td><%=totalCount%></td>
          <td> </td>
          <td><%=totalSales%></td>
		  <td><%=getInPrice(totalSales_in)%></td>
           
          </tr>
          
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
