function CheckLodop(){
   var oldVersion=LODOP.Version;
       newVerion="4.4.3.2";	
   if (oldVersion==null){
	document.write("<h3><font color='#FF00FF'>��ӡ�ؼ�δ��װ!�������<a href='../ocx/install_lodop.exe'>ִ�а�װ</a>,��װ����ˢ��ҳ�档</font></h3>");
	if (navigator.appName=="Netscape")
	document.write("<h3><font color='#FF00FF'>��Firefox������û����ȵ������<a href='npActiveXFirefox4x.xpi'>��װ���л���</a>��</font></h3>");
   } else if (oldVersion<newVerion)
	document.write("<h3><font color='#FF00FF'>��ӡ�ؼ���Ҫ����!�������<a href='install_lodop.exe'>ִ������</a>,�����������½��롣</font></h3>");
	LODOP.SET_LICENSES("֣�ݷɶȵ��ӿƼ����޹�˾","864576063857475919278901905623","","");
}

