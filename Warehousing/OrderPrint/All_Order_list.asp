<!--#include file="../conn.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->

<script type ="text/javascript" language ="javascript" >
function selectGroup(id)
{
    location.href="Agent_Order_Detail_list.asp?Group_Num_id="+id
}
</script>
<html>
<head>
<title>代理订单未发货管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.shdz {
	font-size: 16px;
	text-decoration: none;
	font-weight: bold;
	line-height:120%;
}
td{font-size:12px;line-height:120%;
page-break-before: auto;}
   .bigtitle {
	font-size: 18px;
	text-decoration: none;
	font-weight: bold;
	line-height: 120%;
}
   .fxpt{
	font-size: 14px;
	text-decoration: none;
	line-height: 120%;
	
}
  .urlcss {
float:right;
	font-size: 14px;
	text-decoration: none;
	line-height: 120%;
}

-->
</style>
<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
</head>
<BODY>
<table width="1000" border="0" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th align="center" bgcolor="#D2DCE6">订单未发货</th>
	</tr>
</table>
<table width="804" border="0" align="center"   cellpadding="3" cellspacing="1" class="Noprint">
<form name="form1" method="post" action="All_Order_list.asp">
<tr bgcolor="#FFFFFF">
	<td width="8%">订单号</td>
	<td width="18%"><input name="dingdan" type="text" id="dingdan" size="14" ></td>
	<td width="8%">下单ID</td>
	<td width="9%"><input name="whoid" type="text" id="whoid" value="" size="7" ></td>
	<td width="12%">下单人姓名</td>
	<td width="19%"><input name="whoname" type="text" id="whoname"   size="14"></td>
	<td width="9%">收货人姓名</td>
	<td width="17%"><input name="namekey" type="text" id="namekey" size="14"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>订单类型</td>
	<td><select name="leixing" id="leixing">
          	<option value="">全部订单类型</option>
			<option value="1,2,3">所有代理订单</option>
			<option value="1">--代理注册订单</option>
          	<option value="2">--代理二次进货</option>
			<option value="3">--代理升级订单</option>
			<option value="101,102,103">所有分销订单</option>
			<option value="101">--分销首批进货</option>
			<option value="102">--分销二次进货</option>
			<option value="103">--分销代销订单</option>
        </select>
	</td>
	<td>激活店ID</td>
	<td><input name="did" type="text" id="did" size="7"></td>
	<td>收货方式</td>
	<td><select name="shfs" id="shfs">
			<option value="" selected>--选择收货方式--</option>
          	<option value="">全部方式</option>
          	<option value="3">快递发货</option>
          	<option value="26">物流发货</option>
        </select>
	</td>
	<td>下单日期</td>
	<td ><input name="post_date" type="text" id="post_date" size="14"  onClick="return Calendar('post_date','');"><span style="color:red;"><br>
	日期格式：<%=date%></span></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan ="9" align ="right" ><input type="submit" name="Submit2" value="查 询"></td>
</tr>
</form>
</table>
<br>
<%
Dim namekey  '下单人姓名
Dim dingdan  '订单号
Dim leixing   '订单类型
Dim userid
Dim ReceiveName
Dim shopxpptname
Dim did
Dim post_date
Dim UserName

'获取查询表单值
dingdan=trim(request("dingdan"))
whoid=trim(request("whoid"))
whoname=trim(request("whoname"))
namekey=trim(request("namekey"))
leixing=trim(request("leixing")) 
did=trim(request("did"))
post_date=Trim(request("post_date"))
shop_shfs=trim(request("shfs"))

if OrderStatus<>"" then
if not isnumeric(OrderStatus) then 
response.write"<script>alert(""非法访问!"");location.href=""../index.asp"";</script>"
response.end
end if
end if
if namekey="" then namekey=request.form("namekey")
%>
<script language=javascript>

//复选表单全选事件 form：表单名
function CheckAll(form)  {
	for (var i=0;i<form.elements.length;i++)
	{
		var e = form.elements[i];
		if (e.name != 'chkall'&&e.type=="checkbox")
		{
			e.checked = form.chkall.checked;
		}
	}
}
</script>
<form name="form2" action="OrderDetailPrint.asp" method="post" target="_blank">

  <%
	set rsList=server.CreateObject("adodb.recordset")
	sql="select Id,BigType,OrderSn,BuyType,OrderType,UserName,UserId,ReceiveName,CONVERT (varchar(16),PayTime,120) as PayTime,ReceiveMethod,PayMethod,OrderStatus,PostMoney,ByDistributionId from DeliverGoodsOrder where  OrderStatus=3"
	
	'订单号
	if dingdan<>"" then
		sql=sql&" and OrderSn='"&dingdan&"'"
	end If

	'下单ID
	If whoid<>"" Then 
	 if TestInteger(whoid)=False  Then 
	   response.write"下单ID必须是整数"
	   response.End 
	  End If 
	  sql=sql&" and UserId="&whoid
	End If 
    
	'下单人姓名
	If whoname<>"" Then 
        sql=sql&" and ReceiveName='"&whoname&"' "
	End If 
    '收货人姓名
	if namekey<>"请输入姓名" and namekey<>"" then
	  sql=sql&" and ReceiveName like '%"&namekey&"%' "
	end If
	did=trim(request.form("did"))
	'激活ID判断
	  if did<>"" then
	    sql=sql&" and UserId in (select userid from tiaoxingma.dbo.e_user where did='"&did&"')"
	  end If 

	'订单类型	
	if leixing<>"" then 
	   sql=sql&" and OrderType in ("&leixing&")"
	end if
	if shop_shfs<>"" then
		sql=sql&" and ReceiveMethod="&shop_shfs
	end if
	'发货日期 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"日期格式不正确"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),PayTime,120)='"&post_date&"'"
	end If	
 	sql=sql&" order by PayTime desc"
 	''response.Write sql
	rsList.open sql,conn,3  
	if rsList.eof then
		Response.Write "<p align='center' class='contents'> 对不起，您选择的状态目前还没有订单！</p>"
		response.end
	else			
  %>
  <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top" nowrap> 全选
        <input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(form2)" value="Check All">
        <input type="submit" name="Submit" value="批量打印发货">
        <% 
		page_size=10
		Page_Menu_Init rsList,page_size
		For ipage=1 To rsList.PageSize
		id=rsList("id")
		dd=trim(rsList("OrderSn"))
		UserName=rsList("UserName")
		BigType=rsList("BigType")
		BigTypeText=GetBigTypeName(rsList("BigType"))
		  %>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#FFFFFF">
            <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
            <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">花的少，买的多！</span></td>
            <td width="40%" align="center" nowrap class="bigtitle">电商网订单商品清单(<font color="green"><%=BigTypeText%></font>)</td>
          </tr>
        </table>
		<%
		select case BigType
		case "0":
		call dispAgentOrderDetail(dd,id) ''代理订单
		case "1":
		call dispDistributionOrderDetail(dd,id) ''分销订单
		end select
		%>
        <br>
        <span class="urlcss">产品售后：0371－66236936  感谢您的支持！</span> <br>
        <br>
      </td>
    </tr>
  </table>
  <% 
			rsList.movenext
			if rsList.eof then exit for
			next
			end if
           
	%>
</form>
<%'分页
		alink="?dingdan="&dingdan&"&whoid="&whoid&"&whoname="&whoname&"&namekey="&namekey&"&leixing="&leixing&"&did="&did&"&post_date="&post_date&"&shfs="&shop_shfs
		Page_Menu rsList,page_size,alink
       	rsList.close
        set rsList=nothing
        conn.close
		%>
		<%sub dispAgentOrderDetail(dd,ID) '''显示代理订单详情
		set rs=conn.execute("select IsFreightDelyPay,SuggestFreight,Group_Lable,dingdan,sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,feiyong,fenxiao_userid,TapeColor from order_agent_main where zhuangtai=3 and dingdan='"&dd&"'")
		if not rs.eof then
		
		dd=trim(rs("dingdan"))
		ename=rs("username")
		xiaofeifangshi=rs("xiaofeifangshi")
		dingdan_leixing=rs("dingdan_leixing")
		shopxp_shfs=rs("shopxp_shfs")
		dingdan_userid=rs("userid")
		fksj=rs("fksj")
		shopxp_shiname=rs("shopxp_shiname")
		usertel=rs("usertel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("shopxp_shdz")
		sel_wuliugongshi=rs("sel_wuliugongshi")
		liuyan=rs("liuyan")
		
		fapiao=rs("fapiao")
		feiyong=rs("feiyong")
		fenxiao_userid=rs("fenxiao_userid")
		TapeColor=rs("TapeColor")
		shouhuoname=rs("shouhuo_username")
		if shouhuoname="" or isnull(shouhuoname) then
			shouhuoname=trim(rs("shouhuoname"))
		end if
		
		%>
		<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">订单号</td>
            <td width="16%" align="center">订单类型</td>
            <td width="14%" align="center">消费方式</td>
            <td width="15%" align="center">下单ID</td>
            <td width="20%" align="center">付款时间</td>
            <td width="15%" align="center">收货方式</td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td align="center"><input name="id" type="checkbox" id="id" value="<%=ID%>">
              <a href="javascript:;" onClick="javascript:window.open('order_agent_view.asp?dan=<%=dd%>&shopxp_shfs=<%=shopxp_shfs%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
            <td align="center"><%=dingdan_leixing%></td>
            <td align="center"><%=xiaofeifangshi%></td>
            <td align="center"><%=dingdan_userid%></td>
            <td align="center"><%=fksj%> </td>
            <td align="center"><%=shfs(shopxp_shfs)%>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td colspan="6" align="center">
			<%
				set rss=server.CreateObject("adodb.recordset") 
				sql="select shopxpptid,productdanwei,shopxpptname, area_number,shopxp_yangshiid,huojiahao,other_info,zonger,jifen,bochu,productcount,danjia,p_size from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by other_info asc,area_number asc ,shopxpptname desc,huojiahao desc"
				rss.open sql,conn,3
%>
              <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" >
                <tr align="center" bgcolor="#FFFFFF">
                  <td width="12%">商品名称</td>
                  <td width="21%" nowrap>商品单位</td>
                  <td width="21%">订购数量</td>
                  <td width="67%">样 式</td>
                  <td width="21%" nowrap>商品编号</td>
                  <td width="21%" nowrap>样式ID</td>
                </tr>
                <%
					zongji=0
					zongjifen=0
					ys=1
					zongAdRate=0
				do while not rss.eof
				%>
                <tr bgcolor="#FFFFFF" align="center">
                  <td nowrap style='PADDING-LEFT: 5px;' align="left"><%=rss("huojiahao")%>.<%=trim(rss("shopxpptname"))%></td>
                  <td nowrap><%=rss("productdanwei")%></td>
                  <td bgcolor="#FFFFFF"><%=rss("productcount")%></td>
                  <td align="left"><%=rss("p_size")%><span style="PADDING-LEFT: 5px;">
                    <%if not isnull(rss("other_info")) and rss("other_info")<>"" then%>
                    --<%=rss("other_info")%>
                    <%end if%>
                    </span></td>
                  <td nowrap><%=rss("shopxpptid")%></td>
                  <td nowrap><%=rss("shopxp_yangshiid")%></td>
                </tr>
                <%
					ys=ys+1
					zongji=rss("zonger")+zongji
					zongjifen=rss("jifen")*rss("productcount")+zongjifen
					
					zongAdRate=rss("bochu")*rss("productcount")+zongAdRate 
				rss.movenext
				loop
				rss.close
				set rss=nothing
				set rs_present=server.CreateObject("adodb.recordset")
				sql_present="select shopxpptname,p_size,productcount,other_info,productdanwei from Order_present_Agent where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by huojiahao desc"
				rs_present.open sql_present,conn,3,1
				if not(rs_present.eof and rs_present.bof) then

			%>
			<tr bgcolor="#FFFFFF" align="center">
				<td colspan="6">
					<table border="1" cellpadding="0" cellspacing="0" width="98%">
						<tr>
							<th align="center" colspan="5">赠品信息</th>
						</tr>
						<tr align="center">
							<td>商品名称</td>
							<td>单位</td>
							<td>样式</td>
							<td>赠送数量</td>
							<td>其他说明</td>
						</tr>
						<%
							do while not rs_present.eof
						%>
						<tr align="center">
							<td align="left">&nbsp;<%=rs_present("shopxpptname")%></td>
							<td><%=rs_present("productdanwei")%></td>
							<td align="left">&nbsp;<%=rs_present("p_size")%></td>
							<td><%=rs_present("productcount")%></td>
							<td align="left">&nbsp;<%=rs_present("other_info")%></td>
						</tr>
						<% 
							rs_present.movenext
							if rs_present.eof then exit do
							loop
						%>
					</table>
				</td>
			</tr>
			<%
				end if
				rs_present.close
				set rs_present=nothing
			%>
                <tr bgcolor="#FFFFFF">
                  <td colspan="6"><div align="right">
                <%
				if fapiao=1 and fenxiao_userid<>"" then 
                response.write "服务店已开发票"
                
                end If                
				%>
				<%
				if zongjifen=0 then 
				    response.write "订单总额："&zongji&"元"
				else
				    response.write "订单总额："&formatN(zongji)&"元,积分："&zongjifen
				end if
				
				    if rs("IsFreightDelyPay")=1 then
				        response.Write ""
				    else
				        response.Write ",费用："&feiyong&"元"
				    end if
				 %></div></td>
                </tr>
              </table></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="6" class="shdz" ><%=liuyan%>
              <%if dingdan_leixing="注册订单" then response.write "总广告费："&formatN(zongadRate)
		  		 if dingdan_leixing="注册订单" and zongpv>=1800 then response.write "开授权书"%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >下单人姓名:<%=trim(shopxp_shiname)%>&nbsp;
              <%if rs("dingdan_leixing")="注册订单" then%>
              <%if not isnull(dingdan_userid) and dingdan_userid<>0 then%>
              服务店：
              <%

			  sql="select did,username from tiaoxingma.dbo.e_user where userid='"&dingdan_userid&"'"
			  set rsd=server.CreateObject("adodb.recordset")
			  rsd.open sql,conn,3
			  if not(rsd.eof and rsd.bof) then
			  if rsd("did")="0" then
			    response.write "后台激活"
			  else
			    response.write rsd("did")&" 服务店主姓名："&rsd("username")
			  end If
			  end if
			  rsd.close
			  Set rsd=Nothing 
			  %>
              <%end if%>
              <%end if %>
            </td>
            <td height="30"  colspan="2" class="shdz">收货人联系方式:<%=trim(usertel)%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >收货人：<%=trim(shouhuoname)%> &nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>&nbsp;<%=shfs(shopxp_shfs)%>:<%=sel_wuliugongshi%></td>
            <td class="shdz">
                <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write ""
                else
                    response.Write "运费付款方式：<font color='red'>到付</font>"
                end if
             %>
            </td>
            <td class="shdz">胶带颜色:<%=TapeColor%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" >配货人：</td>
            <td height="30" >&nbsp;</td>
            <td >验货人：</td>
            <td height="30" >&nbsp;</td>
            <td height="30" >发货人：</td>
            <td height="30" >&nbsp;</td>
          </tr>
</table>
		
		
		<%end if
		rs.close
		set rs=nothing
		
		end sub%>		
		<%sub dispDistributionOrderDetail(dd,ID) ''分销订单
		set rs=conn.execute("select shopxpacid,dingdan,province,city,xian,fenxiao_type=case when fenxiao_type=3 then '社区服务店' else '分销中心' end,dingdan_leixing=case dingdan_type when 1 then '首批进货' when 2 then '二次进货' else '代销订单' end, shouhuoname,username,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,shopxp_shfs,feiyong,liuyan,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,other_info,is_tiaohuan,TapeColor,shouhuo_username,shouhuo_userid from Order_Distribution_Main where zhuangtai=3  and dingdan='"&dd&"'")
		if not rs.eof then
		
			ename=rs("username")
			shouhuoname=rs("shouhuoname")
			dd=rs("dingdan")
			is_tiaohuan=rs("is_tiaohuan")
			other_info=rs("other_info")
		
		%>
<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
	<tr bgcolor="#CECFCE" > 
	<td width="14%" align="center">订单号</td>
	<td width="14%" align="center">下单ID</td>
	<td width="14%" align="center">付款时间</td>
	<td width="23%" align="center">收货方式</td>
	<td width="19%" align="center">进货身份</td>
	<td width="15%" align="center">进货类型</td>
	</tr>
        <tr bgcolor="#FFFFFF" > 
          <td align="center"><input name="id" type="checkbox" id="id" value="<%=ID%>">
                      <a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=trim(rs("dingdan"))%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(rs("dingdan"))%></a></td>
          <td align="center"><%=rs("userid")%></td>
          <td align="center"><%=rs("fksj")%></td>
          <td align="center"><%=shfs(rs("shopxp_shfs"))%></td>
          <td align="center"><%=rs("fenxiao_type")%></td>
          <td align="center"><%=rs("dingdan_leixing")%></td>
        </tr>
        <tr bgcolor="#FFFFFF" >
          <td colspan="6" align="center">		  
		  <%
			'订单明细
			sql_order_list="select sa.shopxpptid,sa.shopxpptname,sa.huojiahao,sa.other_info,sa.productcount,sa.zonger,sa.p_size,sa.dingdan,sa.ProSource from Order_Distribution_ProDetail as sa  where sa.dingdan='"&dd&"' order by sa.area_number asc ,sa.shopxpptname asc,sa.huojiahao"
			set rs3=conn.execute(sql_order_list)
%><table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" style=" ">
            <tr align="center" bgcolor="#FFFFFF">
			  <td>序号</td>
              <td>商品名称</td>
              <td>订购数量</td>
              <td>商品规格</td>
			  <td>交易类型</td>
			  <td>商品编号</td>
            </tr>
            <%zongji=0
			  ys=1
			CouponMoney=0
			do while not rs3.eof
			if rs3("ProSource")=1 then CouponMoney=CouponMoney+rs3("zonger")
			%>
            <tr bgcolor="#FFFFFF" align="center">
			  <td><%=ys%></td>
              <td nowrap style='PADDING-LEFT: 5px; text-align:left;'><%=rs3("huojiahao")%>.<%=trim(rs3("shopxpptname"))%></td>
              <td bgcolor="#FFFFFF"> <%=rs3("productcount")%>
              <%if not isnull(rs3("other_info")) and rs3("other_info")<>"" then%><br> --<%=rs3("other_info")%><%end if%></td>
              <td style='PADDING-LEFT: 5px; text-align:left;'><%=rs3("p_size")%></td>
			  <td style='PADDING-LEFT: 5px; text-align:left;'><%=getProSourceName(rs3("ProSource"))%></td>
			  <td><%=rs3("shopxpptid")%></td>
            </tr>
            <%
				ys=ys+1 
				zongji=rs3("zonger")+zongji
				rs3.movenext
				loop
				if rs3.recordcount>0 then
				    rs3.movefirst
				end if 
				'赠品列表
	sql_present="select shopxpptname,p_size,productcount,other_info,productdanwei,dingdan from Order_present_distribution where dingdan ='"&dd&"' order by huojiahao desc"
	set rs_present=conn.execute(sql_present)
				if not (rs_present.eof and rs_present.bof ) then
			%>
			<tr bgcolor="#FFFFFF" align="center">
				<td colspan="6">
					<table border="1" cellpadding="0" cellspacing="0" width="98%">
						<tr>
							<th align="center" colspan="5">赠品信息</th>
						</tr>
						<tr align="center">
							<td>商品名称</td>
							<td>单位</td>
							<td>规格</td>
							<td>赠送数量</td>
							<td>其他说明</td>
						</tr>
						<%
							do while not rs_present.eof
								danwei=rs_present("productdanwei")
								if danwei="" or isnull(danwei) then
									danwei="<font color='#FFFFFF'>&nbsp;</font>"
								end if
						%>
						<tr align="center">
							<td align="left">&nbsp;<%=rs_present("shopxpptname")%></td>
							<td><%=danwei%></td>
							<td><%=rs_present("p_size")%></td>
							<td><%=rs_present("productcount")%></td>
							<td align="left">&nbsp;<%=rs_present("other_info")%></td>
						</tr>
						<% 
							rs_present.movenext
							if rs_present.eof then exit do
							loop
						%>
					</table>				</td>
			</tr>
			<%
				end if
			%>
            <tr bgcolor="#FFFFFF">
              <td colspan="6">
			  
                <div align="right">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%if is_tiaohuan=1 then response.write "<span style='font-weight:900;color:red;'>"&other_info&"</span>&nbsp;&nbsp;&nbsp;&nbsp;"%>
				订单总额：<%=zongji%>元<%if CouponMoney>0 then response.write "(其中购物券兑换"&CouponMoney&"元)"%>＋费用：<%=rs("feiyong")%>元　　&nbsp;&nbsp;&nbsp;				</div>				</td>
            </tr>
          </table></td>
        </tr>
         <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">下单人：<%=rs("shopxp_shiname")%></td>
            <td align="right" nowrap class="shdz">收货人：<%=rs("shouhuoname")%></td>
            <td align="right" class="shdz">联系方式:</td>
            <td align="center" class="shdz"><%=trim(rs("usertel"))%></td>
            <td align="right" class="shdz">胶带颜色:</td>
            <td align="center" class="shdz"><%=trim(rs("TapeColor"))%></td>
  </tr>
            <% if rs("shopxp_shfs")=25 then  %>
            <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">拼单人:</td>
            <td height="30" class="shdz"><%=trim(rs("shouhuo_username"))%></td>
            <td class="shdz" nowrap>拼单代理号：</td>
            <td colspan="5" align="left" class="shdz"><%=trim(rs("shouhuo_userid"))%></td>
          </tr>
            <% end if%>
            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="8" class="shdz" >&nbsp;&nbsp;收货地址:<%=trim(rs("province"))%><%=trim(rs("city"))%><%=trim(rs("xian"))%><%=trim(rs("shopxp_shdz"))%>
                <%if rs("dingdan_leixing")="代销订单" then %>
                <strong style="font-size :13px;">(非<%=rs("fenxiao_type") %>本地址)</strong>
                <%end if %>
                &nbsp;&nbsp;<%=shfs(rs("shopxp_shfs")) %>:&nbsp;<%=rs("sel_wuliugongshi") %></td>
          </tr>
        <% 
			if rs("liuyan")<>"" then 
		%>
		<tr bgcolor="#FFFFFF" style="font-size:18px; ">
		  <td height="30" colspan="6" class="shdz" >&nbsp;备注：<%=rs("liuyan")%></td>
		</tr>
		<% 
			end if 
		%>
        <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
          <td height="30" >配货人：</td>
          <td height="30" ></td>
          <td height="30" >验货人：</td>
          <td height="30"></td>
          <td >发货人：</td>
          <td >&nbsp;</td>
        </tr>
</table>
		<%
		end if
		rs.close
		set rs=nothing
		end sub%>
		
</body>
</html>



<script language=javascript runat=server>
  
 
// 验证是否为整数
function TestInteger(src)
{
  var sxf,regex;
 sxf='^[\\d]{1,}$';
  regex=new RegExp(sxf);
  return regex.test(src);
} 
 
</script>