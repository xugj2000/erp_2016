<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WaybillForDirect.aspx.cs" Inherits="Warehousing.OrderPrint.WaybillForDirect" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>运单录入</title>
        
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script src="../js/tjsetday.js" type="text/javascript"></script>
<script src="../js/js.js" type="text/javascript"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
    <br />
    <br />
   <table width="800" align="center">
  <tr>
		      <td>订单号：<asp:TextBox ID="txtDingdan" runat="server" Width="60px"></asp:TextBox>        
				下单会员：<asp:TextBox ID="txtUserid" runat="server" Width="128px"></asp:TextBox>
		        收件人：
		        <asp:TextBox ID="txtShouhuoName" runat="server" Width="60px"></asp:TextBox>
	          <asp:Button  ID="btnOk" runat="server" Text="查询" onclick="btnOk_Click"/>        </td>
      </tr>
   </table>
   <br />
   <table width="800" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
    <asp:Repeater ID="DirectOrderList" runat="server">
        <HeaderTemplate>
            <tr>
                <td width="74" bgcolor="#EEEEEE">序号</td>
                <td width="72" bgcolor="#EEEEEE">订单号</td>
                <td width="62" bgcolor="#EEEEEE">下单会员</td>
                 <td width="121" bgcolor="#EEEEEE">收件人姓名</td>
                <td width="141" bgcolor="#EEEEEE">货运公司</td>
                <td width="141" bgcolor="#EEEEEE">运单号</td>
                <td width="71" bgcolor="#EEEEEE">联系电话</td>
                <td width="79" align="center" bgcolor="#EEEEEE">操作</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td bgcolor="#FFFFFF"><input type="checkbox" name="id" id="id" value="<%# Eval("Shopxpacid")%>"><%#Container.ItemIndex+1 %></td>
                 <td bgcolor="#FFFFFF"><%#Eval("dingdan")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("user_name")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("shouhuoname")%></td>
                <td bgcolor="#FFFFFF" style="overflow:hidden;"><%#Eval("ShippingCompany")%></td>
                <td bgcolor="#FFFFFF" style="overflow:hidden;"><%#Eval("AWB_No")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("ShippingPhone")%></td>
               
                <td align="center" bgcolor="#FFFFFF"><a href="WayBillDirectEdit.aspx?id=<%#Eval("Shopxpacid")%>"><u>编辑</u></a></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <tr><td colspan=8><input type="checkbox" name="chkall" id="chkall" onClick="CheckAll(form1)">
        全选
                    </td></tr>
    <tr>
        <td colspan="8" bgcolor="#FFFFFF">
            <webdiyer:aspnetpager ID="Pager" FirstPageText="[首页]" LastPageText="[末页]" 
                NextPageText="[下一页]" PrevPageText="[上一页]"
                    ShowCustomInfoSection="Left" 
                CustomInfoHTML="每页[%PageSize%]条  第[%CurrentPageIndex%]页/共[%PageCount%]页" 
                runat="server" PageSize="20" OnPageChanging="Pager_PageChanging">        </webdiyer:aspnetpager>        </td>
    </tr>
   </table>
    </div>
    </form>
</body>
</html>