<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ComplaintList.aspx.cs" Inherits="Warehousing.Complaint.ComplaintList" EnableViewStateMac="false"%>
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
<style>
.aa{width:90px;}
</style>
</head>
<body>
<div style="font-size:16px;text-align:center;background-color:#EEEEEE;line-height:200%; "><strong>
    客户投诉列表</strong></div>
<form id="myform" runat="server">
  <p>
  <table width="780" border="0" align="center" cellpadding="5" cellspacing="5" style="margin-left:5px;">
      
      <tr>

        <td>客户ID
        <asp:TextBox ID="txtUserId" runat="server" Width="60px"></asp:TextBox>&nbsp;
        客户姓名
        <asp:TextBox ID="txtUserName" runat="server" Width="60px"></asp:TextBox>&nbsp;
        接诉人
        <asp:TextBox ID="txtaddOperator" runat="server" Width="60px"></asp:TextBox>&nbsp; 
            联系电话：<asp:TextBox ID="txtTel" runat="server" Width="80px"></asp:TextBox>&nbsp; 
            
            处理状态：<asp:DropDownList ID="ddStatus" runat="server">
          <asp:ListItem Value="">所有</asp:ListItem>
        </asp:DropDownList>        
            <br />
            投诉类型：<asp:DropDownList ID="ddtypeId" runat="server" CssClass="aa"></asp:DropDownList>
            投诉时间：从<asp:TextBox ID="txtSdate" runat="server" Width="63px"  onClick="return Calendar('txtSdate','');"></asp:TextBox>
            至<asp:TextBox ID="txtEdate" runat="server" Width="63px"  onClick="return Calendar('txtEdate','');"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="搜索" OnClick="Button1_Click" />
            <asp:Button
            ID="Button4" runat="server" Text="导出" onclick="Button4_Click" /></td>
      </tr>
  </table>
  
  <table width="780" border="1" align="center" cellpadding="2" cellspacing="0" bordercolor="#EEEEEE">
    <tr><td bgcolor="#F6F6F6"></td>
      <td bgcolor="#F6F6F6">投诉客户</td>
      <td width="7%" bgcolor="#F6F6F6">接诉人</td>
      <td width="10%" bgcolor="#F6F6F6">投诉时间</td>
      <td width="8%" bgcolor="#F6F6F6">投诉类型</td>
      <td width="19%" bgcolor="#F6F6F6">详情</td>
      <td width="9%" bgcolor="#F6F6F6">联系方式</td>
      <td width="9%" align="center" bgcolor="#F6F6F6">客诉状态</td>
      <td width="13%" bgcolor="#F6F6F6">处理结果</td>
      <td width="12%" bgcolor="#F6F6F6">&nbsp;</td>
    </tr>
      <asp:Repeater ID="GoodsList" runat="server" onitemcommand="GoodsList_ItemCommand">
     <ItemTemplate>
    <tr>
      <td width="4%"><%#Container.ItemIndex+1%></td>
      <td width="9%"><%#Eval("UserId")%><br />
      <%#Eval("UserName")%>
      </td>
            <td><%#Eval("addOperator")%></td>
      <td align="center"><%#Eval("ComplaintTime")%></td>
      <td><%#Warehousing.Business.ComplaintHelper.getTypeName(Eval("typeId"))%></td>

      <td><%#Eval("ComplaintDetail")%></td>
      <td><%#Eval("userTel")%></td>
      <td align="center"><%#Warehousing.Business.ComplaintHelper.getStutusText(Convert.ToInt32(Eval("Status")))%></td>
      <td><%#Eval("doContent")%></td>
      <td>
          <asp:Button ID="Button2" runat="server" Text="处理" CommandName="do" CommandArgument='<%#Eval("id")%>'  />
          <asp:Button ID="Button3" runat="server" Text="修改" CommandName="edit" CommandArgument='<%#Eval("id")%>'  />
		  </td>
      </tr>
        </ItemTemplate>
     </asp:Repeater>
      <tr>
          <td>
              <br />
          </td>
      </tr>
    <tr>
      <td colspan="10"><webdiyer:aspnetpager ID="Pager" FirstPageText="[首页]" 
              LastPageText="[末页]" NextPageText="[下一页]" PrevPageText="[上一页]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="每页[%PageSize%]条  第[%CurrentPageIndex%]页/共[%PageCount%]页" 
                runat="server" PageSize="20" EnableUrlRewriting="True" UrlPaging="True" 
              UrlRewritePattern="ComplaintList.aspx?page={0}" SubmitButtonText="Go" 
              TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到">
          </webdiyer:aspnetpager></td>
    </tr>
  </table>
  </p>
</form>
</body>
</html>

