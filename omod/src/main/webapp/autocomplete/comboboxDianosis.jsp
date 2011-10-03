<%@ include file="/WEB-INF/template/include.jsp" %>
<select size="15" id="availableDiagnosisList" name="availableDiagnosisList" multiple="multiple" style="min-width:25em;height:20em" ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList')">
    <c:if test="${not empty  diagnosis}">
		<c:forEach items="${diagnosis}" var="dia">
           <option value="${dia.id}" >${dia.name}</option>
       </c:forEach>
	</c:if>    
</select>