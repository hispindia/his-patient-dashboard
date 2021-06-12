package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.Patient;

public class PatientDialysisSummaryForm implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Patient patient;
    private String bloodGroup;
    private String diagnosis;
    private String vascularAccess;
    private String dryWeightHd;
    private String frequencyHoursHd;
    private String bloodFlowRate;
    private String heparin;
    private String complicationHd;
    private String hbvVaccination;
    private Date hdStartDate;
    private String latestInvestigation;
    private String medications;
    private Date createdDate;

    /**
     * @return Integer return the id
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return Patient return the patient
     */
    public Patient getPatient() {
        return patient;
    }

    /**
     * @param patient the patient to set
     */
    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    /**
     * @return String return the bloodGroup
     */
    public String getBloodGroup() {
        return bloodGroup;
    }

    /**
     * @param bloodGroup the bloodGroup to set
     */
    public void setBloodGroup(String bloodGroup) {
        this.bloodGroup = bloodGroup;
    }

    /**
     * @return String return the diagnosis
     */
    public String getDiagnosis() {
        return diagnosis;
    }

    /**
     * @param diagnosis the diagnosis to set
     */
    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    /**
     * @return String return the vascularAccess
     */
    public String getVascularAccess() {
        return vascularAccess;
    }

    /**
     * @param vascularAccess the vascularAccess to set
     */
    public void setVascularAccess(String vascularAccess) {
        this.vascularAccess = vascularAccess;
    }

    /**
     * @return String return the dryWeightHd
     */
    public String getDryWeightHd() {
        return dryWeightHd;
    }

    /**
     * @param dryWeightHd the dryWeightHd to set
     */
    public void setDryWeightHd(String dryWeightHd) {
        this.dryWeightHd = dryWeightHd;
    }

    /**
     * @return String return the frequencyHoursHd
     */
    public String getFrequencyHoursHd() {
        return frequencyHoursHd;
    }

    /**
     * @param frequencyHoursHd the frequencyHoursHd to set
     */
    public void setFrequencyHoursHd(String frequencyHoursHd) {
        this.frequencyHoursHd = frequencyHoursHd;
    }

    /**
     * @return String return the bloodFlowRate
     */
    public String getBloodFlowRate() {
        return bloodFlowRate;
    }

    /**
     * @param bloodFlowRate the bloodFlowRate to set
     */
    public void setBloodFlowRate(String bloodFlowRate) {
        this.bloodFlowRate = bloodFlowRate;
    }

    /**
     * @return String return the heparin
     */
    public String getHeparin() {
        return heparin;
    }

    /**
     * @param heparin the heparin to set
     */
    public void setHeparin(String heparin) {
        this.heparin = heparin;
    }

    /**
     * @return String return the complicationHd
     */
    public String getComplicationHd() {
        return complicationHd;
    }

    /**
     * @param complicationHd the complicationHd to set
     */
    public void setComplicationHd(String complicationHd) {
        this.complicationHd = complicationHd;
    }

    /**
     * @return String return the hbvVaccination
     */
    public String getHbvVaccination() {
        return hbvVaccination;
    }

    /**
     * @param hbvVaccination the hbvVaccination to set
     */
    public void setHbvVaccination(String hbvVaccination) {
        this.hbvVaccination = hbvVaccination;
    }

    /**
     * @return String return the hdStartDate
     */
    public Date getHdStartDate() {
        return hdStartDate;
    }

    /**
     * @param hdStartDate the hdStartDate to set
     */
    public void setHdStartDate(Date hdStartDate) {
        this.hdStartDate = hdStartDate;
    }

    /**
     * @return String return the latestInvestigation
     */
    public String getLatestInvestigation() {
        return latestInvestigation;
    }

    /**
     * @param latestInvestigation the latestInvestigation to set
     */
    public void setLatestInvestigation(String latestInvestigation) {
        this.latestInvestigation = latestInvestigation;
    }

    /**
     * @return String return the medications
     */
    public String getMedications() {
        return medications;
    }

    /**
     * @param medications the medications to set
     */
    public void setMedications(String medications) {
        this.medications = medications;
    }

    /**
     * @return Date return the createdDate
     */
    public Date getCreatedDate() {
        return createdDate;
    }

    /**
     * @param createdDate the createdDate to set
     */
    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

}
