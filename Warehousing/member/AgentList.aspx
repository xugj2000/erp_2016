<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentList.aspx.cs" Inherits="Warehousing.member.AgentList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>�����б�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

    <style type="text/css">
        .style1
        {
            width: 9%;
        }
        .style4
        {
            width: 7%;
        }
        .style5
        {
            width: 11%;
        }
    </style>

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>�����б�</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="6" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addagent.aspx">��������</a></td>
		</tr>
		<tr align="center">
             <td width=60>����ID</td>
			<td width=200>��������</td>
            <td width=140>���ʱ��</td>
            <td>���˱�ע</td>
			<td width=60>�Ƿ�����</td>
            <td  width=60>����</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF">
        <td><%#Eval("Agent_id")%></td>
          <td><%#Eval("Agent_name")%></td>
          <td><%#Eval("add_time")%></td>
           <td><%#Eval("Agent_remark")%></td>
           <td><%#Convert.ToInt32(Eval("is_hide")) == 1 ? "����" : "����" %></td>
		  <td><a href="addagent.aspx?id=<%#Eval("Agent_id")%>">�޸�</a></td>
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
