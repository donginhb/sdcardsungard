<%@page pageEncoding="UTF-8" %>
<%@ include file="../tiles/include.jsp" %>
<html>
<head>
    <title>监控系统</title>
    <meta http-equiv="Content-Type" content="text/html;">

    <link href="<c:url value="/pages/style/default/style.css"/>" type="text/css" rel=stylesheet>
    <script type="text/javascript" src="<c:url value="/pages/scripts/prototype.js"/>" ></script>
    <script type="text/javascript">
        function check(){
            var groupName = document.getElementById("monitorHostgroups.groupName").value;
            if(groupName==null || groupName==""){
                return false;
            }
            return true;
        }
        function submitForm(){
            var editForm = document.forms[0];
            var url;
            if(!check()){
                alert('主机组名称必须输入！');
                document.getElementById("monitorHostgroups.groupName").focus();
                return;
            }
            var type = document.getElementById("type").value;
            if(type=="edit"){
                url = "hostgroups.do?method=updateMonitorHostgroups";
            } else if(type=="add"){
                url = "hostgroups.do?method=addMonitorHostgroups";
            }
            new Ajax.Request(url,
              {
                method:'post',
                parameters: Form.serialize(document.forms[0]),
                onSuccess: function(result){
                    alert(result.responseText);
                    if(result.responseText.indexOf("error:")!=0){
                        window.close();
                        window.opener.document.forms[0].submit();
                    } else {
                        document.getElementById("monitorHostgroups.groupName").focus();
                    }
                }
              });
        }
    </script>
</head>
<body>
<html:form action="hostgroups.do?method=addMonitorHostgroups" method="post">
<html:hidden property="monitorHostgroups.hostgroupId" />
<html:hidden property="type" />
    <div style="width:100%;margin:8px 8px 0 10">
        <html:errors  property="addMonitorHostgroups"/>
        <table width=100% border=1 cellpadding=1 cellspacing=0 bordercolor="#FFFFFF">
            <tbody>
            <tr class="toptitle">
                <td colspan="2" style="text-align:left"><p style="font-weight:bold;"><logic:equal name="monitorHostgroupsForm" property="type" value="edit">修改</logic:equal><logic:equal name="monitorHostgroupsForm" property="type" value="add">增加</logic:equal>主机组</p></td>
            </tr>
            <tr>
                <td class="td_title">主机组名称：</td>
                <td class="td_value">
                    <html:text property="monitorHostgroups.groupName" styleClass="input_box" maxlength="100"/>
                    <font color="#ff0000">*</font>
                </td>
            </tr>
            <tr>
                <td colspan="2"  align="center">
                    &nbsp;&nbsp;
                    <input type="button" class="button_nor" onclick="javascript:submitForm();" value=" 保 存 " />
                    <input type="reset" class="button_nor" value=" 重 置 " />
                    <input  type="button" class="button_nor" value=" 关 闭 " onclick="window.close();">
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</html:form>
</body>

</html>
