<style>
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
        width: 80%;
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
                }

                .w3-input {
                    width: 100% !important;
                    padding: 4px 0px !important;
                    border: none !important;
                    outline: none !important;
                    font-weight: bold !important;
                    font-size: 18px !important;
                }

                .w3-label {
                    font-weight: bold;
                    color: black;
                    font-size: 18px;
                }

                .certificateMessage {
                    font-size: 22px;
                    text-align: justify;
                    line-height: 2;
                    word-spacing: 10px;
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
                <div style="width: 50%; float: left;">
                    <h1 style="text-align: center; margin: 5 0;"><u>MEDICAL FITNESS CERTIFICATE</u></h1>
                </div>
                <div style="width: 24%; float: left;">
                    <img id="doctorLogo" src="../../moduleResources/patientdashboard/doctorLogo.jpg" alt="Doctor's Logo"
                        style="width: 50%; float: right;">
                </div>
            </div>
            <p style="text-align: center; font-size: 22px; font-weight: bold;">To Whom It May Concern</p>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="width: 24%; float: right; padding: 5px;">
                    <label class="w3-label">Date</label>
                    <input type="text" id="certificateDate" readonly value=""
                        class="w3-input">
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <p class="certificateMessage">It is to certify that Mr/Mrs/Miss<span id="patientName"></span>age<span
                        id="patientAge"></span>sex<span id="patientGender"></span>R/o<span
                        id="patientAddress"></span>is thoroughly examined on<span id="patientCheckDate"></span>He/She is
                    found to be physically and mentally fit at the time of examination.</p>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="float: right; padding: 5px;">
                    <label class="w3-label">Thank You</label>
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="float: right; padding: 5px;">
                    <label class="w3-label">${doctorName}</label>
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="float: right; padding: 5px;">
                    <label class="w3-label">Gajang Medical Hospital</label>
                </div>
            </div>
            <div class="w3-row" style="margin: 5px 2px;">
                <div style="float: right; padding: 5px;">
                    <label class="w3-label">Tibetan Colony, Mundgod, Karnataka</label>
                </div>
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

        jQuery('#viewMedicalCertificateBtn').click((e) => {
            e.preventDefault();
            jQuery('#w3-modal').css('display', 'block')
            jQuery.get('getmedicalcertificatedetail.list?patientId=${patientId}', (data) => {
                jQuery('#certificateDate').val(new Date().toDateString())
                jQuery('#patientName').html(" " + data.patientName + " ")
                jQuery('#patientAge').html(" " + data.patientAge + " ")
                jQuery('#patientGender').html(" " + data.patientGender + " ")
                jQuery('#patientAddress').html(" " + data.patientAddress + " ")
                jQuery('#patientCheckDate').html(" " + new Date().toDateString() + ". ")
                jQuery('#doctorLogo').attr('src', '../../moduleResources/patientdashboard/doctorLogo.jpg')
                jQuery('#facilityLogo').attr('src', '../../moduleResources/patientdashboard/gajangMedicalSocietyLogo.jpg')
            })
        })
    })
</script>