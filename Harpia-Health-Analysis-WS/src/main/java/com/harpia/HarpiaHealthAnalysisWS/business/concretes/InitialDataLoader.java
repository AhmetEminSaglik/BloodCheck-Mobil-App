package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.disease.DiseaseService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Diabetic;
import com.harpia.HarpiaHealthAnalysisWS.model.disease.Disease;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumDiseaseType;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Component
public class InitialDataLoader implements CommandLineRunner {
    @Override
    public void run(String... args) throws Exception {
        saveInitilizateData();
    }

    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService roleService;
    @Autowired
    private DiseaseService diseaseService;
    private static final Logger log = LoggerFactory.getLogger(InitialDataLoader.class);

    private Random random = new Random();

    public void saveInitilizateData() {
        saveUserRoleData();
        saveUserData(getAdminList());
//         rest is the fake data
        saveUserData(getDoctorList());
        saveUserData(getPatientList());
        saveDiseaseData();
    }


    private void saveUserRoleData() {
        List<UserRole> list = roleService.saveAll(getStandartUserRoleList());
        list.forEach(System.out::println);
    }

    private void saveDiseaseData() {
        List<Disease> list = getDiseaseList();
        list = diseaseService.saveAll(list);
        list.forEach(System.out::println);
    }

    private boolean isUserRegistered(String username) {
        User user = userService.findByUsername(username);
        if (user == null)
            return false;
        return true;

    }

    private void saveUserData(List<User> list) {
        for (int i = 0; i < list.size(); i++) {
            String username = list.get(i).getUsername();
            if (isUserRegistered(username)) {
                System.out.println(list.get(i).getClass().getSimpleName() + " -----> data is already registered.");
            } else {
                User user = userService.save(list.get(i));
                System.out.println(user);
            }
        }
    }

    private List<UserRole> getStandartUserRoleList() {
        List<UserRole> list = new ArrayList<>();
        list.add(new UserRole(1, EnumUserRole.ADMIN.getName()));
        list.add(new UserRole(2, EnumUserRole.DOCTOR.getName()));
        list.add(new UserRole(3, EnumUserRole.PATIENT.getName()));
        return list;
    }

    private List<User> getAdminList() {
        List<User> list = new ArrayList<>();
        User admin = new Admin();
        admin.setName("Bulut");
        admin.setLastname("AKAY");
        admin.setUsername("bulut");
        admin.setPassword("akay");
        admin.setRoleId(EnumUserRole.ADMIN.getId());
        list.add(admin);

        admin = new Admin();
        admin.setName("Ahmet Emin");
        admin.setLastname("SAGLIK");
        admin.setUsername("aes");
        admin.setPassword("aes");
        admin.setRoleId(EnumUserRole.ADMIN.getId());
        list.add(admin);
        return list;
    }

    private List<User> getDoctorList() {
        List<User> list = new ArrayList<>();
        for (int i = 1; i <= 5; i++) {
            Doctor user = new Doctor();
            user.setName("doctor Name" + i);
            user.setLastname("doctor Lastname" + i);
            user.setUsername("doc" + i);
            user.setPassword("doc" + i);
            user.setRoleId(EnumUserRole.DOCTOR.getId());
            list.add(user);
        }
        return list;
    }

    private List<User> getPatientList() {
        List<User> list = new ArrayList<>();
        for (int i = 1; i < 40; i++) {
            Patient user = new Patient();
            user.setName("Patient Name" + i);
            user.setLastname("Patient Lastname" + i);
            user.setUsername("pat" + i);
            user.setPassword("pat" + i);
            int doctor_id = random.nextInt(5) + 3;
            Doctor personnel = (Doctor) userService.findById(doctor_id);
//            user.setHealthcarePersonnel(personnel);
            user.setDoctorId(personnel.getId());
            user.setRoleId(EnumUserRole.PATIENT.getId());
            list.add(user);
        }
        return list;
    }

    private List<Disease> getDiseaseList() {
        List<Disease> list = new ArrayList<>();
        for (int i = 1; i < 50; i++) {
            Diabetic diabetic = new Diabetic();
            diabetic.setBloodPressure(random.nextInt(200) + 50);
            diabetic.setCholesterol(random.nextInt(200) + 50);
            diabetic.setBloodSugar(random.nextInt(200) + 50);

            int patient_id = random.nextInt(39) + 8;
            Patient patient = (Patient) userService.findById(patient_id);
            diabetic.setPatientId(patient.getId());
            diabetic.setDiseaseTypeId(EnumDiseaseType.DIABETIC.getId());
            list.add(diabetic);
        }
        return list;
    }


}
