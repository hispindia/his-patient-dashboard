<style>
    .w3-row {
        margin: 5px 0px 0px 0px;
    }

    .w3-column {
        float: left;
        width: 32%;
        padding: 0 5;
    }

    .w3-column button {
        margin: 38px 0px 0px 5px;
    }

    .w3-button {
        background-color: #1aad9b;
        border: none;
        color: white;
        padding: 12px 32px;
        text-decoration: none;
        cursor: pointer;
    }

    .w3-textarea {
        width: 100%;
        height: 80px;
        padding: 12px 20px;
        box-sizing: border-box;
        border-radius: 4px;
        resize: none;
    }

    .w3-column label {
        display: inline-block;
        width: 180px;
        text-align: left;
        font-weight: bold;
    }

    .w3-modal {
        display: none;
        position: fixed;
        z-index: 10000;
        padding-top: 50px;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgb(0, 0, 0);
        background-color: rgba(0, 0, 0, 0.4);
    }

    .w3-modal-body {
        padding: 2px 16px;
        height: 90%;
        max-height: 90%;
        overflow-x: auto;
    }

    .w3-modal-footer {
        padding: 2px 16px;
        color: white;
    }

    .w3-modal-footer button {
        display: inline-block;
    }

    .w3-modal-content {
        position: relative;
        background-color: #fefefe;
        margin: auto;
        padding: 0;
        border: 1px solid #888;
        width: 90%;
        height: 90%;
        max-height: 90%;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        animation-name: animatetop;
        animation-duration: 0.4s;
        overflow-x: auto;
    }

    .w3-overflow {
        overflow-x: auto;
    }
</style>
<form id="hepatitisBForm">
    <fieldset>
        <legend>General</legend>
        <div class="w3-column">
            <label for="yearsOfDiagnosis">Year of Diagnosis</label>
            <input type="text" name="yearsOfDiagnosis" id="yearsOfDiagnosis" class="rxInput" readonly
                value="${yearsOfDiagnosis}">
        </div>
        <div class="w3-column">
            <label for="complications">Complications</label>
            <input type="text" name="complications" id="complications" class="rxInput" readonly
                value="${complications}">
        </div>
    </fieldset>
    <fieldset>
        <legend>RX Date & Indication:</legend>
        <div class="w3-row">
            <div class="w3-column">
                <label for="rxDate">Date</label>
                <input type="text" name="rxDate" id="rxDate" class="rxInput" readonly value="${rxDate}">
            </div>
            <div class="w3-column">
                <label for="cirrhosis">Cirrhosis/Significant Fibrosis</label>
                <input type="text" name="cirrhosis" id="cirrhosis" class="rxInput" readonly value="${cirrhosis}">
            </div>
            <div class="w3-column">
                <label for="highHbvDna">High HBV-DNA & High ALT</label>
                <input type="text" name="highHbvDna" id="highHbvDna" class="rxInput" readonly value="${highHbvDna}">
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-column">
                <label for="familyHcc">Family H/o HCC/Cirrhosis</label>
                <input type="text" name="familyHcc" id="familyHcc" class="rxInput" readonly value="${familyHcc}">
            </div>
            <div class="w3-column">
                <label for="rxOthers">Others</label>
                <input type="text" name="rxOthers" id="rxOthers" class="rxInput" readonly value="${rxOthers}">
            </div>
            <div class="w3-column">
                <button id="editRxDetailsBtn" class="w3-button" style="margin: 0px; padding: 3px 32px;">Edit</button>
                <button id="saveRxDetailsBtn" class="w3-button"
                    style="display: none; margin: 0px; padding: 3px 32px;">Done</button>
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>Details</legend>
        <div class="w3-row">
            <div class="w3-column">
                <label for="alu">ALT (u/l)</label>
                <input type="text" name="alu" id="alu" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="hbvDna">HBV-DNA (iu/ml)</label>
                <input type="text" name="hbvDna" id="hbvDna" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="hbeag">HBeAg</label>
                <input type="text" name="hbeag" id="hbeag" class="w3-input-2">
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-column">
                <label for="usgLiver">USG-LIVER</label>
                <input type="text" name="usgLiver" id="usgLiver" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="fibroscan">FIBROSCAN</label>
                <input type="text" name="fibroscan" id="fibroscan" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="afp">AFP</label>
                <input type="text" name="afp" id="afp" class="w3-input-2">
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-column">
                <label for="cr">CREATININE (mg/dl)</label>
                <input type="text" name="cr" id="cr" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="others">OTHERS</label>
                <input type="text" name="others" id="others" class="w3-input-2">
            </div>
            <div class="w3-column">
                <label for="followupDate">NEXT.F/U</label>
                <input type="text" name="followupDate" id="followupDate" class="w3-input-2">
            </div>
        </div>
    </fieldset>
    <fieldset>
        <legend>Clinical Notes & Medication</legend>
        <div class="w3-row">
            <div class="w3-column">
                <textarea name="clinicalNotesMedication" id="clinicalNotesMedication" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <button id="submitHepatitisBFormBtn" class="w3-button">Submit</button>
                <button id="ViewHepatitisBDetailsBtn" class="w3-button">View</button>
            </div>
        </div>
    </fieldset>
</form>

<div id="w3-modal" class="w3-modal">
    <div class="w3-modal-content">
        <div class="w3-modal-body">
            <style>
                .w3-row:after {
                    content: "";
                    display: table;
                    clear: both;
                }

                .w3-modal-body {
                    padding: 2px 16px;
                }

                .w3-table {
                    border-collapse: collapse;
                    border: 1px solid #ccc;
                    border-spacing: 0;
                    width: 100%;
                    display: table
                }

                .w3-table tr {
                    border-bottom: 1px solid #ddd;
                }

                .w3-table tr:nth-child(odd) {
                    background-color: #fff;
                }

                .w3-table tr:nth-child(even) {
                    background-color: #f1f1f1;
                }

                .w3-table td,
                .w3-table th {
                    padding: 8px 8px;
                    display: table-cell;
                    text-align: left;
                    vertical-align: top;
                    border: 1px solid #ccc;
                }

                .w3-table th:first-child,
                .w3-table td:first-child {
                    padding-left: 16px;
                }

                .w3-input {
                    width: 100% !important;
                    padding: 4px 0px !important;
                    border: none !important;
                    border-bottom: 1px solid #ccc !important;
                    outline: none !important;
                }

                .w3-label {
                    font-weight: bold;
                    font-size: smaller;
                }
            </style>

            <div class="w3-row">
                <div style="width: 24%; float: left;">
                    <img id="facilityLogo" src="../../moduleResources/patientdashboard/gajangMedicalSocietyLogo.jpg"
                        alt="Gajang Medical Society Logo" style="width: 50%;">
                </div>
                <div style="width: 50%; float: left; margin-top: 50px;">
                    <img id="dialysisFormHeadingLogo"
                        src="../../moduleResources/patientdashboard/gadenDialysisFormHeading.jpg"
                        alt="Gajang Medical Society Logo" style="width: 90%;">
                    <h1 style="text-align: center; margin: 5 0;">GAJANG MEDICAL SOCIETY</h1>
                </div>
                <div style="width: 24%; float: left;">
                    <img id="doctorLogo" src="../../moduleResources/patientdashboard/doctorLogo.jpg" alt="Doctor's Logo"
                        style="width: 50%; float: right;">
                </div>
            </div>
            <p style="text-align: center;">Lama Camp No. 1, P.O. Tibetan Colony - 581411, Mundgod Distt. Uttar Kanada
                (K.S) India</p>
            <h3 style="text-align: center; margin: 5 0;"><u>HEPATITIS 'B' CONTROL PROGRAM</u></h3>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="width: 24%; float: left; padding: 5px;">
                    <label class="w3-label" style="color: red">P.I.</label>
                    <input type="text" id="patientIdentifier" readonly value="" class="w3-input">
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="width: 24%; float: left; padding: 5px;">
                    <label class="w3-label" style="color: red">PATIENT'S
                        NAME</label>
                    <input type="text" id="patientName" readonly value="" class="w3-input">
                </div>
                <div style="width: 24%; float: left; padding: 5px;">
                    <label class="w3-label" style="color: red">AGE</label>
                    <input type="text" id="patientAge" readonly value="" class="w3-input">
                </div>
                <div style="width: 24%; float: left; padding: 5px;">
                    <label class="w3-label" style="color: red">SEX</label>
                    <input type="text" id="patientGender" readonly value="" class="w3-input">
                </div>
                <div style="width: 24%; float: left; padding: 5px;">
                    <label class="w3-label" style="color: red">PHONE NO.</label>
                    <input type="text" id="patientPhoneNumber" readonly value="" class="w3-input">
                </div>
            </div>
            <div class="w3-row" style="margin: 0px;">
                <div style="width: 50%; float: left;">
                    <div style="padding: 5px;">
                        <label class="w3-label" style="color: red">ADDRESS</label>
                        <input type="text" id="patientAddress" readonly value=""
                            class="w3-input">
                    </div>
                    <div style="padding: 5px;">
                        <label class="w3-label" style="color: red">D.O.R.</label>
                        <input type="text" id="registrationDate" readonly value="" class="w3-input">
                    </div>
                    <div style="padding: 5px;">
                        <label class="w3-label" style="color: red">YEARS OF
                            DIAGNOSIS</label>
                        <input type="text" id="printYearsOfDiagnosis" readonly value="" class="w3-input">
                    </div>
                    <div style="padding: 5px;">
                        <label class="w3-label" style="color: red">COMPLICATIONS</label>
                        <input type="text" id="printComplications" readonly value="" class="w3-input">
                    </div>
                </div>
                <div style="width:49%; float: left; border: 1px solid red;">
                    <div class="w3-row" style="margin: 0px 2px;">
                        <div style="padding: 5px;">
                            <label class="w3-label" style="color: red">Date</label>
                            <input type="text" id="printRxDate" readonly value="" class="w3-input">
                        </div>
                        <div style="padding: 5px;">
                            <label class="w3-label">1)
                                Cirrhosis/Significant Fibrosis</label>
                            <input type="text" id="printCirrhosis" readonly value=""
                                class="w3-input">
                        </div>
                        <div style="padding: 5px;">
                            <label class="w3-label">2) High HBV-DNA & High
                                ALT</label>
                            <input type="text" id="printHighHbvDna" readonly value=""
                                class="w3-input">
                        </div>
                        <div style="padding: 5px;">
                            <label class="w3-label">3) Family H/o
                                HCC/Cirrhosis</label>
                            <input type="text" id="printFamilyHcc" readonly value=""
                                class="w3-input">
                        </div>
                        <div style="padding: 5px;">
                            <label class="w3-label">Others</label>
                            <input type="text" id="printRxOthers" readonly value=""
                                class="w3-input">
                        </div>
                    </div>
                </div>
            </div>
            <div class="w3-overflow" style="width: 100%;">
                <table class="w3-table">
                    <thead>
                        <tr>
                            <th>Dates</th>
                            <th>ALT (u/l)</th>
                            <th>HBV-DNA(iu/ml)</th>
                            <th>HBeAg</th>
                            <th>USG-LIVER</th>
                            <th>FIBROSCAN</th>
                            <th>AFP</th>
                            <th>CREATININE (mg/dl)</th>
                            <th>OTHERS</th>
                            <th>NEXT.F/U</th>
                        </tr>
                    </thead>
                    <tbody id="hepatitisBDetailsTableBody"></tbody>
                </table>
            </div>
            <br>
            <div style="overflow-x: auto; width: 100%;">
                <table class="w3-table">
                    <thead>
                        <tr>
                            <th>Dates</th>
                            <th>CLINICAL-NOTES/MEDICATION</th>
                        </tr>
                    </thead>
                    <tbody id="hepatitisBDetailsClinicalTableBody"></tbody>
                </table>
            </div>
        </div>
        <div class="w3-modal-footer">
            <button id="printHepatitisDetailBtn" class="w3-button">Print</button>
            <button id="cancelHepatitisDetailBtn" class="w3-button">Cancel</button>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(() => {
        jQuery('#editRxDetailsBtn').click((e) => {
            e.preventDefault()
            jQuery('.rxInput').attr('readonly', false)
            jQuery('#editRxDetailsBtn').css('display', 'none')
            jQuery('#saveRxDetailsBtn').css('display', 'block')
        })

        jQuery('#saveRxDetailsBtn').click((e) => {
            e.preventDefault()
            jQuery('.rxInput').attr('readonly', true)
            jQuery('#editRxDetailsBtn').css('display', 'block')
            jQuery('#saveRxDetailsBtn').css('display', 'none')
        })

        jQuery('#submitHepatitisBFormBtn').click((e) => {
            e.preventDefault()

            if (jQuery('input.rxInput').attr('readonly') == false) {
                alert("Please save Rx details first.")
                return
            }

            followupDate = jQuery('#followupDate')
            alt = jQuery('#alu')
            usgLiver = jQuery('#usgLiver')


            if (alt.val() == "") {
                alert("ALT is required.")
                alt.focus()
                return
            }

            if (usgLiver.val() == "") {
                alert("USG-LIVER is required.")
                usgLiver.focus()
                return
            }

            if (followupDate.val() == "") {
                alert("Next Followup Date date is required.")
                followupDate.focus()
                return
            }

            jQuery('#submitHepatitisBFormBtn').attr('disabled', true)
            let formData = jQuery("#hepatitisBForm").formSerialize()

            jQuery.post('hepatitisBForm.htm?patientId=${patientId}', formData, (data) => {
                jQuery('input.w3-input-2').val('')
                jQuery('textarea.w3-textarea').val('')
                alert('Details added successfully.')
                jQuery('#submitHepatitisBFormBtn').attr('disabled', false)
            })
        })

        jQuery(() => {
            jQuery('#rxDate').datepicker({ minDate: 0 })
            jQuery('#followupDate').datepicker({ minDate: 0 })
        })

        let w3_modal = document.getElementById("w3-modal")
        jQuery(window).click((e) => {
            if (e.target == w3_modal) {
                w3_modal.style.display = 'none'
            }
        })

        jQuery('#cancelHepatitisDetailBtn').click(() => {
            w3_modal.style.display = 'none'
        })

        jQuery('#printHepatitisDetailBtn').click((e) => {
            e.preventDefault()
            jQuery('.w3-modal-body').printArea({
                mode: "popup",
                popClose: true
            });
            w3_modal.style.display = 'none'
        })

        jQuery('#ViewHepatitisBDetailsBtn').click((e) => {
            e.preventDefault();

            jQuery('#w3-modal').css('display', 'block')
            jQuery.get('getPatientHepatitisBDetails.list?patientId=${patientId}', (data) => {
                console.log(data);
                patientDetails = data[data.length - 1]

                jQuery('#patientIdentifier').val(patientDetails.patientIdentifier);
                jQuery('#patientName').val(patientDetails.patientName);
                jQuery('#patientAge').val(patientDetails.patientAge);
                jQuery('#patientGender').val(patientDetails.patientGender);
                jQuery('#patientPhoneNumber').val(patientDetails.patientPhoneNumber);
                jQuery('#patientAddress').val(patientDetails.patientAddress);
                jQuery('#registrationDate').val(new Date(patientDetails.registrationDate).toDateString());

                data.pop()

                rxDetails = data[0]

                jQuery('#printYearsOfDiagnosis').val(rxDetails.years_of_diagnosis)
                jQuery('#printComplications').val(rxDetails.complications)

                let rxDate = "" + rxDetails.rxDate + ""
                console.log(rxDate);
                if (rxDate != "" || rxDate != null) {
                    rxDate = new Date(rxDate).toDateString()
                }
                jQuery('#printRxDate').val(rxDate)

                jQuery('#printCirrhosis').val(rxDetails.cirrhosis)
                jQuery('#printHighHbvDna').val(rxDetails.high_hbv_dna)
                jQuery('#printFamilyHcc').val(rxDetails.family_hcc)
                jQuery('#printRxOthers').val(rxDetails.rx_others)

                let tbody = "";
                let tbody1 = "";
                data.forEach(element => {
                    let createdDate = new Date(element.createdDate).toDateString();
                    let followupDate = new Date(element.followupDate).toDateString();

                    let tr = "<tr>";
                    tr += "<td>" + createdDate + "</td>";
                    tr += "<td>" + element.alu + "</td>";
                    tr += "<td>" + element.hbv_dna + "</td>";
                    tr += "<td>" + element.hbeag + "</td>";
                    tr += "<td>" + element.usg_liver + "</td>";
                    tr += "<td>" + element.fibroscan + "</td>";
                    tr += "<td>" + element.afp + "</td>";
                    tr += "<td>" + element.cr + "</td>";
                    tr += "<td>" + element.others + "</td>";
                    tr += "<td>" + followupDate + "</td>";
                    tr += "</tr>";
                    tbody += tr;

                    if (element.clinical_notes_medication != "") {
                        let tr1 = "<tr>";
                        tr1 += "<td>" + createdDate + "</td>";
                        tr1 += "<td>" + element.clinical_notes_medication + "</td>";
                        tr1 += "</tr>";
                        tbody1 += tr1;
                    }
                });

                if (tbody1.length == 0) {
                    jQuery('#hepatitisBDetailsClinicalTableBody').html("<b>No clinical notes available.</b>");
                } else {
                    jQuery('#hepatitisBDetailsClinicalTableBody').html(tbody1);
                }

                jQuery('#hepatitisBDetailsTableBody').html(tbody)
            })
        })
    })
</script>