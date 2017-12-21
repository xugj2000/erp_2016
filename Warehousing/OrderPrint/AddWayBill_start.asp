<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!--#include file="../inc/conn.asp"-->
<!--#include file="../sxf_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<%
	yundantxm=requestValue(trim(request.form("yundantxm")),1)
	if yundantxm>"" Then
		Call conn_open 
		Call AntiSqlInject
		'查询是否已下载此订单
		sql="select shopxpacid from Order_Agent_Main where dingdan in(select yuandingdan from daili_uniondingdan where WayBill_UnionOrder='"&yundantxm&"') and shopxp_shfs<>27 and shopxp_shfs<>23 and shopxp_shfs<>29 "
		set rs1=conn.execute(sql)
		if not(rs1.bof and rs1.eof) then
			response.Cookies("yundantxm")=yundantxm
			Set rs1=Nothing
			Call conn_close 
			response.Redirect("Agent_AddWayBill_TXM.asp")
		else
			sql="select shopxpacid from Order_Distribution_Main where dingdan in(select yuandingdan from fenxiao_uniondingdan where WayBill_UnionOrder='"&yundantxm&"' ) and  shopxp_shfs<>23 and shopxp_shfs<>29 "
			set rs=conn.execute(sql)
			if not(rs.bof and rs.eof) then
				response.Cookies("yundantxm")=yundantxm
				Set rs=Nothing 
				Set rs1=Nothing 
				Call conn_close 
				response.Redirect("Distibution_AddWayBill_TXM.asp")
			else
				response.write "不存在此订单"   
			end if 
			Set rs=Nothing 
		end If
		Set rs1=Nothing 
		Call conn_close 
	'response.end

	end If




%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>代理配货初始化</title>
</head>
	<SCRIPT language='javascript'>
	function txmdw()
	{
	document.form1.yundantxm.focus();
	}
	</script>
	<body onload="txmdw()">
	<form id="form1" name="form1" method="post" action="">
	 条形码
	  <input type="text" name="yundantxm" id="yundantxm" />
	  <input type="submit" name="button" id="button" value="提交" />
	</form>
	</body>
</html>

 


