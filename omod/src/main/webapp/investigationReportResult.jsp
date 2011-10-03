<%@ include file="/WEB-INF/template/include.jsp" %>
<style>
.rsTable{ margin:5px 5px;text-align:center; border-style:1px  solid black; border-collapse: collapse;}
.rsCell { padding:3px 3px;}
</style>
<c:choose>
	<c:when test="${not empty nodes}">
		<c:forEach items="${nodes }" var="node">
			<table class="rsTable" cellspacing="3" border="1"  cellpadding="3">
				<tr>
					<td><span style="display:block"><b>${node.name }</b></span>
				</tr>
				<tr>
					<td>
						<c:forEach items="${node.children }" var="child">
							<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
								<tr>
									<td><span style="display:block"><b>${child.name }</b></span></td>
								</tr>
								<tr>
									<td>
										<table class="rsTable" cellspacing="3" cellpadding="3" border="1" >
											<c:forEach items="${child.results }" var="result">
												<tr>
													<td>${result.date }  |  ${result.result }</td>
												</tr>
											</c:forEach>
										</table>
									</td>
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
	<c:otherwise>
	No result.
	</c:otherwise>
</c:choose>