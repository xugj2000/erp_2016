<%@LANGUAGE="VBSCRIPT" CODEPAGE="936"%>

<!--#include file="../conn.asp"-->
<%
Response.ContentType = "text/html"
Response.Charset = "GB2312"   '解决乱码问题
'Download:http://www.codefans.net
'-----------------------------------------------------------------
dim keyword
keyword=trim(request.Form("keyword"))			'接收ajax发送的参数
	if keyword="" then response.End()
	
'------------------------------------------------------------------
	set rs=server.CreateObject("adodb.recordset")
	sql="select wuliu_name from wuliu_gongshi where wuliu_name like '%"&keyword&"%'"
	rs.open sql,conn,1,1
'------------------------------------------------------------------
	'--------如果没有找到的话,返回0
	'--------如果找到的话,返回所有匹配的项目
	if not (rs.eof and rs.bof) then
		response.Write("<ul>")
		for i=0 to 3
			if rs.eof then exit for
			response.Write("<li value='"&i&"' onclick='form_auto()' onmouseover='mo(this.value)'>"&trim(rs("wuliu_name"))&"</li>")
			rs.movenext
		next
		response.Write("<li><span>目前共有"&rs.recordcount&"个结果</span></li>")
		response.Write("</ul>")
	end if
	rs.close
	set rs=nothing
%>

