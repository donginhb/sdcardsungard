<%@ page pageEncoding="GBK" %>
<HTML>
<HEAD>
<TITLE> XMLSelTree(V1.0) ==> 选择部门 </TITLE>
<META NAME="Author" CONTENT="moonpiazza">
<META NAME="Keywords" CONTENT="xml,xsl,moonpiazza,XMLSelTree,选择部门">
<META NAME="Description" CONTENT="xml,xsl,moonpiazza,XMLSelTree,选择部门">
<META http-equiv=Content-Type content="text/html; charset=gbk">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link rel="stylesheet" type="text/css" href="treeRes/XMLSelTree.css">
<style type="text/css">
body
{
	SCROLLBAR-FACE-COLOR: #a0a070;
	SCROLLBAR-HIGHLIGHT-COLOR: #FFFFFF;
	SCROLLBAR-SHADOW-COLOR: #FFFFFF;
	SCROLLBAR-3DLIGHT-COLOR: #FFFFFF;
	SCROLLBAR-ARROW-COLOR: #FFFFFF;
	SCROLLBAR-TRACK-COLOR: #FFFFFF;
	SCROLLBAR-DARKSHADOW-COLOR: #a0a070;
	FONT-SIZE: 9pt; FONT-FAMILY: 宋体; COLOR: #000000;
}
</style>
</HEAD>
<BODY  topmargin="0" leftmargin="5" marginheight="0" marginwidth="0" text="#000000" >
<DIV id="SrcDiv"></DIV>
</BODY>
</HTML>

<SCRIPT LANGUAGE=javascript src="treeRes/XMLSelTree.js"></SCRIPT>
<SCRIPT LANGUAGE=javascript>
<!--
//var m_sXMLFile	= document.getElementById("xml").value;
//var m_sXMLFile	= "treeRes/TreeNode.xml";
var accountId = '<%=request.getAttribute("accountId")%>';
var m_sXMLFile	= "getDepartmentXMLTree.do?method=getDepartmentXMLTree&accountId="+accountId;
var m_sXSLPath	= "treeRes/";
var m_oSrcDiv	= SrcDiv;							// HTML标记(菜单容器，菜单在此容器显示)


function window.onload()
{
	InitTree(m_sXMLFile, m_sXSLPath, m_oSrcDiv);
}


/************************************************
** GoLink(p_sHref, p_sTarget)
************************************************/
function GoLink(p_sHref, p_sTarget)
{
	var sHref	= p_sHref;
	var sTarget	= p_sTarget;
	window.open(sHref, sTarget);
}

//-->
</SCRIPT>

