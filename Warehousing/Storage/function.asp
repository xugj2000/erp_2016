<%
'*************************************
'���ƣ�getprice
'���ã���ȡ�۸񲢸�ʽ�����
'��������Ʒ�۸�num��
'author:Litong
'*************************************
sub getprice(num)
	dim rsg,sqlg,price
	if num<>"" then
		numg=formatN(num)
		numf=replace(numg,".","")
		'numf=replace(numg,",","")��
	
	getprice2=len(numf)
	for i=1 to 11-getprice2
      response.Write "<td height='25'>&nbsp;</td>"
     next
	 for m=1 to getprice2
      response.Write "<td height='25'>"&right(left(numf,m),1)&"</td>"
     next
	 end if
end sub

'�ϼ��м��ϣ�������ţ���������ͬ��
sub getpriceSum(num)
	dim rsg,sqlg,price
	if num<>"" then
		numg=formatN(num)
		numf="��"&replace(numg,".","")
		'numf=replace(numg,",","")��
	
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
'���ƣ�getprice
'���ã���ȡ��ˮ���ܼ۸�
'���������ţ�rkhao��
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
		response.Write "������Ϣ��ʾ"
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

'�Ƿ���ȷ�Ͽ��
function queren(num)
		  select case num
		  case 1  
		  queren="��ȷ��" 
		  case 0  
		  queren="<font color=red>δȷ��</font>" 
		  case -1 
		  queren="�˴�����"
		  end select
		  
end function
%>