
////////////////// show history ////////////////////
function getCookieVal (offset)
{
  var endstr = document.cookie.indexOf (";", offset); 
  if (endstr == -1) endstr = document.cookie.length; 

  return unescape(document.cookie.substring(offset, endstr)); 
} 

function getCookie (name)
{
  var arg = name + "="; 
  var alen = arg.length; 
  var clen = document.cookie.length; 
  var i = 0;
  
  while (i < clen) { 
    var j = i + alen; 
    if (document.cookie.substring(i, j) == arg) return getCookieVal (j); 
      i = document.cookie.indexOf(" ", i) + 1; 
      if (i == 0) break; 
  } 
  return null; 
} 

function setCookie2 (name, value)
{
  var exp = new Date(); 
  exp.setTime (exp.getTime()+3600000000); 
  document.cookie = name + "=" + value + "; expires=" + exp.toGMTString() + "; path=/"; 
}

function his_clear()
{
  document.getElementById("div_his").style.visibility="hidden";
  document.getElementById("div_his").innerHTML='';
  //setCookie2("history_info","");
  setCookie2("history_show", "0");
}

function his_show()
{
  setCookie2("history_show", "1");
  history_show();
}

function his_hideshow()
{
  var history_show=getCookie("history_show");
  if(history_show =="0")
  {
    his_show();
  }
  else
  {
    his_clear();
  }
}

  function move22()
  {
    if(window.document.getElementById("div_his") !=null)
      window.document.getElementById("div_his").style.top=window.document.body.scrollTop+100;
  }

function history_show()
{
  var f_history_show=getCookie("history_show");
  if(f_history_show =="0")
  {
    return 0;
  }

  var history_info=getCookie("history_info");
  var content="";

  if(history_info!=null)
  {
    if(window.document.getElementById("div_his") ==null)
    {
      document.writeln('<div id="div_his" style="position:absolute;right:15px;top:100px;width:125px;height:230px; z-index:1;white-space:nowrap;text-align:left;font-size:12px;BORDER-TOP:#cccccc 1px solid">');
      document.writeln('</div>');
    }
    else
      document.getElementById("div_his").style.visibility="visible";
    
    history_arg=history_info.split("__pudn.com__");
    var i;
    for(i=0;i<20;i++)
    {
      if(history_arg[i]!=null && history_arg[i].length >0)
      {
        var wlink=history_arg[i].split("+!");
        content+=("<a href='"+wlink[1]+"'>"+wlink[0]+"</a><br>");
      }
      else break;
    }
    content +='<div style="text-align:right"><a href="javascript:his_clear();">关闭</a>&nbsp;</div>';
    document.getElementById("div_his").innerHTML=content;
  }
  
  return 0;
}

function getLenB(strSrc) {

    return strSrc.replace(/[^\x00-\xff]/g, 'xx').length;

}

   document.writeln('<div id="div_his" style="position:absolute;right:15px;top:100px;width:125px;height:230px; z-index:1;white-space:nowrap;text-align:left;font-size:12px;BORDER-TOP:#cccccc 1px solid;visibility:hidden">');
   document.writeln('</div>');

address=location.pathname;

if(address.indexOf("/detail", 1) >0)
{
  str =GetSSValue("login");
  if(str =="")
  {
    if(document.getElementById('clogin') !=null)
     document.getElementById('clogin').innerHTML='  [<a href=/reg.asp target=_blank>上传源码成为会员下载此文件</a>] [<a href=/vip.asp target=_blank>成为VIP会员下载此文件</a>]';
  }
  else
  {
    if(document.getElementById('tagLogin') !=null)
      document.getElementById('tagLogin').innerHTML=str;
  }
  
  var fromurl="";
  try {fromurl=top.document.referrer;} catch(err) {fromurl="";} finally {fromurl=(fromurl=="")?document.referrer:fromurl;}
  fromurl=escape(fromurl);
  SetFrom(fromurl);

  FriendlyDisplayForSearch();

  linkname=document.title;
  var lenb=getLenB(linkname);
  var ipos =0;
  var len =0;
  while(ipos <lenb)
  {
    len++;
    str=linkname.substring(0, len);
    ipos=getLenB(str)
    if(ipos > 20)
    {
      linkname =linkname.substring(0, len-1);
      break;
    }
    else if(ipos==20)
    {
      linkname =str;
      break;
    }
  }
  address +='__pudn.com__';  // utf-8 if firefox
  wlink=linkname + "+!" + address;
  old_info=getCookie("history_info");
  var new_info =old_info;
  ////////////////////////
  if(old_info!=null)
  {
  new_info ='';
  var old_link=old_info.split("__pudn.com__");

  for(var j=0;j<20;j++)
  {
    if(old_link[j]==null || old_link[j].length ==0)
    {
      new_info =new_info+wlink;
      break;
    }
    if(old_link[j].indexOf(linkname)!=-1)
    {
      new_info =old_info;
      break;
    }
    new_info =new_info + old_link[j] + "__pudn.com__"
  }
  if(j ==20)
  {
    new_info =old_link[19] + "__pudn.com__";
    for(j =18; j>0; j--)
      new_info =old_link[j] + "__pudn.com__" + new_info;
    new_info =new_info + wlink;
  }
  }
  else
    new_info=wlink;

  setCookie2("history_info",escape(new_info));
}

  history_show();

  window.onscroll=move22;

//////////////////////////////////////////////////////////////////////////////// 
