package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.DiabeticService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.diabetic.Diabetic;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumDiabeticType;
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
    static String[] maleName = {"James", "Robert", "John", "Michael", "David", "William", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua"};
    static String[] femaleName = {"Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen", "Lisa", "Nancy", "Betty", "Margaret", "Sandra", "Ashley", "Kimberly", "Emily", "Donna", "Michelle", "Carol", "Amanda"};
    static int doctorIdStartingIndex = 2;
    static int totalDoctorNumber = 3;
    static int totalPatientNumber = 10;
    static int totalDiseaeNumber = 50;

    @Override
    public void run(String... args) throws Exception {
        saveInitilizateData();
    }

    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService roleService;
    @Autowired
    private DiabeticService diabeticService;
    private static final Logger log = LoggerFactory.getLogger(InitialDataLoader.class);

    private static Random random = new Random();

    public void saveInitilizateData() {
        saveDiabeticTypeData();
        saveUserRoleData();
        saveUserData(getAdminList());
//         rest is the fake data
        saveUserData(getDoctorList());
        saveUserData(getPatientList());
//        saveDiseaseData();
    }

    private void saveDiabeticTypeData() {
        List<Diabetic> list=getDiabeticTypeList();
        list.forEach(e -> diabeticService.save(e));
    }

    private void saveUserRoleData() {
        List<UserRole> list = roleService.saveAll(getStandartUserRoleList());
        list.forEach(System.out::println);
    }

 /*   private void saveDiseaseData() {
        List<Disease> list = getDiseaseList();
        list = diseaseService.saveAll(list);
        list.forEach(System.out::println);
    }*/

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
    private List<Diabetic> getDiabeticTypeList() {
        List<Diabetic> list = new ArrayList<>();
        list.add(new Diabetic(1, EnumDiabeticType.TIP_1.getName()));
        list.add(new Diabetic(2, EnumDiabeticType.TIP_2.getName()));
        list.add(new Diabetic(3, EnumDiabeticType.HIPOGLISEMI.getName()));
        list.add(new Diabetic(4, EnumDiabeticType.HIPERGLISEMI.getName()));
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
        admin.setPassword("pass");
        admin.setRoleId(EnumUserRole.ADMIN.getId());
        list.add(admin);
        return list;
    }

    private static String getName(int i) {
        return i % 2 == 0 ? maleName[random.nextInt(maleName.length)] : femaleName[random.nextInt(femaleName.length)];
    }

    private List<User> getDoctorList() {
        List<User> list = new ArrayList<>();
        for (int i = 1; i <= totalDoctorNumber; i++) {
            Doctor user = new Doctor();
            user.setName(getName(i));
            user.setLastname(getName(i));
            user.setUsername("doc" + i);
            user.setPassword("pass");
            user.setRoleId(EnumUserRole.DOCTOR.getId());
            list.add(user);
        }
        return list;
    }

    private List<User> getPatientList() {
        List<User> list = new ArrayList<>();
        for (int i = 1; i <= 10; i++) {
            Patient user = new Patient();
            user.setName(getName(i));
            user.setLastname(getName(i));
            user.setUsername("pat" + i);
            user.setPassword("pass");
//            user.setDiseaseTypeId(EnumDiabeticType.DIABETIC.getId());
            user.setDiabeticTypeId((i % 4 + 1));
            int doctor_id = random.nextInt(totalDoctorNumber - 1) + doctorIdStartingIndex + 1;
            Doctor personnel = (Doctor) userService.findById(doctor_id);
//            user.setHealthcarePersonnel(personnel);
            user.setDoctorId(personnel.getId());
            user.setRoleId(EnumUserRole.PATIENT.getId());
            list.add(user);
        }
        return list;
    }
/*

    private List<Disease> getDiseaseList() {
        List<Disease> list = new ArrayList<>();
        for (int i = 1; i <= 100; i++) {
            Diabetic diabetic = new Diabetic();
            diabetic.setBloodPressure(random.nextInt(200) + 50);
            diabetic.setCholesterol(random.nextInt(200) + 50);
            diabetic.setBloodSugar(random.nextInt(200) + 50);

            int patient_id = random.nextInt(totalPatientNumber - 1) + 2 + totalDoctorNumber + 1; // admin + doctor  +1=  patient starting index
            Patient patient = (Patient) userService.findById(patient_id);
            diabetic.setPatientId(patient.getId());
            diabetic.setDiseaseTypeId(EnumDiabeticType.DIABETIC.getId());
            list.add(diabetic);
        }
        return list;
    }
*/


}
