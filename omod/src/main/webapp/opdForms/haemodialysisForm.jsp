<style>
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

  .w3-modal {
    /* display: none; */
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
    /* margin: 0 auto; */
    /* width: 90%; */
    height: 88%;
    max-height: 88%;
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
    width: 75%;
    height: 90%;
    max-height: 90%;
    box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
    animation-name: animatetop;
    animation-duration: 0.4s;
    /* overflow-x: auto; */
  }

  .w3-overflow {
    overflow-x: auto;
  }
</style>
<div>
  <p style="padding: 5px 0px">
    <b><a class="w3-button" id="openForm">Click Here</a> to Open.</b>
  </p>
</div>

<div id="w3-modal" class="w3-modal">
  <div class="w3-modal-content">
    <div class="w3-modal-header" style="padding: 10px;">
      <button id="newFormBtn" class="w3-button">New</button>
      <button id="saveFormBtn" class="w3-button">Save</button>
      <button id="viewFormsBtn" class="w3-button">View</button>
      <select name="selectFormDate" id="selectFormDate" style="width: 20%; padding: 10px; display: none;">
      </select>
      <button id="printFormBtn" class="w3-button" style="display: none;">Print</button>
      <button id="closeModal" class="w3-button">Cancel</button>
    </div>
    <div class="w3-modal-body">
      <style>
        .w3-row {
          margin-bottom: 10px;
        }

        .w3-row:after {
          content: "";
          display: table;
          clear: both;
        }

        .w3-modal-body {
          padding: 2px 16px;
        }

        label {
          display: inline-block;
          width: max-content;
          font-weight: bold;
        }

        input {
          width: 100px;
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

        .w3-table {
          border-collapse: collapse;
          border: 1px solid #ccc;
          border-spacing: 0;
          width: 100%;
          display: table;
        }

        .w3-table td,
        .w3-table th {
          padding: 4px 4px;
          display: table-cell;
          text-align: left;
          vertical-align: top;
          border: 1px solid #ccc;
          font-size: 12px;
        }

        .w3-table-input {
          border: none !important;
          outline: none !important;
          width: 100%;
          height: 100%;
        }
      </style>
      <div class="w3-row">
        <div style="width: 24%; float: left">
          <img id="facilityLogo" src="../../moduleResources/patientdashboard/gajangMedicalSocietyLogo.jpg"
            alt="Gajang Medical Society Logo" style="width: 50%" />
        </div>
        <div style="width: 50%; float: left; margin-top: 50px">
          <img id="dialysisFormHeadingLogo" src="../../moduleResources/patientdashboard/gadenDialysisFormHeading.jpg"
            alt="Gajang Medical Society Logo" style="width: 90%" />
          <h1 style="text-align: center; margin: 5 0">
            GAJANG MEDICAL SOCIETY
          </h1>
        </div>
        <div style="width: 24%; float: left">
          <img id="doctorLogo" src="../../moduleResources/patientdashboard/doctorLogo.jpg" alt="Doctor's Logo"
            style="width: 50%; float: right" />
        </div>
      </div>
      <p style="text-align: center; font-weight: bold">
        Lama Camp No. 1, P.O. Tibetan Colony - 581411, Mundgod Distt. Uttar
        Kanada (K.S) India
      </p>
      <br>
      <form id="haemodialysisForm" style="margin-top: 5px;">
        <input class="input-field" type="hidden" name="patientHaemodialysisFormId" id="id" value="">
        <div class="w3-row">
          <div style="float: left; width: 50%">
            <label for="created_date">Date:</label>
            <input type="text" readonly name="createdDate" id="created_date" class="w3-input input-field" />
          </div>
          <div style="float: left; width: 50%">
            <p style="margin: 0;"><b>Patient ID: </b>${identifier}</p>
          </div>
        </div>
        <div class="w3-row">
          <div style="float: left; width: 50%">
            <p style="margin: 0;"><b>Name: </b>${patientName}</p>
          </div>
          <div style="float: left; width: 50%">
            <label for="bicarbonate_acetate">Bicarbonate/ Acetate:</label>
            <input type="text" name="bicarbonateAcetate" id="bicarbonate_acetate" class="w3-input input-field" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 25%; float: left">
            <p style="margin: 0;"><b>Age: </b>${patientAge}</p>
          </div>
          <div style="width: 25%; float: left">
            <p><b>Sex: </b>${patientGender}</p>
          </div>
          <div style="width: 50%; float: left">
            <label for="new_reuse">New / Reuse:</label>
            <input type="text" name="newReuse" id="new_reuse" class="w3-input input-field" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 50%; float: left">
            <label for="per_acetic_acid_test">Per acetic Acid Test:</label>
            <input class="input-field" type="text" name="perAceticAcidTest" id="per_acetic_acid_test" />
          </div>
          <div style="width: 50%; float: left">
            <label for="dry_weight">Dry Weight:</label>
            <input class="input-field" type="text" name="dryWeight" id="dry_weight" />
          </div>
        </div>
        <h2 style="text-align: center">HAEMODIALYSIS RECORDS</h2>
        <div class="w3-row">
          <div style="width: 40%; float: left">
            <label for="pre_dialysis_weight">Pre-dialysis Weight:</label>
            <input class="input-field" type="text" name="preDialysisWeight" id="pre_dialysis_weight" />
          </div>
          <div style="width: 30%; float: left">
            <label for="dyspnoea">Dyspnoea:</label>
            <input class="input-field" type="text" name="dyspnoea" id="dyspnoea" />
          </div>
          <div style="width: 30%; float: left">
            <label for="fever">Fever:</label>
            <input class="input-field" type="text" name="fever" id="fever" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 40%; float: left">
            <label for="post_dialysis_weight">Post-dialysis Weight:</label>
            <input class="input-field" type="text" name="postDialysisWeight" id="post_dialysis_weight" />
          </div>
          <div style="width: 30%; float: left">
            <label for="bleeding">Bleeding:</label>
            <input class="input-field" type="text" name="bleeding" id="bleeding" />
          </div>
          <div style="width: 30%; float: left">
            <label for="flaps">Flaps:</label>
            <input class="input-field" type="text" name="flaps" id="flaps" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 40%; float: left">
            <label for="crepitation">Crepitation:</label>
            <input class="input-field" type="text" name="crepitation" id="crepitation" />
          </div>
          <div style="width: 30%; float: left">
            <label for="jvp">JVP:</label>
            <input class="input-field" type="text" name="jvp" id="jvp" />
          </div>
          <div style="width: 30%; float: left">
            <label for="pericarditis">Pericarditis:</label>
            <input class="input-field" type="text" name="pericarditis" id="pericarditis" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 70%; float: left">
            <label for="vomiting">Vomiting:</label>
            <input class="input-field" type="text" name="vomiting" id="vomiting" />
          </div>
          <div style="width: 30%; float: left">
            <label for="hiv">HIV:</label>
            <input class="input-field" type="text" name="hiv" id="hiv" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 40%; float: left">
            <label for="started_at">Started at:</label>
            <input class="input-field" type="text" name="startedAt" id="started_at" />
          </div>
          <div style="width: 30%; float: left">
            <label for="stoped_at">Stopped at:</label>
            <input class="input-field" type="text" name="stopedAt" id="stoped_at" />
          </div>
          <div style="width: 30%; float: left">
            <label for="hbsag">HBSAg:</label>
            <input class="input-field" type="text" name="hbsag" id="hbsag" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 40%; float: left">
            <label for="staff_name">Staff Name:</label>
            <input class="input-field" type="text" name="staffName" id="staff_name" />
          </div>
          <div style="width: 30%; float: left">
            <label for="staff_name_two">Staff Name:</label>
            <input class="input-field" type="text" name="staffNameTwo" id="staff_name_two" />
          </div>
          <div style="width: 30%; float: left">
            <label for="hcv">HCV:</label>
            <input class="input-field" type="text" name="hcv" id="hcv" />
          </div>
        </div>

        <div class="w3-overflow" style="width: 100%; margin: 5px 0px;">
          <table class="w3-table">
            <thead>
              <tr id="tableHeadingRow">
                <th>Time</th>
                <th>Enter values below</th>
              </tr>
            </thead>
            <tbody>
              <tr class="tableRowInput" id="bp">
                <td>BP</td>
                <td>
                  <input type="text" name="bpText" class="w3-table-input input-field" value="" />
                </td>
              </tr>
              <tr class="tableRowInput" id="pulse">
                <td>PULSE</td>
                <td>
                  <input type="text" name="pulseText" class="w3-table-input input-field" value="" />
                </td>
              </tr>
              <tr class="tableRowInput" id="tmp">
                <td>T.M.P</td>
                <td>
                  <input type="text" name="tmpText" class="w3-table-input input-field" value="" />
                </td>
              </tr>
              <tr class="tableRowInput" id="vp">
                <td>V.P</td>
                <td>
                  <input type="text" name="vpText" class="w3-table-input input-field" value="" />
                </td>
              </tr>
            </tbody>
          </table>
        </div>
        <div class="w3-row">
          <div>
            <label for="pre_hd_pulse">Pre HD Pulse:</label>
            <input class="input-field" type="text" name="preHdPulse" id="pre_hd_pulse" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 35%; float: left">
            <label for="vascular_access">Vascular Access:</label>
            <input class="input-field" type="text" name="vascularAccess" id="vascular_access" />
          </div>
          <div style="width: 20%; float: left">
            <label for="afv">AFV:</label>
            <input class="input-field" type="text" name="afv" id="afv" style="width: 50px" />
          </div>
          <div style="width: 25%; float: left">
            <label for="av_shunt">AV Shunt:</label>
            <input class="input-field" type="text" name="avShunt" id="av_shunt" style="width: 50px" />
          </div>
          <div style="width: 20%; float: left">
            <label for="ijv">IJV:</label>
            <input class="input-field" type="text" name="ijv" id="ijv" style="width: 50px" />
          </div>
        </div>
        <div class="w3-row">
          <div>
            <label for="subclavian_femoral_graft">Subclavian Femoral Graft:</label>
            <input class="input-field" type="text" name="subclavianFemoralGraft" id="subclavian_femoral_graft" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 50%; float: left;">
            <label for="dialysis_plan">Dialysis Plan:</label>
            <input class="input-field" type="text" name="dialysisPlan" id="dialysis_plan" />
          </div>
          <div style="width: 50%; float: left;">
            <label for="number_of_dialysis_used">No. of Dialysis Used:</label>
            <input class="input-field" type="text" name="numberOfDialysisUsed" id="number_of_dialysis_used" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 50%; float: left;">
            <label for="duration">Duration:</label>
            <input class="input-field" type="text" name="duration" id="duration" />
          </div>
          <div style="width: 50%; float: left;">
            <label for="number_of_tubings_used">No. of Tubings Used:</label>
            <input class="input-field" type="text" name="numberOfTubingsUsed" id="number_of_tubings_used" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 50%; float: left;">
            <label for="blood_flow_rate">Blood Flow Rate:</label>
            <input class="input-field" type="text" name="bloodFlowRate" id="blood_flow_rate" />
          </div>
          <div style="width: 50%; float: left;">
            <label for="uf">UF:</label>
            <input class="input-field" type="text" name="uf" id="uf" />
          </div>
        </div>
        <div class="w3-row">
          <div>
            <label for="injections">Injections:</label>
            <input class="input-field" type="text" name="injections" id="injections" />
          </div>
        </div>
        <div class="w3-row">
          <div>
            <label for="heparin_dose">Heparin Dose:</label>
            <input class="input-field" type="text" name="heparinDose" id="heparin_dose" />
          </div>
        </div>
        <div class="w3-row">
          <div style="width: 50%; float: left;">
            <label for="blood_transfusion">Blood Transfusion:</label>
            <input class="input-field" type="text" name="bloodTransfusion" id="blood_transfusion" />
          </div>
          <div style="width: 50%; float: left;">
            <label for="post_dialysis_bp">Post dialysis BP:</label>
            <input class="input-field" type="text" name="postDialysisBp" id="post_dialysis_bp" />
          </div>
        </div>
        <div class="w3-row">
          <div>
            <label for="note">Note:</label>
            <input class="input-field" type="text" name="note" id="note" />
          </div>
        </div>
        <div class="w3-row">
          <div style="float: right;">
            <label for="next_dialysis_date">Next Dialysis Date:</label>
            <input class="input-field" type="text" name="nextDialysisDate" id="next_dialysis_date" />
          </div>
        </div>
      </form>
    </div>
  </div>
</div>

<script>
  jQuery(document).ready(() => {

    let patientHaemodialysisFormsList = []

    jQuery(() => {
      jQuery("#next_dialysis_date").datepicker({ minDate: 0 });
      jQuery('input#created_date').val(new Date().toLocaleDateString())
      jQuery('input#next_dialysis_date').val(new Date().toLocaleDateString())
    });

    jQuery('#newFormBtn').click((e) => {
      e.preventDefault()
      deleteColumns()
      jQuery('input.input-field').val("")
      jQuery('input#created_date').val(new Date().toLocaleDateString())
      jQuery('input#next_dialysis_date').val(new Date().toLocaleDateString())
      jQuery('#saveFormBtn').css('display', 'inline-block')
      jQuery('#selectFormDate').css('display', 'none')
      jQuery('#printFormBtn').css('display', 'none')
      jQuery('#viewFormsBtn').css('display', 'inline-block')
    })

    jQuery('#viewFormsBtn').click((e) => {
      jQuery.get('getHaemodialysisForms.htm?patientId=${patientId}', (data) => {
        if (data.length <= 0) {
          alert('No previous forms details available.')
          return
        }
        patientHaemodialysisFormsList = data
        let options = '<option value="" selected>Select a date</option>'
        patientHaemodialysisFormsList.forEach(element => {
          options += '<option value="' + element.id + '">' + new Date(element.created_date).toDateString() + '</option>'
        });
        jQuery('#selectFormDate').html(options)
        // jQuery('#saveFormBtn').css('display', 'none')
        jQuery('#selectFormDate').css('display', 'inline-block')
        jQuery('#printFormBtn').css('display', 'inline-block')
        jQuery('#viewFormBtn').css('display', 'none')
      })
    })

    jQuery('#selectFormDate').change((e) => {
      let id = jQuery('#selectFormDate').val()

      patientHaemodialysisFormsList.forEach(element => {
        if (element.id == id) {
          for (const key in element) {
            if (element.hasOwnProperty(key)) {
              if (key == 'created_date' || key == 'next_dialysis_date') {
                jQuery('#' + key).val(new Date(element[key]).toLocaleDateString())
              } else {
                jQuery('#' + key).val(element[key])
              }
            }
          }
        }
      })

      jQuery.get('getHaemodialysisFormDetails.htm?formId=' + id, (data) => {
        createColumns(data)
      })
    })

    function createColumns(haemodialysisFormDetailsList) {
      deleteColumns()
      haemodialysisFormDetailsList.forEach(element => {
        for (const key in element) {
          if (element.hasOwnProperty(key)) {
            if (key !== "createdDate") {
              jQuery("#" + key)
                .find("td:last")
                .before("<td>" + element[key] + "</td>");
            } else {
              jQuery("#tableHeadingRow")
                .find("th:last")
                .before(
                  "<th>" + getTime(new Date(element[key])) + "</th>"
                );
            }
          }
        }
      })
    }

    function deleteColumns() {
      table = jQuery('table.w3-table')
      rows = table[0].rows

      for (let i = 0; i < rows.length; i++) {
        while (rows[i].cells.length > 2) {
          rows[i].cells[1].remove()
        }
      }
    }

    function checkTime(i) {
      return (i < 10) ? "0" + i : i;
    }

    function getTime(date) {
      var h = checkTime(date.getHours()),
        m = checkTime(date.getMinutes()),
        s = checkTime(date.getSeconds());

      return h + ":" + m + ":" + s
    }

    let w3_modal = document.getElementById("w3-modal");
    jQuery(window).click((e) => {
      if (e.target == w3_modal) {
        w3_modal.style.display = "none";
      }
    });

    jQuery("#closeModal").click(() => {
      w3_modal.style.display = "none";
    });

    jQuery("#printFormBtn").click((e) => {
      e.preventDefault();
      jQuery("tr.tableRowInput").find("td:last").css("display", "none");
      jQuery("tr#tableHeadingRow").find("th:last").css("display", "none");
      jQuery("input.input-field").css("border", "none")
      jQuery(".w3-modal-body").printArea({
        mode: "popup",
        popClose: true,
      });
      w3_modal.style.display = "none";
      jQuery("tr#tableHeadingRow").find("th:last").css("display", "table-cell");
      jQuery("tr.tableRowInput").find("td:last").css("display", "table-cell");
      jQuery("input.input-field").css("border", "1px solid cadetblue")
    });

    jQuery("#openForm").click((e) => {
      e.preventDefault();
      jQuery("#w3-modal").css("display", "block");
    });

    jQuery("#saveFormBtn").click((e) => {
      e.preventDefault();

      let formData = jQuery("#haemodialysisForm").serializeArray();
      let emptyForm = true;

      for (let index = 0; index < formData.length; index++) {
        const element = formData[index];
        if (element.value !== "") {
          emptyForm = false;
          break;
        }
      }

      if (emptyForm) {
        alert("Please fill in the form");
        return;
      }

      let formData1 = jQuery("#haemodialysisForm").serialize();
      jQuery.post(
        "haemodialysisForm.htm?patientId=${patientId}",
        formData1,
        (data) => {
          alert("Form saved successfully!")
          patientHaemodialysisFormsList = data;
          jQuery("input.w3-table-input").val("");
          jQuery.get('getHaemodialysisFormDetails.htm?formId=' + patientHaemodialysisFormsList.id, (data) => {
            createColumns(data)
          })
        }
      );
    });
  });
</script>