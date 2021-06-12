package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.Patient;

public class PatientHaemodialysisForm implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Patient patient;
    private String bicarbonateAcetate;
    private String newReuse;
    private String perAceticAcidTest;
    private String dryWeight;
    private String preDialysisWeight;
    private String postDialysisWeight;
    private String crepitation;
    private String vomiting;
    private String startedAt;
    private String staffName;
    private String dyspnoea;
    private String bleeding;
    private String jvp;
    private String stoppedAt;
    private String staffNameTwo;
    private String fever;
    private String flaps;
    private String pericarditis;
    private String hiv;
    private String hbsag;
    private String hcv;
    private String preHdPulse;
    private String vascularAccess;
    private String afv;
    private String avShunt;
    private String ijv;
    private String subclavianFemoralGraft;
    private String dialysisPlan;
    private String numberOfDialysisUsed;
    private String duration;
    private String numberOfTubingsUsed;
    private String bloodFlowRate;
    private String uf;
    private String injections;
    private String heparinDose;
    private String bloodTransfusion;
    private String postDialysisBp;
    private String note;
    private Date nextDialysisDate;
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
     * @return String return the bicarbonateAcetate
     */
    public String getBicarbonateAcetate() {
        return bicarbonateAcetate;
    }

    /**
     * @param bicarbonateAcetate the bicarbonateAcetate to set
     */
    public void setBicarbonateAcetate(String bicarbonateAcetate) {
        this.bicarbonateAcetate = bicarbonateAcetate;
    }

    /**
     * @return String return the newReuse
     */
    public String getNewReuse() {
        return newReuse;
    }

    /**
     * @param newReuse the newReuse to set
     */
    public void setNewReuse(String newReuse) {
        this.newReuse = newReuse;
    }

    /**
     * @return String return the perAceticAcidTest
     */
    public String getPerAceticAcidTest() {
        return perAceticAcidTest;
    }

    /**
     * @param perAceticAcidTest the perAceticAcidTest to set
     */
    public void setPerAceticAcidTest(String perAceticAcidTest) {
        this.perAceticAcidTest = perAceticAcidTest;
    }

    /**
     * @return String return the dryWeight
     */
    public String getDryWeight() {
        return dryWeight;
    }

    /**
     * @param dryWeight the dryWeight to set
     */
    public void setDryWeight(String dryWeight) {
        this.dryWeight = dryWeight;
    }

    /**
     * @return String return the preDialysisWeight
     */
    public String getPreDialysisWeight() {
        return preDialysisWeight;
    }

    /**
     * @param preDialysisWeight the preDialysisWeight to set
     */
    public void setPreDialysisWeight(String preDialysisWeight) {
        this.preDialysisWeight = preDialysisWeight;
    }

    /**
     * @return String return the postDialysisWeight
     */
    public String getPostDialysisWeight() {
        return postDialysisWeight;
    }

    /**
     * @param postDialysisWeight the postDialysisWeight to set
     */
    public void setPostDialysisWeight(String postDialysisWeight) {
        this.postDialysisWeight = postDialysisWeight;
    }

    /**
     * @return String return the crepitation
     */
    public String getCrepitation() {
        return crepitation;
    }

    /**
     * @param crepitation the crepitation to set
     */
    public void setCrepitation(String crepitation) {
        this.crepitation = crepitation;
    }

    /**
     * @return String return the vomiting
     */
    public String getVomiting() {
        return vomiting;
    }

    /**
     * @param vomiting the vomiting to set
     */
    public void setVomiting(String vomiting) {
        this.vomiting = vomiting;
    }

    /**
     * @return String return the startedAt
     */
    public String getStartedAt() {
        return startedAt;
    }

    /**
     * @param startedAt the startedAt to set
     */
    public void setStartedAt(String startedAt) {
        this.startedAt = startedAt;
    }

    /**
     * @return String return the staffName
     */
    public String getStaffName() {
        return staffName;
    }

    /**
     * @param staffName the staffName to set
     */
    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    /**
     * @return String return the dyspnoea
     */
    public String getDyspnoea() {
        return dyspnoea;
    }

    /**
     * @param dyspnoea the dyspnoea to set
     */
    public void setDyspnoea(String dyspnoea) {
        this.dyspnoea = dyspnoea;
    }

    /**
     * @return String return the bleeding
     */
    public String getBleeding() {
        return bleeding;
    }

    /**
     * @param bleeding the bleeding to set
     */
    public void setBleeding(String bleeding) {
        this.bleeding = bleeding;
    }

    /**
     * @return String return the jvp
     */
    public String getJvp() {
        return jvp;
    }

    /**
     * @param jvp the jvp to set
     */
    public void setJvp(String jvp) {
        this.jvp = jvp;
    }

    /**
     * @return String return the stoppedAt
     */
    public String getStoppedAt() {
        return stoppedAt;
    }

    /**
     * @param stoppedAt the stoppedAt to set
     */
    public void setStoppedAt(String stoppedAt) {
        this.stoppedAt = stoppedAt;
    }

    /**
     * @return String return the staffNameTwo
     */
    public String getStaffNameTwo() {
        return staffNameTwo;
    }

    /**
     * @param staffNameTwo the staffNameTwo to set
     */
    public void setStaffNameTwo(String staffNameTwo) {
        this.staffNameTwo = staffNameTwo;
    }

    /**
     * @return String return the fever
     */
    public String getFever() {
        return fever;
    }

    /**
     * @param fever the fever to set
     */
    public void setFever(String fever) {
        this.fever = fever;
    }

    /**
     * @return String return the flaps
     */
    public String getFlaps() {
        return flaps;
    }

    /**
     * @param flaps the flaps to set
     */
    public void setFlaps(String flaps) {
        this.flaps = flaps;
    }

    /**
     * @return String return the pericarditis
     */
    public String getPericarditis() {
        return pericarditis;
    }

    /**
     * @param pericarditis the pericarditis to set
     */
    public void setPericarditis(String pericarditis) {
        this.pericarditis = pericarditis;
    }

    /**
     * @return String return the hiv
     */
    public String getHiv() {
        return hiv;
    }

    /**
     * @param hiv the hiv to set
     */
    public void setHiv(String hiv) {
        this.hiv = hiv;
    }

    /**
     * @return String return the hbsag
     */
    public String getHbsag() {
        return hbsag;
    }

    /**
     * @param hbsag the hbsag to set
     */
    public void setHbsag(String hbsag) {
        this.hbsag = hbsag;
    }

    /**
     * @return String return the hcv
     */
    public String getHcv() {
        return hcv;
    }

    /**
     * @param hcv the hcv to set
     */
    public void setHcv(String hcv) {
        this.hcv = hcv;
    }

    /**
     * @return String return the preHdPulse
     */
    public String getPreHdPulse() {
        return preHdPulse;
    }

    /**
     * @param preHdPulse the preHdPulse to set
     */
    public void setPreHdPulse(String preHdPulse) {
        this.preHdPulse = preHdPulse;
    }

    /**
     * @return String return the vascularAccess
     */
    public String getvascularAccess() {
        return vascularAccess;
    }

    /**
     * @param vascularAccess the vascularAccess to set
     */
    public void setvascularAccess(String vascularAccess) {
        this.vascularAccess = vascularAccess;
    }

    /**
     * @return String return the afv
     */
    public String getAfv() {
        return afv;
    }

    /**
     * @param afv the afv to set
     */
    public void setAfv(String afv) {
        this.afv = afv;
    }

    /**
     * @return String return the avShunt
     */
    public String getAvShunt() {
        return avShunt;
    }

    /**
     * @param avShunt the avShunt to set
     */
    public void setAvShunt(String avShunt) {
        this.avShunt = avShunt;
    }

    /**
     * @return String return the ijv
     */
    public String getIjv() {
        return ijv;
    }

    /**
     * @param ijv the ijv to set
     */
    public void setIjv(String ijv) {
        this.ijv = ijv;
    }

    /**
     * @return String return the subclavianFemoralGraft
     */
    public String getSubclavianFemoralGraft() {
        return subclavianFemoralGraft;
    }

    /**
     * @param subclavianFemoralGraft the subclavianFemoralGraft to set
     */
    public void setSubclavianFemoralGraft(String subclavianFemoralGraft) {
        this.subclavianFemoralGraft = subclavianFemoralGraft;
    }

    /**
     * @return String return the dialysisPlan
     */
    public String getDialysisPlan() {
        return dialysisPlan;
    }

    /**
     * @param dialysisPlan the dialysisPlan to set
     */
    public void setDialysisPlan(String dialysisPlan) {
        this.dialysisPlan = dialysisPlan;
    }

    /**
     * @return String return the numberOfDialysisUsed
     */
    public String getNumberOfDialysisUsed() {
        return numberOfDialysisUsed;
    }

    /**
     * @param numberOfDialysisUsed the numberOfDialysisUsed to set
     */
    public void setNumberOfDialysisUsed(String numberOfDialysisUsed) {
        this.numberOfDialysisUsed = numberOfDialysisUsed;
    }

    /**
     * @return String return the duration
     */
    public String getDuration() {
        return duration;
    }

    /**
     * @param duration the duration to set
     */
    public void setDuration(String duration) {
        this.duration = duration;
    }

    /**
     * @return String return the numberOfTubingsUsed
     */
    public String getNumberOfTubingsUsed() {
        return numberOfTubingsUsed;
    }

    /**
     * @param numberOfTubingsUsed the numberOfTubingsUsed to set
     */
    public void setNumberOfTubingsUsed(String numberOfTubingsUsed) {
        this.numberOfTubingsUsed = numberOfTubingsUsed;
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
     * @return String return the uf
     */
    public String getUf() {
        return uf;
    }

    /**
     * @param uf the uf to set
     */
    public void setUf(String uf) {
        this.uf = uf;
    }

    /**
     * @return String return the injections
     */
    public String getInjections() {
        return injections;
    }

    /**
     * @param injections the injections to set
     */
    public void setInjections(String injections) {
        this.injections = injections;
    }

    /**
     * @return String return the heparinDose
     */
    public String getHeparinDose() {
        return heparinDose;
    }

    /**
     * @param heparinDose the heparinDose to set
     */
    public void setHeparinDose(String heparinDose) {
        this.heparinDose = heparinDose;
    }

    /**
     * @return String return the bloodTransfusion
     */
    public String getBloodTransfusion() {
        return bloodTransfusion;
    }

    /**
     * @param bloodTransfusion the bloodTransfusion to set
     */
    public void setBloodTransfusion(String bloodTransfusion) {
        this.bloodTransfusion = bloodTransfusion;
    }

    /**
     * @return String return the postDialysisBp
     */
    public String getPostDialysisBp() {
        return postDialysisBp;
    }

    /**
     * @param postDialysisBp the postDialysisBp to set
     */
    public void setPostDialysisBp(String postDialysisBp) {
        this.postDialysisBp = postDialysisBp;
    }

    /**
     * @return String return the note
     */
    public String getNote() {
        return note;
    }

    /**
     * @param note the note to set
     */
    public void setNote(String note) {
        this.note = note;
    }

    /**
     * @return Date return the nextDialysisDate
     */
    public Date getNextDialysisDate() {
        return nextDialysisDate;
    }

    /**
     * @param nextDialysisDate the nextDialysisDate to set
     */
    public void setNextDialysisDate(Date nextDialysisDate) {
        this.nextDialysisDate = nextDialysisDate;
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
