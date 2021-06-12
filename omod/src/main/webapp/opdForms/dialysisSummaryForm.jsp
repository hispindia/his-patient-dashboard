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
	<p style="padding: 5px 0px"><b><a class="w3-button" id="viewFormBtn">Click Here</a> to view</b></p>
</div>

<div id="w3-modal" class="w3-modal">
	<div class="w3-modal-content">
		<div class="w3-modal-header" style="padding: 10px;">
			<button id="newDialysisSummaryFormBtn" class="w3-button">New</button>
			<button id="saveDialysisSummaryFormBtn" class="w3-button">Save</button>
			<button id="viewDialysisSummaryFormBtn" class="w3-button">View</button>
			<select name="selectReferralDate" id="selectDialysisSummaryFormDate"
				style="width: 20%; padding: 10px; display: none;">
			</select>
			<button id="printDialysisSummaryFormBtn" class="w3-button" style="display: none;">Print</button>
			<button id="closeModal" class="w3-button">Cancel</button>
		</div>
		<div class="w3-modal-body">
			<style>
				.w3-row {
					margin: 5px 0px 0px 0px;
					padding: 10px;
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

				label {
					font-weight: bold !important;
				}

				.w3-input {
					border: none !important;
					border-bottom: 1px solid black !important;
				}

				.notes {
					background-image: -webkit-linear-gradient(left, white 0px, transparent 0px), -webkit-linear-gradient(right, white 0px, transparent 0px), -webkit-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
					background-image: -moz-linear-gradient(left, white 0px, transparent 0px), -moz-linear-gradient(right, white 0px, transparent 0px), -moz-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
					background-image: -ms-linear-gradient(left, white 0px, transparent 0px), -ms-linear-gradient(right, white 0px, transparent 0px), -ms-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
					background-image: -o-linear-gradient(left, white 0px, transparent 0px), -o-linear-gradient(right, white 0px, transparent 0px), -o-linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
					background-image: linear-gradient(left, white 0px, transparent 0px), linear-gradient(right, white 0px, transparent 0px), linear-gradient(white 30px, #000 30px, #000 31px, white 31px);
					background-size: 100% 100%, 100% 100%, 100% 31px;
					border: none;
					/* resize: none; */
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
			<h2 style="text-align: center; margin: 2px 0px;">Dialysis Summary</h2>
			<hr>
			<form id="dialysisSummaryForm">
				<input type="hidden" class="editable" name="dialysisSummaryFormId" id="id">
				<div class="w3-row">
					<label for="patientName">PATIENT NAME </label>
					<input type="text" class="w3-input" id="patientName" readonly value="${patientName}"
						style="width: calc(100% - 110px);">
				</div>
				<div class="w3-row">
					<label for="identifier">ID NO </label>
					<input type="text" class="w3-input" id="identifier" readonly value="${identifier}"
						style="width: calc(100% - 50px);">
				</div>
				<div class="w3-row">
					<label for="ageSex">AGE/SEX </label>
					<input type="text" class="w3-input" id="ageSex" readonly value="${patientAge}/${patientGender}"
						style="width: calc(100% - 70px);">
				</div>
				<div class="w3-row">
					<label for="blood_group">BLOOD GROUP </label>
					<input type="text" class="w3-input editable" name="bloodGroup" id="blood_group"
						style="width: calc(100% - 110px);">
				</div>
				<div class="w3-row">
					<div style="padding: 0 5px; margin-top: 20px;">
						<label for="diagnosis">DIAGNOSIS</label>
						<textarea name="diagnosis" id="diagnosis" rows="3" class="notes"></textarea>
					</div>
				</div>
				<div class="w3-row">
					<label for="vascular_access">VASCULAR ACCESS </label>
					<input type="text" class="w3-input editable" name="vascularAccess" id="vascular_access"
						style="width: calc(100% - 135px);">
				</div>
				<div class="w3-row">
					<label for="dry_weight_hd">DRY WEIGHT HD </label>
					<input type="text" class="w3-input editable" name="dryWeightHd" id="dry_weight_hd"
						style="width: calc(100% - 120px);">
				</div>
				<div class="w3-row">
					<label for="frequency_hours_hd">FREQUENCY AND HOURS OF HD </label>
					<input type="text" class="w3-input editable" name="frequencyHoursHd" id="frequency_hours_hd"
						style="width: calc(100% - 220px);">
				</div>
				<div class="w3-row">
					<label for="blood_flow_rate">BLOOD FLOW RATE </label>
					<input type="text" class="w3-input editable" name="bloodFlowRate" id="blood_flow_rate"
						style="width: calc(100% - 140px);">
				</div>
				<div class="w3-row">
					<label for="heparin">HEPARIN </label>
					<input type="text" class="w3-input editable" name="heparin" id="heparin"
						style="width: calc(100% - 70px);">
				</div>
				<div class="w3-row">
					<label for="complication_hd">COMPLICATIONS</label>
					<textarea name="complicationHd" id="complication_hd" rows="3" class="notes"></textarea>
				</div>
				<div class="w3-row">
					<label for="hbv_vaccination">HBV VACCINATION </label>
					<input type="text" class="w3-input editable" name="hbvVaccination" id="hbv_vaccination"
						style="width: calc(100% - 140px);">
				</div>
				<div class="w3-row">
					<label for="hd_start_date">HD START DATE </label>
					<input type="text" class="w3-input" name="hdStartDate" id="hd_start_date"
						style="width: calc(100% - 115px);">
				</div>
				<div class="w3-row">

					<label for="latest_investigation">LATEST INVESTIGATION DONE</label>
					<textarea name="latestInvestigation" id="latest_investigation" rows="3" class="notes"></textarea>
				</div>
				<div class="w3-row">
					<label for="medications">MEDICATIONS</label>
					<textarea name="medications" id="medications" rows="3" class="notes"></textarea>

				</div>
		</div>
	</div>
</div>


<script>
	jQuery(document).ready(() => {

		let w3_modal = document.getElementById("w3-modal")
		let dialysisSummaryDetails = []

		jQuery(() => {
			jQuery("#hd_start_date").datepicker({ minDate: 0 });
			jQuery('input#hd_start_date').val(new Date().toLocaleDateString())
		});

		jQuery('#newDialysisSummaryFormBtn').click((e) => {
			e.preventDefault()
			jQuery('textarea.notes').val("")
			jQuery('input.editable').val("")
			jQuery('#saveDialysisSummaryFormBtn').css('display', 'inline-block')
			jQuery('#selectDialysisSummaryFormDate').css('display', 'none')
			jQuery('#printDialysisSummaryFormBtn').css('display', 'none')
			jQuery('#viewDialysisSummaryFormBtn').css('display', 'inline-block')
		})

		jQuery('#viewDialysisSummaryFormBtn').click((e) => {
			jQuery.get('getDialysisSummaryForms.htm?patientId=${patientId}', (data) => {
				if (data.length <= 0) {
					alert('No previous forms available.')
					return
				}
				dialysisSummaryDetails = data
				let options = '<option value="" selected>Select a date</option>'
				dialysisSummaryDetails.forEach(element => {
					options += '<option value="' + element.id + '">' + new Date(element.created_date).toDateString() + '</option>'
				});
				jQuery('#selectDialysisSummaryFormDate').html(options)
				jQuery('#saveDialysisSummaryFormBtn').css('display', 'none')
				jQuery('#selectDialysisSummaryFormDate').css('display', 'inline-block')
				jQuery('#printDialysisSummaryFormBtn').css('display', 'inline-block')
				jQuery('#viewDialysisSummaryFormBtn').css('display', 'none')
			})
		})

		jQuery('#selectDialysisSummaryFormDate').change((e) => {
			let id = jQuery('#selectDialysisSummaryFormDate').val()
			dialysisSummaryDetails.forEach(element => {
				if (element.id == id) {
					for (const key in element) {
						if (element.hasOwnProperty(key)) {
							if (key === "created_date") {
								continue
							}
							if (key === "hd_start_date") {
								jQuery("#" + key).val(new Date(element[key]).toLocaleDateString())
							} else {
								jQuery("#" + key).val(element[key])
							}
						}
					}
				}
			})
		})

		jQuery('#saveDialysisSummaryFormBtn').click((e) => {
			e.preventDefault()

			let formData = jQuery('#dialysisSummaryForm').serialize()

			jQuery.post('dialysisSummaryForm.htm?patientId=${patientId}', formData, (data) => {
				jQuery('.w3-modal-body').printArea({
					mode: "popup",
					popClose: true,
				})
				jQuery('textarea.notes').val("")
				jQuery('input.editable').val("")
			})

		})

		jQuery('#printDialysisSummaryFormBtn').click((e) => {
			e.preventDefault()
			jQuery('.w3-modal-body').printArea({
				mode: "popup",
				popClose: true
			});
			w3_modal.style.display = 'none'
		})

		jQuery('#viewFormBtn').click((e) => {
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