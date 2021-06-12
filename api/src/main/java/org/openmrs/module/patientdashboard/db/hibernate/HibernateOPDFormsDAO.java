package org.openmrs.module.patientdashboard.db.hibernate;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.openmrs.api.db.DAOException;
import org.openmrs.module.patientdashboard.DatabaseConnector;
import org.openmrs.module.patientdashboard.db.OPDFormsDAO;
import org.openmrs.module.patientdashboard.model.PatientDialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientDialysisSummaryForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisForm;
import org.openmrs.module.patientdashboard.model.PatientHaemodialysisFormDetail;
import org.openmrs.module.patientdashboard.model.PatientHepatitisBDetail;
import org.openmrs.module.patientdashboard.model.PatientReferralDetail;
import org.springframework.jdbc.core.JdbcTemplate;

public class HibernateOPDFormsDAO implements OPDFormsDAO {

	private SessionFactory sessionFactory;

	private DatabaseConnector databaseConnector = new DatabaseConnector();
	private DataSource dataSource = databaseConnector.dataSource();

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	@Override
	public PatientHepatitisBDetail savePatientHepatitisBDetail(PatientHepatitisBDetail PatientHepatitisBDetail) {
		return (PatientHepatitisBDetail) sessionFactory.getCurrentSession().merge(PatientHepatitisBDetail);
	}

	@Override
	public List<Map<String, Object>> getPatientHepatitisBDetails(Integer patientId) throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select afp, alu, cirrhosis, clinical_notes_medication, complications, cr, concat('', created_date) as createdDate, family_hcc, fibroscan, concat('', followup_date) as followupDate, hbeag, hbv_dna, high_hbv_dna, `others`, concat('', rx_date) as rxDate, rx_others, usg_liver, years_of_diagnosis from patient_hepatitis_b_details where patient_id = "
				+ patientId + " order by id desc";
		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public PatientReferralDetail savePatientReferralDetail(PatientReferralDetail patientReferralDetail) {
		return (PatientReferralDetail) sessionFactory.getCurrentSession().merge(patientReferralDetail);
	}

	@Override
	public List<Map<String, Object>> getPatientReferralDetails(Integer patientId) throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select referral_id, refer_to, symptoms, investigations, diagnosis, treatment_given, concat('', created_date) as createdDate, past_history, reason_for_referral from patient_referral_details where patient_id = "
				+ patientId + " order by referral_id desc";
		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public PatientDialysisFormDetail savePatientDialysisFormDetail(
			PatientDialysisFormDetail patientDialysisFormDetail) {
		return (PatientDialysisFormDetail) sessionFactory.getCurrentSession().merge(patientDialysisFormDetail);
	}

	@Override
	public List<Map<String, Object>> getPatientDialysisFormDetails(Integer patientId) throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select bun_pre_dialysis as bunPre, bun_post_dialysis as bunPost, urr, serum_creatinine as serumCreatinine, hemoglobin, potassium, calcium, phosphorus, albumin, fbs, rbs, iron, tibc, saturation, ferritin, hbs_antibody as hbsAntibody, hbs_ag as hbsAg, hcv, hiv, sodium, s_billi as sBilli, sgpt, alk_phos as alkPhos, uric_acid as uricAcid, concat('', created_date) as createdDate from patient_dialysis_form_details where patient_id = "
				+ patientId + " order by id asc";
		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public PatientHaemodialysisForm savePatientHeamodialysisForm(PatientHaemodialysisForm patientHaemodialysisForm) {
		sessionFactory.getCurrentSession().saveOrUpdate(patientHaemodialysisForm);
		return patientHaemodialysisForm;
	}

	@Override
	public PatientHaemodialysisForm getPatientHaemodialysisFormById(Integer id) throws DAOException {
		return (PatientHaemodialysisForm) sessionFactory.getCurrentSession().get(PatientHaemodialysisForm.class, id);
	}

	@Override
	public List<Map<String, Object>> getPatientHaemodialysisForms(Integer patientId) throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select * from patient_haemodialysis_form where patient_id = " + patientId;

		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public PatientHaemodialysisFormDetail savePatientHaemodialysisFormDetail(
			PatientHaemodialysisFormDetail patientHaemodialysisFormDetail) {
		return (PatientHaemodialysisFormDetail) sessionFactory.getCurrentSession()
				.merge(patientHaemodialysisFormDetail);
	}

	@Override
	public List<Map<String, Object>> getPatientHaemodialysisFormDetails(Integer patientHaemodialysisFormId)
			throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select bp, pulse, tmp, vp, created_date as createdDate from patient_haemodialysis_form_details where patient_haemodialysis_form_id = "
				+ patientHaemodialysisFormId;

		return jdbcTemplate.queryForList(sql);
	}

	@Override
	public PatientDialysisSummaryForm savePatientDialysisSummaryForm(
			PatientDialysisSummaryForm patientDialysisSummaryForm) {
		sessionFactory.getCurrentSession().saveOrUpdate(patientDialysisSummaryForm);
		return patientDialysisSummaryForm;
	}

	@Override
	public List<Map<String, Object>> getPatientDialysisSummaryForms(Integer patientId) throws ParseException {
		JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSource);

		String sql = "select * from patient_dialysis_summary_form where patient_id = "
				+ patientId;

		return jdbcTemplate.queryForList(sql);
	}
}
