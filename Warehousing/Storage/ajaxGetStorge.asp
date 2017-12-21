<% 
Response.Charset = "GB2312"   '解决乱码问题
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
 %>
<!--#include file="conn.asp"-->
<!--#include file="inc/function.asp"-->
<% 
DIM warehouseID,shopxp_yangshiid,JsonStr
warehouseID=request("wid")
shopxp_yangshiid=request("sid")
if warehouseID="" or shopxp_yangshiid="" then
     response.Write "库存读取失败"
     response.End()
else
     JsonStr=""
     sql="SELECT top 1 a.shiji_num,a.sunhuai_num,a.NotPost_num,a.shiji_num+a.sunhuai_num as currentNum,a.zhengjian_huojiahao,a.sanjian_huojiahao,a.max_have,a.SaleNumDayOfLastWeek,a.GoodsTurnCycle,a.wuliushijian,a.SaleNumDayOfLastWeek*a.GoodsTurnCycle+a.SaleNumDayOfLastWeek*a.wuliushijian-(a.shiji_num+a.sunhuai_num) as SuggestDiliverNum,c.length,c.width,c.height FROM WareHouse_Detail a left join supplier b on a.supplier_id=b.id left join shopxp_product c on a.shopxpptid=c.shopxpptid  WHERE a.warehouse_id="&warehouseID&" AND a.shopxp_yangshiid="&shopxp_yangshiid&" "
     set rs=conn.execute(sql)
	 if rs.eof and rs.bof then
	      JsonStr="({"
		  JsonStr=JsonStr&chr(34)&"shiji_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"sunhuai_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"NotPost_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"max_have"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"SaleNumDayOfLastWeek"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"GoodsTurnCycle"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"currentNum"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"SuggestDiliverNum"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&"0"&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"Volume"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"zhengjian_huojiahao"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"sanjian_huojiahao"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"wuliushijian"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&chr(34)
		  JsonStr=JsonStr&"})"
	 else
	      JsonStr="({"
		  JsonStr=JsonStr&chr(34)&"shiji_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("shiji_num")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"sunhuai_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("sunhuai_num")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"NotPost_num"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("NotPost_num")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"max_have"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("max_have")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"SaleNumDayOfLastWeek"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("SaleNumDayOfLastWeek")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"GoodsTurnCycle"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("GoodsTurnCycle")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"currentNum"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("currentNum")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"SuggestDiliverNum"&chr(34)&":"
		  SuggestDiliverNum=rs("SuggestDiliverNum")
		  if SuggestDiliverNum<0 then SuggestDiliverNum=0  
		  SuggestDiliverNum=getCeil(SuggestDiliverNum)
		  JsonStr=JsonStr&chr(34)&SuggestDiliverNum&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"Volume"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("length")&"*"&rs("width")&"*"&rs("height")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"zhengjian_huojiahao"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("zhengjian_huojiahao")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"sanjian_huojiahao"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("sanjian_huojiahao")&chr(34)&","
		  JsonStr=JsonStr&chr(34)&"wuliushijian"&chr(34)&":"
		  JsonStr=JsonStr&chr(34)&rs("wuliushijian")&chr(34)
		  JsonStr=JsonStr&"})"	 
	 end if
     response.Write JsonStr
	 response.End()
end if
 %>