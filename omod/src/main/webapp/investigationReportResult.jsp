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
<style>
.rsTable{ margin:5px 5px;text-align:center; border-style:1px  solid black; border-collapse: collapse;}
.rsCell { padding:3px 3px;}
</style>
<c:choose>
<%-- ghanshyam 10-july-2013 Bug #1936 [Patient Dashboard] Wrong Result Generated in Laboratory record(note:added nodes1 and nodes2 condition)--%>
	<c:when test="${not empty nodes1 or not empty nodes2}">
		<c:forEach items="${nodes1 }" var="node">
			<table class="rsTable" cellspacing="3" border="1"  cellpadding="3">
				<tr>
					<td bgcolor="#3BB9FF"><span style="display:block"><b>${node.name }</b></span></td>
				</tr>
				<tr>
					<td>
						<c:forEach items="${node.children }" var="child">
							<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
								<tr>
									<td><span style="display:block"><b>${child.name }</b></span></td>
								</tr>
								
								<c:if test="${not empty child.children}"> 
									<td>
										<table class="rsTable"  cellspacing="3" cellpadding="3" border="1" >
											<tr>
												<th></th>
												<c:forEach items="${child.children}" var="leaf">
													<th><span style="display:block"><b>${leaf.name} </b></th>
												</c:forEach>
											</tr>		
												<c:forEach items="${child.dates}" var="date">
													<tr>
														<td>${date}</td>
														<c:forEach items="${child.mapResult[date]}" var="test">
															<td class="rsCell">${test.result}</td>
														</c:forEach>
													</tr>
												</c:forEach>
										</table>
									</td>
								</c:if>
							</table>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:forEach>
		
		
		<c:forEach items="${nodes2 }" var="node">
			<table class="rsTable" cellspacing="3" border="1"  cellpadding="3">
				<tr>
					<td bgcolor="#3BB9FF"><span style="display:block"><b>${node.name }</b></span></td>
				</tr>
				<tr>
					<td>
						<c:forEach items="${node.children }" var="child">
							<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
								<tr>
									<td><span style="display:block"><b>${child.name }</b></span></td>
								</tr>
								
								<c:if test="${not empty child.children}"> 
									<td>
										<table class="rsTable"  cellspacing="3" cellpadding="3" border="1" >
											<tr>
												<th></th>
												<c:forEach items="${child.children}" var="leaf">
													<th><span style="display:block"><b>${leaf.name} </b></th>
												</c:forEach>
											</tr>		
												<c:forEach items="${child.dates}" var="date">
													<tr>
														<td>${date}</td>
														<c:forEach items="${child.mapResult[date]}" var="test">
															<td class="rsCell">${test.result}</td>
														</c:forEach>
													</tr>
												</c:forEach>
										</table>
									</td>
								</c:if>
							</table>
						</c:forEach>
					</td>
				</tr>
			</table>
		</c:forEach>
		
	</c:when>
<%-- ghanshyam 10-july-2013 Bug #1936 [Patient Dashboard] Wrong Result Generated in Laboratory record --%>
	<c:otherwise>
	PLEASE SELECT THE TESTS.
	</c:otherwise>
</c:choose>