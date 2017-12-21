<!--#include file="../conn.asp"-->
<!--#include file="../inc/ParentcheckPower.asp"-->
<%
call GetPageUrlpower("OrderPrint/wuliu_add.asp")'取得父级页面的所有权限

call CheckPageRead()'检查当前页面是否有页面读取权限
%>
<style type="text/css" >
/* 弹出窗口 */
.dialog{
padding:15px 10px 8px;
width:<%=request("w")%>px;
height:<%=request("h")%>px;
border:solid 1px #0099FF;
background:#C2DDF5;
filter: Alpha(Opacity=100);
-moz-opacity:1; 
opacity:1;
z-index:5100;
font-size:12px;
}
</style>
<script type="text/javascript" src="../pcasunzip.js"></script>
<script language="javascript" defer="defer">
new PCAS("wuliuProvince","wuliuCity","wuliuCounty","<%=request("wuliuProvince1")%>","<%=request("wuliuCity1")%>","<%=request("wuliuCounty1")%>");

function sClosed1(){
	var bgObj = parent.document.getElementById("bgDiv");
	parent.document.body.removeChild(bgObj);
	parent.document.getElementById("msgDiv").removeChild(parent.document.getElementById("msgTitle"));
	parent.location.reload();
}
var thevalue
thevalue=document.getElementById("wuliu_id1").value
document.getElementById("wuliu_id").value=thevalue
</script>
<% 
act=request("act")
action=request("action")
theId=request("theId")
wuliu_Id=request("wuliu_Id")
wuliu_url=request("wuliu_url")
wuliuProvince=request("wuliuProvince")
wuliuCity=request("wuliuCity")
wuliuCounty=request("wuliuCounty")
wuliuTell=request("wuliuTell")
if action="add2" and PowerAdd>0 then 
add2()
response.End()
end if
if action="edit" and PowerEdit>0 then 
edit()
response.End()
end if
if action="edit2" and PowerEdit>0 then 
edit2()
response.End()
end if

%>
<%
if act="edit" then
set wuliurs=conn.execute("select wuliu_tel,wuliu_name,id,wuliu_Url from  wuliu_gongshi where id="&theId&"")
wuliu_tel=wuliurs("wuliu_tel")
wuliu_name=wuliurs("wuliu_name")
wuliu_Url=wuliurs("wuliu_Url")
Id=wuliurs("id")
wuliurs.close
set wuliurs=nothing
%>
<div id="dialog_1" class="dialog" >	
  <form id="form1" name="form1" method="post" action="../OrderPrint/?action=edit&amp;act=<%=act%>&amp;theId=<%=id%>&amp;h=<%=request("h")%>" style="margin:0px">
    <table width="93%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#DBDBDB" style="font-size:12px">
      <tr bgcolor="#FFFFFF">
        <td colspan="2" align="center" bgcolor="#999999"><strong><font color="#FFFFFF" >修改物流公司</font></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="35%" align="right">物流公司：</td>
        <td width="65%" height="27" style="PADDING-LEFT: 10px">
        <input name="wuliu_name" type="text" id="wuliu_name" size="20" value="<%=wuliu_name%>"/></td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">物流公司电话：</td>
        <td height="27" style="PADDING-LEFT: 10px"><input name="wuliuTell" type="text" id="wuliuTell" size="20" value="<%=wuliu_tel%>"/>
            <a href="javascript:sClosed1()">
            <input name="Id" type="hidden" id="Id"  value="<%=id%>"/>
          </a></td>
      </tr>

      <tr bgcolor="#FFFFFF" >
        <td align="right">物流公司网址：</td>
        <td height="27" style="PADDING-LEFT: 10px"><input name="wuliu_Url" type="text" id="wuliu_Url" size="35" value="<%=wuliu_Url%>"/>
          <a href="javascript:sClosed1()"></a></td>
      </tr>
      <tr bgcolor="#FFFFFF"  >
        <td height="30" colspan="2" align="center"><input type="submit" name="Submit32" value="修改" />
          &nbsp;&nbsp;
          <input name="Clear2" type="reset" value="重置" />        </td>
      </tr>
    </table>
  </form>
</div>
<%
 end if
 if act="edit2" then
%>
<div id="dialog_1" class="dialog" >
  <form id="form2" name="form2" method="post" action="../OrderPrint/?action=edit2&amp;act=<%=act%>&amp;h=<%=request("h")%>&amp;theid=<%=theId%>&amp;wuliuProvince1=<%=request("wuliuProvince1")%>&amp;wuliuCity1=<%=request("wuliuCity1")%>&amp;wuliuCounty1=<%=request("wuliuCounty1")%>&amp;wuliuTell1=<%=request("wuliuTell1")%>&amp;wuliuclassid=<%=request("wuliuclassId")%>" style="margin:0px">
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#DBDBDB" style="font-size:12px">
      <tr bgcolor="#FFFFFF">
        <td colspan="2" align="center" bgcolor="#999999"><strong><font color="#FFFFFF" >修改子物流公司</font></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="35%" align="right">物流公司：</td>
        <td width="65%" height="27" style="PADDING-LEFT: 10px"><select name="select" size="1" style="font-size: 12px" disabled="disabled" >
 <%
set rs = Server.CreateObject("ADODB.RecordSet")
sql="select id,wuliu_name from wuliu_gongshi order by add_date desc" 
rs.open sql,conn,1,1
if rs.eof then
response.write "没有类别请添加！"
response.end
else
Do while not rs.eof
   if theId=cstr(rs("id")) then
      khl="selected"
   else
      khl=""
   end if
   response.write ("<option "&khl&" value="&rs("id")&">"&rs("wuliu_name")&"</option>")
   rs.MoveNext
Loop
end if
rs.close
set rs=nothing
%>
          </select>
            <input name="wuliu_Id" type="hidden" id="wuliu_Id" value="<%=theId%>" />
            <input name="wuliuclassID" type="hidden" id="wuliuclassID" value="<%=request("wuliuclassID")%>" /></td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">所属省：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuProvince"  style="display:none">
          </select>
		  <input name="" type="text" value="<%=request("wuliuProvince1")%>"  disabled="disabled"/>
        </td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">所属市：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuCity"  >
        </select>		
		</td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">所属县/区：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuCounty" >
        </select>
		
		</td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">当地物流电话：</td>
        <td height="27" style="PADDING-LEFT: 10px"><input name="wuliuTell" type="text" id="wuliuTell" size="20" value="<%=request("wuliuTell1")%>" />
          <a href="javascript:sClosed1()"></a></td>
      </tr>
      <tr bgcolor="#FFFFFF"  >
        <td height="30" colspan="2" align="center"><input type="submit" name="Submit33" value="添加" />
          &nbsp;&nbsp;
          <input name="Clear3" type="reset" value="重置" />
        </td>
      </tr>
    </table>
  </form>
</div>
<%
 end if
 if act="add2" then
%>
<div id="dialog_1" class="dialog" >

  <form id="form2" name="form2" method="post" action="../OrderPrint/?action=add2&amp;act=<%=act%>&amp;h=<%=request("h")%>&amp;theid=<%=theId%>&amp;wuliuProvince1=<%=request("wuliuProvince1")%>" style="margin:0px">
    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#DBDBDB" style="font-size:12px">
      <tr bgcolor="#FFFFFF">
        <td colspan="2" align="center" bgcolor="#999999"><strong><font color="#FFFFFF" >添加子物流公司</font></strong></td>
      </tr>
      <tr bgcolor="#FFFFFF">
        <td width="35%" align="right">物流公司：</td>
        <td width="65%" height="27" style="PADDING-LEFT: 10px">
<select name="wuliu_Id1" size="1" style="font-size: 12px" disabled="disabled" >
<%
set rs = Server.CreateObject("ADODB.RecordSet")
sql="select id,wuliu_name from wuliu_gongshi order by add_date desc" 
rs.open sql,conn,1,1
if rs.eof then
response.write "没有类别请添加！"
response.end
else
Do while not rs.eof
   if theId=cstr(rs("id")) then
      khl="selected"
   else
      khl=""
   end if
   response.write ("<option "&khl&" value="&rs("id")&">"&rs("wuliu_name")&"</option>")
   rs.MoveNext
Loop
end if
rs.close
set rs=nothing
%>
</select>
<input name="wuliu_Id" type="hidden" value="<%=theId%>" />
</td>
      </tr>
      <tr bgcolor="#FFFFFF" >
	  
        <td align="right">所属省：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuProvince"  <%  if request("wuliuProvince1")<>"" then %> style="display:none"<%end if%> >
                </select>
				<%  if request("wuliuProvince1")<>"" then %>
				<input type="text" disabled="disabled" value="<%=request("wuliuProvince1")%>" size="15"/>
				<% end if%>
		</td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">所属市：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuCity" >
                </select></td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">所属县/区：</td>
        <td height="27" style="PADDING-LEFT: 10px"><select name="wuliuCounty">
                </select></td>
      </tr>
      <tr bgcolor="#FFFFFF" >
        <td align="right">当地物流电话：</td>
        <td height="27" style="PADDING-LEFT: 10px"><input name="wuliuTell" type="text" id="wuliu_name23" size="20" />
        <a href="javascript:sClosed1()"></a></td>
      </tr>
      <tr bgcolor="#FFFFFF"  >
        <td height="30" colspan="2" align="center"><input type="submit" name="Submit3" value="添加" />&nbsp;&nbsp;
        <input name="Clear" type="reset" value="重置" />        </td>
      </tr>
    </table>
  </form>
</div >
<% 
end if

'asp定义函数
function add2()

set rsWuliu=conn.execute("select wuliuClassId  from wuliu_gongshi_class where wuliuGongshiID='"&wuliu_Id&"' and wuliuCity='"&wuliuCity&"' and wuliuCounty='"&wuliuCounty&"'")
if not(rsWuliu.eof and rsWuliu.bof) then 
	response.write ("<script>alert('错误！该地区已经添加过电话');location.href='dialog.asp?act="&act&"&theId="&theId&"&h="&request("h")&"&wuliuProvince1="&request("wuliuProvince1")&"';</script>")
else
	conn.execute("insert into wuliu_gongshi_class (wuliuGongshiID,wuliuProvince,wuliuCity,wuliuCounty,wuliuTell,addTime) values('"&wuliu_Id&"','"&wuliuProvince&"','"&wuliuCity&"','"&wuliuCounty&"','"&wuliuTell&"','"&date()&"')")
	Response.Write("<div id=dialog_1 class=dialog><center style='font-size:12px'>添加成功，请关闭查看<a href=javascript:sClosed1()>关闭</a>窗口查看</center></div>")
end if
rsWuliu.close
set rsWuliu=nothing
end function

function edit()
set rsWuliu=conn.execute("select id  from wuliu_gongshi where wuliu_name='"&request("wuliu_name")&"' and id not in ("&request("id")&")")
if not(rsWuliu.eof and rsWuliu.bof) then 
	response.write ("<script>alert('对不起，此物流公司已存在');location.href='dialog.asp?act="&act&"&theId="&theId&"&h="&request("h")&"';</script>")
else
	conn.execute("update wuliu_gongshi set wuliu_name='"&request("wuliu_name")&"',wuliu_tel='"&request("wuliuTell")&"' ,wuliu_url='"&request("wuliu_url")&"' where id="&request("id")&"")
	Response.Write("<div id=dialog_1 class=dialog><center style='font-size:12px'>修改成功，请关闭查看<a href=javascript:sClosed1()>关闭</a>窗口查看</center></div>")		
end if
rsWuliu.close
set rsWuliu=nothing
end function

function edit2()

set rsWuliu2=conn.execute("select wuliuClassId  from wuliu_gongshi_class where wuliuGongshiID='"&wuliu_Id&"' and wuliuClassId<> "&request("wuliuclassID")&" and wuliuCounty='"&wuliuCounty&"'")
if not(rsWuliu2.eof and rsWuliu2.bof) then 
	response.write ("<script>alert('错误！该地区已经添加过电话');location.href='dialog.asp?act="&act&"&theId="&theId&"&h="&request("h")&"&wuliuProvince1="&request("wuliuProvince1")&"&wuliuCity1="&request("wuliuCity1")&"&wuliuCounty1="&request("wuliuCounty1")&"&wuliuTell1="&request("wuliuTell1")&"';</script>")
else
	conn.execute("update wuliu_gongshi_class set wuliuCity='"&request("wuliuCity")&"',wuliuCounty='"&request("wuliuCounty")&"',wuliuTell='"&request("wuliuTell")&"'where wuliuclassid="&request("wuliuclassid")&"")
	Response.Write("<div id=dialog_1 class=dialog><center style='font-size:12px'>修改成功，请关闭查看<a href=javascript:sClosed1()>关闭</a>窗口查看</center></div>")		
end if
rsWuliu2.close
set rsWuliu2=nothing


end function
%>