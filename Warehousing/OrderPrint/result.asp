<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!--#include file="../conn.asp"-->
<%
Response.ContentType = "text/html"
Response.Charset = "GB2312"   '�����������
'Download:http://www.codefans.net
'-----------------------------------------------------------------
dim keyword
keyword=trim(request.Form("keyword"))			'����ajax���͵Ĳ���
	if keyword="" then response.End()
	
'------------------------------------------------------------------
	set rs=server.CreateObject("adodb.recordset")
	sql="select wuliu_name from wuliu_gongshi where wuliu_name like '%"&keyword&"%'"
	rs.open sql,conn,1,1
'------------------------------------------------------------------
	'--------���û���ҵ��Ļ�,����0
	'--------����ҵ��Ļ�,��������ƥ�����Ŀ
	if not (rs.eof and rs.bof) then
		response.Write("<ul>")
		for i=0 to 3
			if rs.eof then exit for
			response.Write("<li value='"&i&"' onclick='form_auto()' onmouseover='mo(this.value)'>"&trim(rs("wuliu_name"))&"</li>")
			rs.movenext
		next
		response.Write("<li><span>Ŀǰ����"&rs.recordcount&"�����</span></li>")
		response.Write("</ul>")
	end if
	rs.close
	set rs=nothing
%>

