<%@ include file="/WEB-INF/template/include.jsp" %>
<c:choose>
<c:when test="${ not empty nodes }">
<form id="investigationForm" action="investigationReport.htm" method="post">
<input type="hidden" name="patientId" value="${patientId }"/>
<table width="100%" >
	<tr valign="top">
		<td width="60%" id="resultContainer">
			
			
		</td>
		<td width="30%">
			<div style="overflow: hidden;border: 1px solid #8FABC7; " >
				<ul class="tree">
					<c:forEach items="${nodes}" var="node">
						<li><input type="checkbox"/><label>${node.name }</label>
							<c:if test="${not empty node.children }">
									<ul class="tree">
									 <c:forEach items="${node.children}" var="child">
											<li>
												<c:choose>
													<c:when test="${not empty child.children }">
														<input type="checkbox"  value="${child.id}"/><label>${child.name }</label>
														<ul class="tree">
														 <c:forEach items="${child.children}" var="leaf">
															<li><input type="checkbox" name="tests"  value="${leaf.id}"/><label>${leaf.name }</label></li>
														 </c:forEach>
														 </ul>
													</c:when>
													<c:otherwise>
														<input type="checkbox"  name="tests" value="${child.id}"/><label>${child.name }</label>
													</c:otherwise>
												</c:choose>
											</li>
									 </c:forEach>
									 </ul>
							</c:if>
						 </li>
					</c:forEach>
				</ul>
			</div>
			<div>
				<select name="date">
					<option value="all">--All--</option>
					<option value="recent">--Recent--</option>
					<c:forEach items="${dates }" var="date">
						<option value="${date}">${date }</option>
					</c:forEach>
				</select>
				<input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="View"/>
			</div>
			
		</td>
	</tr>
</table>

</form>
</c:when>
<c:otherwise>No investigation found</c:otherwise>
</c:choose>


