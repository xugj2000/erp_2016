<!--#include file="conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="inc/Function.asp"-->
<!--#include file="../inc/powerfunction.asp"-->
<!--#include file="../inc/powercheck.asp"-->
<%
call GetPageUrlpower("Storage/Orderlist.asp")'ȡ��ҳ�������Ȩ��
call CheckPageRead()'��鵱ǰҳ���Ƿ���ҳ���ȡȨ��

if Trim(Request.QueryString("action"))="delOrder" then
   orderid=Trim(Request.QueryString("orderid"))
   conn.execute("delete from shopxp_churuku_yubei where  warehouse_id="&session("warehouse_id")&" and  OrderID='"&orderid&"'")
   response.Redirect("Orderlist.asp")
end if

 %>
<html><head><title>������˶����б�</title>
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
'---�жϲֿ�ID
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
    <td height="30">������
        <input name="OrderId" type="text" id="OrderId" size="15"></td>
    <td>��Ӧ�̱��
      <input name="supplier_id" type="text" id="supplier_id" size="5"></td>
    <td>�����
      <input name="order_user" type="text" id="order_user" size="8"></td>
    <td><input type="submit" name="button" id="button" value="�ύ">
      <input type="reset" name="button2" id="button2" value="����"></td>
    </tr>
</table>
</form>
<table width="1000" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC" class="tableBorder">
<tr bgcolor="#FFFFFF"> 
<td  align="center"><b><strong>������˶���</strong></b></td>
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
		response.Write("<strong>��Ҫ���ҵ���Ϣ������</strong>")
	else
%>
	<table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
		<tr align="center">
			<td width="18%">������</td>
          	<td width="14%">��Ӧ�̱��</td>
		  	<td width="10%">�µ���</td>
		  	<td width="10%">����׼ȷ��</td>
			<td width="30%">�������</td>
			<td width="12%">����</td>
			<td width="6%">ɾ��</td>
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
		  <td><% if rs("op_type")=1 then %><font color="#FF0000">�̼��ͻ������</font><% Else %>�ֿ��������<% End If %></td>
		  <td><%
		    set rszt=server.CreateObject("adodb.recordset")
			rszt.open "select distinct(zhuangtai) from shopxp_churuku_yubei where warehouse_id="&session("warehouse_id")&" and  OrderID='"&rs("OrderId")&"'",conn,3
			if not( rszt.eof and rszt.bof) then
				if rszt.recordcount=1 then
					if rszt("zhuangtai")=1 then
						response.Write("<font color='#FF0000'>����</font>&nbsp;|&nbsp;<a href='ruku_ing_piliang.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>���</a>")
					elseif rszt("zhuangtai")=2 then
						response.Write("<a href='ruku_qc_second.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'><font color='#FF0000'>�����ʼ�</font></a>&nbsp;|&nbsp;<font color='#FF0000'>����</font>")
					else
						response.Write("<a href='ruku_qc.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>�ʼ�</a>&nbsp;|&nbsp;<font color='#FF0000'>����</font>")
					end if
				else
					response.Write("<a href='ruku_qc_second.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'><font color='#FF0000'>�����ʼ�</font></a>&nbsp;|&nbsp;<font color='#FF0000'>����</font>")
				end if
			else
				response.Write("<a href='ruku_qc.asp?action=order&sid="&rs("supplier_id")&"&OrderId="&rs("OrderId")&"'>�ʼ�</a>&nbsp;|&nbsp;<font color='#FF0000'>����</font>")
			end if
			rszt.close
			set rszt=nothing
		  %></td>
		  <td><% if rs("op_type")=0 and PowerDel>0 then %><a href="?action=delOrder&orderid=<%=rs("orderid")%>" onClick="return confirm('ȷ��ɾ����');">ɾ��</a><% End If %></td>
          </tr>
		  <% 
			rs.movenext
			if rs.eof then exit for
			next
			
		  %>
		  <tr>
		  	<td colspan="6">
			<%
				'��ҳ
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

