<!--#include file="../conn.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<html>
<head>
<title>��������Ϣ</title>
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
	response.write"<script>alert(""�Ƿ�����!"");window.close();</script>"
	response.end
end if

set rs=server.CreateObject("adodb.recordset") 
sql="select  IsFreightDelyPay,SuggestFreight,province,city,xian,fahuo_op_user,fahuo_memo,fhsj,actiondate,shopxp_shiname,shouhuoname,dingdan,reply,liuyan,zhifufangshi,shopxp_shfs,zhuangtai,usertel,shopxp_shdz,fapiao,feiyong,userid,shouhuo_username  from order_agent_main where dingdan='"&dingdan&"' "
if shopxp_shfs<>"" then
	select case shopxp_shfs
	case "23"
		sql=sql&" and shopxp_shfs=23 "
		str="չ���ֿ�"
	case  else
		sql=sql&" and shopxp_shfs<>23 and shopxp_shfs<>27 "
		str="���ֿ߲�"
	end select
end if
'response.write sql
rs.open sql,conn,1,1
if rs.eof and rs.bof then
	response.write "<p align=center><font color=red>�˶���������Ʒ�ѱ�����Աɾ�����޷�������ȷ���㡣<br>��������ȡ�������ֶ�ɾ���˶�����</font></p>"
else
%>
<table class="tableBorder" width="800" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#FFFFFF">
  <tr>
    <td colspan="4" align="center"><b><%=str%>��������ϸ</b></td>
  </tr>
  <tr bgcolor="#EFF5FE">
    <td colspan="2" align="center"><table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="89%" align="center">������Ϊ��<%=dingdan%> ����ϸ�������£�</td>
          <td width="11%" align="center"><input type="button" name="Submit4" value="�� ӡ" onClick="javascript:window.print()">
          </td>
        </tr>
      </table></td>
  </tr>
  <tr>
    <td width="13%" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>����״̬��</td>
    <td width="87%" bgcolor="#EFF5FE"><font color="#FF0000"><%=Order_States(rs("zhuangtai"))%></font></td>
  </tr>
  <tr>
    <td width="13%" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>��Ʒ�б�</td>
    <td bgcolor="#EFF5FE">
		<table width="98%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#CCCCCC">
        <tr>
          <td bgcolor="#EFF5FE" align="center">��Ʒ����</td>
          <td bgcolor="#EFF5FE" align="center">��������</td>
          <td bgcolor="#EFF5FE" align="center">�� ʽ</td>
          <td bgcolor="#EFF5FE" align="center">TXM</td>
          <td bgcolor="#EFF5FE" align="center">�� ��</td>
          <td bgcolor="#EFF5FE" align="center">���С��</td>
          <td bgcolor="#EFF5FE" align="center">����С��</td>
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
            <%if rss("is_tejia")=1 then response.write "<font color=red>���ؼۣ�</font>"%></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("productcount")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("p_size")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("TXM")%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("danjia")&"Ԫ"%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("zonger")&"Ԫ"%></div></td>
          <td bgcolor="#EFF5FE"><div align="center"><%=rss("productcount")*rss("bochu")&"Ԫ"%></div></td>
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
          <td colspan="7"><b><font color="red">�����Ʒ</font></b></td>
        </tr>
		<tr>
          <td bgcolor="#EFF5FE" align="center" colspan="2">��Ʒ����</td>
          <td bgcolor="#EFF5FE" align="center" colspan="2">�� ʽ</td>
          <td bgcolor="#EFF5FE" align="center" >TXM</td>
		  <td bgcolor="#EFF5FE" align="center">��������</td>
          <td bgcolor="#EFF5FE" align="center">����˵��</td>
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
          <td colspan="7" bgcolor="#EFF5FE"><div align="right">��Ʒ������<%=PCount %>���������ܶ<%=zongji %>Ԫ
          <%
          if(zongjifen>0) then
            response.Write "���֣�"&zongjifen
            end if
                    
				    if rs("IsFreightDelyPay")=1 then
				        myzongji=rs("SuggestFreight")
				        response.Write ""
				    else
				        myzongji=rs("feiyong")
				        response.Write "  ���ã�"&rs("feiyong")&"Ԫ"
				    end if
				 %>�������ƣ�<%=zongji+myzongji%>Ԫ 
               ����<%=bochu%>Ԫ&nbsp;&nbsp;&nbsp;&nbsp;</div></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�ջ���������</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("shouhuo_username"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�ջ���ַ��</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("province"))%><%=trim(rs("city"))%><%=trim(rs("xian"))%><%=trim(rs("shopxp_shdz"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>��ϵ�绰��</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("usertel"))%></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�ͻ���ʽ��</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=shfs(rs("shopxp_shfs"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>֧����ʽ��</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=zhifufangshi(rs("zhifufangshi"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�˷Ѹ��ʽ��</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>
        <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write "�ָ�"
                else
                    response.Write "<font color='red'>����</font>"
                end if
             %>
    </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�û����ԣ�</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("liuyan"))%> </td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>��������</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><table width="500" height="62" border="0" cellpadding="0" cellspacing="0">
        <form name="form5" method="post" action="order_save_info.asp?dan=<%=dingdan%>&action=fahuo_memo&userid=<%=rs("userid")%>">
          <tr>
            <td><textarea name="fahuo_memo" cols="50" rows="4" class="wenbenkuang" id="fahuo_memo"><%=rs("fahuo_memo")%></textarea>
              <input class="go-wenbenkuang" type="submit" name="Submit52" value="��������">
            </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>վ�����ԣ�</td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=trim(rs("reply"))%>
      <table width="500" height="62" border="0" cellpadding="0" cellspacing="0">
        <form name="form5" method="post" action="order_save_info.asp?dan=<%=dingdan%>&action=liuyan&userid=<%=rs("userid")%>">
          <tr>
            <td><textarea name="reply" cols="50" rows="4" class="wenbenkuang"><%=trim(rs("liuyan"))%></textarea>
              <input class="go-wenbenkuang" type="submit" name="Submit5" value="��������">
            </td>
          </tr>
        </form>
      </table></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>������</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("fahuo_op_user")%></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>��������</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("fhsj")%></td>
  </tr>
  <tr>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>�µ����ڣ�</td>
    <td height="20" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'><%=rs("actiondate")%></td>
  </tr>
  <tr>
    <td height="30" bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'></td>
    <td bgcolor="#EFF5FE" style='PADDING-LEFT: 10px'>&nbsp;
      <input type="button" name="Submit2" value="�رմ���" onClick=javascript:window.close()>
    </td>
  </tr>
</table>
<%end if
rs.close
set rs=nothing
%>
</body>
</html>
