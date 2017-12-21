<!--#include file="../conn.asp"-->
<%
Response.ContentType = "text/html"
Response.Charset = "GB2312"   '解决乱码问题

Dim songid
songid=Request("songid")
dim province
province=left(trim(request("province")),2)
if songid="" then response.end()
userid=trim(request("userid"))

sql="select description from Config_PostStyle where songid="&songid&""
'response.write sql
set rs=server.CreateObject("adodb.recordset")
rs.open sql,conn,1,1 
%>
<body>
<%=rs("description")%>
<br>
<%call yunfei(userid,songid,province,"")%>
应收运费：<%=yingsou_yunfei%>元<br>
实收运费：<%=feiyong%>元
</body>
<%
rs.close
set rs=nothing
conn.close
Set conn = Nothing
Response.End
%>
 