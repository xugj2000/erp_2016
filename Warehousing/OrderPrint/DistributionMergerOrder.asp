<!--#include file="../conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<html>
<head>
<title>��������ƴ��δ��������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="../js/tjsetday.js"></script>
<script language="javascript" type="text/javascript" src="../js/js.js"></script>
</head>
<body>
<%
dim shouhuo_userid
Dim shouhuo_username
Dim userid
Dim username
Dim shopxpptname
Dim post_date

shouhuo_username=trim(request("shouhuo_username"))     '�ջ�������
shouhuo_userid=trim(request("shouhuo_userid"))         '�ջ��˷������ĺ�
userid=trim(request.QueryString("userid"))                           '�µ���ID
dingdan=trim(request("dingdan"))                 '��Ʒ��
post_date=trim(request("post_date"))                    '��������

if shouhuo_userid<>"" then
if not isnumeric(shouhuo_userid) then 
response.write"<script>alert(""�Ƿ�����!"");location.href=""../default.asp"";</script>"
response.end
end if
end if
%>
<table width="1000" border="0" align="center" cellpadding="4" cellspacing="0">
	<tr>
		<th height="30" align="center">��������ƴ��δ��������</th>
	</tr>
	
</table>
<table width="1000" border="0" align="center" cellpadding="1" cellspacing="1">
	<tr>
		<form name="form1" method="post" action="DistributionMergerOrder.asp">
			<td>�����&nbsp;&nbsp;
				<input name="shouhuo_userid" type="text" id="shouhuo_userid" size="14" >
				&nbsp;
				�ջ�����
				<input name="shouhuo_username" type="text" id="shouhuo_username" size="14" >
				&nbsp;
				�µ�ID
				<input name="userid" type="text" id="userid" value="" size="14" >
				&nbsp;<br>
				������
				<input name="dingdan" type="text"   size="14">
				&nbsp;�µ�����
				<input name="post_date" type="text" id="post_date" size="14"  onClick="return Calendar('post_date','');">
				<span style="color:red;">&nbsp;&nbsp;���ڸ�ʽ��<%=date%></span>&nbsp;
				<input type="submit" name="Submit2" value="�� ѯ">
			</td>
		</form>
	</tr>
	<tr align="center">
		<td>&nbsp;</td>
	</tr>
</table>
<%
	set rs_fh=server.CreateObject("adodb.recordset")
	''sql_fh="select distinct sa.shouhuo_userid from order_distribution_main as sa inner join fenxiao as fx on sa.shouhuo_userid=fx.userid where sa.shouhuo_userid is not null and sa.shopxp_shfs=25 and (sa.zhuangtai=3 or sa.dingdan in (select dingdan from Distribution_Nodelivery where zhuangtai=3 ))  and fx.checked=1 "
		sql_fh="select distinct sa.shouhuo_userid from order_distribution_main as sa  where sa.LocalInit=1 and sa.shouhuo_userid is not null and sa.shopxp_shfs=25 and sa.zhuangtai=3 "
	rs_fh.open sql_fh,conn,3
	uid=""
	if not (rs_fh.eof and  rs_fh.bof ) then
		do while not rs_fh.eof 
			uid=uid&","&trim(rs_fh("shouhuo_userid"))
		rs_fh.movenext
		if rs_fh.eof then exit do
		loop
	else
		uid=""
	end if
	rs_fh.close
	set rs_fh=nothing
	if uid<>"" then
		uid=right(uid,len(uid)-1)
	end if
	set rs=server.CreateObject("adodb.recordset")
	sql="select oam.shouhuo_userid,oam.shouhuo_username,zonger=sum(oap.zonger),oam.province,oam.city,oam.xian from order_distribution_main as oam inner join order_distribution_prodetail as oap on oam.dingdan=oap.dingdan and oam.userid=oap.userid where oam.LocalInit=1 and oam.shouhuo_userid is not null and oam.shopxp_shfs=25 and oam.zhuangtai=3"
    '�ջ��˷������ĺ�
	if shouhuo_userid<>"" then
	  sql=sql&" and oam.shouhuo_userid="&shouhuo_userid&""
	end If
	
	'�ջ�������
	if shouhuo_username<>"" then
	  sql=sql&" and oam.shouhuo_username like '%"&shouhuo_username&"%'"
	end If
	if dingdan<>"" then
		sql=sql&" and oam.dingdan='"&dingdan&"'"
	end if
	'�µ�ID
	If userid<>"" Then 

	 if TestInteger(userid)=False  Then 
	   response.write"�µ�ID����������"
	   response.End 
	  End If 

	  sql=sql&" and oam.userid="&userid 

	End If 
    
	'�������� 
	if post_date<>"" Then
		If IsDate(post_date)=False Then 
	    	response.write"���ڸ�ʽ����ȷ"
			response.End 
	   	End If 
	  	sql=sql&" and CONVERT (varchar(10),oam.fksj,120)='"&post_date&"'"
	end if
	
	sql=sql&" group by oam.province,oam.city,oam.xian,oam.shouhuo_userid,oam.shouhuo_username "
	rs.open sql,conn,3  
	
	if rs.eof And rs.bof then
		Response.Write "<p align='center' class='contents'> �Բ�����������ݣ�</p>"
		''response.end
	else	
%>
<table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td valign="top">
<form name="form2" action="fenxiao_editdingdan_new_sel_print.asp?action=fahuo" method="post" target="_blank">
<%Randomize   Timer() 
RefreshId=Int(Rnd(1)*1000+1) ''������������ڷ�ˢ��
session("PrintOk")=RefreshId
%>
<input type="hidden" value="<%=RefreshId%>" name="PrintOk">
	ȫѡ<input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(form2)" value="Check All"><input type="submit" name="Submit" value="������ӡ����">
<table width="800" border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="#DDDDDD">
	<tr align="center">
		<td width="6%" bgcolor="#3182B3"  class="td_title">���</td>
		<td width="24%" bgcolor="#3182B3" class="td_title">���˷ѱ�׼</td>
		<td width="30%" bgcolor="#3182B3" class="td_title">��������ķ�����׼</td>
		<td width="15%" bgcolor="#3182B3" class="td_title">�ջ��˷������ĺ�</td>
        <td width="15%" bgcolor="#3182B3" class="td_title">�ջ�������</td>
		<td width="10%" bgcolor="#3182B3" class="td_title">�������</td>
	</tr>
	<%
		page_size=10
		Page_Menu_Init rs,page_size
		For ipage=1 To rs.PageSize
			if rs("province")<>"" Then
				
				'�µĶ��������پ���������
				set ck_wu=conn.execute("select freePostMoney from dbo.PostFee_Compute(26,'"&rs("province")&"','"&rs("city")&"','"&rs("xian")&"') ")
				if not (ck_wu.eof and ck_wu.bof) then
					free_post_money=ck_wu("freePostMoney")
				else
					free_post_money=1500
				end if
			else
				free_post_money=1500
			end if
	%>
	<tr align="center" >
		<td bgcolor="#5B9AD9" class="td_smalltitle"><%=ipage%></td>
		<td colspan="2" bgcolor="#5B9AD9" class="td_smalltitle">
			<% 
				if clng(rs("zonger"))>=free_post_money then
					response.Write "�����������Է���" 
				else 
					response.Write "<font color=red>���ν���������"&free_post_money&"Ԫ</font>" 	
				end if
			%>
		</td>
		<td bgcolor="#5B9AD9" class="td_smalltitle"><%=trim(rs("shouhuo_userid"))%></td>
        <td bgcolor="#5B9AD9" class="td_smalltitle"><%=trim(rs("shouhuo_username"))%></td>
        <td bgcolor="#5B9AD9" class="td_smalltitle"><%=formatN(rs("zonger"))%></td>
	</tr>
	<tr>
		<td colspan="6">
			<%
				set rss=server.CreateObject("adodb.recordset")
				sqls="select dingdan,userid,convert(varchar(10),actiondate,120) as actiondate,dingdan_type from order_distribution_main where shopxp_shfs=25 and zhuangtai=3 and shouhuo_userid="&trim(rs("shouhuo_userid"))
				rss.open sqls,conn,3
				if rss.eof and  rss.bof then
					response.Write "���޶�����Ϣ"
				else
			%>
			<table width="99%" border="1" align="center" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC">
				<tr>
					<td colspan="4" align="left" style="font-weight:bold; padding-left:5px;">��<%=trim(rs("shouhuo_userid"))%>��ص�ƴ��</td>
				</tr>
				<tr align="center">
					<td width="24%">������</td>
					<td width="20%">�µ���ID</td>
					<td width="26%">��������</td>
					<td width="30%">�µ�ʱ��</td>
				</tr>
				<%
		do while not rss.eof
		dd=rss("dingdan")
		if orderstr="" then
		orderstr=dd
		else
		orderstr=orderstr&","&dd
		end if
				%>
				<tr align="center">
					<td align="left"><input type="checkbox" name="dingdan" value="<%=trim(rss("dingdan"))%>">&nbsp;<a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=trim(rss("dingdan"))%>&shopxp_shfs=25','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(rss("dingdan"))%></a></td>
					<td><%=trim(rss("userid"))%></td>
					<td><% if rss("dingdan_type")=1 then response.Write "ע�ᶩ��" else if rss("dingdan_type")=3 then response.Write "��������" else if rss("dingdan_type")=2 then response.Write "���ν�������" end if%></td>
					<td><%=trim(rss("actiondate"))%></td>
				</tr>
				<%
					rss.movenext
					if rss.eof then exit do
					loop
				%>
			</table>
			<%
				end if
				rss.close
				set rss=nothing
			%>
		</td>
	</tr>
		 
          <% 
			rs.movenext
			if rs.eof then exit for
			next
			
			%>
        </table>
      </form>
      <%'��ҳ
		alink="?shouhuo_username="&request("shouhuo_username")&"&shouhuo_userid="&request("shouhuo_username")&"&userid="&request.QueryString("userid")&"&username="&request("username")&"&dingdan="&request("dingdan")&"&post_date="&request("post_date")
		Page_Menu rs,page_size,alink
		
		%>
    </td>
  </tr>
</table>
<%end if 
rs.close
set rs=nothing
%>
<iframe id="fanliiframe" name="fanliiframe"  src="getNewCancel.aspx?bigtype=1&orderstr=<%=orderstr%>&t=<%=now()%>" scrolling=no width="1" height="1" marginWidth=0 marginHeight=0 frameborder=0 border=0 style="display:none"></iframe>
</body>
</html>
<script language=javascript runat=server>
  
 
// ��֤�Ƿ�Ϊ����
function TestInteger(src)
{
  var sxf,regex;
 sxf='^[\\d]{1,}$';
  regex=new RegExp(sxf);
  return regex.test(src);
} 
 
</script>
