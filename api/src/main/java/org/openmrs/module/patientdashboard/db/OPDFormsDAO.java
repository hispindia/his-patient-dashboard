package org.openmrs.module.patientdashboard.db;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.openmrs.api.db.DAOException;
import org.openmrs.module.patientdashboard.model.PatientDialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientDialysisSummaryForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisForm;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;

public interface OPDFormsDAO {

	/**
	 * Save patient hepatitis-B details
	 * 
	 * @param PatientHepatitisBDetail
	 * @return
	 */
	public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail);

	/**
	 * Get list of patient hepatitis-B details
	 * 
	 * @param patient
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException;

	/**
	 * Save patient referral detail
	 * 
	 * @param patientReferralDetail
	 * @return
	 */
	public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail);

	/**
	 * Get list of patient referral details
	 * 
	 * @param patientId
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException;

	/**
	 * Save patient dialysis form detail
	 * 
	 * @param patientDialysisFormDetail
	 * @return
	 */
	public PatientDialysisFormDetail savePatientDialysisFormDetail(PatientDialysisFormDetail patientDialysisFormDetail);

	/**
	 * Get list of patient dialysis forms details
	 * 
	 * @param patientId
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientDialysisFormDetails(Integer patientId) throws ParseException;

	/**
	 * Save patient heamodialysis form
	 * 
	 * @param patientHeamodialysisForm
	 * @return
	 */
	public PatientHaemodialysisForm savePatientHeamodialysisForm(PatientHaemodialysisForm patientHaemodialysisForm);

	public PatientHaemodialysisForm getPatientHaemodialysisFormById(Integer id) throws DAOException;

	/**
	 * Get list of patient dialysis forms details
	 * 
	 * @param patientId
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientHaemodialysisForms(Integer patientId) throws ParseException;

	/**
	 * 
	 * @param patientHaemodialysisFormDetail
	 * @return
	 */
	public PatientHaemodialysisFormDetail savePatientHaemodialysisFormDetail(
			PatientHaemodialysisFormDetail patientHaemodialysisFormDetail);

	/**
	 * 
	 * @param patientHaemodialysisFormId
	 * @return
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientHaemodialysisFormDetails(Integer patientHaemodialysisFormId)
			throws ParseException;

	/**
	 * Save patient dialysis summary form
	 * 
	 * @param patientDialysisSummaryForm
	 * @return
	 */
	public PatientDialysisSummaryForm savePatientDialysisSummaryForm(
			PatientDialysisSummaryForm patientDialysisSummaryForm);

	/**
	 * 
	 * @param id
	 * @return List of dialysis forms
	 * @throws ParseException
	 */
	public List<Map<String, Object>> getPatientDialysisSummaryForms(Integer patientId) throws ParseException;

}
