<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="addsupplier.aspx.cs" Inherits="Warehousing.Storage.addsupplier" %>

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
<td  align="center"><b><strong>供应商管理</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	
      <table width="100%" cellpadding="4" class="style1">
          <tr>
              <td width="14%">
                  供应商名称：</td>
              <td width="86%">
              <asp:TextBox ID="Textsupplier_name" runat="server" Width="238px" MaxLength=50></asp:TextBox>
               </td>
          </tr>
          <tr>
              <td>
                  供应商地址：</td>
              <td>
              <asp:TextBox ID="Textsupplier_address" runat="server" Width="238px" MaxLength=100></asp:TextBox>
              </td>
          </tr>
          <tr>
              <td>
                  联系电话：</td>
              <td>
              <asp:TextBox ID="TextserviceTel" runat="server" Width="238px" MaxLength=100></asp:TextBox>
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
