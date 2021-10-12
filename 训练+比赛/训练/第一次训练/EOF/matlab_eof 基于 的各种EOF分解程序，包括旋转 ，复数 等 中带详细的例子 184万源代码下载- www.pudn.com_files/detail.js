// js for detail.html

// 如果cookie("lang") 为空并且浏览器语言不匹配, 则弹出让用户选择en,cn的div
var lg=get_user_lang();
var sub_lg=lg.substring(0, 3);

if(sub_lg != "zh-")
{
  document.writeln('<div id=div_lang><div id=set_lang>Please select your language:&nbsp;&nbsp;&nbsp;<a href=# onclick="skip_to_lang(0);return false;">中文</a>&nbsp;&nbsp;<a href=# onclick="skip_to_lang(1);return false;">English</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href=# onclick="close_lang_div();return false;"><img align=middle src="/images/close.jpg" border=0></a></div></div>');
  setTimeout(show_lang_div, 2000);
}

function show_lang_div()
{
  document.getElementById('div_lang').style.display='block';
  setTimeout(close_lang_div, 20000);
}

function get_user_lang()
{
  var Browser_Agent=navigator.userAgent; 

  if(Browser_Agent.indexOf("MSIE")!=-1)    //判断浏览器是否为ie 
    return navigator.browserLanguage; 
  else       //firefox opera safari 
    return navigator.language; 
}

// 检查语言，并跳转到相应的页面
function skip_to_lang(lang)
{
	var url =window.location.href;
	var cn_url, en_url;
	
	cn_url =url;
	en_url =url;
	en_url =en_url.replace("http://www", "http://en");
	
	if(url.indexOf("/detail") >-1)
      en_url =en_url.replace(".html", "_en.html");

	//跳转到对应的lang页面
	if(lang==0)
	  window.location =cn_url;
	else if(lang ==1)
	  window.location =en_url;
}

// 关闭div
function close_lang_div()
{
	document.getElementById('div_lang').style.display='none';
}

function CreateHttpRequest()
{
  if(window.XMLHttpRequest)
    return   new   XMLHttpRequest();   
  try{   
    return   new   ActiveXObject('MSXML2.XMLHTTP.4.0');   
  }catch(e){
  	try{   
      return   new   ActiveXObject('MSXML2.XMLHTTP.3.0');   
  }catch(e){
  	try{   
      return   new   ActiveXObject('MSXML2.XMLHTTP.2.6');   
  }catch(e){
  	try{   
      return   new   ActiveXObject('MSXML2.XMLHTTP');   
  }catch(e){
  	try{   
      return   new   ActiveXObject('Microsoft.XMLHTTP');   
  }catch(e){
  	return   null;
  	}}}}}   
}

function GetSSValue(s)
{
  var url = '/get_ssvalue.asp?s=' + s +'&rnd=' + (new Date()).getTime();

  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
     xmlhttp.open('GET', url, false); 
     xmlhttp.send(null);
     if ( xmlhttp.status == 200 ) 
     { 
         return xmlhttp.responseText;
     } 
     throw '';  
    xmlhttp =null;
  } 
  catch(e) 
  {
    xmlhttp =null;
       return ''; 
  }
  xmlhttp =null;
}

function GetSSValue2(s)
{
  var url = '/get_ssvalue.asp?s=' + s;

  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
     xmlhttp.open('GET', url, false); 
     xmlhttp.send(null);
     if ( xmlhttp.status == 200 ) 
     { 
         return xmlhttp.responseText;
     } 
     throw '';  
    xmlhttp =null;
  } 
  catch(e) 
  {
    xmlhttp =null;
       return ''; 
  }
  xmlhttp =null;
}

function getURL(v_url)
{
  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
     xmlhttp.open('GET', v_url, false); 
     xmlhttp.send(null);
     if ( xmlhttp.status == 200 ) 
     { 
         return xmlhttp.responseText;
     } 
     throw '';  
    xmlhttp =null;
  } 
  catch(e) 
  {
    xmlhttp =null;
       return ''; 
  }
  xmlhttp =null;
}

var content_top, login_info, email, nav;

if(typeof(user_email)=="undefined")
  email ='';
else
  email =user_email;
if(typeof(nav_info)=="undefined")
  nav ='';
else
  nav =nav_info;

content_top ='<div class="header">\n';
content_top +='  <div id="logo"><a href="http://www.pudn.com"><img src="/images/pudn2.gif" alt="程序员联合开发网：最大的源码下载网站" border="0" /></a> </div>\n';
content_top +='  <div class="member">\n';
  
if(email ==null || email =='')
{
  email =GetSSValue('user_email');
}
if(email ==null || email =='')
  login_info ='<a href="/login.asp">登录</a>| <a href="/reg.asp" target=_blank>注册会员</a>| <a href=/help.asp target=_blank>帮助</a>';
else
  login_info ='<a href=/i.asp target=_blank>' + email +'</a>| <a href=/logout.asp>退出</a>';

content_top +=login_info;
content_top +='| <a href="mailto:pudn@qq.com">联系站长</a><BR>\n';
content_top +='  [<a href=' + en_url + ' target=_blank>English Version]</a>\n';
content_top +='  </div>\n';
document.write(content_top);
content_top ='  <div class="nav">\n'; 
content_top +='  <ul>\n';
content_top +='  <li><a href="http://www.pudn.com">首页</a></li>\n';
content_top +='  <li><a  href="/download_types.asp" target=_blank>目录</a></li>\n'; 
content_top +='  <li><a  href="/download1.html" target=_blank>下载</a></li>\n';
content_top +='  <li><a  href="/upload_new.asp" target=_blank>上传</a></li>\n';
content_top +='  <li><a  href="/vip.asp" target=_blank>VIP会员</a></li>\n';
content_top +='  <li><a  href="/search_db.asp">搜索</a></li>\n';
content_top +='  <li><a  href="http://read.pudn.com" target=_blank>阅读</a></li>\n';
content_top +='  <li><a  href="/comment.asp?type_id=1010" title="有问题，请留言" target=_blank>留言薄</a></li>\n';
content_top +='  </ul>\n';
content_top +='  </div>\n';
document.write(content_top);
content_top ='  <form style="margin:0px" method=get action=/search_db.asp>\n';
content_top +='  <div class="nav1"> \n';
content_top +='  <div class="navpos"><a href=/><font color=#FF0080>P</font><font color=#8000FF>u</font><font color=#FF0080>d</font><font color=#8000FF>n</font>.com</a>' + nav +'</div>\n';
content_top +='  <div class="navsearch"><input type=text name=keyword size=20>&nbsp;<input type=submit value="搜 索">&nbsp;</div>\n';
content_top +='  </div>\n';
content_top +='  </form>\n';
content_top +='</div>\n';

document.write(content_top);

function GetADList(t) 
{
  var url = '/ad_show.asp?t=' + t;

  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
     xmlhttp.open('GET', url, false); 
     xmlhttp.send(null);
     if ( xmlhttp.status == 200 ) 
     { 
         return xmlhttp.responseText;
     } 
     throw '';  
    xmlhttp =null;
  } 
  catch(e) 
  {
  //alert(e);
    xmlhttp =null;
       return ''; 
  }
  xmlhttp =null;
}

function SetFrom(r)
{
  var url = '/set_from.asp?r=' + r;

  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
    xmlhttp.open('GET', url, false); 
    xmlhttp.send(null);
    xmlhttp =null;
  }
  catch(e) 
  {
    xmlhttp =null;
  }
  xmlhttp =null;
  return ''; 
}

function show_ad(name)
{
    document.write(GetSSValue2(name));
  //if(name=="ad_detail_a")
    //document.write(GetSSValue('ad_detail_a'));
  //if(name == "ad_detail_b")
    //document.write(GetSSValue('ad_detail_b'));
}

function FriendlyDisplayForSearch()
{
    var url = new UrlBuilder(document.referrer);
    if ( url.m_Success )
    {
         var host = url.m_Host.toLowerCase();
         var keywords;
         if ( host.indexOf('.google.') != -1 )
         {
             keywords = url.GetValue('q', 'UTF8');
         }
         else if ( host.indexOf('.baidu.') != -1 )
         {
             keywords = url.GetValue('wd', 'GB2312');
         }
         else
             keywords = url.GetValue('keyword', 'GB2312');
         
         if ( keywords )
         {
              var ht = new HighlightText();
              ht.Execute(keywords);
         }
    }   
}
function HighlightText(range)
{
    if ( range )
    {
         this.m_Range = range;
    }
    else
    {
         this.m_Range = document.body.createTextRange();
    }     
    this.m_Keyword = '';
    
    this.toString = function()
    {
         return '[class HightlightText]';
    };       
}
HighlightText.prototype.Execute = function(keyword)
{
     if ( keyword )
     {
          this.m_Keyword = keyword;
     }
     if ( this.m_Range && this.m_Keyword )
     {
         var separater = ' ';
         if ( this.m_Keyword.indexOf(' ') == -1 ) 
         {
              separater = '+';
         }   
         var keywords = this.m_Keyword.split(separater); 
         var bookmark = this.m_Range.getBookmark();             
         for ( var i=0 ; i < keywords.length ; ++i )
         {
             var keyword = keywords[i];
             if ( keyword && keyword.length > 1 )
             { 
                 while(this.m_Range.findText(keywords[i]))
                 {
                      this.m_Range.execCommand('ForeColor', 'false', 'highlighttext');
                      this.m_Range.execCommand('BackColor', 'false', 'highlight'); 
                      this.m_Range.collapse(false);
                 }
                 this.m_Range.moveToBookmark(bookmark);
             }
         }
     }
}

function UrlBuilder(url)
{
    this.m_Href = null;
    this.m_Host = null;
    this.m_Hostname = null; 
    this.m_Port = null;
    this.m_Protocol = null;
    this.m_Path = null;
    this.m_Search = null;
    this.m_Hash = null;
    this.m_Params = null; 
    this.m_Sucess = false; 
    if ( url ) this.Parse(url);
   
    this.toString = function()
    {
         return '[class UrlBuilder]';
    };     
}

UrlBuilder.prototype.Parse = function(url)
{
    var m = url.match(/(\w{3,5}:)\/\/([^\.]+(?:\.[^\.:/]+)+)(?::(\d{1,5}))?\/?/);
    if ( m )
    {
         this.m_Protocol = m[1];
         this.m_Hostname = m[2]; 
         this.m_Port = m[3]; 
         if ( this.m_Port ) 
         {
             this.m_Host = this.m_Hostname + ':' + this.m_Port;
         }
         else
         {  
             this.m_Host = m[2];
         }
         var indexHash = url.indexOf('#');
         if ( indexHash != -1 )
         {
             this.m_Hash = url.substr(indexHash);
         }
         else
         {
             this.m_Hash = '';
         }        
         var indexParams = url.indexOf('?');
         if ( indexParams != -1 )
         {
             if ( indexHash != -1 )
             {
                  this.m_Search = url.substring(indexParams, indexHash);
             }
             else
             { 
                  this.m_Search = url.substr(indexParams);
             }
             this.m_Path = url.substr(indexParams);
         }
         else
         {
             this.m_Search = '';
         }
         this.m_Success = true; 
         this.m_Params = null; 
         this.m_Href = url;
    }
};

UrlBuilder.prototype.GetValue = function(key, encoding)
{
    if ( !this.m_Params )
    {
         if ( this.m_Search )
         {
             this.m_Params = {}; 
             var search = this.m_Search.substring(1);
             var keyValues = search.split('&');
             for ( var i=0 ; i < keyValues.length ; ++i )
             {
                  var keyValue = keyValues[i];
                  var index = keyValue.indexOf('=');
                  if ( index != -1 )
                  {
                       this.m_Params[keyValue.substring(0, index)] = keyValue.substr(index+1);
                  }
                  else
                  {
                       this.m_Params[keyValue] = '';
                  }
              }  
         }
    }
    if (!this.m_Params)
      return '';
      
    encoding = encoding || ''; 
    switch(encoding.toUpperCase())
    {
         case 'UTF8' :
         {
              return decodeURI(this.m_Params[key]);
         }
         case 'UNICODE' :
         {
              return unescape(this.m_Params[key]);
         }
         case 'GB2312' : // need VBScript function Chr()
         default :
         {
              return this.m_Params[key];
         }
    }  
}

function t001(i, s)
{
  var url = '/t001.asp?i=' + i +'&s='+s;

  var xmlhttp = CreateHttpRequest();
  if(xmlhttp ==null)
    return '';

  try 
  {   
     xmlhttp.open('GET', url, false); 
     xmlhttp.send(null);
     if ( xmlhttp.status == 200 ) 
     { 
         return xmlhttp.responseText;
     } 
     throw '';  
    xmlhttp =null;
  } 
  catch(e) 
  {
    xmlhttp =null;
       return ''; 
  }
  xmlhttp =null;
}

function gg_translate(id, intro)
{
  try
  {
    //t001(id, 'del');
    google.language.translate(intro, "zh", "en", function(result)
    {
      if (!result.error)
      {
        t001(id, result.translation);
      }
      else
      {
        document.write('err!!!');
      }
    });
  }
  catch(e)
  {
        t001(id, 'err');
  }
}
