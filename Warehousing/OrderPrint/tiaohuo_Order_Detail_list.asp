<!--#include file="../conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<%
Group_Num=request("Group_Num_id")
if Group_Num="" then
    Group_Num=4
end if 
'response.Write Group_Num
%>
<script type ="text/javascript" language ="javascript" >
function selectGroup(id)
{
    location.href="Agent_Order_Detail_list.asp?Group_Num_id="+id
}
</script>
<html>
<head>
<title>大仓库调货订单未发货</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
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
 <script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
  <script language="javascript" type="text/javascript" src="../js/js.js"></script>
</head>
<BODY>
<table width="1000" border="0" align="center" cellpadding="5" cellspacing="0" bgcolor="#D2DCE6">
	<tr>
		<td align="center">大仓库调货订单未发货</td>
	</tr>
</table>
<table width="1000" border="0" align="center"   cellpadding="5" cellspacing="1" bgcolor="#D2DCE6" class="Noprint">
<form name="form1" method="post" action="tiaohuo_Order_Detail_list.asp" >
<tr bgcolor="#FFFFFF">
	<td width="8%">订单号</td>
	<td width="19%"><input name="dingdan" type="text" id="dingdan" size="14" ></td>
	<td width="8%">下单ID</td>
	<td width="11%"><input name="userid" type="text" id="userid" value="" size="7" ></td>
	<td width="11%">下单人姓名</td>
	<td width="19%"><input name="username" type="text"   size="14"></td>
	<td width="9%">收货人姓名</td>
	<td width="15%"><input name="namekey" type="text" id="namekey" size="14"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>订单类型</td>
	<td><select name="leixing" id="leixing">
			<option value="" selected>--选择查询类型--</option>
          	<option value="">全部订单类型</option>
          	<option value="1">注册订单</option>
          	<option value="2">二次进货</option>
			<option value="3">升级订单</option>
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
	<td><input name="post_date" type="text" id="post_date" size="14"  onClick="return Calendar('post_date','');"><span style="color:red;"><br>
	日期格式：<%=date%></span></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan="7"></td>
</tr>
</form>
</table>
<br>
<%
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
did=trim(request("did"))
post_date=Trim(request("post_date"))
shop_shfs=trim(request("shfs"))

if zhuangtai<>"" then
if not isnumeric(zhuangtai) then 
response.write"<script>alert(""非法访问!"");location.href=""../index.asp"";</script>"
response.end
end if
end if
if namekey="" then namekey=request.form("namekey")
%>
<form name="form2" action="Agent_Order_Detail_Print.asp" method="post" target="_blank">
  <%
	conn.cursorlocation=3
	set rs=server.CreateObject("adodb.recordset")
	sql="select IsFreightDelyPay,SuggestFreight,Group_Lable,TapeColor,shopxpacid,op.sumcount ,op.dingdan,sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '商城订单' when xiaofeifangshi=1 then '调换货订单' when xiaofeifangshi=3 then '分销中心代下订单' when xiaofeifangshi=4 then '分销中心提货订单' end,dingdan_leixing=case when dingdan_type=3 then '升级订单' when dingdan_type=2 then '二次进货' else '注册订单' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,feiyong,fenxiao_userid,other_info from order_agent_main  om ,(SELECT dingdan,sum(sumcount) as sumcount from (SELECT dingdan, SUM(productcount) AS sumcount FROM order_agent_prodetail GROUP BY dingdan union all SELECT dingdan, SUM(productcount) AS sumcount from order_present_agent group by dingdan)aa group by dingdan ) op  where shopxp_shfs not in (23,25,27,29) and om.zhuangtai=3 and  om.dingdan=op.dingdan and om.is_tiaohuan=1 and om.LocalInit=1"
	'订单号
	if dingdan<>"" then
		sql=sql&" and op.dingdan='"&dingdan&"'"
	end If

	'下单ID
	If userid<>"" Then 

	 if TestInteger(userid)=False  Then 
	   response.write"下单ID必须是整数"
	   response.End 
	  End If 
	  sql=sql&" and userid="&userid 
	End If 
    
	'下单人姓名
	If username<>"" Then 
        sql=sql&" and shopxp_shiname='"&username&"' "
	End If 
    '收货人姓名
	if namekey<>"请输入姓名" and namekey<>"" then
	  sql=sql&" and shouhuo_username like '%"&namekey&"%' "
	end If
	did=trim(request.form("did"))
	'激活ID判断
	  if did<>"" then
	    sql=sql&" and userid in (select userid from tiaoxingma.dbo.e_user where did='"&did&"')"
	  end If 

	'订单类型	
	if leixing<>"" then 
	   if TestInteger(leixing)=False  Then 
	   response.write"订单类型必须是整数"
	   response.End 
	  End If 
	   sql=sql&" and dingdan_type="&leixing
	end if
	if shop_shfs<>"" then
		sql=sql&" and shopxp_shfs="&shop_shfs
	end if
	'发货日期 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"日期格式不正确"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),fksj,120)='"&post_date&"'"
	end If	
 	sql=sql&" order by om.dingdan desc"
 	'response.Write sql
	rs.open sql,conn 
	if rs.eof And rs.bof then
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
		Page_Menu_Init rs,page_size
        Dim Row
        Dim Data()
        Dim DinDan() 
        Dim Matrix() 
        Row=rs.PageSize
        if cint(Group_Num)>cint(row) then
            Group_Num=row
        end if  
        redim  Data(Row) 
        redim  DinDan(Row)
        redim  Matrix(Group_Num,Row)
		For ipage=1 To rs.PageSize
		
		dd=trim(rs("dingdan"))
		ename=rs("username")
		shouhuoname=rs("shouhuo_username")
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
		other_info=rs("other_info")
		fenxiao_userid=rs("fenxiao_userid")
		TapeColor=rs("TapeColor")
        Data(ipage)=rs("sumcount")
        DinDan(ipage)=rs("shopxpacid")
		if shouhuoname="" or isnull(shouhuoname) then
			shouhuoname=trim(rs("shouhuoname"))
		end if
		  %>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#FFFFFF">
            <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
            <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">花的少，买的多！</span></td>
            <td width="40%" align="center" nowrap class="bigtitle">电商网订单商品清单</td>
          </tr>
        </table>
        <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">订单号</td>
            <td width="16%" align="center">订单类型</td>
            <td width="14%" align="center">消费方式</td>
            <td width="15%" align="center">下单ID</td>
            <td width="20%" align="center">付款时间</td>
            <td width="15%" align="center">收货方式</td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td align="center"><input type="checkbox" name="dingdan" value="<%=trim(dd)%>">
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
				sql="select shopxpptid,productdanwei,shopxpptname,pv*productcount as zongpv,area_number,shopxp_yangshiid,huojiahao,zonger,jifen,bochu,productcount,danjia,p_size from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by area_number asc ,shopxpptname desc,huojiahao desc"
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
					ys=1
					zongpv=0
					zongji=0
				zongjifen=0
				do while not rss.eof
				%>
                <tr bgcolor="#FFFFFF" align="center">
                  <td nowrap style='PADDING-LEFT: 5px;' align="left"><%=rss("huojiahao")%>.<%=trim(rss("shopxpptname"))%></td>
                  <td nowrap><%=rss("productdanwei")%></td>
                  <td bgcolor="#FFFFFF"><%=rss("productcount")%></td>
                  <td align="left"><%=rss("p_size")%></td>
                  <td nowrap><%=rss("shopxpptid")%></td>
                  <td nowrap><%=rss("shopxp_yangshiid")%></td>
                </tr>
                <%
					ys=ys+1
					zongji=rss("zonger")+zongji
				zongjifen=rss("jifen")*rss("productcount")+zongjifen
				
					bochu=rss("bochu")*rss("productcount")+bochu
					 
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
				
				response.write "&nbsp;&nbsp;&nbsp;"&other_info
				
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
				 %>　　&nbsp;&nbsp;&nbsp;</div></td>
                </tr>
              </table></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="6" class="shdz" ><%=liuyan%>
              <%if dingdan_leixing="注册订单" then response.write "总广告费："&formatN(bochu)
		  		 if dingdan_leixing="注册订单" and zongpv>=1800 then response.write "开授权书"%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >姓名:<%=trim(shopxp_shiname)%>&nbsp;
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
              <%end if%></td>
            <td height="30"  colspan="2" class="shdz">联系方式:<%=trim(usertel)%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz"  >收货人：<%=trim(shouhuoname)%> &nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>&nbsp;物流公司:<%=sel_wuliugongshi%></td>
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
        <br>
        <span class="urlcss">产品售后：0371－66236936  感谢您的支持！</span> <br>
        <br>
      </td>
    </tr>
  </table>
  <% 
			rs.movenext
			if rs.eof then exit for
			next
			end if
			Dim i,k,j,Group
            Group=Group_Num
            function array_sum(k,length)
                dim i,sum
                sum=0
                for i=1 to length
                    sum=sum+Matrix(k,i)
                next 
                array_sum=sum   
            end function
            function input_array(k,i,value)
                Matrix(k,i)=value
                conn.execute("update order_agent_main set Group_Lable='第"&k&"组' where shopxpacid='"&DinDan(i)&"'")
            end function
            for i=1 to Group
                Matrix(i,1)=Data(Row+1-i)
                conn.execute("update order_agent_main set Group_Lable='第"&i&"组' where shopxpacid='"&DinDan(Row+1-i)&"'")
            next 
            k=1
            for i=1 to Row-Group+1
                  t = array_sum(k, Row)  
                for j=1 to Group
                    if (t > array_sum(j, Row)) then
                        t = array_sum(j, Row)
                        k = j
                    end if 
                next
                 response.Write input_array(k,i,data(i))
            next  
           
	%>
</form>
<%'分页
		alink="?dingdan="&dingdan&"&userid="&userid&"&username="&username&"&namekey="&namekey&"&leixing="&leixing&"&did="&did&"&post_date="&post_date&"&shfs="&shop_shfs
		Page_Menu rs,page_size,alink
        rs.close
        set rs=nothing
        conn.close
		%>
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