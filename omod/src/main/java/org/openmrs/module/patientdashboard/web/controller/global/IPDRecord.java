package org.openmrs.module.patientdashboard.web.controller.global;

import java.util.Date;

public class IPDRecord {
	
	private static final String HOSPITAL_NAME = "Hospital";

	private String hospitalName = HOSPITAL_NAME;
	private Date admissionDate;
	private Date dischargeDate;
	private String diagnosis;
	private String procedures;
	private String admissionOutcome;
	private String dischargeSummaryLink;

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public Date getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(Date admissionDate) {
		this.admissionDate = admissionDate;
	}

	public Date getDischargeDate() {
		return dischargeDate;
	}

	public void setDischargeDate(Date dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public String getDiagnosis() {
		return diagnosis;
	}

	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}

	public String getProcedures() {
		return procedures;
	}

	public void setProcedures(String procedures) {
		this.procedures = procedures;
	}

	public String getAdmissionOutcome() {
		return admissionOutcome;
	}

	public void setAdmissionOutcome(String admissionOutcome) {
		this.admissionOutcome = admissionOutcome;
	}

	public String getDischargeSummaryLink() {
		return dischargeSummaryLink;
	}

	public void setDischargeSummaryLink(String dischargeSummaryLink) {
		this.dischargeSummaryLink = dischargeSummaryLink;
	}

}
