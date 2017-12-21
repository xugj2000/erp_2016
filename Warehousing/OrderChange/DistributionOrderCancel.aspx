<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DistributionOrderCancel.aspx.cs" EnableViewState="false" Inherits="Warehousing.OrderChange.DistributionOrderCancel" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>分销中心取消订单</title>
    <link href="../css/global.css" rel="stylesheet" type="text/css" />
    <link href="../css/right.css" rel="stylesheet" type="text/css" />
    <script src="../js/js.js"></script>

</head>
<body>
    <form id="form1" runat="server">
    <div>
      <table width="800" align="center">
  <tr>
		      <td height="35" align="center"> <font style="font-size:14px;font-weight:bold">分销中心取消订单审核</font>	          </td>
      </tr>
		   
   </table>
    
   <table width="800" align="center">
  <tr>
		      <td> 取消员：<asp:TextBox ID="txtOperator" runat="server" Width="50px"></asp:TextBox>
		      用户ID：<asp:TextBox ID="txtAgentId" runat="server" Width="50px"></asp:TextBox>
		      代理姓名：<asp:TextBox ID="txtAgentName" runat="server" Width="70px"></asp:TextBox>
		          商品名称：<asp:TextBox ID="txtpname" runat="server" Width="110px"></asp:TextBox>
		        订单号：
		        <asp:TextBox ID="txtOrderSn" runat="server" Width="100px"></asp:TextBox>
                  <asp:DropDownList ID="ConfirmFlag" runat="server">
                  <asp:ListItem Value="" Text="所有"></asp:ListItem>
                  <asp:ListItem Value="0" Text="待审核"></asp:ListItem>
                  <asp:ListItem Value="1" Text="已确认"></asp:ListItem>
                  </asp:DropDownList>
		        <asp:Button  ID="btnOk" runat="server" Text="查询" onclick="btnOk_Click"/>
	          </td>
      </tr>
		   
   </table>
   <br />
   <table width="800" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
    <asp:Repeater ID="rptruku_newlist" runat="server">
        <HeaderTemplate>
            <tr>
            <td width="31" bgcolor="#EEEEEE"></td>
            <td width="49" bgcolor="#EEEEEE">取消号</td>
            <td width="69" bgcolor="#EEEEEE">订单号</td>
            <td width="55" bgcolor="#EEEEEE">代理号<br />
              代理姓名</td>
                <td width="140" bgcolor="#EEEEEE">产品名称(Id)</td>
                <td width="57" bgcolor="#EEEEEE">产品规格</td>
                 <td width="38" bgcolor="#EEEEEE">数量</td>
                <td width="39" bgcolor="#EEEEEE">取消额</td>
                
                <td width="117" bgcolor="#EEEEEE">取消时间</td>
                <td width="46" bgcolor="#EEEEEE">取消员</td>
                <td width="30" bgcolor="#EEEEEE">类型</td>
                <td width="32" bgcolor="#EEEEEE">确认?</td>
                <td width="29" bgcolor="#EEEEEE">详情</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
             <td bgcolor="#EEEEEE"><%#Eval("checkidstr")%></td>
             <td bgcolor="#FFFFFF"><%#Eval("id")%></td>
             <td bgcolor="#FFFFFF" title="<%#Eval("actiondate")%>"><%#Eval("dingdan")%></td>
             <td bgcolor="#FFFFFF"><%#Eval("userid")%><br /><%#Eval("username")%></td>
                 <td bgcolor="#FFFFFF"><%#Eval("shopxpptname")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("p_size")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("productcount")%></td>
                <td bgcolor="#FFFFFF"><%#Eval("zonger")%></td>
               <td bgcolor="#FFFFFF"><%#Eval("quxiao_date")%></td>
               <td bgcolor="#FFFFFF"><%#Eval("op_user")%></td>
               <td bgcolor="#FFFFFF"><%#Warehousing.SiteHelper.getReturnGoodsText(Eval("OP_Type"))%></td>
               <td bgcolor="#FFFFFF"><%#Warehousing.SiteHelper.getConfirmText(Eval("warehouse_confirm").ToString())%></td>
                <td bgcolor="#FFFFFF"><a href="dingdan_quxiao_fenxiao_view.asp?id=<%#Eval("id")%>"><u>查看</u></a></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
        <tr>
        <td colspan="13" bgcolor="#FFFFFF">
         <input type="checkbox" name="chkall" id="chkall" onClick="CheckAll(form1)">全选 
         
            <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="确认取消"  OnClientClick="return confirm('确定对您选择的商品进行取消吗?');"/>
        </td>
    </tr>
    <tr>
        <td colspan="13" bgcolor="#FFFFFF">
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