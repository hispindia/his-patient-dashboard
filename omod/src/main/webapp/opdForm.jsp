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
<%@ include file="/WEB-INF/template/include.jsp"%>

<script type="text/javascript">
    // get context path in order to build controller url
    function getContextPath() {
        pn = location.pathname;
        len = pn.indexOf("/", 1);
        cp = pn.substring(0, len);
        return cp;
    }

    function getForm(formName) {
        jQuery.ajax({
            type: "GET",
            url: getContextPath() + "/module/patientdashboard/" + formName + "?patientId=${patientId}",
            success: function (data) {
                jQuery("#formsSection").html(data)
            }
        })
    }

    jQuery(".opdFormNav li a").click(function () {
        jQuery(".opdFormNav li a").removeClass("active");
        jQuery(this).addClass("active");
    });

    jQuery(document).ready(function () {
        getForm('hepatitisBForm.htm')
    })

</script>
<style>
    .opdFormNav {
        list-style-type: none;
        margin: 0;
        padding: 0;
        overflow: hidden;
        background-color: #1aad9b;
        border-radius: 5px;
    }

    .opdFormNav li {
        float: left;
    }

    .opdFormNav li a {
        display: block;
        color: white !important;
        text-align: center;
        font-weight: bold;
        padding: 10px 12px;
        text-decoration: none;
    }

    .opdFormNav li a:hover {
        background-color: #0e8072;
    }

    a.active {
        background-color: #0e8072;
    }
</style>

<ul class="opdFormNav">
    <li><a href="#" class="active" onclick="getForm('hepatitisBForm.htm')">HAPATITIS B</a></li>
    <li><a href="#" onclick="getForm('medicalCertificate.htm')">MEDICAL FITNESS</a></li>
    <li><a href="#" onclick="getForm('medicalSickness.htm')">MEDICAL SICKNESS</a></li>
    <li><a href="#" onclick="getForm('deathCertificate.htm')">DEATH CERTIFICATE</a></li>
    <li><a href="#" onclick="getForm('referralLetter.htm')">REFFERAL LETTER</a></li>
    <li><a href="#">DIALYSIS</a></li>
    <li><a href="#">DIALYSIS</a></li>
    <li><a href="#">DIALYSIS</a></li>

</ul>
<div id="formsSection" style="margin-top: 10px"></div>