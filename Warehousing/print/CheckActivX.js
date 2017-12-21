function CheckLodop() {
    var oldVersion = LODOP.Version;
    var ieplatform = window.navigator.platform
    //document.write(ieplatform + navigator.appName);
    
       newVerion="4.4.3.2";
       if (oldVersion == null) {
       var print_text="";
       if (ieplatform == "Win32") {
           print_text = "<a href='/print/ocx/install_lodop32.exe'>执行安装(32位)</a>";
       }
       else {
           print_text = "<a href='/print/ocx/install_lodop64.exe'>执行安装(64位)</a>";
       }
       document.write("<h3><font color='#FF00FF'>打印控件未安装!点击这里/" + print_text + "/安装后请刷新页面。</font></h3>");

       //<a href='/print/ocx/install_lodop.exe'>执行安装(还不行试试这个)</a>,

       if (navigator.appName=='Netscape')
	    document.write("<h3><font color='#FF00FF'>（当前使用非IE内核浏览器，可能不直接支持，请更换IE再试）</font></h3>");
	//document.write("<h3><font color='#FF00FF'>（Firefox浏览器用户需先点击这里<a href='npActiveXFirefox4x.xpi'>安装运行环境</a>）</font></h3>");
   } else if (oldVersion<newVerion)
    document.write("<h3><font color='#FF00FF'>打印控件需要升级!点击这里<a href='/print/ocx/install_lodop.exe'>执行升级</a>,升级后请重新进入。</font></h3>");
	LODOP.SET_LICENSES("郑州飞度电子科技有限公司","864576063857475919278901905623","","");
}

