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
<title>��ֿ��������δ����</title>
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
		<td align="center">��ֿ��������δ����</td>
	</tr>
</table>
<table width="1000" border="0" align="center"   cellpadding="5" cellspacing="1" bgcolor="#D2DCE6" class="Noprint">
<form name="form1" method="post" action="tiaohuo_Order_Detail_list.asp" >
<tr bgcolor="#FFFFFF">
	<td width="8%">������</td>
	<td width="19%"><input name="dingdan" type="text" id="dingdan" size="14" ></td>
	<td width="8%">�µ�ID</td>
	<td width="11%"><input name="userid" type="text" id="userid" value="" size="7" ></td>
	<td width="11%">�µ�������</td>
	<td width="19%"><input name="username" type="text"   size="14"></td>
	<td width="9%">�ջ�������</td>
	<td width="15%"><input name="namekey" type="text" id="namekey" size="14"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>��������</td>
	<td><select name="leixing" id="leixing">
			<option value="" selected>--ѡ���ѯ����--</option>
          	<option value="">ȫ����������</option>
          	<option value="1">ע�ᶩ��</option>
          	<option value="2">���ν���</option>
			<option value="3">��������</option>
        </select>
	</td>
	<td>�����ID</td>
	<td><input name="did" type="text" id="did" size="7"></td>
	<td>�ջ���ʽ</td>
	<td><select name="shfs" id="shfs">
			<option value="" selected>--ѡ���ջ���ʽ--</option>
          	<option value="">ȫ����ʽ</option>
          	<option value="3">��ݷ���</option>
          	<option value="26">��������</option>
        </select>
	</td>
	<td>�µ�����</td>
	<td><input name="post_date" type="text" id="post_date" size="14"  onClick="return Calendar('post_date','');"><span style="color:red;"><br>
	���ڸ�ʽ��<%=date%></span></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan="7"></td>
</tr>
</form>
</table>
<br>
<%
Dim namekey  '�µ�������
Dim dingdan  '������
Dim leixing   '��������
Dim userid
Dim shouhuoname
Dim shopxpptname
Dim did
Dim post_date
Dim username

'��ȡ��ѯ��ֵ
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
response.write"<script>alert(""�Ƿ�����!"");location.href=""../index.asp"";</script>"
response.end
end if
end if
if namekey="" then namekey=request.form("namekey")
%>
<form name="form2" action="Agent_Order_Detail_Print.asp" method="post" target="_blank">
  <%
	conn.cursorlocation=3
	set rs=server.CreateObject("adodb.recordset")
	sql="select IsFreightDelyPay,SuggestFreight,Group_Lable,TapeColor,shopxpacid,op.sumcount ,op.dingdan,sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '�̳Ƕ���' when xiaofeifangshi=1 then '����������' when xiaofeifangshi=3 then '�������Ĵ��¶���' when xiaofeifangshi=4 then '���������������' end,dingdan_leixing=case when dingdan_type=3 then '��������' when dingdan_type=2 then '���ν���' else 'ע�ᶩ��' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,feiyong,fenxiao_userid,other_info from order_agent_main  om ,(SELECT dingdan,sum(sumcount) as sumcount from (SELECT dingdan, SUM(productcount) AS sumcount FROM order_agent_prodetail GROUP BY dingdan union all SELECT dingdan, SUM(productcount) AS sumcount from order_present_agent group by dingdan)aa group by dingdan ) op  where shopxp_shfs not in (23,25,27,29) and om.zhuangtai=3 and  om.dingdan=op.dingdan and om.is_tiaohuan=1 and om.LocalInit=1"
	'������
	if dingdan<>"" then
		sql=sql&" and op.dingdan='"&dingdan&"'"
	end If

	'�µ�ID
	If userid<>"" Then 

	 if TestInteger(userid)=False  Then 
	   response.write"�µ�ID����������"
	   response.End 
	  End If 
	  sql=sql&" and userid="&userid 
	End If 
    
	'�µ�������
	If username<>"" Then 
        sql=sql&" and shopxp_shiname='"&username&"' "
	End If 
    '�ջ�������
	if namekey<>"����������" and namekey<>"" then
	  sql=sql&" and shouhuo_username like '%"&namekey&"%' "
	end If
	did=trim(request.form("did"))
	'����ID�ж�
	  if did<>"" then
	    sql=sql&" and userid in (select userid from tiaoxingma.dbo.e_user where did='"&did&"')"
	  end If 

	'��������	
	if leixing<>"" then 
	   if TestInteger(leixing)=False  Then 
	   response.write"�������ͱ���������"
	   response.End 
	  End If 
	   sql=sql&" and dingdan_type="&leixing
	end if
	if shop_shfs<>"" then
		sql=sql&" and shopxp_shfs="&shop_shfs
	end if
	'�������� 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"���ڸ�ʽ����ȷ"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),fksj,120)='"&post_date&"'"
	end If	
 	sql=sql&" order by om.dingdan desc"
 	'response.Write sql
	rs.open sql,conn 
	if rs.eof And rs.bof then
		Response.Write "<p align='center' class='contents'> �Բ�����ѡ���״̬Ŀǰ��û�ж�����</p>"
		response.end
	else			
  %>
  <table width="1000" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
      <td valign="top" nowrap> ȫѡ
        <input name="chkall" type="checkbox" id="chkall" onClick="CheckAll(form2)" value="Check All">
        <input type="submit" name="Submit" value="������ӡ����">
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
            <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">�����٣���Ķ࣡</span></td>
            <td width="40%" align="center" nowrap class="bigtitle">������������Ʒ�嵥</td>
          </tr>
        </table>
        <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">������</td>
            <td width="16%" align="center">��������</td>
            <td width="14%" align="center">���ѷ�ʽ</td>
            <td width="15%" align="center">�µ�ID</td>
            <td width="20%" align="center">����ʱ��</td>
            <td width="15%" align="center">�ջ���ʽ</td>
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
                  <td width="12%">��Ʒ����</td>
                  <td width="21%" nowrap>��Ʒ��λ</td>
                  <td width="21%">��������</td>
                  <td width="67%">�� ʽ</td>
                  <td width="21%" nowrap>��Ʒ���</td>
                  <td width="21%" nowrap>��ʽID</td>
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
							<th align="center" colspan="5">��Ʒ��Ϣ</th>
						</tr>
						<tr align="center">
							<td>��Ʒ����</td>
							<td>��λ</td>
							<td>��ʽ</td>
							<td>��������</td>
							<td>����˵��</td>
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
                response.write "������ѿ���Ʊ"
               
                end If     
				
				response.write "&nbsp;&nbsp;&nbsp;"&other_info
				
				 if zongjifen=0 then 
				    response.write "�����ܶ"&zongji&"Ԫ"
				else
				    response.write "�����ܶ"&formatN(zongji)&"Ԫ,���֣�"&zongjifen
				end if
				
				
				    if rs("IsFreightDelyPay")=1 then
				        response.Write ""
				    else
				        response.Write ",���ã�"&feiyong&"Ԫ"
				    end if
				 %>����&nbsp;&nbsp;&nbsp;</div></td>
                </tr>
              </table></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="6" class="shdz" ><%=liuyan%>
              <%if dingdan_leixing="ע�ᶩ��" then response.write "�ܹ��ѣ�"&formatN(bochu)
		  		 if dingdan_leixing="ע�ᶩ��" and zongpv>=1800 then response.write "����Ȩ��"%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >����:<%=trim(shopxp_shiname)%>&nbsp;
              <%if not isnull(dingdan_userid) and dingdan_userid<>0 then%>
              ����꣺
              <%

			  sql="select did,username from tiaoxingma.dbo.e_user where userid='"&dingdan_userid&"'"
			  set rsd=server.CreateObject("adodb.recordset")
			  rsd.open sql,conn,3
			  if not(rsd.eof and rsd.bof) then
			  if rsd("did")="0" then
			    response.write "��̨����"
			  else
			    response.write rsd("did")&" �������������"&rsd("username")
			  end If
			  end if
			  rsd.close
			  Set rsd=Nothing 
			  %>
              <%end if%></td>
            <td height="30"  colspan="2" class="shdz">��ϵ��ʽ:<%=trim(usertel)%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz"  >�ջ��ˣ�<%=trim(shouhuoname)%> &nbsp;�ջ���ַ:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%>&nbsp;������˾:<%=sel_wuliugongshi%></td>
            <td class="shdz">
                
                <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write ""
                else
                    response.Write "�˷Ѹ��ʽ��<font color='red'>����</font>"
                end if
             %>
            </td>
            <td class="shdz">������ɫ:<%=TapeColor%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" >����ˣ�</td>
            <td height="30" >&nbsp;</td>
            <td >����ˣ�</td>
            <td height="30" >&nbsp;</td>
            <td height="30" >�����ˣ�</td>
            <td height="30" >&nbsp;</td>
          </tr>
        </table>
        <br>
        <span class="urlcss">��Ʒ�ۺ�0371��66236936  ��л����֧�֣�</span> <br>
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
                conn.execute("update order_agent_main set Group_Lable='��"&k&"��' where shopxpacid='"&DinDan(i)&"'")
            end function
            for i=1 to Group
                Matrix(i,1)=Data(Row+1-i)
                conn.execute("update order_agent_main set Group_Lable='��"&i&"��' where shopxpacid='"&DinDan(Row+1-i)&"'")
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
<%'��ҳ
		alink="?dingdan="&dingdan&"&userid="&userid&"&username="&username&"&namekey="&namekey&"&leixing="&leixing&"&did="&did&"&post_date="&post_date&"&shfs="&shop_shfs
		Page_Menu rs,page_size,alink
        rs.close
        set rs=nothing
        conn.close
		%>
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