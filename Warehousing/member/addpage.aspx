<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addpage.aspx.cs" Inherits="Warehousing.member.addpage" %>
<html><head><title>分组编辑</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 


</head>
<body>
    <form id="form1" runat="server">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>模块编辑</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  模块名称：</td>
              <td width="86%">
                  <asp:TextBox ID="TextModuleName" runat="server" Width="238px"></asp:TextBox>
                            </td>
          </tr>
          <tr>
              <td width="14%">
                  页面地址：</td>
              <td width="86%">
                  <asp:TextBox ID="TextPageUrl" runat="server" Width="238px"></asp:TextBox>
                            </td>
          </tr>
          <tr>
              <td>
                  模块描述：</td>
              <td>

                  <asp:TextBox ID="TextModuleDesc" runat="server" Height="72px" Width="239px" 
                      TextMode="MultiLine"></asp:TextBox>
              </td>
          </tr>
                    <tr>
              <td width="14%">
                  序号：</td>
              <td width="86%">
                  <asp:TextBox ID="TextOrderNum" runat="server" Width="238px"></asp:TextBox>
                            </td>
          </tr>
                    <tr>
              <td width="14%">
                  是否菜单：</td>
              <td width="86%">
                  是<input type="radio" name="isShow" value="1"<%if (IsShow=="1"){Response.Write(" checked");} %>/> &nbsp;&nbsp;否<input type="radio" name="isShow" value="0"<%if (IsShow!="1"){Response.Write(" checked");} %>/></td>
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
