<!--#include file="../conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<html>
<head>
<title>订单已发货管理</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css" id="print"> 
td
{
font-size:12px;
} 
.dot
{
	
	border-bottom-style:dashed;border-bottom-width:1px;border-bottom-color:#ececec;
	border-right-style:dashed;border-right-width:1px;border-right-color:#ececec;
	border-left-style:dashed;border-left-width:1px;border-left-color:#ececec;
}
 
  .fxpt{
	font-size: 14px;
	text-decoration: none; 
}
 
 .bigtitle {
	font-size: 18px;
	text-decoration: none;
	font-weight: bold; 
}
 
.shdz {
	font-size: 16px;
	text-decoration: none;
	font-weight: bold; 
}
 
  .urlcss { 
	font-size: 12px;
	 
}
.STYLE1 {font-size: 16px}
</style> 

<link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="../js/js.js"></script>
</head>
<BODY>
<table width="1000" border="0" align="center" cellpadding="5" cellspacing="0">
	<tr>
		<th align="center" bgcolor="#D2DCE6">订单已发货</th>
	</tr>
</table>
<table width="804" border="0" align="center"   cellpadding="3" cellspacing="1" class="Noprint">
<form name="form1" method="post" action="DirectOrderPosted.asp">
<tr bgcolor="#FFFFFF">
	<td colspan="8">订单号
	  <input name="dingdan" type="text" id="dingdan" size="14" maxlength="30" >
	  &nbsp;&nbsp;下单人
	  <input name="username" type="text" size="10" maxlength="10">
	  &nbsp;收货人姓名
	  <input name="namekey" type="text" id="namekey" size="10" maxlength="10">
	  </td>
	</tr>
<tr bgcolor="#FFFFFF">
	<td width="9%">下单日期</td>
	<td width="14%"><input name="fksj" type="text" id="fksj"   onClick="return Calendar('fksj','');" size="10" maxlength="10" readonly></td>
	<td width="9%">发货日期</td>
	<td colspan="4">        <input name="post_date" type="text" id="post_date" size="10"  onClick="return Calendar('post_date','');" readonly>
        至
      <input name="end_date" type="text" id="Text1" size="10"  onClick="return Calendar('end_date','');" readonly></td>
	<td width="20%" ><input type="submit" name="Submit2" value="查 询"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan ="9" align ="right" >&nbsp;</td>
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
dim orderstr
dim payMethod
'获取查询表单值
dingdan=trim(request("dingdan"))
username=trim(request("username"))
namekey=trim(request("namekey"))
shouhuoname=trim(request("shouhuoname"))
shopxpptname=trim(request("shopxpptname"))
leixing=trim(request("leixing")) 
fksj=Trim(request("fksj"))
post_date=Trim(request("post_date"))
end_date=Trim(request("end_date"))
shop_shfs=trim(request("shfs"))
sid=trim(request("sid"))
if zhuangtai<>"" then
if not isnumeric(zhuangtai) then 
response.write"<script>alert(""非法访问!"");location.href=""../index.asp"";</script>"
response.end
end if
end if
if namekey="" then namekey=request.form("namekey")
%>
<form name="form2" action="DirectOrderPrint.asp?isPosted=ok" method="post" target="_blank">
<%Randomize   Timer() 
RefreshId=Int(Rnd(1)*1000+1) ''生成随机数用于防刷新
session("PrintOk")=RefreshId
%>
<input type="hidden" value="<%=RefreshId%>" name="PrintOk">
  <%
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from Direct_OrderMain where  zhifufangshi<>99 and zhuangtai>6"
	'订单号
	if dingdan<>"" then
		sql=sql&" and dingdan like '%"&dingdan&"%'"
	end If
    
	'下单人
	If username<>"" Then 
        sql=sql&" and shouhuoname='"&username&"' "
	End If 

    '收货人姓名
	if namekey<>"请输入姓名" and namekey<>"" then
	  sql=sql&" and shouhuoname like '%"&namekey&"%' "
	end If
	
	'下单日期 
	if fksj<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"日期格式不正确"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),fksj,120)='"&fksj&"'"
	end If	
	
	
	
		'发货日期 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"日期格式不正确"
		response.End 
	   End If 
	  sql=sql&" and fhsj >'"&post_date&"'"
	end if
	if end_date<>"" then
	sql=sql&" and fhsj <'"&dateadd("d",1,end_date)&"'"
	end if
	
 	sql=sql&" order by fksj desc"
 	''response.Write sql
	rs.open sql,conn,3  
	if rs.eof And rs.bof then
		Response.Write "<p align='center' class='contents'> 对不起，您选择的状态目前还没有订单！</p>"
		response.end
	else			
  %>
  <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top" nowrap> 全选
        <input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(form2)" value="Check All">
        <input type="submit" name="Submit" value="重新打单">
        <% 
		page_size=10
		Page_Menu_Init rs,page_size
		For ipage=1 To rs.PageSize
		
		dd=trim(rs("dingdan"))
		if orderstr="" then
		orderstr=dd
		else
		orderstr=orderstr&","&dd
		end if
		shopxp_shfs=rs("shopxp_shfs")
		dingdan_userid=rs("userid")
		fksj=rs("fksj")
		fhsj=rs("fhsj")
		''shopxp_shiname=rs("shopxp_shiname")
		usertel=rs("usertel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("shdz")
		seller_name=rs("seller_name")
		liuyan=rs("liuyan")
		payMethod=rs("zhifufangshi")
		cart_type=rs("cart_type")
		fapiao=rs("fapiao")
		feiyong=rs("freight")
		fenxiao_userid=rs("fenxiao_userid")
		shouhuoname=rs("shouhuoname")
		if shouhuoname="" or isnull(shouhuoname) then
			shouhuoname=trim(rs("shouhuoname"))
		end if
		IsFreightDelyPay=rs("IsFreightDelyPay")
        supplierid=rs("supplierid")
        post_city=""
        if supplierid="1" then
        post_city="<font color=red style='font-size:16px;'>银川仓</font>"
        else
        post_city="<font color=blue style='font-size:16px;'>广州仓</font>"
        end if
		  %>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#FFFFFF">
            <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
            <td width="81%" align="center" nowrap class="bigtitle">ERP2016订单商品清单</td>
          </tr>
        </table>
        <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">订单号</td>
            <td width="16%" align="center">订单类型</td>
            <td width="14%" align="center">下单ID</td>
            <td width="15%" align="center">付款时间</td>
            <td width="20%" align="center">发货打单时间</td>
            <td width="15%" align="center">收货方式</td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td align="center"><input type="checkbox" name="dingdan" value="<%=trim(dd)%>">
             <%=trim(dd)%></td>
            <td align="center">直营订单</td>
            <td align="center"><%=dingdan_userid%></td>
            <td align="center"><%=fksj%>
              <%if payMethod="19" then response.write "<font color=red>货到付款</font>"%></td>
            <td align="center"><%=fhsj%></td>
            <td align="center"><%=shfs(shopxp_shfs)%>            </td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td colspan="6" align="center">
			<%
				set rss=server.CreateObject("adodb.recordset") 
				sql="select * from Direct_OrderDetail  where dingdan='"&dd&"' order by shopxpptname desc"
               '' response.write sql
				rss.open sql,conn,3
%>
              <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" >
                <tr align="center" bgcolor="#FFFFFF">
                  <td width="41%">商品名称</td>
				  <td width="18%">样 式</td>
                  <td width="9%" nowrap>商品单位</td>
                  <td width="10%" nowrap>单价</td>
                  <td width="10%">订购数量</td>
                  <td width="12%" nowrap>小计</td>
                </tr>
                <%
					zongji=0
					allCount=0
				do while not rss.eof
				%>
                <tr bgcolor="#FFFFFF" align="center">
                  <td nowrap style='PADDING-LEFT: 5px;' align="left"><%=rss("huojiahao")%>.<%=trim(rss("shopxpptname"))%> --[<%=trim(rss("txm"))%>]</td>
				  <td align="left"><%=rss("p_size")%></td>
                  <td nowrap><%=rss("unit")%></td>
                  <td nowrap><%=rss("voucher")%></td>
                  <td bgcolor="#FFFFFF"><%=rss("productcount")%></td>
                  <td nowrap><%=rss("zonger")%></td>
                </tr>
                <%
					ys=ys+1
					zongji=cdbl(rss("zonger"))+zongji
					allCount=allCount+rss("productcount")
				rss.movenext
				loop
				rss.close
				set rss=nothing
			%>
                <tr bgcolor="#FFFFFF">
                  <td colspan="6"><div align="right">
				<%
				   response.write "商品总额："&formatN(zongji)&"元"
				    response.Write ",物流费用："&feiyong&"元"
				 %>&nbsp;
				  </div></td>
                </tr>
              </table></td>
          </tr>

          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" class="shdz" >&nbsp;收货人:&nbsp;              </td>
            <td height="30" class="shdz" ><%=trim(shouhuoname)%></td>
            <td height="30" class="shdz" >联系电话</td>
            <td height="30" class="shdz" ><%=trim(usertel)%></td>
            <td height="30" class="shdz">商品数量</td>
            <td height="30" align="center" class="shdz"><%=allCount%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >&nbsp;收货地址:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>
			 <%
                if IsFreightDelyPay="1" then
                    response.Write "<font color='red'>运费到付</font>"
                end if
             %>
			</td>
            <td class="shdz">&nbsp;</td>
            <td class="shdz">&nbsp;</td>
          </tr>
		            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="6" class="shdz" ><%if liuyan<>"" then response.write "留言：<font style='font-size:12px;font-weight:normal;'>"&liuyan&"</font>"%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" >商家名称：</td>
            <td height="30" colspan="2" ><%=seller_name%>(<%=post_city%>)</td>
            <td height="30" >售后电话：</td>
            <td height="30" colspan="2" >400 867 9900</td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
  <% 
			rs.movenext
			if rs.eof then exit for
			next
			end if
           
	%>
</form>
<%'分页
		alink="DirectOrderPosted.asp?sid="&sid&"&dingdan="&dingdan&"&userid="&userid&"&username="&username&"&namekey="&namekey&"&leixing="&leixing&"&did="&did&"&post_date="&post_date&"&shfs="&shop_shfs
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