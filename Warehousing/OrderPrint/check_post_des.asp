<!--#include file="../conn.asp"-->
<%
Response.ContentType = "text/html"
Response.Charset = "GB2312"   '�����������

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
Ӧ���˷ѣ�<%=yingsou_yunfei%>Ԫ<br>
ʵ���˷ѣ�<%=feiyong%>Ԫ
</body>
<%
rs.close
set rs=nothing
conn.close
Set conn = Nothing
Response.End
%>
 