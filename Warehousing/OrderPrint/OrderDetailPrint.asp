<!--#include file="../conn.asp"-->
<!--#include file="../inc/TXM.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
''call GetPageUrlpower("OrderPrint/Agent_Order_Detail_list.asp")'ȡ�ø���ҳ�������Ȩ��

''call CheckPageEdit()'��鵱ǰҳ���Ƿ���ҳ���ȡȨ��
%>
<%
dim LoginName
LoginName=session("trueName")
dim action,dingdans,username
Dim rows  '�и�
action=request.QueryString("action")
IDs=request.form("id")
if IDs="" or isnull(IDs) then
	response.Write("<script>alert('��û��ѡ�񶩵�');window.close();</script>")
	response.End()
end if

str="select BigType,OrderSn from DeliverGoodsOrder where id in ("&IDs&")"

dingdangs_agent="0"
dingdangs_dist="0"
set rsorder=conn.execute(str)
while not rsorder.eof
if rsorder("BigType")="0" then
dingdangs_agent=dingdangs_agent+","&rsorder("OrderSn")
elseif rsorder("BigType")="1" then
dingdangs_dist=dingdangs_dist+","&rsorder("OrderSn")
end if
rsorder.movenext
wend
rsorder.close
set rsorder=nothing

rows=0

if dingdangs_agent<>"0" then
	conn.execute(" exec AgentOrderPost '"&dingdangs_agent&"','"&LoginName&"',1 ") 
end if
if dingdangs_dist<>"0" then
	conn.execute(" exec DistributionOrderPost '"&dingdangs_dist&"','"&LoginName&"',0 ")
end if
 
%>
<html>
<head><title>������ӡ</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  <link href="../css/global.css" rel="stylesheet" type="text/css" />
<link href="../css/right.css" rel="stylesheet" type="text/css" />
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
</head>

<BODY>

<script language="javascript" src="../js/CheckActivX.js"></script>
<object id="LODOP" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
  <param name="License" value="845515150585010011211256128900">
</object>
<script language="javascript" type="text/javascript">
	var LODOP=document.getElementById("LODOP");//���������Ϊ�˷���DTD�淶
	CheckLodop();
</script>
<div class="only_print_view"><table width="1000" border="0" align="center" cellpadding="5">
  <tr>
    <td><input type="button" id="btnPrint" value="��ӡԤ��" onClick="OrderPreview()">
<input type="button"  value="ֱ�Ӵ�ӡ" onClick="OrderPrint()"  id="directPrint"></td>
  </tr>
</table>


</div>


<!-- lodop��ӡ����ʼ#################################################################### -->
<div id="view" width="100%">

<%
if IDs<>"" then
 
		
		sql="select Id,BigType,OrderSn  from DeliverGoodsOrder where ID in ("&IDs&")"
		set rsPrint=server.CreateObject("adodb.recordset")
		set rs=server.CreateObject("adodb.recordset")
		rsPrint.open sql,conn,1,1
		'response.Write sql
		do while not rsPrint.EOF 
		PCount=0
		dd=trim(rsPrint("OrderSn"))
		BigType=trim(rsPrint("BigType"))
		  %>
		  <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
	<td valign="top" nowrap>
		  <table width="100%" border="1" cellpadding="0" cellspacing="1">
           
            <tr>
              <td width="19%" align="left" valign="top" nowrap height=52><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
              <td width="41%" align="center" valign="middle" nowrap><span class="fxpt">�����٣���Ķ࣡</span></td>
<td width="40%" align="center" nowrap class="bigtitle">������������&nbsp;&nbsp;<%''=rs("Group_Lable") %></td>
            </tr>
             <tr>
              <td colspan="3" align="left" valign="top" nowrap  height=52><span style="width:50px;"></span><%=dragcode(haiwaocde(lcase(dd)))%></td>
            </tr>
          </table>
<%
select case BigType
case "0":
call dispPrintDetail_Agent(dd)
case "1":
call dispPrintDetail_Dist(dd)
end select
%>



		  <div align=right height=25><span class="urlcss">��Ʒ�ۺ�0371��66236936  ��л����֧�֣�</span></div> 
		  <div align=right height=10>&nbsp;</div>  
		   
		   <%
			 rows=rows+40
			 %>
		   
	  </td>
	</tr>
</table>
 
<%
    rsPrint.movenext
    loop
end if
conn.close
Set conn=Nothing 
%>
 

</div>
<!-- lodop��ӡ����ʼ#################################################################### -->


 <script language="javascript" type="text/javascript"> 
 	
	function OrderPrint() 
	{		
		CreateFormPage();
		LODOP.PRINT();	
	};               	
	function OrderPreview()
	{		
		CreateFormPage();
		LODOP.PREVIEW();
	};
	function CreateFormPage()
	{
		 
		var strBodyStyle="<style>"+document.getElementById("print").innerHTML+"</style>";
		var strFormHtml=strBodyStyle+"<body>"+document.getElementById("view").innerHTML+"</body>";	
		//var iPageHigh=document.getElementById("view").scrollHeight;
		var iPageHigh=<%=rows%>;
		//iPageHigh=iPageHigh+60;//���Ϲ�����Ϣ
		iPageHighs=iPageHigh/96*254;//����ɺ���(��λ0.1mm) (����px�Ǿ���ֵ���ȵ�λ��96px/in)
		LODOP.PRINT_INIT("����δ����"); 
		LODOP.SET_PRINT_PAGESIZE(1,2300,iPageHighs,"");
		LODOP.ADD_PRINT_HTM(0,0,750,iPageHigh,strFormHtml); 
		LODOP.SET_PRINT_STYLEA(1,"Horient",2);

		
	};
	 
</script>
<%sub dispPrintDetail_Agent(dd)%>
		 <%
		 rows=rows+110
		 
sql="select IsFreightDelyPay,Group_Lable,fapiao_title,liushuihao,dingdan,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,province,city,xian,xiaofeifangshi=case when xiaofeifangshi=0 then '�̳Ƕ���' when xiaofeifangshi=1 then '����������' when xiaofeifangshi=3 then '�������Ĵ��¶���' when xiaofeifangshi=4 then '���������������' end,dingdan_leixing=case when dingdan_type=3 then '��������' when dingdan_type=2 then '���ν���' else 'ע�ᶩ��' end, shouhuo_username,shouhuoname,username,userid,sale_userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,fapiao,convert(varchar(16),fapiao_date,120) as fapiao_date,fuwu_userid,fenxiao_userid,is_givecard,feiyong,TapeColor from order_agent_main where dingdan='"&dd&"'"

		rs.open sql,conn,1,1
		'response.Write sql
		if not rs.EOF  then
		PCount=0
		liushuihao=rs("liushuihao")
		ename=rs("username")
		xiaofeifangshi=rs("xiaofeifangshi")
		dingdan_leixing=rs("dingdan_leixing")
		shopxp_shfs=rs("shopxp_shfs")
		dingdan_userid=rs("userid")
		fksj=rs("fksj")
		shopxp_shiname=rs("shopxp_shiname")
		shouhuoname=rs("shouhuo_username")
		usertel=rs("usertel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("shopxp_shdz")
		sel_wuliugongshi=rs("sel_wuliugongshi")
		liuyan=rs("liuyan")
		
		fapiao_title=rs("fapiao_title") 
		
		is_givecard=rs("is_givecard")
		feiyong=rs("feiyong")
		TapeColor=rs("TapeColor")
		select case is_givecard
		case "1"
			is_givecard="���������ѷ���"
		case "2"
			is_givecard="���������ѷ���"
		case else
			is_givecard="��Ҫ����"
		end select
		if shouhuoname="" or isnull(shouhuoname) then
			shouhuoname=trim(rs("shouhuoname"))
		end if
		 %>
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
	<tr bgcolor="#CECFCE" >
	  <td width="10%" align="center"  height=25>��ˮ��</td>
	  <td width="15%" align="center">������</td>
	  <td width="7%" align="center">�µ�ID</td>
	<td width="12%" align="center">��������</td>
	<td width="8%" align="center">���ѷ�ʽ</td>
	<td width="14%" align="center">����ʱ��</td>
	<td width="10%" align="center">�ջ���ʽ</td>
	 
	</tr>
        <tr align="center">
          <td height=25><%=liushuihao%></td>
          <td ><a href="javascript:;" onClick="javascript:window.open('order_agent_view.asp?dan=<%=dd%>&shopxp_shfs=<%=shopxp_shfs%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
		  <td ><%=dingdan_userid%></td>
		  <td align="center"><%=dingdan_leixing%></td>
          <td ><%=xiaofeifangshi%></td>
          <td ><%=fksj%></td>
          <td ><%=shfs(shopxp_shfs)%></td>
		  
        </tr>
		 <%
		 rows=rows+25*2
		 %> 
        <tr >
			<td colspan="7" align="center">		  
		  		<table width="100%"   align="center" cellpadding="0" cellspacing="1" class="dot"    style="word-break:break-all;">
			<%
			 set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from order_agent_prodetail where dingdan='"&dd&"' and userid='"&dingdan_userid&"' ",conn
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
			  
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select shopxpptid,productdanwei,shopxpptname,shopxp_yangshiid,huojiahao,other_info,zonger,jifen,bochu,productcount,danjia,p_size,StorageSortId,Storage_name,txm from order_agent_prodetail  where dingdan='"&dd&"' and userid='"&dingdan_userid&"' order by StorageSortId asc,huojiahao asc,shopxpptname asc" 
			rs_p.open sql,conn
			if not rs_p.eof then
				 
				
				bochu=0
				i=1
				n=1
				b=""
					zongji=0
				zongjifen=0
				
				do while not rs_p.eof
					if rs_p("StorageSortId")="" or isnull(rs_p("StorageSortId")) then
						StorageSortId=0
					else
						StorageSortId=rs_p("StorageSortId")
					end if
					if rs_p("Storage_name")="" or isnull(rs_p("Storage_name")) then
						Storage_name="δ����"
					else
						Storage_name=trim(rs_p("Storage_name"))
					end if
					if b<>StorageSortId then
			%>
			<tr align="center">
			<td colspan="7" align="left" height="30" style="padding-bottom:12px;" class="dot" >
				<span style="width:100%; border-bottom:1px dashed #CCCCCC;"></span>
			</td>
			</tr>
			<tr align="center">
				<td colspan="7" style='padding-left:30px; height:25px;' align="left"  class="dot" ><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%> -- <%=dingdan_userid%> -- �ջ��ˣ�<%=shouhuoname%> --  <%=maxc&"-"&n%></span><%if Storage_name="ϴ����" then %><span style="padding-right:120px; text-align:right;float:right;">A11-A20����ˣ�</span><br/><span style="padding-right:120px; text-align:right;float:right;">A01-A10����ˣ�</span><%else%><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span><%end if%></td>
			  </tr>

			   <%
			 rows=rows+30*2
			 %>
			   
			     <tr align="center"  height=25>
					<td  nowrap  class=dot width="36">���</td>
					<td  nowrap  class=dot  width="350">��Ʒ����</td>
					<td  nowrap  class=dot width="105">���</td>
					<td  nowrap  class=dot width="30">����</td>
					<td  nowrap  class=dot width="24">��λ</td>
					<td  nowrap  class="dot" width="90">TXM</td>
					<td  nowrap  class=dot width="45">���</td>
				  </tr>

			<%
						b=StorageSortId
						rows=rows+25
						n=n+1
						i=1
					end if
			%>
		  <tr align="center">
		  	<td class="dot" height=25><%=i%></td>
			<td   style='padding-left:5px;' align="left" class="dot" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right"  width="54"><span style="font-weight:900;"><%=rs_p("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_p("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_p("p_size")%>
				
			</td>
			
			<td  class="dot" ><%=rs_p("productcount")%></td>
			<td nowrap  class="dot" ><%=rs_p("productdanwei")%></td>
			<td class="dot" ><%=rs_p("txm") %></td>
			<td nowrap class="dot" ><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			zongji=rs_p("zonger")+zongji
			zongjifen=rs_p("jifen")*rs_p("productcount")+zongjifen
			
			bochu=rs_p("bochu")*rs_p("productcount")+bochu
			i=i+1 			
			'���ϴ��е��и�
			If Len(rs_p("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_p("productcount")
			rs_p.movenext
			loop
			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_Agent where dingdan='"&dd&"' order by shopxpptname desc",conn
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center">
			<td colspan="7" align="left" height="30" style="padding-bottom:12px;"  class="dot" >
				<span style="width:100%; border-bottom:1px dashed #CCCCCC;"></span>
			</td>
		</tr>
		<tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>��Ʒ��</strong> -- <%=dd%> -- <%=dingdan_userid%> -- �ջ��ˣ�<%=shouhuoname%></span><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span></td>
  		</tr>
  		<tr align="center">
			<td  nowrap   class=dot>���</td>
			<td  nowrap   class=dot>����</td>
			<td     class=dot>���</td>
			<td  nowrap   class=dot>����</td>
			<td  nowrap  class=dot>��λ</td>
			<td  nowrap  class="dot" >TXM</td>
			<td  nowrap  class=dot>���</td>
		</tr>

		<%
			rows=rows+80
			i=1
  			do while not rs_give.eof
  		%>
  		<tr align="center">
			<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left"  class="dot" >
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right" width="54"><span style="font-weight:900;"><%=rs_give("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_give("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;" class="dot" >
				<%=rs_give("p_size")%>
			
			</td>
			<td class="dot" ><%=rs_give("productcount")%></td>
			<td  class="dot" ><%=rs_give("productdanwei")%></td>
			<td class="dot" ><%=rs_give("txm") %></td>
			<td  class="dot" ><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			'���ϴ��е��и�
			If Len(rs_give("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_give("productcount")
			rs_give.movenext
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			'set rs_give=nothing
	  	%>
  		<tr>
    		<td colspan="7" height=25 align=right>
    		
    		 
    		<%
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
				 %>��</td>
  		</tr>
		<%
			rows=rows+25
			end if
			rs_p.close
			set rs_p=nothing
 		%>
		</table>
			</td>
        </tr>
        <%
			Set rs_give=server.CreateObject("adodb.recordset")
            rs_give.open "select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&dd&"'",conn
			if not(rs_give.eof and rs_give.bof) then
         %>
        <tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>��Ʊ��</strong></span><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span></td>
  		</tr>
  		<tr align="center">
  		    <td   height=25  class="dot" >���</td>
			<td   height=25  class="dot"  colspan ="2">����</td>
			<td  nowrap class="dot" >��Ʒ��λ</td>
			<td  class="dot" >����</td>
			<td  class="dot" >���</td>
			<td  class="dot" >���</td>
		</tr>
		<%
		    ticket_i=1
		    do while not rs_give.eof
		   
		 %>
		 <tr  align="center">
		    <td><%=ticket_i %></td>
            <td nowrap style='padding-left:5px;'  class="dot" >���ŷ�������Ʊ</td>
            <td nowrap class="dot" >��</td>
            <td class="dot" ><%=rs_give("ticket_num")%></td>
            <td class="dot" >��׼</td>
            <td class="dot" ><%=rs_give("ticket_id")%></td>
		 </tr>
		 <%		
				rows=rows+25
		        rs_give.movenext
		        ticket_i=ticket_i+1
			    if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
		  %>
		<% if liuyan<>"" then %>
		<tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;���ԣ�<%=liuyan%>
		  </td>
		</tr>
		<%
			rows=rows+40
			end if
			if dingdan_leixing="ע�ᶩ��" then
		%>
        <tr >
          <td height="40" colspan="7" class="shdz">&nbsp;&nbsp;��ע��<%
		  	response.write is_givecard&"  �ܹ��ѣ�"&formatN(bochu)
		   	if bochu>=3000 then response.write "  ����Ȩ��"
		  %>
		  </td>
		</tr>
		<%
			rows=rows+40
			end if
		%>
		<tr >
          <td height="40" colspan="5" class="shdz">&nbsp;&nbsp;�µ�������:<%=trim(shopxp_shiname)%>&nbsp;
              <%if not isnull(dingdan_userid) and dingdan_userid<>"0" then%>
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
			  rows=rows+40
			  %>
              <%end if%>
		  </td>
		  <td colspan="2" class="shdz">
            <%
                if rs("IsFreightDelyPay")=0 then
                    response.Write ""
                else
                    response.Write "�˷Ѹ��ʽ��<font color='red'>����</font>"
                end if
             %>
          </td>
		</tr>
        <tr  align="center">
          <td height="40" class="shdz"  >�ջ���:</td>
		  <td height="40" class="shdz" colspan="1"><%=trim(shouhuoname)%></td>
          <td   class="shdz">��ϵ��ʽ:</td>
          <td   class="shdz" colspan="2"><%=trim(usertel)%></td>
          <td   colspan="2" class="shdz" align="left">&nbsp;&nbsp;<%if fapiao="1" and fapiao_title<>"" then response.write "��Ʊ̧ͷ:"&fapiao_title%></td>
  </tr>
        <tr >
          <td height="40" colspan="7" class="shdz" >&nbsp;&nbsp;�ջ���ַ:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%></td>
  </tr>

        <tr >
          <td height="40" colspan="5" class="shdz" >&nbsp;&nbsp;������ɫ:<%=TapeColor%></td>
          <td align="right" class="shdz">��Ʒ������</td>
          <td class="shdz"><%=PCount %></td>
  </tr>


        <tr align="center">
          <td height="30">����ˣ�</td>
          <td  colspan="1" >&nbsp;</td>
          <td  >���ʱ�䣺</td>
          <td colspan="1">&nbsp;</td>
          <td  colspan="3"><span>����������<span style="width:30px;"></span>�����嵥�ڵ�<span style="width:30px;"></span>��</span></td>
  </tr>
</table>
	  	<%
		rs.close
		 rows=rows+40*5
		 end if
		 end sub%>

<%sub dispPrintDetail_Dist(dd)%>
		    <%
			'�����������������и�Ϊ110px
			rows=rows+110
			set rss=server.CreateObject("adodb.recordset")
	sqls="select liushuihao,dingdan,province,city,xian,fenxiao_type,dingdan_leixing=case dingdan_type when 1 then '��������' when 2 then '���ν���' else '��������' end, shouhuoname,username,userid,shopxp_shiname,shopxp_shdz,usertel,CONVERT (varchar(16),fksj,120) as fksj,convert(varchar(16),actiondate,120) as actiondate,shopxp_shfs,zhifufangshi,zhuangtai,liuyan,feiyong,isnull(sel_wuliugongshi,'') as sel_wuliugongshi,other_info,is_tiaohuan,TapeColor,shouhuo_userid,shouhuo_username from Order_Distribution_Main where dingdan ='"&dd&"'"
	rss.open sqls,conn 
	
	if not rss.eof then
	    PCount=0
		dd=trim(rss("dingdan"))
		liushuihao=rss("liushuihao")
		ename=rss("username")
		shouhuoname=rss("shouhuoname")
		userids=rss("userid")
		dingdan_leixing=rss("dingdan_leixing")
		shopxp_shfs=rss("shopxp_shfs")
		sel_wuliugongshi=trim(rss("sel_wuliugongshi"))
		dingdan_userid=rss("userid")
		fksj=rss("fksj")
		shopxp_shiname=rss("shopxp_shiname")
		usertel=rss("usertel")
		province=rss("province")
		city=rss("city")
		xian=rss("xian")
		shopxp_shdz=rss("shopxp_shdz")
		liuyan=rss("liuyan")
		feiyong=rss("feiyong")
		fenxiao_type=rss("fenxiao_type")
		is_tiaohuan=rss("is_tiaohuan")
		other_info=rss("other_info")
		TapeColor=rss("TapeColor")
		shouhuo_userid=rss("shouhuo_userid")
		shouhuo_username=rss("shouhuo_username")
		select case fenxiao_type
		case "3"
			fenxiao_type="���������"
		case else
			fenxiao_type="��������"
		end select
			
		  %>
<table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC">
            <tr bgcolor="#CECFCE" height=30>
              <td width="15%" align="center" nowrap>��ˮ��</td>
              <td width="18%" align="center" nowrap>������</td>
              <td width="13%" align="center" nowrap>�µ�ID</td>
              <td width="13%" align="center" nowrap>����ʱ��</td>
              <td width="13%" align="center" nowrap>�ջ���ʽ</td>
              <td width="14%" align="center" nowrap>�������</td>
              <td width="14%" align="center" nowrap>��������</td>
            </tr>
            <tr  height=30 >
              <td align="center" nowrap id="liushuihao_<%=trim(dd)%>"><%=liushuihao%></td>
              <td align="center"><a href="javascript:;" onClick="javascript:window.open('fenxiao_viewdingdan_new.asp?dan=<%=dd%>&shouhuoname=<%=shouhuoname%>&ename=<%=username%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=dd%></a></td>
              <td align="center"><%=userids%></td>
              <td align="center"><%=fksj%></td>
              <td align="center"><%=shfs(shopxp_shfs)%></td>
              <td align="center"><%=fenxiao_type%></td>
              <td align="center"><%=dingdan_leixing%></td>
            </tr>
			 

		<%
		'�����������������и�Ϊ50px
		rows=rows+30*2
		%>
            <tr  >
              <td colspan="7" align="center" id="heit_<%=j%>">
			  	<table width="98%"   align="center" cellpadding="0" cellspacing="0" class=dot  style="word-break:break-all;">
			  <%
			  set rs_c=server.CreateObject("adodb.recordset")
			  rs_c.open "select distinct(Storage_name) from tiaoxingma.dbo.Order_Distribution_ProDetail where dingdan='"&dd&"' ",conn
			  if not rs_c.eof and not rs_c.bof then
			  	maxc=rs_c.recordcount
			  end if
			  rs_c.close
			  set rs_c=nothing
		  	set rs_p=server.CreateObject("adodb.recordset")
			sql="select sa.shopxpptid,sa.productdanwei,sa.shopxpptname,sa.huojiahao,sa.other_info,sa.zonger,sa.productcount,sa.p_size as style,sa.StorageSortId,sa.Storage_name,txm from tiaoxingma.dbo.Order_Distribution_ProDetail as sa  where sa.dingdan='"&dd&"' order by sa.StorageSortId asc,sa.huojiahao asc,sa.shopxpptname asc" 
			rs_p.open sql,conn
			if not rs_p.eof then
				zongpv=0
				zongji=0
				bochu=0
				i=1
				n=1
				b=""
				do while not rs_p.eof
					if rs_p("StorageSortId")="" or isnull(rs_p("StorageSortId")) then
						StorageSortId=0
					else
						StorageSortId=rs_p("StorageSortId")
					end if
					if rs_p("Storage_name")="" or isnull(rs_p("Storage_name")) then
						Storage_name="δ����"
					else
						Storage_name=trim(rs_p("Storage_name"))
					end if
					if b<>StorageSortId then
			%>
			<tr  align="center"  height=25>
				<td colspan="6" style='padding-left:30px; height:25px;' align="left"  class=dot><span style="float:left;"><b><%=Storage_name%></b> -- <%=dd%>  -- <%=userids%> -- �ջ��ˣ�<%=shouhuoname%>  --  <%=maxc&"-"&n%></span><%if Storage_name="ϴ����" then %><span style="padding-right:120px; text-align:right;float:right;">A11-A20����ˣ�</span><span style="padding-right:120px; text-align:right;float:right;">A01-A10����ˣ�</span><%else%><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span><%end if%></td>
			  </tr >
			    
				   <tr align="center"  height=25>
					<td  nowrap  class=dot width="36">���</td>
					<td  nowrap  class=dot  width="350">��Ʒ����</td>
					<td  nowrap  class=dot width="105">���</td>
					<td  nowrap  class=dot width="30">����</td>
					<td  nowrap  class=dot width="24">��λ</td>
					<td  nowrap  class="dot" width="90">TXM</td>
					<td  nowrap  class=dot width="45">���</td>
				  </tr>
			<%
						'���ϴ�2�е��и�
						rows=rows+25*2
						b=StorageSortId
						i=1
						n=n+1
					end if
			%>
		  <tr  align="center"  height=25>
		  	<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left"  class=dot>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right"  width="54"><span style="font-weight:900;"><%=rs_p("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_p("shopxpptname"))%></span></td>
				  </tr>
				</table>
		 
			</td>
			<td align="left" style="padding-left:5px;"  class=dot>
				<%=rs_p("style")%>
				
			</td>
			
			<td  class=dot><%=rs_p("productcount")%></td>
			<td  class=dot><%=rs_p("productdanwei")%></td>
			<td  class=dot><%=rs_p("txm")%></td>
			<td  class=dot><%=rs_p("shopxpptid")%></td>
		  </tr>
		  <%
			zongji=rs_p("zonger")+zongji
			i=i+1
			'���ϴ��е��и�
			If Len(rs_p("shopxpptname"))>30 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_p("productcount")
			rs_p.movenext
			Loop
			

			set rs_give=server.CreateObject("adodb.recordset")
			rs_give.open "select shopxpptid,huojiahao,shopxpptname,productdanwei,productcount,p_size,other_info,shopxp_yangshiid,txm from Order_present_distribution where dingdan='"&dd&"' order by shopxpptname desc",conn,1,1
			if not(rs_give.eof and rs_give.bof) then
		%>
		<tr align="center"  height=25>
    		<td colspan="6" style='padding-left:30px; height:25px;' align="left"><span style="float:left;"><strong>��Ʒ</strong> -- <%=dd%>  --  <%=userids%> -- �ջ��ˣ�<%=shouhuoname%></span><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span></td>
  		</tr>
  		<tr align="center"  height=25>
			<td nowrap   class=dot>���</td>
			<td  nowrap  class=dot>����</td>
			<td  nowrap class=dot>���</td>
			<td nowrap class=dot>����</td>
			<td  nowrap  class=dot>��λ</td>
			<td  nowrap  class="dot" >TXM</td>
			<td  nowrap  class=dot>���</td>
		</tr>
		<%
			'���ϴ�2�е��и�
			rows=rows+25*2
			i=1
  			do while not rs_give.eof
				danwei=rs_give("productdanwei")
				if danwei="" or isnull(danwei) then
					danwei="<font color='#FFFFFF'>&nbsp;</font>"
				end if
  		%>
  		<tr  align="center" height=25>
			<td  class=dot><%=i%></td>
			<td  style='padding-left:5px;' align="left" class=dot>
			
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
				    <td valign="right" width="54"><span style="font-weight:900;"><%=rs_give("huojiahao")%>.</span></td>
					<td><span><%=trim(rs_give("shopxpptname"))%></span></td>
				  </tr>
				</table>
			</td>
			<td align="left" style="padding-left:5px;"  class=dot>
				<%=rs_give("p_size")%>
				
			</td>
			
			<td  class=dot><%=rs_give("productcount")%></td>
			<td nowrap  class=dot><%=danwei%></td>
			<td  class=dot><%=rs_give("txm")%></td>
			<td nowrap  class=dot><%=rs_give("shopxpptid")%></td>
		</tr>
	  	<%
			'���ϴ��е��и�
			If Len(rs_give("shopxpptname"))>25 Then 
				rows=rows+25*2
			Else 
				rows=rows+25
			End If 
			PCount=PCount+rs_give("productcount")
			rs_give.movenext
			i=i+1
			if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			'set rs_give=nothing
	  	%>
  		<tr  height=30>
    		<td colspan="6"  class=dot><div align="right">
				<%if is_tiaohuan=1 then response.write "<span style='font-weight:900;color:red;'>"&other_info&"</span>&nbsp;&nbsp;&nbsp;&nbsp;"%>�����ܶ<%=zongji%>Ԫ�����ã�<%=feiyong%>Ԫ��</div></td>
  		</tr>
		<%
			'���ϴ��е��и�
			rows=rows+30
			end if
			rs_p.close
			set rs_p=nothing
 		%>
                </table>
			  </td>
            </tr>
             <%
			 set rs_give=conn.execute("select ticket_id,ticket_num,userid,recevie_id from Ticket_Order where dingdan='"&dd&"'")
			if not(rs_give.eof and rs_give.bof) then
         %>
        <tr align="center">
    		<td colspan="7" style='padding-left:30px; height:25px;' align="left" class="dot" ><span style="float:left;"><strong>��Ʊ��</strong></span><span style="padding-right:150px; text-align:right;float:right;">����ˣ�</span></td>
  		</tr>
  		<tr align="center">
  		    <td   height=25  class="dot" >���</td>
			<td   height=25  class="dot"  colspan ="2">����</td>
			<td  nowrap class="dot" >��Ʒ��λ</td>
			<td  class="dot" >����</td>
			<td  class="dot" >���</td>
			<td  class="dot" >���</td>
		</tr>
		<%
		    ticket_i=1
		    do while not rs_give.eof
		   
		 %>
		 <tr  align="center">
		    <td ><%=ticket_i %></td>
            <td   class="dot"  colspan ="2">���ŷ�������Ʊ</td>
            <td nowrap class="dot" >��</td>
            <td class="dot" ><%=rs_give("ticket_num")%></td>
            <td class="dot" >��׼</td>
            <td class="dot"><%=rs_give("ticket_id")%></td>
		 </tr>
		 <%
		        rs_give.movenext
		        ticket_i=ticket_i+1
			    if rs_give.eof then exit do
			loop
			end if
			rs_give.close
			set rs_give=nothing
		  %>
          <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">�µ��ˣ�<%=shopxp_shiname%></td>
            <td align="right" nowrap class="shdz">�ջ��ˣ�<%=shouhuoname%></td>
            <td align="right" class="shdz">��ϵ��ʽ:</td>
            <td align="center" class="shdz"><%=usertel%></td>
            <td align="right" class="shdz">������ɫ:</td>
            <td align="center" class="shdz"><%=TapeColor%></td>
          </tr>
            <% if shopxp_shfs=25 then  %>
            <tr bgcolor="#FFFFFF" style="font-size:18px; text-align:center;">
            <td height="30" class="shdz">ƴ����:</td>
            <td height="30" class="shdz"><%=shouhuo_username%></td>
            <td class="shdz" nowrap>ƴ������ţ�</td>
            <td colspan="5" align="left" class="shdz"><%=shouhuo_userid%></td>
          </tr>
            <% end if%>
            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="5" class="shdz" >&nbsp;&nbsp;�ջ���ַ:<%=province%><%=city%><%=xian%><%=shopxp_shdz%>
                <%if dingdan_leixing="��������" then %>
                <strong style="font-size :13px;">(��<%=fenxiao_type %>����ַ)</strong>
                <%end if %>
                &nbsp;&nbsp;<%=shopxp_shfs %>:&nbsp;<%=sel_wuliugongshi %></td>
                <td align="right" class="shdz">��Ʒ������</td>
                <td class="shdz"><%=PCount %></td>
          </tr>
           <%
		   '���ϴ�2�е��и�
			rows=rows+40*2
		   if liuyan>"" then 
		   %>
            <tr  >
			<!-- �˴�&nbsp;����ʹ��һ���������ڴ�ӡ������ʱ�򣬺��������ʾ������ -->
              <td height="40" colspan="7"  ><span class="shdz">&nbsp;&nbsp;&nbsp;&nbsp;��ע:<%=liuyan%></span></td>
            </tr>
			<%
				'���ϴ��е��и�
				rows=rows+40
			end If
			%>
            <tr  style="font-size:18px; text-align:center;" >
              <td >����ˣ�</td>
              <td height="30" >&nbsp;</td>
              <td height="30" >���ʱ�䣺</td>
              <td>&nbsp;</td>
              <td colspan="3">����������<span style="width:50px;"></span>�����嵥�ڵ�<span style="width:30px;"></span>��</td>
            </tr>
</table>
<%
end if
rss.close
set rss=nothing
end sub%>
</body>
</html>
