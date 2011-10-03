<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="Manage IPD" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/headerMinimal.jsp" %>
<%@ include file="includes/js_css.jsp" %>

<input type="hidden" id="pageId" value="dischagePage"/>
<form method="post" id="dischargeForm">
<input type="hidden" id="id" name="admittedId" value="${admitted.id }" />
<div class="box">
<c:if test ="${not empty message }">
<div class="error">
<ul>
    <li>${message}</li>   
</ul>
</div>
</c:if>
<table width="100%">
	<tr>
		<td><spring:message code="ipd.patient.patientName"/>:&nbsp;<b>${admitted.patientName }</b></td>
		<td><spring:message code="ipd.patient.patientId"/>:&nbsp;<b>${admitted.patientIdentifier}</b></td>
		<td><spring:message code="ipd.patient.age"/>:&nbsp;<b><age:getAgeFromBirthDay input="${admitted.birthDate }"></age:getAgeFromBirthDay></b></td>
		<td><spring:message code="ipd.patient.gender"/>:&nbsp;<b>${admitted.gender }</b></td>
	</tr>
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.caste"/>: ${admitted.caste}</td>
		<td colspan="2"><spring:message code="ipd.patient.monthlyIncome"/>: ${admitted.monthlyIncome}</td>
	</tr>
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.fatherName"/>:  ${relationName }</td>
		<td colspan="2"><spring:message code="ipd.patient.basicPay"/>: ${admitted.basicPay }</td>
	</tr>
	<tr>
		<td colspan="2"><spring:message code="ipd.patient.admittedWard"/>: ${admitted.admittedWard}</td>
		<td colspan="2"><spring:message code="ipd.patient.bedNumber"/>: ${admitted.bed }</td>
	</tr>
	<tr>
		<td colspan="4"><spring:message code="ipd.patient.homeAddress"/>: ${address }</td>
	</tr>
</table>

</div>
<br/>
<table class="box">
	<tr>
		<td>Out come<em>*</em></td>
		<td><select  id="outCome" name="outCome" >
			  <option value="">[Please Select]</option>
					<c:forEach items="${listOutCome}" var="outCome" >
						<option value="${outCome.answerConcept.id}">${outCome.answerConcept.name }</option>
					</c:forEach>			  
		</select></td>
	</tr>
</table>

<table  width="98%">


	<tr><td align="right"><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Submit"></td></tr>
</table>

</form>