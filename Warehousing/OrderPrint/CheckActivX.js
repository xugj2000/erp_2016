function CheckLodop(){
   var oldVersion=LODOP.Version;
       newVerion="3.0.0.0";	
   if (oldVersion==null){
	document.write("<h3><font color='#FF00FF'>��ӡ�ؼ�δ��װ!�������<a href='../OrderPrint/install_lodop.exe'>ִ�а�װ</a>,��װ����ˢ��ҳ�档</font></h3>");
	if (navigator.appName=="Netscape")
	document.write("<h3><font color='#FF00FF'>��Firefox������û����ȵ������<a href='../OrderPrint/npActiveX0712SFx31.xpi'>��װ���л���</a>��</font></h3>");
   } else if (oldVersion<newVerion)
	document.write("<h3><font color='#FF00FF'>��ӡ�ؼ���Ҫ����!�������<a href='../OrderPrint/install_lodop.exe'>ִ������</a>,�����������½��롣</font></h3>");
}

