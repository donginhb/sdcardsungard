<%@ include file="/commons/init.jsp"%>
<%@ taglib uri="/WEB-INF/extremecomponents.tld" prefix="ec"%>
<%@ page import="com.kingstargroup.advquery.common.GetProperty"%>
<head>
<link href="<%= ContextUtil.getCtxPath(request)%>/commons/styles/style.css" rel="stylesheet" type="text/css" />
<link href="<%= ContextUtil.getCtxPath(request)%>/commons/styles/ele.css" rel="stylesheet" type="text/css" />
<link href="<%= ContextUtil.getCtxPath(request)%>/commons/styles/frame.css" rel="stylesheet" type="text/css" />
<link href="<%= ContextUtil.getCtxPath(request)%>/commons/styles/extremecomponents.css" rel="stylesheet"
	type="text/css" />
</head>
<%String statTypeShow = request.getAttribute("stattypeshow").toString();%>
<%String devName=request.getAttribute("devname").toString();%>
<%List result = (List) request.getAttribute("result");%>
<%String dateRange = request.getAttribute("daterange").toString();%>
<%String picType = request.getAttribute("pictype").toString();%>
<%String yLabel = request.getAttribute("ylabel").toString();%>
<table border="0"  cellpadding="0"  cellspacing="0"  width="100%">
<tr><td>
<ec:table items="result" 
		title='<%= devName+GetProperty.getProperties("consumebypos.title",getServletContext())+dateRange%>' 
		filterable="false"
		imagePath="../../commons/ximages/*.gif" 
		rowsDisplayed="10">

    <ec:export 
       view="xls" 
       fileName="output.xls" />

	<ec:row highlightRow="true">
		<ec:column property="balance_date" headerStyle="text-align:center"
			style="text-align:center"
			filterable="false" 
			sortable="false"
			title="<%= statTypeShow%>" />
		<ec:column property="tradefee"  headerStyle="text-align:center"
			cell="currency"
			format="###,###,###,##0.00"
			style="text-align:right"
			filterable="false" 
			sortable="false" 
			title='<%= GetProperty.getProperties("consumebypos.tradefee",getServletContext())%>' />	
	</ec:row>

</ec:table>
</td></tr></table>
<table>
<cewolf:chart 
	id="verticalBar" 
	title='<%=devName+GetProperty.getProperties("consumebypos.title",getServletContext())%>'
	type="<%=picType%>"
	yaxislabel="<%=yLabel%>"
	> 
	<cewolf:colorpaint color='<%= GetProperty.getProperties("chart.bgcolor",getServletContext())%>'/>
	<cewolf:data>
		<cewolf:producer id="ConsumeStatByPosChart" />
	</cewolf:data>
    <cewolf:chartpostprocessor id="dataColor">
        <cewolf:param name="0" value='<%= GetProperty.getProperties("chart.customer1",getServletContext()) %>'/>
        <cewolf:param name="1" value='<%= GetProperty.getProperties("chart.customer2",getServletContext()) %>'/>
        <cewolf:param name="2" value='<%= GetProperty.getProperties("chart.customer3",getServletContext()) %>'/>
        <cewolf:param name="3" value='<%= GetProperty.getProperties("chart.customer4",getServletContext()) %>'/>
        <cewolf:param name="4" value='<%= GetProperty.getProperties("chart.customer5",getServletContext()) %>'/>
        <cewolf:param name="5" value='<%= GetProperty.getProperties("chart.customer6",getServletContext()) %>'/>
    </cewolf:chartpostprocessor>

</cewolf:chart>

<cewolf:img 
	chartid="verticalBar" 
	renderer="/cewolf" 
	width='<%= Integer.parseInt(GetProperty.getProperties("chart.barwidth",getServletContext()))%>'
	height='<%= Integer.parseInt(GetProperty.getProperties("chart.barheight",getServletContext()))%>'/>
</table>