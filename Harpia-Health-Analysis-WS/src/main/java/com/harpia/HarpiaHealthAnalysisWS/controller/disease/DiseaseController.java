package com.harpia.HarpiaHealthAnalysisWS.controller.disease;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseService;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.DoctorController;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.PatientController;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Diabetic;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@RestController
@RequestMapping("/diseases")
@CrossOrigin(
        origins = "http://localhost:8080"
)
public class DiseaseController {
    private static final Logger log = LoggerFactory.getLogger(DiseaseController.class);

    @Autowired
    private DiseaseService service;
    @Autowired
    private PatientController patCont;

    @Autowired
    private DoctorController hcpCont;

    @PostMapping
    ResponseEntity<List<Patient>> saveFakeDiabeticPatients() {
        List<Patient> patientList = new ArrayList<>();

        Random random = new Random();
        for (int i = 1; i <= 10; i++) {
            Disease diseaseResult = null;
            Doctor hcp = new Doctor();
            hcp.setName("hcp" + i);
            hcp.setLastname("hcp" + i);
            hcp.setUsername("hcp" + i);
            hcp.setPassword("hcp");
            hcpCont.saveHealthcarePersonnel(hcp);
            Diabetic diabetic = new Diabetic();
//            diabetic.setPatient(patient);
            diabetic.setBloodPressure(random.nextInt(10));
            diabetic.setBloodSugar(random.nextInt(10));
            diabetic.setCholesterol(random.nextInt(10));
            List<Disease> diseaseList = new ArrayList<>();
            diseaseList.add(diabetic);


            Patient p1 = new Patient();
            p1.setName("patien" + i);
            p1.setLastname("patt" + i);
            p1.setUsername("aes" + i);
            p1.setPassword("aes");
            p1.setDoctorId(hcp.getId());
//            p1.setDiseasesList(diseaseList);
            patCont.savePatient(p1);
            service.save(diabetic);

//            htpCont.saveHealthcarePersonnel(hcp);


//            patient = patCont.findById(i).getData();
//            patient.setHealthcarePersonnel(hcp);
//            System.out.println("Patient  " + patient);
//            Diabetic diabetic = new Diabetic();
//            diabetic.setPatient(patient);
//            diabetic.setBloodPressure(random.nextInt(10));
//            diabetic.setBloodSugar(random.nextInt(10));
//            diabetic.setCholesterol(random.nextInt(10));
//            List<Disease> diseaseList= new ArrayList<>();
//            patient.setDiseasesList(diseaseList);
//            l2.add(diabetic);
//            patient.setDiseasesList(l2);
//            diseaseResult = service.save(diabetic);
            System.out.println("AFTER SAVE diseaseResult : " + diseaseResult);
//            }
            patientList.add(p1);
//            diseaseList.add(diseaseResult);
        }
        return ResponseEntity.status(HttpStatus.CREATED).body(patientList);
    }

/*    private List<UserRole> getFakeDiabeticPatients() {
        List<UserRole> list = new ArrayList<>();
        list.add(new UserRole(1, EnumUserRole.ADMIN.getName()));
        list.add(new UserRole(2, EnumUserRole.HEALTHCARE_PERSONAL.getName()));
        list.add(new UserRole(3, EnumUserRole.PATIENT.getName()));
        return list;
    }*/


}
