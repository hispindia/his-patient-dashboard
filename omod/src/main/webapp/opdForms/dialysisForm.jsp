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

                .w3-table {
                    border-collapse: collapse;
                    border: 1px solid #ccc;
                    border-spacing: 0;
                    width: 100%;
                    display: table
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
            <div class="w3-row" style="margin: 5px 2px;">
                <p style="text-align: center;"><b>PATIENT NAME:</b> <span
                        style="padding-right: 10px;">${patientName}</span><b>AGE:</b> <span
                        style="padding-right: 10px;">${patientAge}</span><b>SEX:</b> <span>${patientGender}</span>
                </p>
            </div>
            <div class="w3-overflow" style="width: 100%;">
                <form id="dialysisForm">
                    <table class="w3-table">
                        <thead>
                            <tr id="tableHeadingRow">
                                <th>Sr. No.</th>
                                <th>Dates</th>
                                <th>Enter values below</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="tableRowInput" id="bunPre">
                                <td>1</td>
                                <td>BUN-Pre Dialysis (mg / dl)</td>
                                <td><input type="text" name="bunPreText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="bunPost">
                                <td>2</td>
                                <td>BUN-Post Dialysis (mg / dl)</td>
                                <td><input type="text" name="bunPostText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="urr">
                                <td>3</td>
                                <td>URR%</td>
                                <td><input type="text" name="urrText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="serumCreatinine">
                                <td>4</td>
                                <td>Serum Creatinine (mg / dl)</td>
                                <td><input type="text" name="serumCreatinineText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="hemoglobin">
                                <td>5</td>
                                <td>Hemoglobin %</td>
                                <td><input type="text" name="hemoglobinText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="potassium">
                                <td>6</td>
                                <td>Potassium(meg/l)</td>
                                <td><input type="text" name="potassiumText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="calcium">
                                <td>7</td>
                                <td>Calcium (mg / dl)</td>
                                <td><input type="text" name="calciumText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="phosphorus">
                                <td>8</td>
                                <td>Phosphorus (mg / dl)</td>
                                <td><input type="text" name="phosphorusText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="albumin">
                                <td>9</td>
                                <td>Albumin / S. Proteins</td>
                                <td><input type="text" name="albuminText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="fbs">
                                <td>10</td>
                                <td>FBS</td>
                                <td><input type="text" name="fbsText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="rbs">
                                <td>11</td>
                                <td>RBS</td>
                                <td><input type="text" name="rbsText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="iron">
                                <td>12</td>
                                <td>Iron</td>
                                <td><input type="text" name="ironText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="tibc">
                                <td>13</td>
                                <td>TIBC</td>
                                <td><input type="text" name="tibcText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="saturation">
                                <td>14</td>
                                <td>% Saturation</td>
                                <td><input type="text" name="saturationText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="ferritin">
                                <td>15</td>
                                <td>Ferritin</td>
                                <td><input type="text" name="ferritinText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="hbsAntibody">
                                <td>16</td>
                                <td>HBS Antibody</td>
                                <td><input type="text" name="hbsAntibodyText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="hbsAg">
                                <td>17</td>
                                <td>HBS Ag</td>
                                <td><input type="text" name="hbsAgText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="hcv">
                                <td>18</td>
                                <td>HCV</td>
                                <td><input type="text" name="hcvText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="hiv">
                                <td>19</td>
                                <td>HIV</td>
                                <td><input type="text" name="hivText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="sodium">
                                <td>20</td>
                                <td>Sodium</td>
                                <td><input type="text" name="sodiumText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="sBilli">
                                <td>21</td>
                                <td>S. Billi</td>
                                <td><input type="text" name="sBilliText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="sgpt">
                                <td>22</td>
                                <td>SGPT / SGOT</td>
                                <td><input type="text" name="sgptText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="alkPhos">
                                <td>23</td>
                                <td>Alk. Phos</td>
                                <td><input type="text" name="alkPhosText" class="w3-table-input" value=""></td>
                            </tr>
                            <tr class="tableRowInput" id="uricAcid">
                                <td>24</td>
                                <td>Uric Acid</td>
                                <td><input type="text" name="uricAcidText" class="w3-table-input" value=""></td>
                            </tr>
                        </tbody>
                    </table>
                </form>
            </div>


        </div>
        <div class="w3-modal-footer">
            <button id="printHepatitisDetailBtn" class="w3-button">Print</button>
            <button id="saveDialysisFormBtn" class="w3-button">Save</button>
            <button id="cancelHepatitisDetailBtn" class="w3-button">Cancel</button>
            <div style="float: right; margin-right: 16px;">
                <button id="previousPageBtn" class="w3-button">Previous</button>
                <button id="nextPageBtn" class="w3-button" style="display: none;">Next</button>
                <span id="pageNumberStatus" style="color: red;"></span>
            </div>

        </div>
    </div>
</div>

<script>
    jQuery(document).ready(() => {

        patientDialysisFormDetails = ${ patientDialysisFormDetails }
        limit = 10
        pageCount = Math.ceil(patientDialysisFormDetails.length / limit)
        totalPages = pageCount ? pageCount : 1
        pageNumber = totalPages

        if (totalPages === 1) {
            jQuery('#previousPageBtn').css('display', 'none')
        }

        jQuery('#pageNumberStatus').html('Page ' + pageNumber + ' of ' + totalPages)

        createColumns(pageNumber)

        function createColumns(pageNumber) {
            for (let index = (pageNumber - 1) * limit; index < pageNumber * limit; index++) {
                if (index < patientDialysisFormDetails.length) {
                    const element = patientDialysisFormDetails[index];
                    for (const key in element) {
                        if (element.hasOwnProperty(key)) {
                            if (key !== "createdDate") {
                                jQuery('#' + key).find('td:last').before("<td>" + element[key] + "</td>")
                            } else {
                                jQuery('#tableHeadingRow').find('th:last').before("<th>" + new Date(element[key]).toDateString() + "</th>")
                            }
                        }
                    }
                } else {
                    break;
                }
            }
        }

        function changePage(pageNumber) {
            table = jQuery('table.w3-table')
            rows = table[0].rows

            for (let i = 0; i < rows.length; i++) {
                while (rows[i].cells.length > 3) {
                    rows[i].cells[2].remove()
                }
            }
            createColumns(pageNumber)
            jQuery('#pageNumberStatus').html('Page ' + pageNumber + ' of ' + totalPages)
        }

        jQuery('#nextPageBtn').click((e) => {
            e.preventDefault()
            if (pageNumber < totalPages) {
                pageNumber += 1
                changePage(pageNumber)
                jQuery('#previousPageBtn').css('display', 'inline-block')
            }

            if (pageNumber === totalPages) {
                jQuery('#nextPageBtn').css('display', 'none')
            }

        })

        jQuery('#previousPageBtn').click((e) => {
            e.preventDefault()
            if (pageNumber > 1) {
                pageNumber -= 1
                changePage(pageNumber)
                jQuery('#nextPageBtn').css('display', 'inline-block')
            }

            if (pageNumber === 1) {
                jQuery('#previousPageBtn').css('display', 'none')
            }
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
            jQuery("tr.tableRowInput").find("td:last").css("display", 'none')
            jQuery("tr#tableHeadingRow").find("th:last").css("display", 'none')
            jQuery('.w3-modal-body').printArea({
                mode: "popup",
                popClose: true
            });
            w3_modal.style.display = 'none'
            jQuery("tr#tableHeadingRow").find("th:last").css("display", 'table-cell')
            jQuery("tr.tableRowInput").find("td:last").css("display", 'table-cell')
        })

        jQuery('#viewMedicalCertificateBtn').click((e) => {
            e.preventDefault();
            jQuery('#w3-modal').css('display', 'block')
            // jQuery('#doctorLogo').attr('src', '../../moduleResources/patientdashboard/doctorLogo.jpg')
            // jQuery('#dialysisFormHeadingLogo').attr('src', '../../moduleResources/patientdashboard/gadenDialysisFormHeading.jpg')
            // jQuery('#facilityLogo').attr('src', '../../moduleResources/patientdashboard/gajangMedicalSocietyLogo.jpg')
        })

        jQuery('#saveDialysisFormBtn').click((e) => {
            e.preventDefault()

            let formData = jQuery('#dialysisForm').serializeArray()
            let emptyForm = true

            for (let index = 0; index < formData.length; index++) {
                const element = formData[index];
                if (element.value !== "") {
                    emptyForm = false
                    break
                }
            }

            if (emptyForm) {
                alert('Please fill in the form')
                return
            }

            let formData1 = jQuery('#dialysisForm').serialize()
            jQuery.post('dialysisForm.htm?patientId=${patientId}', formData1, (data) => {
                patientDialysisFormDetails = data
                totalPages = Math.ceil(patientDialysisFormDetails.length / limit)
                pageNumber = totalPages

                changePage(pageNumber)

                jQuery('#nextPageBtn').css('display', 'none')

                if (pageNumber > 1) {
                    jQuery('#previousPageBtn').css('display', 'inline-block')
                }

                jQuery('input.w3-table-input').val("")
            })
        })
    })
</script>