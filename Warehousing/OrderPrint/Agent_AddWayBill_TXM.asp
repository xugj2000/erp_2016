<!--#include file="../conn.asp"-->
<!--#include file="cls.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<script src="/js/jquery-1.3.2.min.js" type="text/javascript"></script>

<script language="javascript">
//��ȡmemo����ajax��ʽ��ȡ���Լӿ�ҳ����ٶ�
function getMemo(tel,msg) 
{
	
	$.ajax
	({
		 
		url:"/sendsms.aspx",
		type:"get",
		cache:true,
		data:"tel="+tel+"&msg="+msg,
		dataType:"text",	 		
		success:function(html){alert(html+",��ӳɹ�");location.href='addwaybill_start.asp';}
		
	});
	
}

	
</script>
<%
call GetPageUrlpower("OrderPrint/AddWayBill_start.asp")'ȡ�ø���ҳ�������Ȩ��

call CheckPageAdd()'��鵱ǰҳ���Ƿ���ҳ���ȡȨ��
%>

<%

dim dailidingdan,fenxiaodingdan,thedingdan
dailidingdan=""
fenxiaodingdan=""
yundantxm=trim(request.Cookies("yundantxm"))

thedingdan=trim(request("thedingdan"))
if request.QueryString("action")="UnionOrder" then 
    if thedingdan<>"" and thedingdan<>yundantxm then
        '��ѯ�Ƿ������ش˶���
        sql="select id from daili_uniondingdan where WayBill_UnionOrder='"&thedingdan&"'"
        set rs1=conn.execute(sql)
        if not(rs1.bof and rs1.eof) then
            sql="update daili_uniondingdan set WayBill_UnionOrder='"&yundantxm&"' where WayBill_UnionOrder='"&thedingdan&"'"
            conn.execute(sql)
            response.write "<script language=javascript>alert('�ϲ������ɹ���');location.href='Agent_AddWayBill_TXM.asp';</script>"
        else
            sql="select id from fenxiao_uniondingdan where WayBill_UnionOrder='"&thedingdan&"'"
            set rs=conn.execute(sql)
            if not(rs.bof and rs.eof) then
                sql="update fenxiao_uniondingdan set WayBill_UnionOrder='"&yundantxm&"',yuandingdan='wl'+yuandingdan where WayBill_UnionOrder='"&thedingdan&"'"
                conn.execute(sql)
            else
                response.write "<script language='javascript'>alert('�ϲ��Ķ������벻���ڣ�');</script>"  
            end if   
        end if
    end if
end if 

set rsc=conn.execute("select dingdan from Order_Agent_Main where dingdan in (select yuandingdan from daili_uniondingdan where WayBill_UnionOrder='"&yundantxm&"') ")
do while not rsc.eof
    dailidingdan=dailidingdan&rsc("dingdan")&","
    rsc.movenext
loop
set rsc=conn.execute("select distinct dingdan from Order_Distribution_Main where (dingdan in (select right(yuandingdan,16) from fenxiao_uniondingdan where WayBill_UnionOrder='"&yundantxm&"')) or (dingdan in (select right(yuandingdan,16) from daili_uniondingdan where WayBill_UnionOrder='"&yundantxm&"')) ")
do while not rsc.eof
    fenxiaodingdan=fenxiaodingdan&rsc("dingdan")&","
    rsc.movenext
loop
set rsb=conn.execute("select distinct shouhuoname,usertel from daili_uniondingdan where WayBill_UnionOrder='"&yundantxm&"'")

'dailidingdan=
'fenxiaodingdan=left(fenxiaodingdan,len(fenxiaodingdan)-1)
if request.QueryString("action")="save" then
	wuliu_id=trim(request("wuliu_id"))
	shouhuo_tel=trim(request("shouhuo_tel"))
	dingdan=trim(request("dingdan"))
	shouhuo_name=trim(request("shouhuo_name"))
	yanhuoren=trim(request("yanhuoren"))
	fahuoren=trim(request("fahuoren"))
	fahuo_date=trim(request("fahuo_date"))
	yundanhao=trim(request("yundanhao"))
	dangdiwuliu_tel=trim(request("dangdiwuliu_tel"))
	yunfei=trim(request("yunfei"))
	if wuliu_id="" then 
	wuliu_id=wuliuId(request("keyword"))
	end if
	address=trim(request("address"))

	set rs=conn.execute("select yundanhao from wuliu_yifahuo where yundanhao='"&yundanhao&"'")
	if (rs.bof and rs.eof) then
		sql="insert into wuliu_yifahuo (fahuo_date,yundanhao,wuliu_id,shouhuo_tel,shouhuo_name,fahuo_user,add_user,dangdiwuliu_tel,yunfei,address) values('"&fahuo_date&"','"&yundanhao&"','"&wuliu_id&"','"&shouhuo_tel&"','"&shouhuo_name&"','"&fahuoren&"','"&session("trueName")&"','"&dangdiwuliu_tel&"','"&yunfei&"','"&address&"')"
		'response.write sql
		'response.end
		conn.execute(sql)

		if dailidingdan<>"" then 
			thedingdan=split(dailidingdan,",")
			for i=0 to ubound(thedingdan)
				conn.execute("update Order_Agent_Main set wuliu_id="&wuliu_id&",yundanhao='"&yundanhao&"',is_postwuliu=1 where dingdan ='"&thedingdan(i)&"' and shopxp_shfs<>27 and shopxp_shfs<>23  and shopxp_shfs<>29 ")
			next
		end if
		if fenxiaodingdan<>"" then 
			thedingdan=split(fenxiaodingdan,",")
			for i=0 to ubound(thedingdan)
			conn.execute("update Order_Distribution_Main set wuliu_id="&wuliu_id&",yundanhao='"&yundanhao&"',is_postwuliu=1 where dingdan='"&thedingdan(i)&"' and shopxp_shfs<>23 ")
			next
		end if

		set rsi=conn.execute("select wy.fahuo_date,wy.yundanhao,wy.dangdiwuliu_tel,wg.wuliu_name,wy.shouhuo_tel from wuliu_yifahuo as wy inner join wuliu_gongshi as wg on wy.wuliu_id=wg.id where wy.yundanhao='"&yundanhao&"'")
		if not  rsi.eof then
			sms_content="���ã�������Ʒ��ͨ��"&rsi("wuliu_name")&"��"&rsi("fahuo_date")&"�������˵��ţ�"&yundanhao&",��������ѯ"&rsi("dangdiwuliu_tel")&""
			if Trim(Rsi("shouhuo_tel"))>"" Then	
				response.write "<script language=javascript>getMemo('"&Rsi("shouhuo_tel")&"','"&Sms_content&"');</script>"
			end If
		   'response.write "<script language=javascript>getMemo('13598015302','����˭');</script>"
		
		end if
        
		
		
		Call ConnClose
		response.End
	else
		response.write "���˵��Ѵ��ڣ�"
		response.End 
	end if
end if

function wuliuId(wuliuName)
	set wuliu_Idrs=conn.execute("select id from wuliu_gongshi where wuliu_name='"&wuliuName&"'")
	wuliuId=wuliu_Idrs("id")
end function

%>
<html><head><title>�������</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link type="text/css" rel="stylesheet" href="suggest.css"/>
<script type="text/javascript" src="suggest.js"></script>
<script language="javascript">

function checkdata()
{
 
   if (document.form1.keyword.value=="")
	{
	  alert("������˾���Ʋ���Ϊ��");
	  history.go(1);
	  return false;
	 } 
   if (document.form1.shouhuo_name.value=="")
	{
	  alert("�Բ����������ջ���������");
	  history.go(1);
	  return false;
	 }
   if (document.form1.shouhuo_tel.value=="")
	{
	  alert("�Բ����������ջ��˵绰��");
	history.go(1);
	  return false;
	 }
   if (document.form1.yundanhao.value=="")
	{
	  alert("�Բ����������˵����룡");
	 history.go(1);
	  return false;
	 }
   if (document.form1.fahuoren.value=="")
	{
	  alert("�Բ��������뷢���˲���Ϊ��");
	  history.go(1);
	  return false;
	 }	 	 	 
   if (document.form1.yunfei.value=="")
	{
	  alert("�Բ������������÷���");
	  history.go(1);
	  return false;
	 }	
 	 
    if(isNaN(document.form1.yunfei.value))
     {
       alert("�˷ѱ���Ϊ����");
	   history.go(1);
       return false;
     }

	return true;	
}

function thecheck()
{
   if (document.form2.thedingdan.value=="")
	{
	  alert("�����Ų���Ϊ�գ�");
	  history.go(1);
	  return false;
	 }
	 
   if (document.form2.sc.value=="")
	{
	  alert("��ѡ�񶩵���ʽ��");
	  history.go(1);
	  return false;
	 }	
	  
  return true;	
}

function okS(obj){ 
  document.getElementById("keyword").value=obj.options[obj.selectedIndex].text; 
} 

function okSs(obj)
{ 
	var objSelect=document.getElementById("wuliu_id");
	for (var i=0;i<=(objSelect.length-1);i++)
		{
			if (objSelect.options[i].text==obj.value)
			{
				objSelect.options[i].selected=true;
			}
		}
} 
function wuliufocus()
{
    document.form1.wuliu_id.focus();
}

/*function changDingdan(obj){ 
    
if (document.getElementById("alldingdan").value=="")
   {
   document.getElementById("alldingdan").value=obj.value;
   }
  else
  {
   document.getElementById("alldingdan").value=obj.value+","+document.getElementById("alldingdan").value;
  } 
 obj.value=""; 
 obj.focus();
} */
/* setTimeout(obj.value="",200); */
//-->
</script>

<link href="../css.css" rel="stylesheet" type="text/css">
</head>
<body  onload ="wuliufocus();"onclick="hide_suggest();">
<table width="95%" border="0" cellpadding="2" cellspacing="1" bgcolor="#DBDBDB" style="margin-top:5px; margin-left:10px">

    <tr bgcolor="#FFFFFF">
      <td height="25" align="center" bgcolor="#F7F5EE" colspan ="2"><strong>����û��˵��µĶ�����</strong></td>
    </tr>
    <tr bgcolor="#FFFFFF">
      <td style ="width :120px;" align ="right">�����룺</td>
      <td height="45" align="left">
            <form name="form2" method="post" style="margin:0px"  action="../OrderPrint/?action=UnionOrder">
                <input name="thedingdan" type="text" id="thedingdan"  size="40" style="height:25px" >
                <input type="submit" name="Submit2" value="��Ӷ���">
            </form>
      </td>
    </tr>
</table>
<table width="95%" border="0" cellpadding="2" cellspacing="1" bgcolor="#DBDBDB" style="margin-top:5px; margin-left:10px">
  <form name="form1" method="post" action="../OrderPrint/?action=save" onSubmit="return checkdata()" autocomplete="off">
    <tr bgcolor="#FFFFFF">
      <td height="25" colspan="2" align="center" bgcolor="#F7F5EE" ><strong style="color:#FF0000">��ӻ��˵�</strong></td>
    </tr>  
  
    <tr bgcolor="#FFFFFF">
      <td align="right">������˾��</td>
      <td style="PADDING-LEFT: 10px">
	  <div style="position:relative;">
	    <input type="text" name="keyword" id="keyword" onKeyUp="keyupdeal(event);" onKeyDown="keydowndeal(event);" onClick="keyupdeal(event);"   onFocus="okSs(this);"/>
		
		  <select name="wuliu_id" onChange="okS(this)">
		  <option value="">--��ѡ��������˾--</option>
		          <%
	  set rs1=conn.execute("select id,wuliu_name from wuliu_gongshi order by id desc")
	  do while not rs1.eof%>
        <option value="<%=rs1("id")%>"><%=rs1("wuliu_name")%></option>
        <%
	  rs1.movenext
	  if rs1.eof then exit do  
	  loop
	  %>
       </select>
  		<div id="suggest" style="position:absolute; left:0px; top: 20px;"></div>
     </div>		</td>
    </tr>
    
    <tr bgcolor="#FFFFFF" >
      <td width="17%" align="right">�ջ���������</td>
      <td width="83%" style="PADDING-LEFT: 10px">
      <input name="shouhuo_name" type="text" id="shouhuo_name" value="<%=rsb("shouhuoname")%>" size="50">      </td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td align="right">�ջ��˵绰��</td>
      <td style="PADDING-LEFT: 10px"><input name="shouhuo_tel" type="text" id="shouhuo_tel" value="<%=rsb("usertel")%>" size="50"><input type="checkbox" name="SendMsg" id="SendMsg" />�Ƿ�����Ϣ</td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td align="right" >�������ڣ�</td>
      <td style="PADDING-LEFT: 10px"><input name="fahuo_date" type="text" id="fahuo_date" size="50" value="<%=year(DateAdd("d",-1,date))&"-"&right("0"&month(DateAdd("d",-1,date)),2)&"-"&right("0"&day(DateAdd("d",-1,date)),2)%>">      </td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�����˷�:</td>
      <td height="30" style="PADDING-LEFT: 10px"><input name="yunfei" type="text" id="yunfei"></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�˵��ţ�</td>
      <td height="30" style="PADDING-LEFT: 10px"><input name="yundanhao" type="text" id="peihuoren4"></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�ջ���ַ:</td>
      <td height="30" style="PADDING-LEFT: 10px"><input name="address" type="text" id="address"></td>
    </tr>   
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�����ˣ�</td>
      <td height="30" style="PADDING-LEFT: 10px"><input name="fahuoren" type="text" id="fahuoren" value="�Ż�"></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">��˾�绰��</td>
      <td height="30" style="PADDING-LEFT: 10px"><input name="dangdiwuliu_tel" type="text" id="dangdiwuliu_tel" value ="0371-63655796"></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�̳Ƕ���:</td>
      <td height="30" style="PADDING-LEFT: 10px">
	  <textarea name="dingdan" cols="70" rows="8" id="dingdan" readonly ><%if dailidingdan<>"" then  %><%=left(dailidingdan,len(dailidingdan)-1)%><%end if  %> </textarea></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30" align="right">�������Ķ���:</td>
      <td height="30" style="PADDING-LEFT: 10px">
      <textarea name="fenxiaodingdan" cols="70" rows="8" id="fenxiaodingdan" readonly ><%if fenxiaodingdan<>"" then  %><%=left(fenxiaodingdan,len(fenxiaodingdan)-1)%><%end if  %></textarea></td>
    </tr>
    <tr bgcolor="#FFFFFF" >
      <td height="30"></td>
      <td height="30" style="PADDING-LEFT: 10px">
        <input type="submit" name="Submit" value="���" >
        <input type="reset" name="Clear" value="������д">      </td>
    </tr>
  </form>
</table>
</body>
</html>
