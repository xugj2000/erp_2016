<!--#include file="../conn.asp"-->
<!--#include file="../inc/geturl.asp"-->
<!--#include file="../inc/commonfunction.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/PowerCheck.asp"-->
<html>
<head>
<title>��������δ��������</title>
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
		<th align="center" bgcolor="#D2DCE6">��������δ����</th>
	</tr>
</table>
<table width="804" border="0" align="center"   cellpadding="3" cellspacing="1" class="Noprint">
<form name="form1" method="post" action="DirectOrderWillList.asp">
<tr bgcolor="#FFFFFF">
	<td width="9%">������</td>
	<td width="12%"><input name="dingdan" type="text" id="dingdan" size="14" ></td>
	<td width="9%">�µ�����</td>
	<td width="13%"><input name="post_date" type="text" id="post_date"   onClick="return Calendar('post_date','');" size="10" maxlength="10" readonly></td>
	<td width="12%">�ջ�������</td>
	<td width="16%"><input name="namekey" type="text" id="namekey" size="14"></td>
	<td width="9%">&nbsp;</td>
	<td width="20%"><input type="submit" name="Submit2" value="�� ѯ"></td>
</tr>
<tr bgcolor="#FFFFFF">
	<td colspan ="9" align ="right" >&nbsp;</td>
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
dim orderstr

'��ȡ��ѯ��ֵ
dingdan=trim(request("dingdan"))
username=trim(request("username"))
namekey=trim(request("namekey"))
post_date=Trim(request("post_date"))

if namekey="" then namekey=request.form("namekey")
%>
<form name="form2" action="ReturnOrderPrint.asp?isPosted=no" method="post" target="_blank">
<%Randomize   Timer() 
RefreshId=Int(Rnd(1)*1000+1) ''������������ڷ�ˢ��
session("PrintOk")=RefreshId
%>
<input type="hidden" value="<%=RefreshId%>" name="PrintOk">
  <%
	set rs=server.CreateObject("adodb.recordset")
	sql="select * from TB_GoodsReturnOrder where  OrderStatus=0"
	'������
	if dingdan<>"" then
		sql=sql&" and OrderId='"&dingdan&"'"
	end If

    '�ջ�������
	if namekey<>"����������" and namekey<>"" then
	  sql=sql&" and ReveivedName like '%"&namekey&"%' "
	end If
	
	'�������� 
	if post_date<>"" Then
	  If IsDate(post_date)=False Then 
	    response.write"���ڸ�ʽ����ȷ"
		response.End 
	   End If 
	  sql=sql&" and CONVERT (varchar(10),AddTime,120)='"&post_date&"'"
	end If	
 	sql=sql&" order by AddTime desc"
 	'response.Write sql
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
		
		dd=trim(rs("OrderId"))
		if orderstr="" then
		orderstr=dd
		else
		orderstr=orderstr&","&dd
		end if
		dingdan_userid=rs("AgentId")
		AddTime=rs("AddTime")
		usertel=rs("UserTel")
		province=rs("province")
		city=rs("city")
		xian=rs("xian")
		shopxp_shdz=rs("PostAddress")
		shouhuoname=rs("ReveivedName")

		  %>
        <table width="100%" border="0" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC">
          <tr bgcolor="#FFFFFF">
            <td width="19%" align="left" valign="top" nowrap><img src="../images/logo.gif" width="100" height="50" align="bottom"></td>
            <td width="81%" align="center" nowrap class="bigtitle">����������������Ʒ�嵥</td>
          </tr>
        </table>
        <table width="100%" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#CCCCCC">
          <tr bgcolor="#CECFCE" >
            <td width="20%" align="center">������</td>
            <td width="12%" align="center">��������</td>
            <td width="12%" align="center">���ѷ�ʽ</td>
            <td width="19%" align="center">�µ�ID</td>
            <td width="20%" align="center">�µ�ʱ��</td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td align="center"><input type="checkbox" name="dingdan" value="<%=trim(dd)%>">
              <a href="javascript:;" onClick="javascript:window.open('order_agent_view.asp?dan=<%=dd%>&shopxp_shfs=<%=shopxp_shfs%>','','width=710,height=588,top=50,left=50,toolbar=no, status=no, menubar=no, resizable=yes, scrollbars=yes');return false;"><%=trim(dd)%></a></td>
            <td align="center">��������</td>
            <td align="center">�����µ�</td>
            <td align="center"><%=dingdan_userid%></td>
            <td align="center"><%=AddTime%>            </td>
          </tr>
          <tr bgcolor="#FFFFFF" >
            <td colspan="5" align="center">
			<%
				set rss=server.CreateObject("adodb.recordset") 
				sql="select * from TB_GoodsReturn  where ReturnOrderId='"&dd&"' and ChangeFlag>=0 order by ID desc"
				rss.open sql,conn,3
%>
              <table width="98%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#CCCCCC" >
                <tr align="center" bgcolor="#FFFFFF">
                  <td width="50%">��Ʒ����</td>
                  <td width="50%">��������</td>
                </tr>
                <%
					zongji=0
					zongjifen=0
					allCount=0
				do while not rss.eof
				%>
                <tr bgcolor="#FFFFFF" align="center">
                  <td nowrap style='PADDING-LEFT: 5px;' align="left"><%=trim(rss("ProductName"))%></td>
                  <td bgcolor="#FFFFFF"><%=rss("ProductCount")%></td>
                </tr>
                <%
					ys=ys+1
				rss.movenext
				loop
				rss.close
				set rss=nothing
			%>
              </table></td>
          </tr>

          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" class="shdz" >&nbsp;�ջ���:&nbsp;              </td>
            <td height="30" class="shdz" ><%=trim(shouhuoname)%></td>
            <td height="30" class="shdz" >��ϵ�绰</td>
            <td height="30" class="shdz" ><%=trim(usertel)%></td>
            <td height="30" align="center" class="shdz"><%=allCount%></td>
          </tr>
          <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="4" class="shdz" >&nbsp;�ջ���ַ:<%=trim(province)%><%=trim(city)%><%=trim(xian)%><%=trim(shopxp_shdz)%> <%
                if IsFreightDelyPay="1" then
                    response.Write "<font color='red'>(�˷ѵ���)</font>"
                end if
             %></td>
            <td class="shdz">&nbsp;</td>
          </tr>
		            <tr bgcolor="#FFFFFF" style="font-size:18px; ">
            <td height="30" colspan="5" class="shdz" ><%if liuyan<>"" then response.write "���ԣ�<font style='font-size:12px;font-weight:normal;'>"&liuyan&"</font>"%></td>
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
<%'��ҳ
		alink="ReturnOrderWillList.asp?dingdan="&dingdan&"&userid="&userid&"&namekey="&namekey&"&post_date="&post_date
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