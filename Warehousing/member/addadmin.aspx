<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addadmin.aspx.cs" Inherits="Warehousing.member.addadmin" %>
<html><head><title>人员管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 


</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>人员管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  管理员工号：</td>
              <td width="86%">
              <asp:TextBox ID="TextLoginName" runat="server" Width="238px"></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td>
                  管理员姓名：</td>
              <td>
              <asp:TextBox ID="Textfullname" runat="server" Width="238px"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  管理员密码：</td>
              <td>
              <asp:TextBox ID="TextLoginPwd" runat="server" Width="238px" TextMode="Password"></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  所属仓库</td>
              <td>
                  <asp:DropDownList ID="WarehouseList" runat="server">
                  <asp:ListItem Text="所有仓" Value="0"></asp:ListItem>
                  </asp:DropDownList>
              </td>
          </tr>
          <tr>
              <td>
                  所属角色</td>
              <td>
                  <asp:DropDownList ID="RoleList" runat="server">
                  </asp:DropDownList>
              </td>
          </tr>
                    <tr>
              <td width="14%">
                  是否锁定：</td>
              <td width="86%">
                  是<input type="radio" name="IsLock" value="1"<%if (IsLock=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="IsLock" value="0"<%if (IsLock!="1"){Response.Write(" checked");} %>/></td>
          </tr>
          <tr>
              <td class="style2">&nbsp;
              </td>
                            <td>
                                <asp:Button ID="Button1" runat="server" Text=" 提 交 " onclick="Button1_Click" />
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
