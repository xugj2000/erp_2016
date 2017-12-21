<%
'*************************************
'名称：getprice
'作用：获取价格并格式化输出
'参数：产品价格（num）
'author:Litong
'*************************************
sub getprice(num)
	dim rsg,sqlg,price
	if num<>"" then
		numg=formatN(num)
		numf=replace(numg,".","")
		'numf=replace(numg,",","")￥
	
	getprice2=len(numf)
	for i=1 to 11-getprice2
      response.Write "<td height='25'>&nbsp;</td>"
     next
	 for m=1 to getprice2
      response.Write "<td height='25'>"&right(left(numf,m),1)&"</td>"
     next
	 end if
end sub

'合计中加上￥特殊符号，其它功能同上
sub getpriceSum(num)
	dim rsg,sqlg,price
	if num<>"" then
		numg=formatN(num)
		numf="￥"&replace(numg,".","")
		'numf=replace(numg,",","")￥
	
	getprice2=len(numf)
	for i=1 to 11-getprice2
      response.Write "<td height='25'>&nbsp;</td>"
     next
	 for m=1 to getprice2
      response.Write "<td height='25'>"&right(left(numf,m),1)&"</td>"
     next
	 end if
end sub

'*************************************
'名称：getprice
'作用：获取流水号总价格
'参数：入库号（rkhao）
'author:Litong
'*************************************
function getZonger(rkhao)
	dim rsg,sqlg,accmoney
	Dim n
	
	
	if rkhao<>"" then
		sqlg="select sum_money from shopxp_churuku_prodetail where liushuihao='"&rkhao&"'"
 'response.write sql
    set rsg=conn.execute(sqlg)
	if rsg.bof and rsg.eof then
		response.Write "暂无信息显示"
	else
		accmoney=0
		n=1
		do while not rsg.eof
		accmoney=accmoney+rsg("sum_money")
		 n=n+1
		 rsg.movenext
		 if rsg.eof then exit do 
		 loop
		end if
	 end if
	 getZonger=formatN(accmoney)
end function

'是否已确认库存
function queren(num)
		  select case num
		  case 1  
		  queren="已确认" 
		  case 0  
		  queren="<font color=red>未确认</font>" 
		  case -1 
		  queren="此次作废"
		  end select
		  
end function
%>