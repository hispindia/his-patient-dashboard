<%--
 *  Copyright 2013 Society for Health Information Systems Programmes, India (HISP India)
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
 *  author:ghanshyam
 *  date: 18-april-2013
 *  issue: #1391 India module
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>

<table width="100%">
	<tr valign="top">
		<td>
			<span class="boxHeader">Issue drugs detail</span>
			<div class="box">
				<table width="100%" class="rsTable">
					<thead>
						<tr>
							<th>#</th>
							<th>Drug</th>
							<th>Issue date</th>
							<th>Quantity</th>
						</tr>
					</thead>
					<tbody id="issueDrugDetailTableBody"></tbody>
				</table>
			</div>
		</td>
		<td>
			<select name="issueDrugDates" id="issueDrugDates" onchange="updateTable()">
				<option disabled selected>Select date</option>
			</select>
		</td>
	</tr>
</table>

<script type="text/javascript">

	var identifier = `${patientIdentifier}`
	var issueDrugDates = JSON.parse(`${issueDrugDatesJson}`)
	var patientDrugDetails = JSON.parse(`${patientDrugDetailsJson}`)

	console.log(identifier);
	console.log(issueDrugDates);
	console.log(patientDrugDetails);

	// get context path in order to build controller url
	function getContextPath() {
		pn = location.pathname;
		len = pn.indexOf("/", 1);
		cp = pn.substring(0, len);
		return cp;
	}

	if (issueDrugDates.length > 0) {
		var options = "<option value='all'>All</option>";
		issueDrugDates.forEach((date) => {
			options += "<option value='" + date + "'>" + date + "</option>";
		});
		document.getElementById("issueDrugDates").innerHTML += options;
		creatTable();
	} else {
		document.getElementById("issueDrugDetailTableBody").innerHTML = "<b>No pharmacy record found</b>"
	}

	function creatTable() {
		var rows = "";
		patientDrugDetails.forEach((element, index) => {
			let date = new Date(element.issue_date)
			rows += "<tr class=" + (index % 2 == 0 ? 'evenRow' : 'oddRow') + ">";
			rows += "<td>" + (index + 1) + "</td>";
			rows += "<td>" + element.drug + "</td>";
			rows += "<td>" + date.toDateString() + "</td>";
			rows += "<td>" + element.quantity + "</td>";
			rows += "</tr>";
		});
		document.getElementById("issueDrugDetailTableBody").innerHTML = rows;
	}

	function updateTable() {
		var date = jQuery("#issueDrugDates").val();
		jQuery.get(getContextPath() + '/api/patientdrugdetails.json?identifier=' + identifier + '&date=' + date, (data) => {
			patientDrugDetails = JSON.parse(data)
			creatTable()
		})
	}
</script>