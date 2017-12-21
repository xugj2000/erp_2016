<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserTotal.aspx.cs" Inherits="Warehousing.User.UserTotal" %>

<html><head><title>会员汇总</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="UserTotal.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>会员汇总</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="9" align="right" bgcolor="#FFFFFF">
            </td>
		</tr>
    		<tr align="center">
			<td colspan="9" align="left" bgcolor="#FFFFFF">
            
            注册时间:从<asp:TextBox ID="startDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('startDate','');" Width="80px"></asp:TextBox> 至
            <asp:TextBox ID="endDate" runat="server"  MaxLength="20"  
                onClick="return Calendar('endDate','');" Width="80px"></asp:TextBox>

            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            </td>
		</tr>   
		<tr align="center">
            <td>日期</td>
            <td>会员数</td>
		</tr>
		<asp:Repeater ID="OrderList" runat="server">
                           <ItemTemplate>   
        <tr bgcolor="#FFFFFF" align="center">
        <td><%#Eval("thisdate")%></td>
         <td><%#Eval("allCount")%></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		<tr  bgcolor="#FFFFFF" align="center">
            <td>合计</td>
            <td><%=total_allCount%></td>
		</tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
