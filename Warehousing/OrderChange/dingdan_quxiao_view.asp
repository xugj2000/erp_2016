<!--#include file="../conn.asp"-->
<!--#include file="../Inc/Order_function.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
'call GetPageUrlpower("order_cancel/dingdan_quxiao_list.asp")'ȡ�ø���ҳ�������Ȩ��

''call CheckPageRead()'��鵱ǰҳ���Ƿ���ҳ���ȡȨ��
%>
<%
function formatN(num)
if num="" or isnull(num) then
num=0
else
num=cdbl(num)
end if
formatN=formatnumber(num,2,-1)
end function

userid=trim(request("userid"))

function cangkuname(num)
select case num
case "erqi_shijikucun"
cangkuname="����"
case "zhanting_shijikucun"
cangkuname="չ��"
end select
end function

function kucun_type(num)
select case num
case "1"
kucun_type="�������"
case "2"
kucun_type="�𻵿��"
end select
end function
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<meta name="GENERATOR" content="Microsoft FrontPage 5.0">
<meta name="ProgId" content="FrontPage.Editor.Document">
<title>�û��б�</title>
</head>
<style type=text/css>
body  { margin:0px; font:9pt ����; }
table  { border:0px; }
td  { font:normal 12px ����; }
img  { vertical-align:bottom; border:0px; }
a  { font:normal 12px ����; color:#000000; text-decoration:none; }
a:hover  { color:#428EFF;text-decoration:underline; }
.sec_menu  { border-left:1px solid white; border-right:1px solid white; border-bottom:1px solid white; overflow:hidden; background:#D6DFF7; }
.menu_title  { }
.menu_title span  { position:relative; top:2px; left:8px; color:#215DC6; font-weight:bold; }
.menu_title2  { }
.menu_title2 span  { position:relative; top:2px; left:8px; color:#428EFF; font-weight:bold; }
</style>

<body>
<center>
<%
id=trim(request("id"))
sql="select IsFreightDelyPay,SuggestFreight,dingdan,addkucun,pro_type,is_fanbi,userid,username,shopxpptname,shopxpptid,p_size,productcount,danjia,zonger,op_user,actiondate,quxiao_date,shopxp_shfs,zhifufangshi,cangku_type,tiaohuoren,jiehuoren,is_validate,quxiao_liyou,fuwuzhekou,warehouse_confirm,warehouse_confirmuser,warehouse_confirmdate,cart_type,fuwu_userid from CancelOrder_Agent where id="&id
 did=trim(request("did"))
%>
<br>
<table width="90%" border="0" cellpadding="4" cellspacing="1" bordercolorlight="#000000" bordercolordark="#FFFFFF" bgcolor="#A6DEFD">
<%
	set rst=server.CreateObject("adodb.recordset")
	rst.open sql,conn,3,1
	if rst.bof and rst.eof then
		response.write "<tr  bgcolor=#FFFFFF><td colspan=20>û����ؼ�¼</td></tr>"
	else
	%>
	    <tr>
	        <td height="25" bgcolor="#FFFFFF">�˷Ѹ��ʽ</td>
            <td bgcolor="#FFFFFF">
                <%
                if rst("IsFreightDelyPay")=0 then
                    response.Write "�ָ�"
                else
                    response.Write "<font color='red'>����</font>"
                end if
             %>
            </td>
	    </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�Ƿ����ӿ��</td>
        <td bgcolor="#FFFFFF"><%=Print_yes_no(rst("addkucun"))%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">���ӿ������</td>
        <td bgcolor="#FFFFFF"><%=kucun_type(rst("pro_type"))%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�Ƿ񷵱�</td>
        <td bgcolor="#FFFFFF"><%=Print_yes_no(rst("is_fanbi"))%></td>
      </tr>
	   <tr>
        <td height="25" bgcolor="#FFFFFF">���Ҵ����</td>
        <td bgcolor="#FFFFFF">
			<%
			If rst("cart_type")=1 Or rst("cart_type")=5 Then
				response.write rst("fuwu_userid")
			Else
				response.write rst("userid")
			End If 
			%>
		</td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�Ƿ����</td>
        <td bgcolor="#FFFFFF"><%=rst("is_validate")%></td>
      </tr>
      <tr>
        <td width="20%" height="25" bgcolor="#FFFFFF">������</td>
        <td width="80%" bgcolor="#FFFFFF"><%=rst("dingdan")%>&nbsp;</td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�����</td>
        <td bgcolor="#FFFFFF"><%=rst("userid")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">��������</td>
        <td bgcolor="#FFFFFF"><%=rst("username")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">��Ʒ����</td>
        <td bgcolor="#FFFFFF"><%=rst("shopxpptname")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">���</td>
        <td bgcolor="#FFFFFF"><%=rst("p_size")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">ȡ������</td>
        <td bgcolor="#FFFFFF"><%=rst("productcount")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">����</td>
        <td bgcolor="#FFFFFF"><%=rst("danjia")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">ȡ���ܶ�</td>
        <td bgcolor="#FFFFFF"><%=rst("zonger")%></td>
      </tr>
      <tr>
        <td height="20" bgcolor="#FFFFFF">�����ۿ�</td>
        <td bgcolor="#FFFFFF"><%=rst("fuwuzhekou")%></td>
      </tr>
      <tr>
        <td height="20" bgcolor="#FFFFFF">ȡ��Ա</td>
        <td bgcolor="#FFFFFF"><%=rst("op_user")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">����ʱ��</td>
        <td bgcolor="#FFFFFF"><%=rst("actiondate")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">ȡ��ʱ��</td>
        <td bgcolor="#FFFFFF"><%=rst("quxiao_date")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">������ʽ</td>
        <td bgcolor="#FFFFFF"><%=shfs(rst("shopxp_shfs"))%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">֧����ʽ</td>
        <td bgcolor="#FFFFFF"><%=zhifufangshi(rst("zhifufangshi"))%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�ֿ�</td>
        <td bgcolor="#FFFFFF"><%=cangkuname(rst("cangku_type"))%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">������</td>
        <td bgcolor="#FFFFFF"><%=rst("tiaohuoren")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�ӻ���</td>
        <td bgcolor="#FFFFFF"><%=rst("jiehuoren")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">ȡ��ԭ��</td>
        <td bgcolor="#FFFFFF"><%=rst("quxiao_liyou")%></td>
      </tr>
       <tr>
        <td height="25" bgcolor="#FFFFFF">�ֿ��Ƿ����</td>
        <td bgcolor="#FFFFFF"><%=rst("warehouse_confirm")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�ֿ�ȷ����</td>
        <td bgcolor="#FFFFFF"><%=rst("warehouse_confirmuser")%></td>
      </tr>
      <tr>
        <td height="25" bgcolor="#FFFFFF">�ֿ�ȷ��ʱ��</td>
        <td bgcolor="#FFFFFF"><%=rst("warehouse_confirmdate")%></td>
      </tr>
	  <% 
		end if
		rst.close
		set rst=nothing
	  %>
</table>
</center>
<%
	conn.close
	set conn=nothing
%>
</body>
</html>

