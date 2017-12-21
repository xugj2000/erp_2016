<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RukuNewList.aspx.cs" Inherits="Warehousing.Storage.RukuNewList" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>每日入库新品统计</title>
        
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script src="../js/tjsetday.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
    <br />
   <table width="800" align="center">
  <tr>
		      <td width="100">商品ID：</td>
		      <td width="100">
		      <asp:TextBox ID="txtsid" runat="server" Width="86px"></asp:TextBox>
		      </td>
		      <td width="90">商品名称：</td>
		      <td width="450">
		      <asp:TextBox ID="txtpname" runat="server"></asp:TextBox>
		        条形码：
		        <asp:TextBox ID="txttxm" runat="server"></asp:TextBox>
        </td>
		     
		      <td width="95">
		        <asp:Button  ID="btnOk" runat="server" Text="查询" onclick="btnOk_Click"/>
	          </td>
      </tr>
		   
   </table>
   <br />
   <table width="800" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
    <asp:Repeater ID="rptruku_newlist" runat="server">
        <HeaderTemplate>
            <tr>
                <td bgcolor="#EEEEEE">序号</td>
                <td bgcolor="#EEEEEE">商品Id</td>
                <td bgcolor="#EEEEEE">样式Id</td>
                 <td bgcolor="#EEEEEE">条形码</td>
                <td bgcolor="#EEEEEE">商品名称</td>
                <td bgcolor="#EEEEEE">规格</td>
                
                <td bgcolor="#EEEEEE">仓库实存</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td bgcolor="#FFFFFF"><%#Container.ItemIndex+1 %></td>
                 <td bgcolor="#FFFFFF"><%#Eval("shopxpptid")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("shopxp_yangshiid")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("txm") %></td>
                <td bgcolor="#FFFFFF"><a href="http://www.maiduo.com/product/<%#Eval("pid")%>.html" target="_blank"><%#Eval("shopxpptname")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("p_size")%></td>
               
                <td bgcolor="#FFFFFF"><%#Eval("shiji_num") %></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <tr>
        <td colspan="7" bgcolor="#FFFFFF">
            <webdiyer:aspnetpager ID="Pager" FirstPageText="[首页]" LastPageText="[末页]" 
                NextPageText="[下一页]" PrevPageText="[上一页]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="每页[%PageSize%]条  第[%CurrentPageIndex%]页/共[%PageCount%]页" 
                runat="server" PageSize="20" OnPageChanging="Pager_PageChanging">
        </webdiyer:aspnetpager>
        </td>
    </tr>
   </table>
    </div>
    </form>
</body>
</html>
