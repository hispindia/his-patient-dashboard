<%@ include file="/WEB-INF/template/include.jsp" %>
<select size="15" id="availableProcedureList" name="availableProcedureList" multiple="multiple" style="min-width:25em;height:20em" ondblclick="moveSelectedById( 'availableProcedureList', 'selectedProcedureList')">
    <c:if test="${not empty  procedures}">
		<c:forEach items="${procedures}" var="dia">
           <option value="${dia.id}" >${dia.name}</option>
       </c:forEach>
	</c:if>    
</select>