<!--#include file="conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="inc/Function.asp"-->
<!--#include file="../inc/powerfunction.asp"-->
<!--#include file="../inc/powercheck.asp"-->
<%
call GetPageUrlpower("Storage/Orderlist.asp")'取得页面的所有权限
call CheckPageRead()'检查当前页面是否有页面读取权限

if Trim(Request.QueryString("action"))="delOrder" then
   orderid=Trim(Request.QueryString("orderid"))
   conn.execute("delete from shopxp_churuku_yubei where  warehouse_id="&session("warehouse_id")&" and  OrderID='"&orderid&"'")
   response.Redirect("Orderlist.asp")
end if

 %>
<html><head><title>入库待审核订单列表</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" /> 
<style>
.erqi_css{background-color:#FFCC00;color:red;}
.zhanting_css{
	background-color:#FF0000;
	color:#FFFFFF;
}
</style>

</head>
<%
'session("warehouse_id")=1
'---判断仓库ID
call CheckStock(session("warehouse_id"))
	action=request("action")
	response.Cookies("OrderId")=""
	response.Cookies("supplier_id")=""
%>
<body>
<div id="div1">
<form name="form2" method="post" action="Orderlist.asp">
<table width="800" height="50" border="0" align="center" cellpadding="1" cellspacing="2">
  <tr>
    <td height="30">订单号
        <input name="OrderId" type="text" id="OrderId" size="15"></td>
    <td>供应商编号
      <input name="supplier_id" type="text" id="supplier_id" size="5"></td>
    <td>入库人
      <input name="order_user" type="text" id="order_user" size="8"></td>
    <td><input type="submit" name="button" id="button" value="提交">
      <input type="reset" name="button2" id="button2" value="重置"></td>
    </tr>
</table>
</form>
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>入库待审核订单</strong></b></td>
</tr>
<tr bgcolor="#FFFFFF">
  <td  align="center" bgcolor="#FFFFFF">
<%
	ordercode=trim(request("OrderId"))
	supplierid=trim(request("supplier_id"))
	order_user=trim(request("order_user"))
	sql="select distinct orderid,supplier_id,op_user,op_type ,(SELECT SUM(if_error_count) * 100 / COUNT(0) from shopxp_churuku_yubei WHERE op_user = tba.op_user) as errorcount from shopxp_churuku_yubei as tba where warehouse_id="&session("warehouse_id")&" and orderid like 'RK%'  "
	if ordercode<>"" then
		sql=sql&" and orderid='"&ordercode&"'"
	end if
	if supplierid<>"" then
		sql=sql&" and supplier_id="&supplierid&""
	end if
	if order_user<>"" then
		sql=sql&" and op_user='"&order_user&"'"
	end if
	sql=sql&" order by orderid desc"
	'response.Write sql
	set rs=server.CreateObject("adodb.recordset")
	rs.open sql,conn,1,1
	if  rs.eof and rs.bof  then
		response.Write("<strong>您要查找的信息不存在</strong>")
	else
%>
	<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td width="18%">订单号</td>
          	<td width="14%">供应商编号</td>
		  	<td width="10%">下单人</td>
		  	<td width="10%">点数准确率</td>
			<td width="30%">入库类型</td>
			<td width="12%">操作</td>
			<td width="6%">删除</td>
		</tr>
<%
		page_size=20
		Page_Menu_Init rs,page_size
		For ipage=1 To rs.PageSize
		
 %>
        <tr bgcolor="#FFFFFF" align="center">
          <td align="center"><%=rs("orderid")%></td>
          <td><%=rs("supplier_id")%></td>
		  <td><%=rs("op_user")%></td>
		  <td><%=rs("errorcount")%>%</td>
		  <td><% if rs("op_type")=1 then %><font color="#FF0000">商家送货单入库</font><% Else %>仓库自身入库<% End If %></td>
		  <td><%
		    set rszt=server.CreateObject("adodb.recordset")
			rszt.open "select distinct(zhuangtai) from shopxp_churuku_yubei where warehouse_id="&session("warehouse_id")&" and  OrderID='"&rs("OrderId")&"'",conn,3
			if not( rszt.eof and rszt.bof) then
				if rszt.recordcount=1 then
					if rszt("zhuangtai")=1 then
						response.Write("<font color='#FF0000'>禁用</font>&nbsp;|&nbsp;<a href='ruku_ing_piliang.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>入库</a>")
					elseif rszt("zhuangtai")=2 then
						response.Write("<a href='ruku_qc_second.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'><font color='#FF0000'>二次质检</font></a>&nbsp;|&nbsp;<font color='#FF0000'>禁用</font>")
					else
						response.Write("<a href='ruku_qc.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>质检</a>&nbsp;|&nbsp;<font color='#FF0000'>禁用</font>")
					end if
				else
					response.Write("<a href='ruku_qc_second.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'><font color='#FF0000'>二次质检</font></a>&nbsp;|&nbsp;<font color='#FF0000'>禁用</font>")
				end if
			else
				response.Write("<a href='ruku_qc.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>质检</a>&nbsp;|&nbsp;<font color='#FF0000'>禁用</font>")
			end if
			rszt.close
			set rszt=nothing
		  %></td>
		  <td><% if rs("op_type")=0 and PowerDel>0 then %><a href="?action=delOrder&orderid=<%=rs("orderid")%>" onClick="return confirm('确定删除吗');">删除</a><% End If %></td>
          </tr>
		  <% 
			rs.movenext
			if rs.eof then exit for
			next
			
		  %>
		  <tr>
		  	<td colspan="6">
			<%
				'分页
				alink="?ordercode="&ordercode&"&supplier_id="&supplierid&"&order_user="&order_user
				Page_Menu rs,page_size,alink
			%>
			</td>
		  </tr>
	</table>
<%
	end if
	rs.close
	set rs=nothing
	conn.close
	set conn=nothing
%>
</td>
  </tr>          
<tr bgcolor="#FFFFFF" > 
<td height="30"  align="right">&nbsp;</td>
</tr>
</table>
</div>
				

</body>
</html>

