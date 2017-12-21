<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Template.aspx.cs" Inherits="Warehousing.Production.Template" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<html><head><title>加工产品模板</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<script language="javascript" type="text/javascript" src="/js/jquery.js"></script>
<script language="javascript" type="text/javascript" src="/js/tjsetday.js"></script>
<script>
    $(function () {
        /* 全选 */
        $('.checkall').click(function () {
            var _self = this;
            $('.checkitem').each(function () {
                if (!this.disabled) {
                    $(this).attr('checked', _self.checked);
                }
            });
            $('.checkall').attr('checked', this.checked);
        });

        $("#Button2").click(function () {
            var selectflag = 0;
            $('.checkitem').each(function () {
                if ($(this).attr('checked') && selectflag == 0) {
                    selectflag = 1;
                }
            });
            if (selectflag == 0) {
                alert("请至少选中一款产品模板！");
                return false;
            }
        });
    });
</script>
</head>
<body>
<form runat="server" id="form1" action="Template.Aspx">
<div id="div1">
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>加工产品模板</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
	<table width="100%" border="0" cellpadding="4" cellspacing="1" bgcolor="#CCCCCC">
    		<tr align="center">
			<td colspan="13" align="right" bgcolor="#FFFFFF">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                     <a href="addTemplate.aspx" style="color:red;font-size:16px;text-decoration:underline">新增模板</a>&nbsp;&nbsp;</td>
		</tr>
    		<tr align="center">
			<td colspan="13" align="left" bgcolor="#FFFFFF">
            名称<asp:TextBox ID="pro_name" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
             货号<asp:TextBox ID="pro_code" runat="server" Width="120px"></asp:TextBox>
            &nbsp;
        <asp:DropDownList ID="factory_id" runat="server" style="width:100px;">
          <asp:ListItem Value="">匹配工厂</asp:ListItem>
        </asp:DropDownList>
            <asp:DropDownList ID="tpl_status" runat="server" style="width:50px;">
            <asp:ListItem Value="">状态</asp:ListItem>
           <asp:ListItem Value="1">正常</asp:ListItem>
           <asp:ListItem Value="2">作废</asp:ListItem>
            </asp:DropDownList>
           <asp:Button ID="Button1" runat="server" Text="查找" OnClick="Button1_Click" />

           <span style="display:block;float:right;margin-right:40px;">
           <asp:Button ID="Button2" runat="server" Text=" 加 入 预 选 " OnClick="Button2_Click" />
           <a href="WorkingCart.Aspx">已预选</a>
           </span>

           
            </td>
		</tr>        
		<tr align="center">
            <th><input type="checkbox" name=tplall class="checkall" /></th>
                    <th>ID</th>
                    <th>成品名称</th>
                    <th>成品货号</th>
                    <th>匹配工厂</th>
                    <th>用料</th>
                    <th>用料数量</th>
                    <th>原料费用</th>
                    <th>单位加工费</th>
                    <th>其它费用</th>
					<th>录入时间</th>
                    <th>操作员</th>
					<th></th>
		</tr>
		<asp:Repeater ID="MemberList" runat="server">
                           <ItemTemplate>   
        <tr align="center" style='background-color:<%#(Container.ItemIndex%2==0)?"#FFFFFF":"#F3F3F3"%>'>
        <td><input type="checkbox" class="checkitem" name="tpl_id" value='<%#Eval("tpl_id")%>'/></td>
         <td><%#Eval("tpl_id")%></td>
          <td align="center"><%#Eval("pro_name")%></td>
          <td align="center"><%#Eval("pro_code")%></td>
           <td><%#Warehousing.Business.ProductionHelper.getFactoryName(Convert.ToInt32(Eval("factory_id")))%></td>
           <td align="center"><%#Eval("pro_txm_from")%></td>
           <td align="center"><%#Eval("pro_nums")%></td>
           <td align="center"><%#Convert.ToDouble(Eval("pvolume"))%></td>
           <td align="center"><%#Eval("do_cost")%></td>
           <td align="center"><%#Eval("other_cost")%></td>
		  <td><%#Eval("add_time")%></td>
          <td><%#Warehousing.Business.StorageHelper.getAdminName(Convert.ToInt32(Eval("operator")))%></td>
		  <td><a href="addTemplate.aspx?id=<%#Eval("tpl_id")%>" <%#getStyletext(Convert.ToInt32(Eval("tpl_status")))%>>修改&nbsp;</a>
              <a href="TemplateDetail.aspx?id=<%#Eval("tpl_id")%>">查看&nbsp;</a>
          </td>
          </tr>
          </ItemTemplate>
          </asp:Repeater>
		  <tr>
		  	<td colspan="13" align=center>
		  	
                <webdiyer:AspNetPager ID="AspNetPager1" runat="server" FirstPageText="首页" LastPageText="尾页"
            NextPageText="下一页" PrevPageText="上一页" ShowPageIndexBox="Always"
            SubmitButtonText="Go" TextAfterPageIndexBox="页" TextBeforePageIndexBox="转到"
            PageSize="20" CustomInfoHTML="" EnableUrlRewriting="True" UrlPaging="True" 
                    UrlRewritePattern="Template.Aspx?page={0}">
        </webdiyer:AspNetPager>
          
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
