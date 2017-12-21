<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GoodsReturnList.aspx.cs" Inherits="Warehousing.GoodsReturn.GoodsReturnList" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>返货商品管理</title>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script src="../js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script src="../js/js.js"></script>
<script>
$(function(){
$('#selectAll').click(function(){
var thischeck=$(this).attr("checked");
$("[name='id']").each(function(){
$(this).attr("checked",thischeck);
});

});
});
</script>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>返货商品列表</strong></div>
<form id="myform" runat="server" action="GoodsReturnList.aspx">
  <p>
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>代理ID
        <asp:TextBox ID="txtAgentId" runat="server" Width="80px"></asp:TextBox>&nbsp;商品名称
       
        <asp:TextBox ID="txtProductName" runat="server" Width="127px"></asp:TextBox> &nbsp; 
            收货人
        <asp:TextBox ID="txtUserName" runat="server" Width="80px"></asp:TextBox>&nbsp;返货状态：
        <asp:DropDownList ID="ddStatus" runat="server">
          <asp:ListItem Value="">所有商品</asp:ListItem>
        </asp:DropDownList>        
            <br />
            录入时间:从<asp:TextBox ID="txtStartDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtStartDate','');" Width="91px"></asp:TextBox> 至
            <asp:TextBox ID="txtEndDate" runat="server"  MaxLength="50"  
                onClick="return Calendar('txtEndDate','');" Width="83px"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" /></td>
      </tr>
  </table>
  
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE">
    <tr><td bgcolor="#F6F6F6">&nbsp;</td>
      <td bgcolor="#F6F6F6">商品名</td>
      <td width="4%" bgcolor="#F6F6F6">数量</td>
      <td width="10%" bgcolor="#F6F6F6">录入时间</td>
      <td width="8%" bgcolor="#F6F6F6">所属代理</td>
      <td width="7%" bgcolor="#F6F6F6">收货人</td>
      <td width="10%" bgcolor="#F6F6F6">电话</td>
      <td width="6%" bgcolor="#F6F6F6">省</td>
      <td width="5%" bgcolor="#F6F6F6">运费</td>
      <td width="9%" align="center" bgcolor="#F6F6F6">处理状态</td>
      <td width="14%" bgcolor="#F6F6F6">&nbsp;</td>
    </tr>
      <asp:Repeater ID="GoodsList" runat="server">
     <ItemTemplate>
    <tr>
      <td width="4%"><%#getCheckBoxStr(Eval("id").ToString(), Eval("Status").ToString()) %> </td>
      <td width="23%"><a href="javascript:openWin('GoodsDetail.aspx?id=<%#Eval("ID")%>',600,400)" title="<%#Eval("ReturnRemark")%>"><%#Eval("ProductName")%></a><%#Warehousing.Business.GoodsReturnHelper.checkIsChange(Eval("ChangeFlag"))%></td>
      <td align="center"><%#Eval("ProductCount")%></td>
      <td><%#Eval("AddTime")%></td>
      <td><%#Eval("AgentId")%></td>
      <td><%#Eval("UserName")%></td>
      <td><%#Eval("UserTel")%></td>
      <td><%#Eval("UserProvince")%></td>
      <td><%#Eval("PostFee")%></td>
      <td align="center"><%#Warehousing.Business.GoodsReturnHelper.getStutusText(Convert.ToInt32(Eval("Status")))%></td>
      <td><%#getChangeString(Eval("ID"), Eval("Status"))%>
          <input id="Button1" type="button" value="处理" onclick="location.href='GoodsReturnDo.aspx?id=<%#Eval("ID")%>&url=<%=thisUrl%>'" />
		  <input id="Button2" type="button" value="修改" onclick="location.href='GoodsReturnAddNext.aspx?id=<%#Eval("ID")%>&type=<%#Eval("OrderType")%>&isDirect=1&url=<%=thisUrl%>'" />
		  <%#getDelString(Eval("ID"),Eval("Status"))%>
		  </td>
      </tr>
        </ItemTemplate>
     </asp:Repeater>
    <tr>
      <td colspan="11"><webdiyer:aspnetpager ID="Pager" FirstPageText="[首页]" LastPageText="[末页]" NextPageText="[下一页]" PrevPageText="[上一页]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="每页[%PageSize%]条  第[%CurrentPageIndex%]页/共[%PageCount%]页" 
                runat="server" PageSize="20" EnableUrlRewriting="True" UrlPaging="True" UrlRewritePattern="GoodsReturnAdd.aspx?page={0}">
          </webdiyer:aspnetpager></td>
    </tr>
    <%if (haveFlag==1){ %>
    <tr>
	      <td colspan="11"><input name="selectAll" type="checkbox" id="selectAll"/>
	    
              &nbsp;选取所有<asp:Button ID="Button3" runat="server" Text="生成订单" 
                  onclick="Button3_Click" onclientclick="return confirm('你可对发往同一地址的商品进行并单处理,确定吗?');"/>          </td>
    </tr>
    <%} %>
  </table>
  </p>
</form>
</body>
</html>

