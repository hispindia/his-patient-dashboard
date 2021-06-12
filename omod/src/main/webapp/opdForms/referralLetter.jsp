<style>
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

    .w3-modal {
        display: block;
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
        padding-bottom: 20px;
        border: 1px solid #888;
        width: 70%;
        height: 87%;
        max-height: 88%;
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
        animation-name: animatetop;
        animation-duration: 0.4s;
        /* overflow-x: auto; */
    }

    .w3-modal-body {
        height: 90%;
        max-height: 90%;
        overflow-y: auto;
    }

    .w3-modal-header {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    }

    .w3-overflow {
        overflow-x: auto;
    }
</style>
<div>
    <p style="padding: 5px 0px"><b><a class="w3-button" id="viewReferralLetterBtn">Click Here</a> to view the
            Referral Letter</b></p>
</div>

<div id="w3-modal" class="w3-modal">
    <div class="w3-modal-content">
        <div class="w3-modal-header" style="padding: 10px;">
            <button id="newReferralFormBtn" class="w3-button">New</button>
            <button id="saveReferralFormBtn" class="w3-button">Save</button>
            <button id="viewReferralFormBtn" class="w3-button">View</button>
            <select name="selectReferralDate" id="selectReferralFormDate"
                style="width: 20%; padding: 10px; display: none;">
            </select>
            <button id="printReferralFormBtn" class="w3-button" style="display: none;">Print</button>
            <button id="closeModal" class="w3-button">Cancel</button>
        </div>
        <div class="w3-modal-body">
            <style>
                .w3-row {
                    margin: 5px 0px 0px 0px;
                }

                .w3-row::after {
                    content: "";
                    display: table;
                    clear: both;
                }

                .w3-column {
                    float: left;
                    width: 32%;
                    padding: 0px 5px;
                }

                .w3-modal-body {
                    border: 1px solid black;
                }

                .w3-label {
                    font-weight: bold;
                    font-size: smaller;
                }

                .notes {
                    background-image: -webkit-linear-gradient(left, white 0px, transparent 0px), -webkit-linear-gradient(right, white 0px, transparent 0px), -webkit-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
                    background-image: -moz-linear-gradient(left, white 0px, transparent 0px), -moz-linear-gradient(right, white 0px, transparent 0px), -moz-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
                    background-image: -ms-linear-gradient(left, white 0px, transparent 0px), -ms-linear-gradient(right, white 0px, transparent 0px), -ms-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
                    background-image: -o-linear-gradient(left, white 0px, transparent 0px), -o-linear-gradient(right, white 0px, transparent 0px), -o-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
                    background-image: linear-gradient(left, white 0px, transparent 0px), linear-gradient(right, white 0px, transparent 0px), linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
                    background-size: 100% 100%, 100% 100%, 100% 31px;
                    border: none;
                    resize: none;
                    width: 100%;
                    line-height: 31px;
                    font-family: Arial, Helvetica, Sans-serif;
                }

                .notes:focus {
                    outline: none;
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
            <hr>
            <h2 style="text-align: center; margin: 2px 0px;">Referral Letter</h2>
            <hr>
            <form id="referralLetterForm">
                <div class="w3-row">
                    <div class="w3-column">
                        <label for="referTo" style="margin: 0px; padding: 0px;">To</label>
                        <textarea name="referTo" id="referTo" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <h3 style="text-align: center; margin: 0px 0px 20px 0px;">Patient Summary</h3>
                <div class="w3-row">
                    <div class="w3-column">
                        <p style="margin: 0px;"><span style="font-weight: bold;">Name- </span>${patientName}</p>
                    </div>
                    <div class="w3-column">
                        <p style="margin: 0px;"><span style="font-weight: bold;">Age- </span>${patientAge}</p>
                    </div>
                    <div class="w3-column">
                        <p style="margin: 0px;"><span style="font-weight: bold;">Sex- </span>${patientGender}</p>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="symptoms" style="font-weight: bold;">Symptoms & Signs</label>
                        <textarea name="symptoms" id="symptoms" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="investigation" style="font-weight: bold;">Investigation-Reports attached</label>
                        <textarea name="investigation" id="investigation" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="diagnosis" style="font-weight: bold;">Provisional Diagnosis/Active problem</label>
                        <textarea name="diagnosis" id="diagnosis" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="treatment" style="font-weight: bold;">Treatment given</label>
                        <textarea name="treatment" id="treatment" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="pastHistory" style="font-weight: bold;">Past History</label>
                        <textarea name="pastHistory" id="pastHistory" rows="3" class="notes"></textarea>
                    </div>
                </div>
                <div class="w3-row">
                    <div style="padding: 0 5px; margin-top: 20px;">
                        <label for="referralReason" style="font-weight: bold;">Reason for Referral</label>
                        <textarea name="referralReason" id="referralReason" rows="3" class="notes"></textarea>
                    </div>
                </div>
            </form>
            <div class="w3-row">
                <div class="w3-column">
                    <p style="font-weight: bold; margin: 5px;">Thank you</p>
                    <p style="margin: 5px;">${doctorName}</p>
                </div>
            </div>
        </div>
    </div>
</div>


<script>
    jQuery(document).ready(() => {

        let w3_modal = document.getElementById("w3-modal")
        let referralDetails = []

        jQuery('#newReferralFormBtn').click((e) => {
            e.preventDefault()
            jQuery('textarea.notes').val("")
            jQuery('#saveReferralFormBtn').css('display', 'inline-block')
            jQuery('#selectReferralFormDate').css('display', 'none')
            jQuery('#printReferralFormBtn').css('display', 'none')
            jQuery('#viewReferralFormBtn').css('display', 'inline-block')
        })

        jQuery('#viewReferralFormBtn').click((e) => {
            jQuery.get('getReferralLetter.htm?patientId=${patientId}', (data) => {
                if (data.length <= 0) {
                    alert('No previous referral details available.')
                    return
                }
                referralDetails = data
                let options = '<option value="" selected>Select a date</option>'
                referralDetails.forEach(element => {
                    options += '<option value="' + element.referral_id + '">' + new Date(element.createdDate).toDateString() + '</option>'
                });
                jQuery('#selectReferralFormDate').html(options)
                jQuery('#saveReferralFormBtn').css('display', 'none')
                jQuery('#selectReferralFormDate').css('display', 'inline-block')
                jQuery('#printReferralFormBtn').css('display', 'inline-block')
                jQuery('#viewReferralFormBtn').css('display', 'none')
            })
        })

        jQuery('#selectReferralFormDate').change((e) => {
            let referral_id = jQuery('#selectReferralFormDate').val()
            referralDetails.forEach(element => {
                if (element.referral_id == referral_id) {
                    jQuery('#referTo').val(element.refer_to)
                    jQuery('#symptoms').val(element.symptoms)
                    jQuery('#investigation').val(element.investigations)
                    jQuery('#diagnosis').val(element.diagnosis)
                    jQuery('#treatment').val(element.treatment_given)
                    jQuery('#pastHistory').val(element.past_history)
                    jQuery('#referralReason').val(element.reason_for_referral)
                }
            });
        })

        jQuery('#saveReferralFormBtn').click((e) => {
            e.preventDefault()

            if (jQuery('#referTo').val().trim() == "") {
                alert('Refer To details are required.')
                return
            }

            let formData = jQuery('#referralLetterForm').serialize()

            jQuery.post('referralLetter.htm?patientId=${patientId}', formData, (data) => {
                jQuery('.w3-modal-body').printArea({
                    mode: "popup",
                    popClose: true,
                })
                jQuery('textarea.notes').val("")
            })

        })

        jQuery('#printReferralFormBtn').click((e) => {
            e.preventDefault()
            jQuery('.w3-modal-body').printArea({
                mode: "popup",
                popClose: true
            });
            w3_modal.style.display = 'none'
        })

        jQuery('#viewReferralLetterBtn').click((e) => {
            e.preventDefault()
            w3_modal.style.display = 'block'
        })

        jQuery('#closeModal').click((e) => {
            e.preventDefault()
            w3_modal.style.display = 'none'
        })

        jQuery(window).click((e) => {
            if (e.target == w3_modal) {
                w3_modal.style.display = 'none'
            }
        })
    })
</script>