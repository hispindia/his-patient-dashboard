package org.openmrs.module.patientdashboard.impl;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.openmrs.api.db.DAOException;
import org.openmrs.api.impl.BaseOpenmrsService;
import org.openmrs.module.patientdashboard.OPDFormsService;
import org.openmrs.module.patientdashboard.db.OPDFormsDAO;
import org.openmrs.module.patientdashboard.model.PatientDialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientDialysisSummaryForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;

public class OPDFormsServiceImpl extends BaseOpenmrsService implements OPDFormsService {

    public OPDFormsServiceImpl() {
    }

    protected OPDFormsDAO dao;

    public void setDao(OPDFormsDAO dao) {
        this.dao = dao;
    }

    @Override
    public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail) {
        return dao.savePatientHepatitisBDetail(PatientHepatitisBDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException {
        return dao.getPatientHepatitisBDetails(patientId);
    }

    @Override
    public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail) {
        return dao.savePatientReferralDetail(patientReferralDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException {
        return dao.getPatientReferralDetails(patientId);
    }

    @Override
    public PatientDialysisFormDetail savePatientDialysisFormDetail(
            PatientDialysisFormDetail patientDialysisFormDetail) {
        return dao.savePatientDialysisFormDetail(patientDialysisFormDetail);
    }

    public List<Map<String, Object>> getPatientDialysisFormDetails(Integer patientId) throws ParseException {
        return dao.getPatientDialysisFormDetails(patientId);
    }

    @Override
    public PatientHaemodialysisForm savePatientHeamodialysisForm(PatientHaemodialysisForm patientHaemodialysisForm) {
        return dao.savePatientHeamodialysisForm(patientHaemodialysisForm);
    }

    @Override
    public PatientHaemodialysisForm getPatientHaemodialysisFormById(Integer id) throws DAOException {
        return dao.getPatientHaemodialysisFormById(id);
    }

    @Override
    public List<Map<String, Object>> getPatientHaemodialysisForms(Integer patientId) throws ParseException {
        return dao.getPatientHaemodialysisForms(patientId);
    }

    @Override
    public PatientHaemodialysisFormDetail savePatientHaemodialysisFormDetail(
            PatientHaemodialysisFormDetail patientHaemodialysisFormDetail) {
        return dao.savePatientHaemodialysisFormDetail(patientHaemodialysisFormDetail);
    }

    @Override
    public List<Map<String, Object>> getPatientHaemodialysisFormDetails(Integer patientHaemodialysisFormId)
            throws ParseException {
        return dao.getPatientHaemodialysisFormDetails(patientHaemodialysisFormId);
    }

    @Override
    public PatientDialysisSummaryForm savePatientDialysisSummaryForm(
            PatientDialysisSummaryForm patientDialysisSummaryForm) {
        return dao.savePatientDialysisSummaryForm(patientDialysisSummaryForm);
    }

    @Override
    public List<Map<String, Object>> getPatientDialysisSummaryForms(Integer patientId) throws ParseException {
        return dao.getPatientDialysisSummaryForms(patientId);
    }

}
