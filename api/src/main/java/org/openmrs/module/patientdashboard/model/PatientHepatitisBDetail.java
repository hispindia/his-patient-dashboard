package org.openmrs.module.patientdashboard.model;

import java.io.Serializable;
import java.util.Date;

import org.openmrs.Patient;

public class PatientHepatitisBDetail implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer id;
    private Patient patient;
    private String alu;
    private String hbvDna;
    private String hbeag;
    private String usgLiver;
    private String fibroscan;
    private String afp;
    private String cr;
    private String others;
    private Date followupDate;
    private Date createdDate;
    private Date rxDate;
    private String cirrhosis;
    private String highHbvDna;
    private String familyHcc;
    private String rxOthers;
    private String yearsOfDiagnosis;
    private String complications;
    private String clinicalNotesMedication;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Patient getPatient() {
        return patient;
    }

    public void setPatient(Patient patient) {
        this.patient = patient;
    }

    public String getAlu() {
        return alu;
    }

    public void setAlu(String alu) {
        this.alu = alu;
    }

    public String getHbvDna() {
        return hbvDna;
    }

    public void setHbvDna(String hbvDna) {
        this.hbvDna = hbvDna;
    }

    public String getHbeag() {
        return hbeag;
    }

    public void setHbeag(String hbeag) {
        this.hbeag = hbeag;
    }

    public String getUsgLiver() {
        return usgLiver;
    }

    public void setUsgLiver(String usgLiver) {
        this.usgLiver = usgLiver;
    }

    public String getFibroscan() {
        return fibroscan;
    }

    public void setFibroscan(String fibroscan) {
        this.fibroscan = fibroscan;
    }

    public String getAfp() {
        return afp;
    }

    public void setAfp(String afp) {
        this.afp = afp;
    }

    public String getCr() {
        return cr;
    }

    public void setCr(String cr) {
        this.cr = cr;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }

    public Date getFollowupDate() {
        return followupDate;
    }

    public void setFollowupDate(Date followupDate) {
        this.followupDate = followupDate;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getRxDate() {
        return rxDate;
    }

    public void setRxDate(Date rxDate) {
        this.rxDate = rxDate;
    }

    public String getCirrhosis() {
        return cirrhosis;
    }

    public void setCirrhosis(String cirrhosis) {
        this.cirrhosis = cirrhosis;
    }

    public String getHighHbvDna() {
        return highHbvDna;
    }

    public void setHighHbvDna(String highHbvDna) {
        this.highHbvDna = highHbvDna;
    }

    public String getFamilyHcc() {
        return familyHcc;
    }

    public void setFamilyHcc(String familyHcc) {
        this.familyHcc = familyHcc;
    }

    public String getRxOthers() {
        return rxOthers;
    }

    public void setRxOthers(String rxOthers) {
        this.rxOthers = rxOthers;
    }

    public String getYearsOfDiagnosis() {
        return yearsOfDiagnosis;
    }

    public void setYearsOfDiagnosis(String yearsOfDiagnosis) {
        this.yearsOfDiagnosis = yearsOfDiagnosis;
    }

    public String getComplications() {
        return complications;
    }

    public void setComplications(String complications) {
        this.complications = complications;
    }

    public String getClinicalNotesMedication() {
        return clinicalNotesMedication;
    }

    public void setClinicalNotesMedication(String clinicalNotesMedication) {
        this.clinicalNotesMedication = clinicalNotesMedication;
    }
}