<!--#include file="../conn.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<html>
<head>
<title>代理订单信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
</head>
<body>
<%
dingdan=trim(request("dan"))
shopxp_shfs=trim(request("shopxp_shfs"))
PCount=0
if isnull(dingdan) or dingdan="" then
	response.write"<script>alert(""非法访问!"");window.close();</script>"
	response.end
end if

set rs=server.CreateObject("adodb.recordset") 
sql="select  IsFreightDelyPay,SuggestFreight,province,city,xian,fahuo_op_user,fahuo_memo,fhsj,actiondate,shopxp_shiname,shouhuoname,dingdan,reply,liuyan,zhifufangshi,shopxp_shfs,zhuangtai,usertel,shopxp_shdz,fapiao,feiyong,userid,shouhuo_username  from order_agent_main where dingdan='"&dingdan&"' "
if shopxp_shfs<>"" then
	select case shopxp_shfs
	case "23"
		sql=sql&" and shopxp_shfs=23 "
		str="展厅仓库"
	case  else
		sql=sql&" and shopxp_shfs<>23 and shopxp_shfs<>27 "
		str="二七仓库"
	end select
end if
'response.write sql
rs.open sql,conn,1,1
if rs.eof and rs.bof then
	response.write "<p align=center><font color=red>此订单中有商品已被管理员删除，无法进行正确计算。<br>订单操作取消，请手动删除此订单！</font></p>"
else
%>
<table class="tableBorder" width="800" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
  <tr>
    <td colspan="4" align="center"><b><%=str%>代理订单详细</b></td>
  </tr>
  <tr bgcolor="#EFF5FE">
    <td colspan="2" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="89%" align="center">订单号为：<%=dingdan%> ，详细资料如下：</td>
          <td width="11%" align="center"><input type="button" name="Submit4" value="打 印" onClick="javascript:window.print()">
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="13%" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>订单状态：</td>
    <td width="87%" bgcolor="#EFF5FE"><font color="#FF0000"><%=Order_States(rs("zhuangtai"))%></font></td>
  </tr>
  <tr>
    <td width="13%" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>商品列表：</td>
    <td bgcolor="#EFF5FE">
		<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
        <tr>
          <td bgcolor="#EFF5FE" align="center">商品名称</td>
          <td bgcolor="#EFF5FE" align="center">订购数量</td>
          <td bgcolor="#EFF5FE" align="center">样 式</td>
          <td bgcolor="#EFF5FE" align="center">TXM</td>
          <td bgcolor="#EFF5FE" align="center">价 格</td>
          <td bgcolor="#EFF5FE" align="center">金额小计</td>
          <td bgcolor="#EFF5FE" align="center">广告费小计</td>
        </tr>
        <%
            myuserid=rs("userid")
            if (myuserid="" or myuserid=null) then
                myuserid=0
            end if
			set rss=server.CreateObject("adodb.recordset")
			rss.open "select is_tejia,shopxpptid,shopxpptname,p_size,danjia,zonger,jifen,case when  cast('"&rs("actiondate")&"' as datetime)> cast('2010-09-16 12:00:00' as datetime) then bochu  else productcount*pv end as bochu,productcount,TXM from order_agent_prodetail where dingdan='"&rs("dingdan")&"' and userid="&myuserid,conn,3
			zongji=0
			zongjifen=0
			do while not rss.eof
		%>
        <tr>
          <td bgcolor="#EFF5FE" style='PADDING-LEFT: 5px'><%=trim(rss("shopxpptname"))%>
            <%if rss("is_tejia")=1 then response.write "<font color=red>（特价）</font>"%></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("productcount")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("p_size")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("TXM")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("danjia")&"元"%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("zonger")&"元"%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("productcount")*rss("bochu")&"元"%></div></td>
        </tr>
        <%
			zongji=rss("zonger")+zongji
			zongjifen=rss("jifen")*rss("productcount")+zongjifen
			bochu=rss("productcount")*rss("bochu")+bochu
			PCount=PCount+rss("productcount")
			rss.movenext
			if rss.eof then exit do
			loop
			rss.close
			set rss=nothing
		%>
        <tr>
          <%
			set zprs=server.CreateObject("adodb.recordset") 
			zpsql = " select shopxpptname,productcount,p_size,other_info,TXM from Order_present_Agent where dingdan = '"&rs("dingdan")&"'"									
			zprs.open zpsql,conn,3
			if not zprs.eof then
		%>
        <tr>
          <td colspan="7"><b><font color="red">相关赠品</font></b></td>
        </tr>
		<tr>
          <td bgcolor="#EFF5FE" align="center" colspan="2">商品名称</td>
          <td bgcolor="#EFF5FE" align="center" colspan="2">样 式</td>
          <td bgcolor="#EFF5FE" align="center" >TXM</td>
		  <td bgcolor="#EFF5FE" align="center">赠送数量</td>
          <td bgcolor="#EFF5FE" align="center">其他说明</td>
        </tr>
        <% do while not zprs.eof %>
        <tr bgcolor="#FFFFFF">
          <td nowrap style='PADDING-LEFT: 5px;' colspan="2"><%=trim(zprs("shopxpptname"))%></td>
          <td bgcolor="#FFFFFF" style='PADDING-LEFT: 5px;' colspan="2"><%=zprs("p_size")%></td>
          <td nowrap ><%=zprs("TXM")%></td>
		  <td nowrap ><%=zprs("productcount")%></td>
          <td bgcolor="#FFFFFF"><%=zprs("other_info")%></td>
        </tr>
        <%
            PCount=PCount+zprs("productcount")
			zprs.movenext
			Loop
			end if
			Set zprs=Nothing 
		%>
        <tr>
          <td colspan="7" bgcolor="#EFF5FE"><div align="right">产品数量：<%=PCount %>　　订单总额：<%=zongji %>元
          <%
          if(zongjifen>0) then
            response.Write "积分："&zongjifen
            end if
                    
				    if rs("IsFreightDelyPay")=1 then
				        myzongji=rs("SuggestFreight")
				        response.Write ""
				    else
				        myzongji=rs("feiyong")
				        response.Write "  费用："&rs("feiyong")&"元"
				    end if
				 %>　　共计：<%=zongji+myzongji%>元 
               广告费<%=bochu%>元&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>收货人姓名：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("shouhuo_username"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>收货地址：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("province"))%><%=trim(rs("city"))%><%=trim(rs("xian"))%><%=trim(rs("shopxp_shdz"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>联系电话：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("usertel"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>送货方式：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=shfs(rs("shopxp_shfs"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>支付方式：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=zhifufangshi(rs("zhifufangshi"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>运费付款方式：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>
        <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write "现付"
                else
                    response.Write "<font color='red'>到付</font>"
                end if
             %>
    </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>用户留言：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("liuyan"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>发货留言</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><table width="500" height="62" border="0" cellpadding="0" cellspacing="0">
        <form name="form5" method="post" action="order_save_info.asp?dan=<%=dingdan%>&action=fahuo_memo&userid=<%=rs("userid")%>">
          <tr>
            <td><textarea name="fahuo_memo" cols="50" rows="4" class="wenbenkuang" id="fahuo_memo"><%=rs("fahuo_memo")%></textarea>
              <input class="go-wenbenkuang" type="submit" name="Submit52" value="保存留言">
            </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>站长留言：</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("reply"))%>
      <table width="500" height="62" border="0" cellpadding="0" cellspacing="0">
        <form name="form5" method="post" action="order_save_info.asp?dan=<%=dingdan%>&action=liuyan&userid=<%=rs("userid")%>">
          <tr>
            <td><textarea name="reply" cols="50" rows="4" class="wenbenkuang"><%=trim(rs("liuyan"))%></textarea>
              <input class="go-wenbenkuang" type="submit" name="Submit5" value="保存留言">
            </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>发货人</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("fahuo_op_user")%></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>发货日期</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("fhsj")%></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>下单日期：</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("actiondate")%></td>
  </tr>
  <tr>
    <td height="30" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'></td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>&nbsp;
      <input type="button" name="Submit2" value="关闭窗口" onClick=javascript:window.close()>
    </td>
  </tr>
</table>
<%end if
rs.close
set rs=nothing
%>
</body>
</html>
