<style>
    .w3-row {
        margin: 5px 0px 0px 0px;
    }

    .w3-column {
        float: left;
        width: 32%;
        padding: 0px 5px;
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
        width: 100% !important;
        height: 80px;
        padding: 12px 20px;
        box-sizing: border-box;
        border-radius: 4px;
        resize: none;
    }

    .w3-label {
        font-weight: bold;
        font-size: smaller;
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


<form id="referralLetterForm">
    <fieldset>
        <legend>Referral Details</legend>
        <div class="w3-row">
            <div class="w3-column">
                <label for="referTo">Refer To</label>
                <textarea name="referto" id="referTo" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <label for="symptoms">Symptoms</label>
                <textarea name="symptoms" id="symptoms" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <label for="investigation">Investigation</label>
                <textarea name="investigation" id="investigation" class="w3-textarea"></textarea>
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-column">
                <label for="diagnosis">Diagnosis</label>
                <textarea name="diagnosis" id="diagnosis" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <label for="treatment">Treatment</label>
                <textarea name="treatment" id="treatment" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <label for="pastHistory">Past History</label>
                <textarea name="pastHistory" id="pastHistory" class="w3-textarea"></textarea>
            </div>
        </div>
        <div class="w3-row">
            <div class="w3-column">
                <label for="referralReason">Referral Reason</label>
                <textarea name="referralReason" id="referralReason" class="w3-textarea"></textarea>
            </div>
            <div class="w3-column">
                <button id="submitReferralDetailsBtn" class="w3-button">Submit</button>
                <button id="viewReferralDetailsBtn" class="w3-button">View</button>
            </div>
        </div>
    </fieldset>
</form>

<div id="w3-modal" class="w3-modal">
    <div class="w3-modal-content">
        <div class="w3-modal-header">
            <select name="selectReferralDate" id="selectReferralDate">
                <option value="1">Date 1</option>
                <option value="1">Date 2</option>
                <option value="1">Date 3</option>
                <option value="1">Date 4</option>
                <option value="1">Date 5</option>
            </select>
            <button>View</button>
            <button>Print</button>
            <button>Cancel</button>
        </div>
        <div class="w3-modal-body">
        </div>
    </div>
</div>


<script>
    jQuery(document).ready(() => {

        patientReferralDetailsList = ${ patientReferralDetailsList }
        console.log(patientReferralDetailsList);

        jQuery('#submitReferralDetailsBtn').click((e) => {
            e.preventDefault()

            let formData = jQuery('#referralLetterForm').serialize()

            jQuery.post('referralLetter.htm?patientId=${patientId}', formData, (data) => {
                alert('Details added successfully.')
            })
        })
    })
</script>