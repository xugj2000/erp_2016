<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="changerole.aspx.cs" Inherits="Warehousing.member.changerole" %>
<html><head><title>��Ա����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 


</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>��Ա����</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  ����Ա���ţ�</td>
              <td width="86%"><%=memberLoginName%> </td>
          </tr>
          <tr>
              <td>
                  ����Ա������</td>
              <td><%=memberfullname%> 
              </td>
          </tr>
          <tr>
              <td>
                  ������ɫ</td>
              <td>
                  <asp:DropDownList ID="RoleList" runat="server">
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" �� �� " onclick="Button1_Click" />
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
