<!--#include file="../conn.asp"-->
<!--#include file="../zhanting/geturl.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../sxf_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->

<html><head><title>�ͷ���������</title>
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
 <div align=center style="font-weight:900;">�ͷ���������</div>
 <br>
 
<table width="100%" border="0"   cellpadding="1" cellspacing="1" class="Noprint">
  <tr>
    <form name="form1" method="post" action="Agent_Order_Posted.asp">
      <td >������
        <input name="dingdan" type="text" id="dingdan" size="14" onFocus="this.value=''">
        �µ�ID
        <input name="userid" type="text" id="userid" value="" size="14" >
        �µ�������
		<input name="username" type="text"   size="5">&nbsp; 
         
		�ջ�������
		<input name="namekey" type="text" id="namekey" size="5"><br>

        <select name="leixing" id="leixing">
          <option value="" selected>--ѡ���ѯ����--</option>
          <option value="">ȫ����������</option>
          <option value="1">ע�ᶩ��</option>
          <option value="2">���ν���</option>
		  <option value="3">��������</option>
        </select>
        <select name="zhuangtai" id="zhuangtai">
          <option value="0" selected>--ѡ���ѯ״̬--</option>
          <option value="0" >ȫ������״̬</option>
          <option value="1" >δ���κδ���</option>
          <option value="2" >�û��Ѿ�������</option>
          <option value="3" >�������Ѿ��յ���</option>
          <option value="4" >�������Ѿ�����</option>
          <option value="5" >�û��Ѿ��յ���</option>
        </select>
       
        &nbsp;�������ID
        <input name="did" type="text" id="did" size="14">
		��������
        <input name="post_date" type="text" id="post_date" size="14" ><span style="color:red;">���ڸ�ʽ��<%=date%></span>
        <input type="submit" name="Submit" value="�� ѯ">
      </td>
    </form>
  </tr>
</table>
<br>
<!--
<%
dim zhuangtai '����״̬
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
zhuangtai=trim(request("zhuangtai")) 
did=trim(request("did"))
post_date=Trim(request("post_date"))



'����״̬�ж�
if zhuangtai<>"" then
if not isnumeric(zhuangtai) then 
response.write"<script>alert(""�Ƿ�����!"");location.href=""../index.asp"";</script>"
response.end
end if
end If

 
%>
<div id="div1" style="width:100%;">

<%
	set rs=server.CreateObject("adodb.recordset")
	if request("Submit")="" then 
	'����sql���
	sql="select  top 100  dingdan ,IsFreightDelyPay,SuggestFreight,liushuihao,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '�̳Ƕ���' when xiaofeifangshi=1 then '����������' when xiaofeifangshi=3 then '�������Ĵ��¶���' when xiaofeifangshi=4 then '���������������' end,dingdan_leixing=case when dingdan_type=3 then '��������' when dingdan_type=2 then '���ν���' else 'ע�ᶩ��' end, shouhuo_username,username,userid,shopxp_shiname,shopxp_shdz,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,liuyan,usertel,CONVERT (varchar(10),fksj,120) as fksj,convert(varchar(10),fhsj,120)  as fhsj,shopxp_shfs,zhifufangshi,zhuangtai,fapiao,fenxiao_userid,fapiao_date,fuwu_userid,feiyong,TapeColor from order_agent_main where cart_type=8 "
     else
	'����sql���
	sql="select dingdan ,IsFreightDelyPay,SuggestFreight,liushuihao,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '�̳Ƕ���' when xiaofeifangshi=1 then '����������' when xiaofeifangshi=3 then '�������Ĵ��¶���' when xiaofeifangshi=4 then '���������������' end,dingdan_leixing=case when dingdan_type=3 then '��������' when dingdan_type=2 then '���ν���' else 'ע�ᶩ��' end, shouhuo_username,username,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(10),fksj,120) as fksj,convert(varchar(10),fhsj,120)  as fhsj,shopxp_shfs,zhifufangshi,zhuangtai,fapiao,fenxiao_userid,fapiao_date,fuwu_userid,feiyong,TapeColor,liuyan from order_agent_main where cart_type=8 "	 
	 
	 end if 
    '������
	if dingdan<>"" then
	sql=sql&" and dingdan='"&dingdan&"'"
	end If

	'�µ�ID
	If userid<>"" Then 

	 if isInt(userid)=False  Then 
	   response.write"�µ�ID����������"
	   response.End 
	  End If 

	  sql=sql&" and userid="&userid 

	End If 
    
	'�µ�������
	If username<>"" Then 
        sql=sql&" and username='"&username&"' "
	End If 


    '�ջ�������
	if namekey<>"����������" and namekey<>"" then
	  sql=sql&" and shouhuo_username='"&namekey&"' "
	  did=trim(request.form("did"))
	  '����ID�ж�
	  if did<>"" then
	    sql=sql&" and userid in (select userid from e_user where did='"&did&"')"
	  end If 
	end If

	'��������	
	if leixing<>"" then 
	   if isInt(leixing)=False  Then 
	   response.write"�������ͱ���������"
	   response.End 
	  End If 
	   sql=sql&" and dingdan_type="&leixing
	end if
	
	
	'����״̬��ѯ
	select case zhuangtai
	case "4"
		sql=sql&" and zhuangtai=4 "
	case "5"
		sql=sql&" and zhuangtai=5 "
	case else
		 
	end select
		
	'�������� 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"���ڸ�ʽ����ȷ"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),fhsj,120)='"&post_date&"'"
	end if
	
   sql=sql&" order by fhsj desc, fksj desc "

'response.write sql
rs.open sql,conn,3  
if rs.eof And rs.bof then
	Response.Write "<p align='center' class='contents'> �Բ�����ѡ���״̬Ŀǰ��û�ж�����</p>"
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
              <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">�����٣���Ķ࣡</span></td>
              <td width="40%" align="center" nowrap class="bigtitle"><%=liushuihao%></td>
            <td nowrap>�����ţ�<a href="javascript:;" onClick="javascript:window.open('../order_info/order_agent_view.asp?dan=<%=trim(rs("dingdan"))%>&shopxp_shfs=<%=rs("shopxp_shfs")%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(rs("dingdan"))%></a> </td>
            </tr>
          </table>
	    <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" class="tableBorder">
	<tr bgcolor="#CECFCE" > 
	<td width="10%" align="center">��ˮ��</td>
	  <td width="10%" align="center">������</td>
	<td width="10%" align="center">��������</td>
	<td width="10%" align="center">���ѷ�ʽ</td>
	<td width="9%" align="center">֧����ʽ</td>
	<td width="5%" align="center">�µ�ID</td>
	<td width="10%" align="center">����ʱ��</td>
	<td width="10%" align="center">��ʱ��</td>
	<td width="10%" align="center">�ջ���ʽ</td>
	<td width="7%" align="center">�Ƿ񿪷�Ʊ</td>
	<td width="9%" align="center">�Ƿ�˰</td>
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
                response.write "������ѿ���Ʊ"
           
            end If
		  %>		  </td>
		  <td>
		  <%
		  	if rs("fapiao")=1 and rs("fapiao_date")<>"" then
				response.Write "�ѷ�˰��"&rs("fuwu_userid")
			else
				response.Write "��δ��˰"
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
			  <td>���</td>
              <td width="29%">��Ʒ����</td>
              <td width="11%">��������</td>
              <td width="10%">��Ʒ��λ</td>
              <td width="29%">�� ʽ</td>
			  <td width="11%">��Ʒ���</td>
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
							<th align="center" colspan="5">��Ʒ��Ϣ</th>
						</tr>
						<tr align="center">
							<td width="17%">��Ʒ����</td>
							<td width="18%">��λ</td>
							<td width="24%">���</td>
							<td width="20%">��������</td>
							<td width="21%">����˵��</td>
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

				%>   �����ܶ<%=zongji+zongjifen*0.1%>Ԫ�����л��ֳ��<%=zongjifen*0.1 %>Ԫ��ʵ��<%=zongji %>Ԫ����
				<%
				    if rs("IsFreightDelyPay")=1 then
				        ''response.Write "�����˷ѣ�"&rs("SuggestFreight")
				    else
				        response.Write "���ã�"&feiyong
				    end if
				 %>��<a href="check_post_des.asp?province=<%=trim(rs("province"))%>&dingdan=<%=trim(rs("dingdan"))%>&songid=26">�������˷�</a>����&nbsp;&nbsp;&nbsp;</div></td>
            </tr>
              <%
            rs_present.open "select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&rs("dingdan")&"' and zhuangtai=4 ",conn
			if not(rs_present.eof and rs_present.bof) then
         %>
           <tr bgcolor="#FFFFFF" align="center">
                  <td colspan="6"><table border="1" cellpadding="0" cellspacing="0" width="98%">
                      <tr>
                        <th align="center" colspan="5">��Ʊ��Ϣ</th>
                      </tr>
                      <tr align="center">
                        <td>��Ʊ����</td>
                        <td>��λ</td>
                        <td>���</td>
                        <td>��Ʊ����</td>
                        <td>����˵��</td>
                      </tr>
                      <%
							ticket_i=1
		                    do while not rs_present.eof
						%>
                      <tr align="center">
                        <td align="center">���ŷ�������Ʊ</td>
                        <td>��</td>
                        <td align="center">��׼</td>
                        <td><%=rs_present("ticket_num")%></td>
                        <td align="left">�������������ŷ�������Ʊ</td>
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
          <td height="30" colspan="5" class="shdz" >�µ�������:<%=trim(rs("shopxp_shiname"))%>&nbsp;
		  <%if not isnull(rs("userid")) and rs("userid")<>0 then%>
		  ����꣺
		  <%
		  sql="select did from e_user where userid='"&rs("userid")&"'"
		  Set rsd=server.CreateObject("adodb.recordset")
		  rsd.open sql,conn,3
		  If Not rsd.eof Then 
		    if rsd("did")=0 then
		      response.write "��̨����"
		    else
		      response.write rsd("did")
		    end If
		  %>&nbsp;&nbsp;&nbsp;�������������
		  <%
		    if rsd("did")=0 then
		      response.write "��̨����"
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
          <td height="30" class="shdz" colspan="3">�ջ�����ϵ��ʽ:<%=trim(rs("usertel"))%></td>
		   <td class="shdz" colspan=3>������ɫ:<%=trim(rs("TapeColor"))%></td>
          </tr>
        <tr bgcolor="#FFFFFF" style="font-size:18px; ">
          <td height="30" colspan="5" class="shdz" >�ջ���ַ:<%=trim(rs("province"))%><%=trim(rs("city"))%><%=trim(rs("xian"))%><%=trim(rs("shopxp_shdz"))%>&nbsp;&nbsp;</td>
          <td height="30" colspan="3" class="shdz" >�˷Ѹ��ʽ��
            <%
            if rs("IsFreightDelyPay")=0 then
                response.Write "�ָ�"
            else
                response.Write "<font color=red>����</font>"
            end if 
          %></td>
          <td class="shdz" colspan ="3"><%=shfs(rs("shopxp_shfs")) %>:&nbsp;<%=rs("sel_wuliugongshi")%></td>
          </tr>

		<%
		    if rs("liuyan")<>"" then
		%>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="8" class="shdz" >&nbsp;��ע��<%=rs("liuyan")%></td>
          </tr>
        <%
			end if
		%>
        <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
          <td height="30" >����ˣ�</td>
          <td colspan="2">&nbsp;</td>
          <td colspan="2">����ˣ�</td>
          <td colspan="2">&nbsp;</td>
          <td colspan="2">�����ˣ�</td>
		  <td colspan="2">&nbsp;</td>
          </tr>
      </table>
		  <br>
		  <span class="urlcss">����ȫ������������Ʒ����ƽ̨��http://www.maiduo.com �ͷ����ۺ�0371��66236936  ��л����֧�֣�</span>  <br>
      			<% 
rs.movenext
if rs.eof then exit for
next
''��ҳ
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


 
