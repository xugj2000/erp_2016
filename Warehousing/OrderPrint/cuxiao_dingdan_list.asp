<!--#include file="../conn.asp"-->
<!--#include file="../zhanting/geturl.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../sxf_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->

<html><head><title>客服促销订单</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
.shdz {
	font-size: 16px;
	text-decoration: none;
	font-weight: bold;
	line-height:120%;
}
td{font-size:12px;line-height:120%;}
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
  <style media=print>   
  .Noprint{display:none;}   
  td{
border:1px solid #CCCCCC;}
tr{page-break-after:auto}
  </style>  
  <STYLE MEDIA="PRINT">    
	.only_print_view {display:none;}
  </STYLE>
<STYLE MEDIA="SCREEN">    
	.only_print_view {display:block;}
  </STYLE> 
</head>

<BODY>
 <br><br>
 <div align=center style="font-weight:900;">客服促销订单</div>
 <br>
 
<table width="100%" border="0"   cellpadding="1" cellspacing="1" class="Noprint">
  <tr>
    <form name="form1" method="post" action="Agent_Order_Posted.asp">
      <td >订单号
        <input name="dingdan" type="text" id="dingdan" size="14" onFocus="this.value=''">
        下单ID
        <input name="userid" type="text" id="userid" value="" size="14" >
        下单人姓名
		<input name="username" type="text"   size="5">&nbsp; 
         
		收货人姓名
		<input name="namekey" type="text" id="namekey" size="5"><br>

        <select name="leixing" id="leixing">
          <option value="" selected>--选择查询类型--</option>
          <option value="">全部订单类型</option>
          <option value="1">注册订单</option>
          <option value="2">二次进货</option>
		  <option value="3">升级订单</option>
        </select>
        <select name="zhuangtai" id="zhuangtai">
          <option value="0" selected>--选择查询状态--</option>
          <option value="0" >全部订单状态</option>
          <option value="1" >未作任何处理</option>
          <option value="2" >用户已经划出款</option>
          <option value="3" >服务商已经收到款</option>
          <option value="4" >服务商已经发货</option>
          <option value="5" >用户已经收到货</option>
        </select>
       
        &nbsp;按激活店ID
        <input name="did" type="text" id="did" size="14">
		发货日期
        <input name="post_date" type="text" id="post_date" size="14" ><span style="color:red;">日期格式：<%=date%></span>
        <input type="submit" name="Submit" value="查 询">
      </td>
    </form>
  </tr>
</table>
<br>
<!--
<%
dim zhuangtai '订单状态
Dim namekey  '下单人姓名
Dim dingdan  '订单号
Dim leixing   '订单类型
Dim userid
Dim shouhuoname
Dim shopxpptname
Dim did
Dim post_date
Dim username

'获取查询表单值
dingdan=trim(request("dingdan"))
userid=trim(request("userid"))
username=trim(request("username"))
namekey=trim(request("namekey"))
shouhuoname=trim(request("shouhuoname"))
shopxpptname=trim(request("shopxpptname"))
leixing=trim(request("leixing"))
zhuangtai=trim(request("zhuangtai")) 
did=trim(request("did"))
post_date=Trim(request("post_date"))



'订单状态判断
if zhuangtai<>"" then
if not isnumeric(zhuangtai) then 
response.write"<script>alert(""非法访问!"");location.href=""../index.asp"";</script>"
response.end
end if
end If

 
%>
<div id="div1" style="width:100%;">

<%
	set rs=server.CreateObject("adodb.recordset")
	if request("Submit")="" then 
	'构造sql语句
	sql="select  top 100  dingdan ,IsFreightDelyPay,SuggestFreight,liushuihao,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,username,userid,shopxp_shiname,shopxp_shdz,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,liuyan,usertel,CONVERT (varchar(10),fksj,120) as fksj,convert(varchar(10),fhsj,120)  as fhsj,shopxp_shfs,zhifufangshi,zhuangtai,fapiao,fenxiao_userid,fapiao_date,fuwu_userid,feiyong,TapeColor from order_agent_main where cart_type=8 "
     else
	'构造sql语句
	sql="select dingdan ,IsFreightDelyPay,SuggestFreight,liushuihao,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,username,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(10),fksj,120) as fksj,convert(varchar(10),fhsj,120)  as fhsj,shopxp_shfs,zhifufangshi,zhuangtai,fapiao,fenxiao_userid,fapiao_date,fuwu_userid,feiyong,TapeColor,liuyan from order_agent_main where cart_type=8 "	 
	 
	 end if 
    '订单号
	if dingdan<>"" then
	sql=sql&" and dingdan='"&dingdan&"'"
	end If

	'下单ID
	If userid<>"" Then 

	 if isInt(userid)=False  Then 
	   response.write"下单ID必须是整数"
	   response.End 
	  End If 

	  sql=sql&" and userid="&userid 

	End If 
    
	'下单人姓名
	If username<>"" Then 
        sql=sql&" and username='"&username&"' "
	End If 


    '收货人姓名
	if namekey<>"请输入姓名" and namekey<>"" then
	  sql=sql&" and shouhuo_username='"&namekey&"' "
	  did=trim(request.form("did"))
	  '激活ID判断
	  if did<>"" then
	    sql=sql&" and userid in (select userid from e_user where did='"&did&"')"
	  end If 
	end If

	'订单类型	
	if leixing<>"" then 
	   if isInt(leixing)=False  Then 
	   response.write"订单类型必须是整数"
	   response.End 
	  End If 
	   sql=sql&" and dingdan_type="&leixing
	end if
	
	
	'订单状态查询
	select case zhuangtai
	case "4"
		sql=sql&" and zhuangtai=4 "
	case "5"
		sql=sql&" and zhuangtai=5 "
	case else
		 
	end select
		
	'发货日期 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"日期格式不正确"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),fhsj,120)='"&post_date&"'"
	end if
	
   sql=sql&" order by fhsj desc, fksj desc "

'response.write sql
rs.open sql,conn,3  
if rs.eof And rs.bof then
	Response.Write "<p align='center' class='contents'> 对不起，您选择的状态目前还没有订单！</p>"
else
 
		page_size=10
		Page_Menu_Init rs,page_size
		For ipage=1 To rs.PageSize
		
		ename=rs("username")
		shouhuoname=rs("shouhuo_username")
		liushuihao=rs("liushuihao")
		dingdan=rs("dingdan")
		feiyong=rs("feiyong")
		  %>
		  <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr bgcolor="#FFFFFF">
              <td width="19%" align="left" valign="top" nowrap><img src="../logo.gif" width="100" height="50" align="bottom"></td>
              <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">花的少，买的多！</span></td>
              <td width="40%" align="center" nowrap class="bigtitle"><%=liushuihao%></td>
            <td nowrap>订单号：<a href="javascript:;" onClick="javascript:window.open('../order_info/order_agent_view.asp?dan=<%=trim(rs("dingdan"))%>&shopxp_shfs=<%=rs("shopxp_shfs")%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(rs("dingdan"))%></a> </td>
            </tr>
          </table>
	    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" class="tableBorder">
	<tr bgcolor="#CECFCE" > 
	<td width="10%" align="center">流水号</td>
	  <td width="10%" align="center">订单号</td>
	<td width="10%" align="center">订单类型</td>
	<td width="10%" align="center">消费方式</td>
	<td width="9%" align="center">支付方式</td>
	<td width="5%" align="center">下单ID</td>
	<td width="10%" align="center">付款时间</td>
	<td width="10%" align="center">打单时间</td>
	<td width="10%" align="center">收货方式</td>
	<td width="7%" align="center">是否开发票</td>
	<td width="9%" align="center">是否返税</td>
	</tr>
        <tr bgcolor="#FFFFFF" align="center" > 
		<td height="22" ><%=liushuihao%></td>
          <td ><a href="javascript:;" onClick="javascript:window.open('../order_info/order_agent_view.asp?dan=<%=dingdan%>&shopxp_shfs=<%=rs("shopxp_shfs")%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dingdan)%></a></td>	
		  <td align="center"><%=rs("dingdan_leixing")%></td>
          <td ><%=rs("xiaofeifangshi")%></td>
		  <td><%=zhifufangshi(rs("zhifufangshi"))%></td>
          <td ><%=rs("userid")%></td>
          <td ><%=rs("fksj")%></td>
		  <td><%=rs("fhsj")%></td>
          <td ><%=shfs(rs("shopxp_shfs"))%></td>
		  <td>
		  <%
		  	if rs("fapiao")=1 and rs("fenxiao_userid")<>"" then 
                response.write "服务店已开发票"
           
            end If
		  %>		  </td>
		  <td>
		  <%
		  	if rs("fapiao")=1 and rs("fapiao_date")<>"" then
				response.Write "已返税给"&rs("fuwu_userid")
			else
				response.Write "暂未返税"
			end if
		  %>		  </td>
          </tr>
        <tr bgcolor="#FFFFFF">
          <td colspan="11" align="center">		  
		  <%
		  	set rss=server.CreateObject("adodb.recordset") 
			sql="select id as shopxpacid,shopxpptid,productdanwei,shopxpptname,pv*productcount as zongpv,area_number,shopxp_yangshiid,huojiahao,other_info,zonger,jifen,bochu,productcount,danjia,p_size from order_agent_prodetail  where dingdan='"&dingdan&"' and userid='"&rs("userid")&"' order by area_number asc ,shopxpptname asc,huojiahao"
			rss.open sql,conn,3
		  %>
		  
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
            <tr align="center" bgcolor="#FFFFFF">
			  <td>序号</td>
              <td width="29%">商品名称</td>
              <td width="11%">订购数量</td>
              <td width="10%">商品单位</td>
              <td width="29%">样 式</td>
			  <td width="11%">商品编号</td>
            </tr>
            <%
				zongji=0
				zongjifen=0
				ys=1
				do while not rss.eof
			%>
            <tr bgcolor="#FFFFFF" align="center">
			  <td align="center"><%=ys%></td>
              <td style='PADDING-LEFT: 5px;' align="left"><%=rss("huojiahao")%>.<%=trim(rss("shopxpptname"))%></td>
              <td bgcolor="#FFFFFF"> <%=rss("productcount")%></td>
              <td bgcolor="#FFFFFF" > <%=rss("productdanwei")%></td>
              <td align="center"><%=rss("p_size")%></td>
              <td><%=rss("shopxpptid")%></td>
            </tr>
            <%
				ys=ys+1
				zongji=rss("zonger")+zongji
				zongjifen=rss("zonger")+zongjifen
				bochu=rss("bochu")+bochu
				rss.movenext
				loop
				set rs_present=server.CreateObject("adodb.recordset")
				sql_present="select shopxpptname,p_size,productcount,other_info,productdanwei from Order_present_Agent where dingdan='"&dingdan&"' order by huojiahao desc"
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
							<td width="17%">商品名称</td>
							<td width="18%">单位</td>
							<td width="24%">规格</td>
							<td width="20%">赠送数量</td>
							<td width="21%">其他说明</td>
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
					</table>				</td>
			</tr>
			<%
				end if
				rs_present.close
				'set rs_present=nothing
			%>
            <tr bgcolor="#FFFFFF">
              <td colspan="6" height="20">
                <div align="right">
				<%
				
				Set rss=Nothing 

				%>   订单总额：<%=zongji+zongjifen*0.1%>元（其中积分冲抵<%=zongjifen*0.1 %>元，实付<%=zongji %>元）＋
				<%
				    if rs("IsFreightDelyPay")=1 then
				        ''response.Write "建议运费："&rs("SuggestFreight")
				    else
				        response.Write "费用："&feiyong
				    end if
				 %>　<a href="check_post_des.asp?province=<%=trim(rs("province"))%>&dingdan=<%=trim(rs("dingdan"))%>&songid=26">算物流运费</a>　　&nbsp;&nbsp;&nbsp;</div></td>
            </tr>
              <%
            rs_present.open "select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&rs("dingdan")&"' and zhuangtai=4 ",conn
			if not(rs_present.eof and rs_present.bof) then
         %>
           <tr bgcolor="#FFFFFF" align="center">
                  <td colspan="6"><table border="1" cellpadding="0" cellspacing="0" width="98%">
                      <tr>
                        <th align="center" colspan="5">门票信息</th>
                      </tr>
                      <tr align="center">
                        <td>门票名称</td>
                        <td>单位</td>
                        <td>规格</td>
                        <td>门票数量</td>
                        <td>其他说明</td>
                      </tr>
                      <%
							ticket_i=1
		                    do while not rs_present.eof
						%>
                      <tr align="center">
                        <td align="center">新闻发布会门票</td>
                        <td>张</td>
                        <td align="center">标准</td>
                        <td><%=rs_present("ticket_num")%></td>
                        <td align="left">电商网上线新闻发布会门票</td>
                      </tr>
                      <% 
							rs_present.movenext
							if rs_present.eof then exit do
							loop
						%>
                    </table></td>
                </tr>
                <%
				end if
				rs_present.close
				set rs_present=nothing
			%>
          </table>		  </td>
        </tr>
        <tr bgcolor="#FFFFFF" style="font-size:18px; ">
          <td height="30" colspan="5" class="shdz" >下单人姓名:<%=trim(rs("shopxp_shiname"))%>&nbsp;
		  <%if not isnull(rs("userid")) and rs("userid")<>0 then%>
		  服务店：
		  <%
		  sql="select did from e_user where userid='"&rs("userid")&"'"
		  Set rsd=server.CreateObject("adodb.recordset")
		  rsd.open sql,conn,3
		  If Not rsd.eof Then 
		    if rsd("did")=0 then
		      response.write "后台激活"
		    else
		      response.write rsd("did")
		    end If
		  %>&nbsp;&nbsp;&nbsp;服务店主姓名：
		  <%
		    if rsd("did")=0 then
		      response.write "后台激活"
		    Else
		       sql="select username from e_user where userid='"&rsd("did")&"'"
		       set rsm=server.CreateObject("adodb.recordset")
			   rsm.open sql,conn,3
			   If Not rsm.eof Then 
		          response.write rsm("username")
			   End If 
			   Set rsm=Nothing 
		    end If
		   end If
		   Set rsd=Nothing 
		  End If 
		  %>		  </td>
          <td height="30" class="shdz" colspan="3">收货人联系方式:<%=trim(rs("usertel"))%></td>
		   <td class="shdz" colspan=3>胶带颜色:<%=trim(rs("TapeColor"))%></td>
          </tr>
        <tr bgcolor="#FFFFFF" style="font-size:18px; ">
          <td height="30" colspan="5" class="shdz" >收货地址:<%=trim(rs("province"))%><%=trim(rs("city"))%><%=trim(rs("xian"))%><%=trim(rs("shopxp_shdz"))%>&nbsp;&nbsp;</td>
          <td height="30" colspan="3" class="shdz" >运费付款方式：
            <%
            if rs("IsFreightDelyPay")=0 then
                response.Write "现付"
            else
                response.Write "<font color=red>到付</font>"
            end if 
          %></td>
          <td class="shdz" colspan ="3"><%=shfs(rs("shopxp_shfs")) %>:&nbsp;<%=rs("sel_wuliugongshi")%></td>
          </tr>

		<%
		    if rs("liuyan")<>"" then
		%>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="8" class="shdz" >&nbsp;备注：<%=rs("liuyan")%></td>
          </tr>
        <%
			end if
		%>
        <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
          <td height="30" >配货人：</td>
          <td colspan="2">&nbsp;</td>
          <td colspan="2">验货人：</td>
          <td colspan="2">&nbsp;</td>
          <td colspan="2">发货人：</td>
		  <td colspan="2">&nbsp;</td>
          </tr>
      </table>
		  <br>
		  <span class="urlcss">打造全球最大的生活用品分销平台！http://www.maiduo.com 客服及售后：0371－66236936  感谢您的支持！</span>  <br>
      			<% 
rs.movenext
if rs.eof then exit for
next
''分页
alink="?dingdan="&request("dingdan")&"&userid="&request("userid")&"&username="&request("username")&"&namekey="&request("namekey")&"&shopxpptname="&request("shopxpptname")&"&leixing="&request("leixing")&"&zhuangtai="&request("zhuangtai")&"&did="&request("did")&"&post_date="&request("post_date")
Page_Menu rs,page_size,alink
rs.close
set rs=nothing

end If

connclose			
%>
</div>
-->
</body>
</html>


 
