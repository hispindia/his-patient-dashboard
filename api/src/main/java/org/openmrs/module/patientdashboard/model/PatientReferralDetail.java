package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.Patient;

public class PatientReferralDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer referralId;
    private Patient patient;
    private String referTo;
    private String symptoms;
    private String investigations;
    private String diagnosis;
    private String treatmentGiven;
    private String pastHistory;
    private String ReasonForReferral;
    private Date createdDate;

    public Integer getReferralId() {
        return referralId;
    }

    public void setReferralId(Integer referralId) {
        this.referralId = referralId;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getReferTo() {
        return referTo;
    }

    public void setReferTo(String referTo) {
        this.referTo = referTo;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getInvestigations() {
        return investigations;
    }

    public void setInvestigations(String investigations) {
        this.investigations = investigations;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTreatmentGiven() {
        return treatmentGiven;
    }

    public void setTreatmentGiven(String treatmentGiven) {
        this.treatmentGiven = treatmentGiven;
    }

    public String getPastHistory() {
        return pastHistory;
    }

    public void setPastHistory(String pastHistory) {
        this.pastHistory = pastHistory;
    }

    public String getReasonForReferral() {
        return ReasonForReferral;
    }

    public void setReasonForReferral(String reasonForReferral) {
        ReasonForReferral = reasonForReferral;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}