<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Brandlist.aspx.cs" Inherits="Warehousing.member.Brandlist" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>Ʒ���б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

    <style type="text/css">
        .style1
        {
            width: 9%;
        }
        .style3
        {
            width: 8%;
        }
        .style4
        {
            width: 7%;
        }
        .style5
        {
            width: 11%;
        }
        .style6
        {
            width: 16%;
        }
        .style7
        {
            width: 71px;
        }
        .style8
        {
            width: 10%;
        }
    </style>

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>Ʒ���б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addbrand.aspx">����Ʒ��</a></td>
		</tr>
		<tr align="center">
             <td class="style4">Ʒ��ID</td>
			<td class="style5">Ʒ������</td>
            <td>���ʱ��</td>
            <td class="style1">��ע</td>
			<td class="style4">�Ƿ�����</td>
            <td class="style4">����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF">
        <td><%#Eval("brand_id")%></td>
          <td ><%#Eval("brand_name")%></td>
          <td><%#Eval("add_time")%></td>
           <td><%#Eval("brand_remark")%></td>
           <td><%#Convert.ToInt32(Eval("is_hide")) == 1 ? "����" : "����" %></td>
		  <td><a href="addbrand.aspx?id=<%#Eval("brand_id")%>">�޸�</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="6" align=center>
		  	<form runat="server" id="form1">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="��ҳ" LastPageText="βҳ"
            NextPageText="��һҳ" PrevPageText="��һҳ" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="ҳ" TextBeforePageIndexBox="ת��" OnPageChanging="AspNetPager1_PageChanging"
            PageSize="20" CustomInfoHTML="">
        </webdiyer:AspNetPager>
          </form>
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
				

</body>
</html>
