<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserList.aspx.cs" Inherits="Warehousing.User.UserList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>会员列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
</head>
<body>
<form runat="server" id="form1" action="UserList.aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>会员列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="13" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="AddUser.aspx" style="color:red;font-size:16px;text-decoration:underline">新增会员</a>&nbsp;&nbsp;
            </td>
		</tr>
    		<tr align="center">
			<td colspan="13" align="left" bgcolor="#FFFFFF">
            用户名<asp:TextBox ID="User_name" runat="server" Width="80px"></asp:TextBox>
            手机号<asp:TextBox ID="User_Mobile" runat="server" Width="80px"></asp:TextBox>
            会员类型
            <asp:DropDownList ID="User_Level" runat="server" AutoPostBack="false">
                  <asp:ListItem Text="所有" Value=""></asp:ListItem>
                  <asp:ListItem Text="普通会员" Value="0"></asp:ListItem>
                  <asp:ListItem Text="一级批发商" Value="1"></asp:ListItem>
                  <asp:ListItem Text="二级批发商" Value="2"></asp:ListItem>
                  <asp:ListItem Text="加盟商" Value="9"></asp:ListItem>
                  </asp:DropDownList>

            注册时间
            从<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="91px"></asp:TextBox> 至
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="83px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />

            </td>
		</tr>   
		<tr align="center">
             <td>ID</td>
			<td>会员名</td>
            <td>会员姓名</td>
            <td>手机号</td>
            <td>会员类型</td>
            <td>注册时间</td>
            <td>活跃时间</td>
            <td>累计应收</td>
            <td>累计已收</td>
            <td>累计欠款</td>
          	<td>预存帐户</td>
		  	<td>积分帐户</td>
			<td>操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
        <td><%#Eval("User_id")%></td>
          <td><%#Eval("User_name")%></td>
          <td><%#Eval("True_name")%></td>
          <td><%#Eval("User_Mobile")%></td>
          <td><%#Warehousing.Business.UserHelper.getUserLevelText(Convert.ToInt32(Eval("User_level")))%></td>
          <td><%#Eval("Add_time")%></td>
          <td><%#Eval("last_login")%></td>
          <td><%#Convert.ToDouble(Eval("PayAll"))%></td>
          
           <td><%#Convert.ToDouble(Eval("PayAlready"))%></td>
            <td><%#Convert.ToDouble(Eval("PayWill"))%></td>
		  <td><%#Eval("Account_money")%></td>
		  <td><%#Eval("Account_score")%></td>
		  <td><a href="AddUser.aspx?id=<%#Eval("User_id")%>">修改</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="13" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="第%CurrentPageIndex%页，共%PageCount%页，每页%PageSize%条,共%RecordCount%记录" 
                    EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="UserList.aspx?page={0}" ShowCustomInfoSection="Left">
        </webdiyer:AspNetPager>
          
			</td>
		  </tr>
	</table>
</td>
  </tr>          
</table>
</div>
		</form>		

</body>
</html>
