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
<title>������δ��������</title>
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
		<th align="center" bgcolor="#D2DCE6">����δ����</th>
	</tr>
</table>
<table width="804" border="0" align="center"   cellpadding="3" cellspacing="1" class="Noprint">
<form name="form1" method="post" action="All_Order_list.asp">
<tr bgcolor="#FFFFFF">
	<td width="8%">������</td>
	<td width="18%"><input name="dingdan" type="text" id="dingdan" size="14" ></td>
	<td width="8%">�µ�ID</td>
	<td width="9%"><input name="whoid" type="text" id="whoid" value="" size="7" ></td>
	<td width="12%">�µ�������</td>
	<td width="19%"><input name="whoname" type="text" id="whoname"   size="14"></td>
	<td width="9%">�ջ�������</td>
	<td width="17%"><input name="namekey" type="text" id="namekey" size="14"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td>��������</td>
	<td><select name="leixing" id="leixing">
          	<option value="">ȫ����������</option>
			<option value="1,2,3">���д�����</option>
			<option value="1">--����ע�ᶩ��</option>
          	<option value="2">--������ν���</option>
			<option value="3">--������������</option>
			<option value="101,102,103">���з�������</option>
			<option value="101">--������������</option>
			<option value="102">--�������ν���</option>
			<option value="103">--������������</option>
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
	<td ><input name="post_date" type="text" id="post_date" size="14"  onClick="return Calendar('post_date','');"><span style="color:red;"><br>
	���ڸ�ʽ��<%=date%></span></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan ="9" align ="right" ><input type="submit" name="Submit2" value="�� ѯ"></td>
</tr>
</form>
</table>
<br>
<%
Dim namekey  '�µ�������
Dim dingdan  '������
Dim leixing   '��������
Dim userid
Dim ReceiveName
Dim shopxpptname
Dim did
Dim post_date
Dim UserName

'��ȡ��ѯ��ֵ
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
response.write"<script>alert(""�Ƿ�����!"");location.href=""../index.asp"";</script>"
response.end
end if
end if
if namekey="" then namekey=request.form("namekey")
%>
<script language=javascript>

//��ѡ��ȫѡ�¼� form������
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
	set rs=server.CreateObject("adodb.recordset")
	sql="select Id,BigType,IsFreightDelyPay,SuggestFreight,OrderSn,LogisticsCompany,Province,City,County,BuyType,OrderType,UserName,UserId,ReceiveName,PostAddress,UserTel,CONVERT (varchar(16),PayTime,120) as PayTime,ReceiveMethod,PayMethod,OrderStatus,Message,InvoiceFlag,PostMoney,ByDistributionId,TapeColor from DeliverGoodsOrder where ReceiveMethod not in (23,27,25,29) and IsPay=1 and OrderStatus=3"
	
	'������
	if dingdan<>"" then
		sql=sql&" and OrderSn='"&dingdan&"'"
	end If

	'�µ�ID
	If whoid<>"" Then 
	 if TestInteger(whoid)=False  Then 
	   response.write"�µ�ID����������"
	   response.End 
	  End If 
	  sql=sql&" and UserId="&whoid
	End If 
    
	'�µ�������
	If whoname<>"" Then 
        sql=sql&" and ReceiveName='"&whoname&"' "
	End If 
    '�ջ�������
	if namekey<>"����������" and namekey<>"" then
	  sql=sql&" and ReceiveName like '%"&namekey&"%' "
	end If
	did=trim(request.form("did"))
	'����ID�ж�
	  if did<>"" then
	    sql=sql&" and UserId in (select userid from tiaoxingma.dbo.e_user where did='"&did&"')"
	  end If 

	'��������	
	if leixing<>"" then 
	   sql=sql&" and OrderType in ("&leixing&")"
	end if
	if shop_shfs<>"" then
		sql=sql&" and ReceiveMethod="&shop_shfs
	end if
	'�������� 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"���ڸ�ʽ����ȷ"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),PayTime,120)='"&post_date&"'"
	end If	
 	sql=sql&" order by PayTime desc"
 	''response.Write sql
	rs.open sql,conn,3  
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
		For ipage=1 To rs.PageSize
		id=rs("id")
		dd=trim(rs("OrderSn"))
		UserName=rs("UserName")
		BigType=rs("BigType")
		BigTypeText=GetBigTypeName(rs("BigType"))
		BuyTypeName=GetConsumptionMethodText(rs("BuyType"))
		OrderType=rs("OrderType")
		OrderTypeName=GetDingdanTypeText(rs("OrderType"))
		ReceiveMethod=rs("ReceiveMethod")
		UserId=rs("userid")
		PayTime=rs("PayTime")
		ReceiveName=rs("ReceiveName")
		UserTel=rs("UserTel")
		Province=rs("Province")
		City=rs("City")
		County=rs("County")
		PostAddress=rs("PostAddress")
		LogisticsCompany=rs("LogisticsCompany")
		Message=rs("Message")
		InvoiceFlag=rs("InvoiceFlag")
		PostMoney=rs("PostMoney")
		ByDistributionId=rs("ByDistributionId")
		TapeColor=rs("TapeColor")
		ReceiveName=rs("ReceiveName")
		if ReceiveName="" or isnull(ReceiveName) then
			ReceiveName=trim(rs("ReceiveName"))
		end if
		  %>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#FFFFFF">
            <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
            <td width="20%" align="center" valign="middle" nowrap><span class="fxpt">�����٣���Ķ࣡</span></td>
            <td width="40%" align="center" nowrap class="bigtitle">������������Ʒ�嵥(<font color="green"><%=BigTypeText%></font>)</td>
          </tr>
        </table>
		<%
		select case BigType
		case "0":
		call dispAgentOrderDetail() ''������
		case "1":
		call dispDistributionOrderDetail() ''��������
		end select
		%>
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
           
	%>
</form>
<%'��ҳ
		alink="?dingdan="&dingdan&"&whoid="&whoid&"&whoname="&whoname&"&namekey="&namekey&"&leixing="&leixing&"&did="&did&"&post_date="&post_date&"&shfs="&shop_shfs
		Page_Menu rs,page_size,alink
        rs.close
        set rs=nothing
        conn.close
		%>
		<%sub dispAgentOrderDetail() '''��ʾ����������%>
        <table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">������</td>
            <td width="16%" align="center">��������</td>
            <td width="14%" align="center">���ѷ�ʽ</td>
            <td width="15%" align="center">�µ�ID</td>
            <td width="20%" align="center">����ʱ��</td>
            <td width="15%" align="center">�ջ���ʽ</td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td align="center"><input type="checkbox" name="ID" value="<%=ID%>">
              <a href="javascript:;" onClick="javascript:window.open('order_agent_view.asp?dan=<%=dd%>&ReceiveMethod=<%=ReceiveMethod%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
            <td align="center"><%=OrderTypeName%></td>
            <td align="center"><%=BuyTypeName%></td>
            <td align="center"><%=UserId%></td>
            <td align="center"><%=PayTime%> </td>
            <td align="center"><%=shfs(ReceiveMethod)%>
            </td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td colspan="6" align="center">
			<%
				set rss=server.CreateObject("adodb.recordset") 
				sql="select shopxpptid,productdanwei,shopxpptname, area_number,shopxp_yangshiid,huojiahao,other_info,zonger,jifen,bochu,productcount,danjia,p_size from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&UserId&"' order by other_info asc,area_number asc ,shopxpptname desc,huojiahao desc"
				rss.open sql,conn,3
%>
              <table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" >
                <tr align="center" bgcolor="#FFFFFF">
                  <td width="12%">��Ʒ����</td>
                  <td width="21%" nowrap>��Ʒ��λ</td>
                  <td width="21%">��������</td>
                  <td width="67%">�� ʽ</td>
                  <td width="21%" nowrap>��Ʒ���</td>
                  <td width="21%" nowrap>��ʽID</td>
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
				sql_present="select shopxpptname,p_size,productcount,other_info,productdanwei from Order_present_Agent where dingdan='"&dd&"' and userid='"&UserId&"' order by huojiahao desc"
				rs_present.open sql_present,conn,3,1
				if not(rs_present.eof and rs_present.bof) then

			%>
			<tr bgcolor="#FFFFFF" align="center">
				<td colspan="6">
					<table border="1" cellpadding="0" cellspacing="0" width="99%">
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
				if InvoiceFlag=1 and ByDistributionId<>"" then 
                response.write "������ѿ���Ʊ"
                
                end If                
				%>
				<%
				if zongjifen=0 then 
				    response.write "�����ܶ"&zongji&"Ԫ"
				else
				    response.write "�����ܶ"&formatN(zongji)&"Ԫ,���֣�"&zongjifen
				end if
				
				    if rs("IsFreightDelyPay")=1 then
				        response.Write ""
				    else
				        response.Write ",���ã�"&PostMoney&"Ԫ"
				    end if
				 %></div></td>
                </tr>
              </table></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="6" class="shdz" ><%=Message%>
              <%if OrderTypeName="ע�ᶩ��" then response.write "�ܹ��ѣ�"&formatN(zongadRate)
		  		 if OrderTypeName="ע�ᶩ��" and zongpv>=1800 then response.write "����Ȩ��"%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >�µ�������:<%=trim(UserName)%>&nbsp;
              <%if OrderTypeName="ע�ᶩ��" then%>
              <%if not isnull(UserId) and UserId<>0 then%>
              ����꣺
              <%

			  sql="select did,UserName from tiaoxingma.dbo.e_user where userid='"&UserId&"'"
			  set rsd=server.CreateObject("adodb.recordset")
			  rsd.open sql,conn,3
			  if not(rsd.eof and rsd.bof) then
			  if rsd("did")="0" then
			    response.write "��̨����"
			  else
			    response.write rsd("did")&" �������������"&rsd("UserName")
			  end If
			  end if
			  rsd.close
			  Set rsd=Nothing 
			  %>
              <%end if%>
              <%end if %>
            </td>
            <td height="30"  colspan="2" class="shdz">�ջ�����ϵ��ʽ:<%=trim(UserTel)%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >�ջ��ˣ�<%=trim(ReceiveName)%> &nbsp;�ջ���ַ:<%=trim(Province)%><%=trim(City)%><%=trim(County)%><%=trim(PostAddress)%>&nbsp;<%=shfs(ReceiveMethod)%>:<%=LogisticsCompany%></td>
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
		<%end sub%>		
		<%sub dispDistributionOrderDetail() ''��������%>
<table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
	<tr bgcolor="#CECFCE" > 
	<td width="14%" align="center">������</td>
	<td width="14%" align="center">�µ�ID</td>
	<td width="14%" align="center">����ʱ��</td>
	<td width="23%" align="center">�ջ���ʽ</td>
	<td width="19%" align="center">�������</td>
	<td width="15%" align="center">��������</td>
	</tr>
        <tr bgcolor="#FFFFFF" > 
          <td align="center"><input type="checkbox" name="ID" value="<%=ID%>">
            <a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=dd%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td><td align="center"><%=UserId%></td>
          <td align="center"><%=PayTime%></td>
          <td align="center"><%=shfs(ReceiveMethod)%></td>
          <td align="center"><%=BuyTypeName%></td>
          <td align="center"><%=OrderTypeName%></td>
        </tr>
        <tr bgcolor="#FFFFFF" >
          <td colspan="6" align="center">		  
		  <%
			'������ϸ
			sql_order_list="select sa.shopxpptid,sa.shopxpptname,sa.huojiahao,sa.other_info,sa.productcount,sa.zonger,sa.p_size,sa.dingdan,sa.ProSource from Order_Distribution_ProDetail as sa  where sa.dingdan='"&dd&"' order by sa.area_number asc ,sa.shopxpptname asc,sa.huojiahao"
			set rs3=conn.execute(sql_order_list)
%><table width="99%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" style=" ">
            <tr align="center" bgcolor="#FFFFFF">
			  <td>���</td>
              <td>��Ʒ����</td>
              <td>��������</td>
              <td>��Ʒ���</td>
			  <td>��������</td>
			  <td>��Ʒ���</td>
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
				'��Ʒ�б�
	sql_present="select shopxpptname,p_size,productcount,other_info,productdanwei,dingdan from Order_present_distribution where dingdan ='"&dd&"' order by huojiahao desc"
	set rs_present=conn.execute(sql_present)
				if not (rs_present.eof and rs_present.bof ) then
			%>
			<tr bgcolor="#FFFFFF" align="center">
				<td colspan="6">
					<table border="1" cellpadding="0" cellspacing="0" width="99%">
						<tr>
							<th align="center" colspan="5">��Ʒ��Ϣ</th>
						</tr>
						<tr align="center">
							<td>��Ʒ����</td>
							<td>��λ</td>
							<td>���</td>
							<td>��������</td>
							<td>����˵��</td>
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
				�����ܶ<%=zongji%>Ԫ<%if CouponMoney>0 then response.write "(���й���ȯ�һ�"&CouponMoney&"Ԫ)"%>�����ã�<%=PostMoney%>Ԫ����&nbsp;&nbsp;&nbsp;				</div>				</td>
            </tr>
          </table></td>
        </tr>
         <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">�µ��ˣ�<%=UserName%></td>
            <td align="right" nowrap class="shdz">�ջ��ˣ�<%=trim(ReceiveName)%></td>
            <td align="right" class="shdz">��ϵ��ʽ:</td>
            <td align="center" class="shdz"><%=trim(UserTel)%></td>
            <td align="right" class="shdz">������ɫ:</td>
            <td align="center" class="shdz"><%=TapeColor%></td>
  </tr>
            <% if ReceiveMethod=25 then  %>
            <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">ƴ����:</td>
            <td height="30" class="shdz"><%''=trim(rs("shouhuo_username"))%></td>
            <td class="shdz" nowrap>ƴ������ţ�</td>
            <td colspan="5" align="left" class="shdz"><%''=trim(rs("shouhuo_userid"))%></td>
          </tr>
            <% end if%>
            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="8" class="shdz" >&nbsp;&nbsp;�ջ���ַ:<%=trim(Province)%><%=trim(City)%><%=trim(County)%><%=trim(PostAddress)%>
                <%if OrderType="103" then %>
                <strong style="font-size :13px;">(��<%=BuyTypeName%>����ַ)</strong>
                <%end if %>
                &nbsp;&nbsp;<%=shfs(ReceiveMethod) %>:&nbsp;<%=LogisticsCompany%></td>
          </tr>
        <% 
			if Message<>"" then 
		%>
		<tr bgcolor="#FFFFFF" style="font-size:18px; ">
		  <td height="30" colspan="6" class="shdz" >&nbsp;��ע��<%=Message%></td>
		</tr>
		<% 
			end if 
		%>
        <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
          <td height="30" >����ˣ�</td>
          <td height="30" ></td>
          <td height="30" >����ˣ�</td>
          <td height="30"></td>
          <td >�����ˣ�</td>
          <td >&nbsp;</td>
        </tr>
</table>
		<%end sub%>
		
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