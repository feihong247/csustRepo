<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<title>经管资源库系统</title>

<%@include file="/admin/head.jsp" %>


<script type="text/javascript">
function getTableForm() {
	return document.getElementById('tableForm');
}


function optAdd(){
	var f = getTableForm();
	f.action="admin_add.do";
	f.method="get";
	f.submit();
}
function optDelete() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	if(!confirm("您确定删除吗？")) {
		return;
	}
	var f = getTableForm();
	f.action="admin_delete.do";
	f.submit();
}
function optLock() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	var f = getTableForm();
	f.action="admin_lock.do";
	f.submit();
}
function optUnlock() {
	if(Pn.checkedCount('ids')<=0) {
		alert("请选择您要操作的数据");
		return;
	}
	var f = getTableForm();
	f.action="admin_unlock.do";
	f.submit();
}
function chgStatus() {
	var f = getTableForm();
	f.submit();
}

function _gotoPage(pageNo) {
	try{
		var tableForm = getTableForm();
		$("input[name=pageNo]").val(pageNo);
		tableForm.action="admin_list.do";
		tableForm.onsubmit=null;
		tableForm.submit();
	} catch(e) {
		alert('_gotoPage(pageNo)方法出错');
	}
	
}

$(function(){

	
	$("select[name='school'] option").eq(0).attr("selected","selected");
	$("select[name='school'] option").each(function(){
		if(this.value=="<s:property value='#params.school[0]' />"){
			$("select[name='school'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
	
	$("select[name='roleid'] option").eq(0).attr("selected","selected");
	$("select[name='roleid'] option").each(function(){
		if(this.value=="<s:property value='#params.roleid[0]' />"){
			$("select[name='roleid'] option").eq(0).removeAttr("selected");
			this.selected=true;
		}
	});
})
</script>
</head>
<body>
<div class="box-positon">
	<div class="rpos">当前位置: 用户管理 - 后台用户 - 列表</div>
	<div class="clear"></div>
</div>
<div class="body-box">
<form id="tableForm" action="admin_list.do" method="post" style="padding-top:5px;">
<input type="hidden" name="pageNo" value=""/>
<div>
用户名: <input type="text" name="username" value="<s:property value="#params.username[0]" />" style="width:100px">

学院: 
<select name="school" style="width:150px;">
       <option value="">全部</option>
       <option value="经济与管理学院">经济与管理学院</option>
       <option value="交通运输工程学院">交通运输工程学院</option>
       <option value="土木与建筑学院">土木与建筑学院</option>
       <option value="汽车与机械工程学院">汽车与机械工程学院</option>
       <option value="电气与信息工程学院" >电气与信息工程学院</option>
       <option value="计算机与通信工程学院">计算机与通信工程学院</option>
       <option value="能源与动力工程学院">能源与动力工程学院</option>
       <option value="马克思主义学院">马克思主义学院</option>
       <option value="文法学院">文法学院</option>
       <option value="数学与计算科学学院">数学与计算科学学院</option>
       <option value="设计艺术学院">设计艺术学院</option>
       <option value="物理与电子科学学院">物理与电子科学学院</option>
       <option value="化学与生物工程学院">化学与生物工程学院</option>
       <option value="水利工程学院">水利工程学院</option>
       <option value="外国语学院">外国语学院</option>
       <option value="体育教学部">体育教学部</option>
       <option value="城南学院">城南学院</option>
       <option value=" 继续教育学院">继续教育学院</option>
</select>
专业: <input type="text" name="major" value="<s:property value="#params.major[0]" />" style="width:70px">
是否锁定:<select name="islock">
<option value="-1" <s:property value="#params.size()==0?'selected=selected':''" /> <s:property value="params.islock[0]==-1?'selected=selected':''" /> >全部</option>
<option value="0" <s:property value="#params.islock[0]==0?'selected=selected':''" />>未锁定</option>
<option value="1" <s:property value="#params.islock[0]==1?'selected=selected':''" />>已锁定</option></select>

角色:<select name="roleid">
	<option value="-1">全部</option>
<s:iterator value="#roles">
	<option value="<s:property value='id' />"><s:property value='name' /></option>
</s:iterator>
</select>

<select name="queryOrderBy">
<option value="desc" <s:property value="#params.size()==0?'selected=selected':''" /> <s:property value="#params.queryOrderBy[0]=='desc'?'selected=selected':''" />>ID降序</option>
<option value="asc" <s:property value="#params.queryOrderBy[0]=='asc'?'selected=selected':''" />>ID升序</option></select>
<input type="hidden" name="id" value="">
<input class="query" type="submit" value="查询">
</div>
<table class="pn-ltable" style="" width="100%" cellspacing="1" cellpadding="0" border="0">
<thead class="pn-lthead"><tr>
	<th width="20"><input type='checkbox' onclick='Pn.checkbox("ids",this.checked)'/></th>
	<th>ID</th>
	<th>用户名称</th>
	<th>真实姓名</th>
	<th>角色</th>
	<th>状态</th>
	<th>添加时间</th>
	<th>上次登录IP</th>
	<th>上次登录时间</th>
	<th>学院</th>
	<th>专业</th>
	<th>手机号码</th>
	<th>操作选项</th></tr></thead>
<tbody  class="pn-ltbody">
<s:iterator value="#page.rows">
<tr onmouseover="this.bgColor='#eeeeee'" onmouseout="this.bgColor='#ffffff'">
	<td><input type='checkbox' name='ids' value='<s:property value="id" />'/></td>
	<td><s:property value="id" /></td>
	<td><s:property value="username" /></td>
	<td><s:property value="realname" /></td>
	<td><s:property value="repRole.name" /></td>
	<td align="center"><s:property value="islock==0?'正常':'<font color=red>锁定</font>'" escapeHtml="false" /></td>
	<td><s:if test="addtime!=null"><s:date name="addtime" format="yyyy-MM-dd HH:mm:ss" /></s:if></td>
	<td><s:property value="lastloginip" /></td>
	<td><s:if test="lastlogintime!=null"><s:date name="lastlogintime" format="yyyy-MM-dd HH:mm:ss" /></s:if></td>
	<td><s:property value="school" /></td>
	<td><s:property value="major" /></td>
	<td><s:property value="phone" /></td>
	<td align="center">		<a href="admin_edit.do?id=<s:property value="id" />" class="pn-opt">修改</a> | <a href="admin_delete.do?id=<s:property value="id" />" class="pn-opt" onclick="if(!confirm('您确定删除吗？')) {return false;}">删除</a></td>
</tr>
</s:iterator>

</tbody>
</table>

<table width="100%" border="0" cellpadding="0" cellspacing="0"><tbody><tr><td align="center" class="pn-sp">
	共 <s:property value="#page.records" /> 条&nbsp;
	每页<input type="text" name="pageSize" value="<s:property value="#page.pageSize" />" style="width:30px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$(this).blur();return false;}">条&nbsp;
	<input class="first-page" type="button" value="首 页" onclick="_gotoPage('1');">
	<input class="pre-page" type="button" value="上一页" onclick="_gotoPage('<s:property value="#page.page-1<1?#page.page:#page.page-1" />');">
	<input class="next-page" type="button" value="下一页" onclick="_gotoPage('<s:property value="#page.page+1>#page.total?#page.page:#page.page+1" />');">
	<input class="last-page" type="button" value="尾 页" onclick="_gotoPage(<s:property value="#page.total" />);">&nbsp;
	当前 <s:property value="#page.page" />/<s:property value="#page.total" /> 页 &nbsp;转到第<input type="text" id="_goPs" style="width:50px" onfocus="this.select();" onkeypress="if(event.keyCode==13){$('#_goPage').click();return false;}">页
	<input class="go" id="_goPage" type="button" value="转" onclick="_gotoPage($('#_goPs').val());">
</td></tr></tbody></table>
<div style="margin-top:15px;">
<input type="button" value="新增" onclick="optAdd();" class="add"/>
&nbsp; <input type="button" value="删除" onclick="optDelete();" class="del-button"/>
&nbsp; <input type="button" value="锁定" onclick="optLock();" class="lock"/>
&nbsp; <input type="button" value="解锁" onclick="optUnlock();" class="unlock"/>
</div>
</form>
</div>
</body>
</html>