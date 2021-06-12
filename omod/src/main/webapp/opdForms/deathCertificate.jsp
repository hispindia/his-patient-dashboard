<style>
    .w3-button {
        background-color: #1aad9b;
        border: none;
        color: white !important;
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
        padding: 10px 10px 0px 10px;
        width: 80%;
        height: 80%;
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
<div>
    <p style="padding: 5px 0px"><b><a class="w3-button" id="viewMedicalCertificateBtn">Click Here</a> to view the
            Certificate</b></p>
</div>

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
                    border: 1px solid black;
                }

                .w3-input {
                    /* width: 100% !important; */
                    padding: 4px 0px !important;
                    border: none !important;
                    border-bottom: 1px solid black !important;
                    outline: none !important;
                }

                .w3-label {
                    font-weight: bold;
                    color: black;
                    font-size: 18px;
                }

                .certificateMessage {
                    /* font-size: 16px; */
                    text-align: justify;
                    /* line-height: 2; */
                    /* word-spacing: 5px; */
                }

                .certificateMessage span {
                    font-weight: bold;
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
            <div class="w3-row">
                <h3 style="text-align: center; margin: 5 0;">(REGD. UNDER K.S.R. ACT 1960 No. SOCIETY
                    DR/SOR/89/2004-2005)</h3>
            </div>
            <hr>

            <div class="w3-row" style="margin: 5px 2px;">
                <div style="width: 24%; float: right; padding: 5px;">
                    <label class="w3-label" style="font-size: 12px;">Date</label>
                    <input type="text" id="certificateDate" readonly value="" style="font-weight: bolder;"
                        class="w3-input">
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px; text-align: center;">
                <h1><u>DEATH CERTIFICATE</u></h1>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <p class="certificateMessage">It is hereby to certify that the person whose particulars given below, died in the hospital in Ward Name<input type="text" class="w3-input editInput" id="wardName"
                        style="text-align: center; font-weight: bold;" value=""> bed no.<input type="text" class="w3-input editInput" id="wardNumber"
                        style="text-align: center; font-weight: bold;" value=""> on<input type="text"
                        class="w3-input editInput" id="deathDate" style="text-align: center; font-weight: bold;"
                        value=""> at<input type="text" class="w3-input editInput" id="deathTime"
                        style="text-align: center; font-weight: bold;" value="">A.M.
                    /P.M. </p>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="float: left; width: 49%;">
                    <label class="" style="width: 100px;">Patient Name:</label>
                    <input type="text" readonly class="w3-input" id="patientName" value="${patientName}"
                        style="width: calc(100% - 100px); font-weight: bold;">
                </div>
                <div style="float: left; width: 26%;">
                    <label class="" style="width: 30px;">Age:</label>
                    <input type="text" readonly class="w3-input" id="patientAge" value="${patientAge}"
                        style="width: calc(100% - 40px); font-weight: bold;">
                </div>
                <div style="float: left; width: 25%;">
                    <label class="" style="width: 30px;">Sex:</label>
                    <input type="text" readonly class="w3-input" id="patientSex" value="${patientGender}"
                        style="width: calc(100% - 40px); font-weight: bold;">
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">Permanent Address:</label>
                <input type="text" readonly class="w3-input" id="patientAddress" value="${address}"
                    style="width: calc(100% - 140px); font-weight: bold;">
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">Place of Death:</label>
                <input type="text" class="w3-input editInput" id="patientPlaceOfDeath" value=""
                    style="width: calc(100% - 110px); font-weight: bold;">
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">Time of Death:</label>
                <input type="text" class="w3-input editInput" id="patientTimeOfDeath" value=""
                    style="width: calc(100% - 110px); font-weight: bold;">
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 100px;">Diagnosis:</label>
                <input type="text" class="w3-input editInput" id="patientDiagnosis" value=""
                    style="width: calc(100% - 80px); font-weight: bold;">
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">Past Medical History:</label>
                <input type="text" class="w3-input editInput" id="pastMedicalHistory" value=""
                    style="width: calc(100% - 150px); font-weight: bold;">
            </div>
            <br>
            <h3>Cause of Death:</h3>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">1. Immediate Cause:</label>
                <input type="text" class="w3-input editInput" id="patientImmediateCause" value=""
                    style="width: calc(100% - 150px); font-weight: bold;">
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <label style="width: 150px;">2. Antecedent cause: </label>
                <input type="text" class="w3-input editInput" id="patientAntecedentCause" value=""
                    style="width: calc(100% - 140px); font-weight: bold;">
            </div>
            <br>
            <div class="w3-row" style="margin: 5px 2px;">
                <h4 style="float: right;">Resident Medical Officer</h4>
            </div>
            <br>
            <hr>
            <div class="w3-row">
                <p style="text-align: center; margin: 5 0;">Lama camp No.1 P.O Tibetan colony-581411 Mundgod, Distt.
                    Uttar Kanara (K.S) India</p>
            </div>
            <div class="w3-row">
                <p style="text-align: center; margin: 5 0;">Tel: <a href="tel:+91-8301-246004">+91-8301-246004</a>
                    E-mail: <a href="mailto:gjmbclinic2001@yahoo.co.in">gjmbclinic2001@yahoo.co.in</a> (NON-PROFIT
                    ORGANIZATION)</p>
            </div>

        </div>
        <div class="w3-modal-footer">
            <button id="printHepatitisDetailBtn" class="w3-button">Print</button>
            <button id="editDeathCertificateDetailsBtn" style="display: none;" class="w3-button">Edit</button>
            <button id="saveDeathCertificateDetailsBtn" class="w3-button">Save</button>
            <button id="cancelHepatitisDetailBtn" class="w3-button">Cancel</button>
        </div>
    </div>
</div>

<script>
    jQuery(document).ready(() => {

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

            if (jQuery('input.editInput').attr('readonly') == false) {
                alert("Please first save the details.")
                return
            }

            jQuery('.w3-modal-body').printArea({
                mode: "popup",
                popClose: true
            });
            w3_modal.style.display = 'none'
        })

        jQuery('#saveDeathCertificateDetailsBtn').click((e) => {
            e.preventDefault()

            jQuery('input.editInput').attr('readonly', true)
            jQuery('#editDeathCertificateDetailsBtn').css('display', 'inline-block')
            jQuery('#saveDeathCertificateDetailsBtn').css('display', 'none')


        })

        jQuery('#editDeathCertificateDetailsBtn').click((e) => {
            e.preventDefault()

            jQuery('input.editInput').attr('readonly', false)
            jQuery('#editDeathCertificateDetailsBtn').css('display', 'none')
            jQuery('#saveDeathCertificateDetailsBtn').css('display', 'inline-block')
        })

        jQuery('#viewMedicalCertificateBtn').click((e) => {
            e.preventDefault();

            jQuery('#certificateDate').val(new Date().toDateString())

            jQuery('#w3-modal').css('display', 'block')
        })

    })
</script>