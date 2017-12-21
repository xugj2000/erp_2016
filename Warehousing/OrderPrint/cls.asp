<%
'==================================================
'��������GetHttpPage
'��  �ã���ȡ��ҳԴ��
'��  ����HttpUrl ------��ҳ��ַ
'==================================================
Function GetHttpPage(HttpUrl)
   If IsNull(HttpUrl)=True Or Len(HttpUrl)<18 Or HttpUrl="$False$" Then
      GetHttpPage="$False$"
      Exit Function
   End If
   Dim Http
   Set Http=server.createobject("MSX" & "ML2.XM" & "LHT" & "TP")
   Http.open "GET",HttpUrl,False
   Http.Send()
   If Http.Readystate<>4 then
      Set Http=Nothing 
      GetHttpPage="$False$"
      Exit function
   End if
   GetHTTPPage=bytesToBSTR(Http.responseBody,"GB2312")
   Set Http=Nothing
   If Err.number<>0 then
      Err.Clear
   End If
End Function

'==================================================
'��������BytesToBstr
'��  �ã�����ȡ��Դ��ת��Ϊ����
'��  ����Body ------Ҫת���ı���
'��  ����Cset ------Ҫת��������
'==================================================
Function BytesToBstr(Body,Cset)
   Dim Objstream
   Set Objstream = Server.CreateObject("ad" & "odb.str" & "eam")
   objstream.Type = 1
   objstream.Mode =3
   objstream.Open
   objstream.Write body
   objstream.Position = 0
   objstream.Type = 2
   objstream.Charset = Cset
   BytesToBstr = objstream.ReadText 
   objstream.Close
   set objstream = nothing
End Function


'==================================================
'��������GetBody
'��  �ã���ȡ�ַ���
'��  ����ConStr ------��Ҫ��ȡ���ַ���
'��  ����StartStr ------��ʼ�ַ���
'��  ����OverStr ------�����ַ���
'��  ����IncluL ------�Ƿ����StartStr
'��  ����IncluR ------�Ƿ����OverStr
'==================================================
Function GetBody(ConStr,StartStr,OverStr,IncluL,IncluR)
   If ConStr="$False$" or ConStr="" or IsNull(ConStr)=True Or StartStr="" or IsNull(StartStr)=True Or OverStr="" or IsNull(OverStr)=True Then
      GetBody="$False$"
      Exit Function
   End If
   Dim ConStrTemp
   Dim Start,Over
   ConStrTemp=Lcase(ConStr)
   StartStr=Lcase(StartStr)
   OverStr=Lcase(OverStr)
   Start = InStrB(1, ConStrTemp, StartStr, vbBinaryCompare)
   If Start<=0 then
      GetBody="$False$"
      Exit Function
   Else
      If IncluL=False Then
         Start=Start+LenB(StartStr)
      End If
   End If
   Over=InStrB(Start,ConStrTemp,OverStr,vbBinaryCompare)
   If Over<=0 Or Over<=Start then
      GetBody="$False$"
      Exit Function
   Else
      If IncluR=True Then
         Over=Over+LenB(OverStr)
      End If
   End If
   GetBody=MidB(ConStr,Start,Over-Start)
End Function


'==================================================
'��������GetArray
'��  �ã���ȡ���ӵ�ַ����$Array$�ָ�
'��  ����ConStr ------��ȡ��ַ��ԭ�ַ�
'��  ����StartStr ------��ʼ�ַ���
'��  ����OverStr ------�����ַ���
'��  ����IncluL ------�Ƿ����StartStr
'��  ����IncluR ------�Ƿ����OverStr
'==================================================
Function GetArray(Byval ConStr,StartStr,OverStr,IncluL,IncluR)
   If ConStr="$False$" or ConStr="" Or IsNull(ConStr)=True or StartStr="" Or OverStr="" or  IsNull(StartStr)=True Or IsNull(OverStr)=True Then
      GetArray="$False$"
      Exit Function
   End If
   Dim TempStr,TempStr2,objRegExp,Matches,Match
   TempStr=""
   Set objRegExp = New Regexp 
   objRegExp.IgnoreCase = True 
   objRegExp.Global = True
   objRegExp.Pattern = "("&StartStr&").+?("&OverStr&")"
   Set Matches =objRegExp.Execute(ConStr) 
   For Each Match in Matches
      TempStr=TempStr & "$Array$" & Match.Value
   Next 
   Set Matches=nothing

   If TempStr="" Then
      GetArray="$False$"
      Exit Function
   End If
   TempStr=Right(TempStr,Len(TempStr)-7)
   If IncluL=False then
      objRegExp.Pattern =StartStr
      TempStr=objRegExp.Replace(TempStr,"")
   End if
   If IncluR=False then
      objRegExp.Pattern =OverStr
      TempStr=objRegExp.Replace(TempStr,"")
   End if
'objRegExp.Pattern ="<a href(.[^><]*)/a>"
  'TempStr=objRegExp.Replace(TempStr,"")
   Set objRegExp=nothing
   Set Matches=nothing
   
   TempStr=Replace(TempStr,"""","")
   TempStr=Replace(TempStr,"'","")
   TempStr=Replace(TempStr," ","")
   TempStr=Replace(TempStr,"(","")
   TempStr=Replace(TempStr,")","")

   If TempStr="" then
      GetArray="$False$"
   Else
      GetArray=TempStr
   End if
End Function


'==================================================
'��������FpHtmlEnCode
'��  �ã��������
'��  ����fString ------�ַ���
'==================================================
Function FpHtmlEnCode(fString)
   If IsNull(fString)=False or fString<>"" or fString<>"$False$" Then
       fString=nohtml(fString)
       fString=FilterJS(fString)
       fString = Replace(fString,"&nbsp;"," ")
       fString = Replace(fString,"&quot;","")
       fString = Replace(fString,"&#39;","")
       fString = replace(fString, ">", "")
       fString = replace(fString, "<", "")
       fString = Replace(fString, CHR(9), " ")'&nbsp;
       fString = Replace(fString, CHR(10), "")
       fString = Replace(fString, CHR(13), "")
       fString = Replace(fString, CHR(34), "")
       fString = Replace(fString, CHR(32), " ")'space
       fString = Replace(fString, CHR(39), "")
       fString = Replace(fString, CHR(10) & CHR(10),"")
       fString = Replace(fString, CHR(10)&CHR(13), "")
       fString=Trim(fString)
       FpHtmlEnCode=fString
   Else
       FpHtmlEnCode="$False$"
   End If
End Function

'==================================================
'��������GetPaing
'��  �ã���ȡ��ҳ
'==================================================
Function GetPaing(Byval ConStr,StartStr,OverStr,IncluL,IncluR)
If ConStr="$False$" or ConStr="" Or StartStr="" Or OverStr="" or IsNull(ConStr)=True or IsNull(StartStr)=True Or IsNull(OverStr)=True Then
   GetPaing="$False$"
   Exit Function
End If

Dim Start,Over,ConTemp,TempStr
TempStr=LCase(ConStr)
StartStr=LCase(StartStr)
OverStr=LCase(OverStr)
Over=Instr(1,TempStr,OverStr)
If Over<=0 Then
   GetPaing="$False$"
   Exit Function
Else
   If IncluR=True Then
      Over=Over+Len(OverStr)
   End If
End If
TempStr=Mid(TempStr,1,Over)
Start=InstrRev(TempStr,StartStr)
If IncluL=False Then
   Start=Start+Len(StartStr)
End If

If Start<=0 Or Start>=Over Then
   GetPaing="$False$"
   Exit Function
End If
ConTemp=Mid(ConStr,Start,Over-Start)

ConTemp=Trim(ConTemp)
'ConTemp=Replace(ConTemp," ","")
ConTemp=Replace(ConTemp,",","")
ConTemp=Replace(ConTemp,"'","")
ConTemp=Replace(ConTemp,"""","")
ConTemp=Replace(ConTemp,">","")
ConTemp=Replace(ConTemp,"<","")
ConTemp=Replace(ConTemp,"&nbsp;","")
GetPaing=ConTemp
End Function

'
Function CheckUrl(strUrl)
   Dim Re
   Set Re=new RegExp
   Re.IgnoreCase =true
   Re.Global=True
   Re.Pattern="http://([\w-]+\.)+[\w-]+(/[\w-./?%&=]*)?"
   If Re.test(strUrl)=True Then
      CheckUrl=strUrl
   Else
      CheckUrl="$False$"
   End If
   Set Rs=Nothing
End Function

'==================================================
'��������ScriptHtml
'��  �ã�����html���
'��  ����ConStr ------ Ҫ���˵��ַ���
'==================================================
Function ScriptHtml(Byval ConStr,TagName,FType)
    Dim Re
    Set Re=new RegExp
    Re.IgnoreCase =true
    Re.Global=True
    Select Case FType
    Case 1
       Re.Pattern="<" & TagName & "([^>])*>"
       ConStr=Re.Replace(ConStr,"")
    Case 2
       Re.Pattern="<" & TagName & "([^>])*>.*?</" & TagName & "([^>])*>"
       ConStr=Re.Replace(ConStr,"")
    Case 3
       Re.Pattern="<" & TagName & "([^>])*>"
       ConStr=Re.Replace(ConStr,"")
       Re.Pattern="</" & TagName & "([^>])*>"
       ConStr=Re.Replace(ConStr,"")
    End Select
    ScriptHtml=ConStr
    Set Re=Nothing
End Function


'**************************************************
'��������IsObjInstalled
'��  �ã��������Ƿ��Ѿ���װ
'��  ����strClassString ----�����
'����ֵ��True  ----�Ѿ���װ
'        False ----û�а�װ
'**************************************************
Function IsObjInstalled(strClassString)
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

'**************************************************
'��������FSOFileRead
'��  �ã�ʹ��FSO��ȡ�ļ����ݵĺ���
'��  ����filename  ----�ļ�����
'����ֵ���ļ�����
'**************************************************
  function FSOFileRead(filename) 
  Dim objFSO,objCountFile,FiletempData 
  Set objFSO = Server.CreateObject("Scripting.FileSystemObject") 
  Set objCountFile = objFSO.OpenTextFile(Server.MapPath(filename),1,True) 
  FSOFileRead = objCountFile.ReadAll 
  objCountFile.Close 
  Set objCountFile=Nothing 
  Set objFSO = Nothing 
  End Function 

'**************************************************
'��������FSOlinedit
'��  �ã�ʹ��FSO��ȡ�ļ�ĳһ�еĺ���
'��  ����filename  ----�ļ�����
'        lineNum   ----����
'����ֵ���ļ���������
'**************************************************
  function FSOlinedit(filename,lineNum) 
  if linenum < 1 then exit function 
  dim fso,f,temparray,tempcnt 
  set fso = server.CreateObject("scripting.filesystemobject") 
  if not fso.fileExists(server.mappath(filename)) then exit function 
  set f = fso.opentextfile(server.mappath(filename),1) 
  if not f.AtEndofStream then 
  tempcnt = f.readall 
  f.close 
  set f = nothing 
  temparray = split(tempcnt,chr(13)&chr(10)) 
  if lineNum>ubound(temparray)+1 then 
  exit function 
  else 
  FSOlinedit = temparray(lineNum-1) 
  end if 
  end if 
  end function 

'**************************************************
'��������FSOlinewrite
'��  �ã�ʹ��FSOд�ļ�ĳһ�еĺ���
'��  ����filename    ----�ļ�����
'        lineNum     ----����
'        Linecontent ----����
'����ֵ����
'**************************************************
  function FSOlinewrite(filename,lineNum,Linecontent) 
  if linenum < 1 then exit function 
  dim fso,f,temparray,tempCnt 
  set fso = server.CreateObject("scripting.filesystemobject") 
  if not fso.fileExists(server.mappath(filename)) then exit function 
  set f = fso.opentextfile(server.mappath(filename),1) 
  if not f.AtEndofStream then 
  tempcnt = f.readall 
  f.close 
  temparray = split(tempcnt,chr(13)&chr(10)) 
  if lineNum>ubound(temparray)+1 then 
  exit function 
  else 
  temparray(lineNum-1) = lineContent 
  end if 
  tempcnt = join(temparray,chr(13)&chr(10)) 
  set f = fso.createtextfile(server.mappath(filename),true) 
  f.write tempcnt 
  end if 
  f.close 
  set f = nothing 
  end function  
  
'**************************************************
'��������ShowPage
'��  �ã���ʾ����һҳ ��һҳ������Ϣ
'��  ����sFileName    ----���ӵ�ַ
'        TotalNumber  ----������
'        MaxPerPage   ----ÿҳ����
'        ShowTotal    ----�Ƿ���ʾ������
'        ShowAllPages ----�Ƿ��������б���ʾ����ҳ���Թ���ת����ĳЩҳ�治��ʹ�ã���������JS����
'        strUnit      ----������λ
'����ֵ������һҳ ��һҳ������Ϣ��HTML����
'**************************************************
function ShowPage(sFileName,CurrentPage,TotalNumber,MaxPerPage,ShowTotal,ShowAllPages,strUnit)
	dim TotalPage,strTemp,strUrl,i

	if TotalNumber=0 or MaxPerPage=0 or isNull(MaxPerPage) then
		ShowPage=""
		exit function
	end if
	if totalnumber mod maxperpage=0 then
    	TotalPage= totalnumber \ maxperpage
  	else
    	TotalPage= totalnumber \ maxperpage+1
  	end if
	if CurrentPage>TotalPage then CurrentPage=TotalPage
		
  	strTemp= "<table align='center'><tr><td>"
	if ShowTotal=true then 
		strTemp=strTemp & "�� <b>" & totalnumber & "</b> " & strUnit & "&nbsp;&nbsp;"
	end if
	strUrl=JoinChar(sfilename)
  	if CurrentPage<2 then
    	strTemp=strTemp & "��ҳ ��һҳ&nbsp;"
  	else
    	strTemp=strTemp & "<a href='" & strUrl & "page=1'>��ҳ</a>&nbsp;"
    	strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage-1) & "'>��һҳ</a>&nbsp;"
  	end if

  	if CurrentPage>=TotalPage then
    	strTemp=strTemp & "��һҳ βҳ"
  	else
    	strTemp=strTemp & "<a href='" & strUrl & "page=" & (CurrentPage+1) & "'>��һҳ</a>&nbsp;"
    	strTemp=strTemp & "<a href='" & strUrl & "page=" & TotalPage & "'>βҳ</a>"
  	end if
   	strTemp=strTemp & "&nbsp;ҳ�Σ�<strong><font color=red>" & CurrentPage & "</font>/" & TotalPage & "</strong>ҳ "
        strTemp=strTemp & "&nbsp;<b>" & maxperpage & "</b>" & strUnit & "/ҳ"
	if ShowAllPages=True then
		strTemp=strTemp & "&nbsp;&nbsp;ת����<input type='text' name='page' size='3' maxlength='5' value='" & CurrentPage & "' onKeyPress=""if (event.keyCode==13) window.location='" & strUrl & "page=" & "'+this.value;""'>ҳ"
	end if
	strTemp=strTemp & "</td></tr></table>"
	ShowPage=strTemp
end function

'****************************************************
'��������WriteErrMsg
'��  �ã���ʾ������ʾ��Ϣ
'��  ������
'****************************************************
sub WriteErrMsg(errmsg)
	dim strErr
	strErr=strErr & "<html><head><title>������Ϣ</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>" & vbcrlf
	strErr=strErr & "<link href='css/main.css' rel='stylesheet' type='text/css'></head><body><br><br>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=1 border=1 width=500 class='border' align=center  bordercolor=#A4CEE4 bordercolordark=#FFFFFF>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='xxxxxt'><td height='22' bgcolor=#588fc7><font color=#FFFFFF><b>������Ϣ</b></font></td></tr>" & vbcrlf
	strErr=strErr & "  <tr class='dt'><td height='100' valign='top'><b>��������Ŀ���ԭ��</b>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center' class='dt'><td><a href='javascript:history.go(-1)'>&lt;&lt; ������һҳ</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub

'****************************************************
'��������WriteSuccessMsg
'��  �ã���ʾ�ɹ���ʾ��Ϣ
'��  ������
'****************************************************
sub WriteSuccessMsg(SuccessMsg)
	dim strSuccess
	strSuccess=strSuccess & "<html><head><title>�ɹ���Ϣ</title><meta http-equiv='Content-Type' content='text/html; charset=gb2312'>" & vbcrlf
	strSuccess=strSuccess & "<link href='css/main.css' rel='stylesheet' type='text/css'></head><body><br><br>" & vbcrlf
	strSuccess=strSuccess & "<table cellpadding=2 cellspacing=1 border=1 width=500 class='border' align=center  bordercolor=#A4CEE4 bordercolordark=#FFFFFF>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center' class='xxxxxt'><td height='22' bgcolor=#588fc7><font color=#FFFFFF><b>��ϲ�㣡</b></font></td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr class='dt'><td height='100' valign='top'><br>" & SuccessMsg &"</td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center' class='dt'><td>&nbsp;</td></tr>" & vbcrlf
	strSuccess=strSuccess & "</table>" & vbcrlf
	strSuccess=strSuccess & "</body></html>" & vbcrlf
	response.write strSuccess
end sub

'****************************************************
'��������SendMail
'��  �ã���Jmail��������ʼ�
'��  ����MailtoAddress  ----�����˵�ַ
'        MailtoName    -----����������
'        Subject       -----����
'        MailBody      -----�ż�����
'        FromName      -----����������
'        MailFrom      -----�����˵�ַ
'        Priority      -----�ż����ȼ�
'****************************************************
function SendMail(MailtoAddress,MailtoName,Subject,MailBody,FromName,MailFrom,Priority)
	on error resume next
	Dim JMail
	Set JMail=Server.CreateObject("JMail.Message")
	if err then
		SendMail= "<br><li>û�а�װJMail���</li>"
		err.clear
		exit function
	end if
	JMail.Charset="gb2312"          '�ʼ�����
	JMail.silent=true
	JMail.ContentType = "text/html"     '�ʼ����ĸ�ʽ
	'JMail.ServerAddress=MailServer     '���������ʼ���SMTP������
   	'�����������ҪSMTP�����֤����ָ�����²���
	JMail.MailServerUserName = MailServerUserName    '��¼�û���
   	JMail.MailServerPassWord = MailServerPassword        '��¼����
  	JMail.MailDomain = MailDomain       '����������á�name@domain.com���������û�����¼ʱ����ָ��domain.com
	JMail.AddRecipient MailtoAddress,MailtoName     '������
	JMail.Subject=Subject         '����
	JMail.HMTLBody=MailBody       '�ʼ����ģ�HTML��ʽ��
	JMail.Body=MailBody          '�ʼ����ģ����ı���ʽ��
	JMail.FromName=FromName         '����������
	JMail.From = MailFrom         '������Email
	JMail.Priority=Priority              '�ʼ��ȼ���1Ϊ�Ӽ���3Ϊ��ͨ��5Ϊ�ͼ�
	JMail.Send(MailServer)
	SendMail =JMail.ErrorMessage
	JMail.Close
	Set JMail=nothing
end function



%>
