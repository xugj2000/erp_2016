function CheckLodop() {
    var oldVersion = LODOP.Version;
    var ieplatform = window.navigator.platform
    //document.write(ieplatform + navigator.appName);
    
       newVerion="4.4.3.2";
       if (oldVersion == null) {
       var print_text="";
       if (ieplatform == "Win32") {
           print_text = "<a href='/print/ocx/install_lodop32.exe'>ִ�а�װ(32λ)</a>";
       }
       else {
           print_text = "<a href='/print/ocx/install_lodop64.exe'>ִ�а�װ(64λ)</a>";
       }
       document.write("<h3><font color='#FF00FF'>��ӡ�ؼ�δ��װ!�������/" + print_text + "/��װ����ˢ��ҳ�档</font></h3>");

       //<a href='/print/ocx/install_lodop.exe'>ִ�а�װ(�������������)</a>,

       if (navigator.appName=='Netscape')
	    document.write("<h3><font color='#FF00FF'>����ǰʹ�÷�IE�ں�����������ܲ�ֱ��֧�֣������IE���ԣ�</font></h3>");
	//document.write("<h3><font color='#FF00FF'>��Firefox������û����ȵ������<a href='npActiveXFirefox4x.xpi'>��װ���л���</a>��</font></h3>");
   } else if (oldVersion<newVerion)
    document.write("<h3><font color='#FF00FF'>��ӡ�ؼ���Ҫ����!�������<a href='/print/ocx/install_lodop.exe'>ִ������</a>,�����������½��롣</font></h3>");
	LODOP.SET_LICENSES("֣�ݷɶȵ��ӿƼ����޹�˾","864576063857475919278901905623","","");
}

