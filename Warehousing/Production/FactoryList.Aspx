<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FactoryList.aspx.cs" Inherits="Warehousing.Production.FactoryList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>加工厂列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 

</head>
<body>
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>加工厂列表</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="11" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;<a href="addFactory.aspx" style="color:red;font-size:16px;text-decoration:underline">新增加工厂</a>&nbsp;&nbsp;</td>
		</tr>
		<tr align="center">
        <td width="60">加工厂ID</td>
			<td width="120">加工厂名称</td>
          	<td>地址</td>
		  	<td width="120">联系电话</td>
			<td width="120">加入时间</td>
            <td width="60">计划应付</td>
            <td width="60">实际应付</td>
            <td width="60">累计已付</td>
            <td width="60">累计欠款</td>
             <td width="30">状态</td>
			<td width="60">操作</td>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr  style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>' align="center">
         <td><%#Eval("id")%></td>
          <td align="left"><%#Eval("supplier_name")%></td>
          <td><%#Eval("supplier_address")%></td>
		  <td><%#Eval("serviceTel")%></td>
		  <td><%#Eval("add_date")%></td>
          <td><%#Convert.ToDouble(Eval("PayAll"))%></td>
          <td><%#Convert.ToDouble(Eval("PayGoods"))%></td>
           <td><%#Convert.ToDouble(Eval("PayAlready"))%></td>
            <td><%#Convert.ToDouble(Eval("PayWill"))%></td>
            <td><%#Convert.ToInt32(Eval("IsLock")) == 1 ? "锁定" : "正常"%></td>
		  <td><a href="addFactory.aspx?id=<%#Eval("id")%>">修改</a></td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="11" align=center>
		  	<form runat="server" id="form1">
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到" OnPageChanging="AspNetPager1_PageChanging"
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
