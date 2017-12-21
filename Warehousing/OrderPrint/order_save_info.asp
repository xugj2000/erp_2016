<!--#include file="../conn.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("order_info/order_agent_view.asp")'取得父级页面的所有权限

''call CheckPageEdit()'检查当前页面是否有页面读取权限

action=request.QueryString("action")
dingdan=request.QueryString("dan")
userid=trim(request("userid"))
if isnull(dingdan) or dingdan="" or isnull(usreid) or userid="" then
	response.Write "<script>alert('传值有误');window.close();</script>"
	response.End()
end if
select case action
case "faka"

if userid<>"" then
	set rsz=conn.execute("select zhuangtai from order_agent_main where dingdan='"&dingdan&"' and userid="&userid)
	
	if rsz("zhuangtai")=3 then
	'更新分销中心服务费
	conn.execute("exec fenxiao_fuwufei_gongshifahuo '"&dingdan&"'")
	conn.execute("exec maijiufan_proc_daili '"&dingdan&"'")
	
	end if
	
set rsc=conn.execute("select give_card,give_card_date from e_user where userid='"&userid&"'")
	if not (rsc.bof and rsc.eof) then
		if rsc("give_card")=1 then
		response.Write "此代理已经发过卡了！"
		else
		conn.execute("update e_user set give_card=1,give_card_date=getdate() where userid='"&userid&"'")
		response.Write "<font color=red>发卡成功！</font><br><a href=# onclick=javascript:window.close();>关闭窗口</a>"

		end if
	end if
end if
case "liuyan"
	liuyan=trim(request("reply"))
	if liuyan<>"" then
		conn.execute("update order_agent_main set reply='"&liuyan&"' where dingdan='"&dingdan&"' and userid="&userid)
		conn.execute("update DeliverGoodsOrder set DeliverReplay='"&liuyan&"',RemoteFlag=2 where BigType=0 and OrderSn='"&dingdan&"'")
		response.write"<SCRIPT language=JavaScript>alert('回复成功！');"
		response.write"javascript:history.go(-1)</SCRIPT>"
	else
		response.Write("<script>history.go(-1);</script>")
		response.End()
	end if

case "fahuo_memo"
	fahuo_memo=trim(request("fahuo_memo"))
	if fahuo_memo<>"" then
	 
	conn.execute("update order_agent_main set fahuo_memo='"&fahuo_memo&"' where dingdan='"&dingdan&"' and userid="&userid)
	conn.execute("update DeliverGoodsOrder set DeliverMessage='"&request("fahuo_memo")&"',RemoteFlag=2 where BigType=0 and OrderSn='"&dingdan&"'")
	response.write"<SCRIPT language=JavaScript>alert('发货备注成功！');"
	response.write"javascript:history.go(-1)</SCRIPT>"
	response.End()
	else
		response.Write("<script>history.go(-1);</script>")
		response.End()
	end if
case "save"

end select

%>
