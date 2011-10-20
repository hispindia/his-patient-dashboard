 <%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Patient-dashboard module.
 *
 *  Patient-dashboard module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Patient-dashboard module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Patient-dashboard module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%> 
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


