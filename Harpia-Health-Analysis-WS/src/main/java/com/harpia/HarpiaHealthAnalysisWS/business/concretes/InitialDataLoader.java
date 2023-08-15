package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.DiabeticService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.controller.timer.PatientTimerController;
import com.harpia.HarpiaHealthAnalysisWS.controller.user.PatientController;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.diabetic.Diabetic;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumDiabeticType;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Doctor;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Patient;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
import com.harpia.HarpiaHealthAnalysisWS.utility.LogUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Component
public class InitialDataLoader implements CommandLineRunner {
    static String[] maleName = {"James", "Robert", "John", "Michael", "David", "William", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua"};
    static String[] femaleName = {"Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen", "Lisa", "Nancy", "Betty", "Margaret", "Sandra", "Ashley", "Kimberly", "Emily", "Donna", "Michelle", "Carol", "Amanda"};
    static int doctorIdStartingIndex = 2;
    static int totalDoctorNumber = 3;

    @Override
    public void run(String... args) throws Exception {
        saveInitilizateData();
    }

    @Autowired
    BloodResultService bloodResultService;
    @Autowired
    private PatientController patientController;
    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService roleService;
    @Autowired
    private DiabeticService diabeticService;
    @Autowired
    private PatientTimerController timerController;
    private static final Logger log = LoggerFactory.getLogger(InitialDataLoader.class);

    private static Random random = new Random();

    public void saveInitilizateData() {
        saveDiabeticTypeData();
        saveUserRoleData();
        saveUserData(getAdminList());
//         rest is the fake data
        saveUserData(getDoctorList());
        saveUserData(getPatientList());
//        saveBloodResult();
        savePatientTimer();
        if (!isSavedBloodResultsBefore()) {
            List<Patient> patientList = patientController.getPatientList().getBody().getData();
            Patient patient_17_Days = patientList.get(patientList.size() - 1);
            Patient patient_PerMinute = patientList.get(patientList.size() - 2);
            saveBloodResult_17_Days_16_Hours(patient_17_Days);
            saveBloodResultPerMinute(patient_PerMinute);
        }
//        new FakeSensors().runFakeSensors(timerController.findAllPatientTimers().getBody().getData(), bloodResultService);
    }

    boolean isSavedBloodResultsBefore() {
        List<BloodResult> retrivedBloodResultList = bloodResultService.findAll();
        log.info(LogUtil.withPrefix("KAYITLI DATA : " + retrivedBloodResultList.size()));
        if (retrivedBloodResultList.size() > 300) {
            return true;
        }
        return false;
    }

    void saveBloodResultPerMinute(Patient patient) {
        PatientTimer patientTimer = timerController.findPatientTimerByPatientId(patient.getId()).getBody().getData();
        log.info(LogUtil.withPrefix(patientTimer.toString()));
        final int maxMinutes = (24 * 17 + 16) * 60;
        int minutesCounter = 0;
        int sensorTestTime = 5;
        int createdTime = 0;//useMinute * minutesCounter;
        List<BloodResult> bloodResultList = new ArrayList<>();
        while (createdTime < maxMinutes) {
            BloodResult bloodResult = new BloodResult(createdTime);
            bloodResult.setBloodPressure(random.nextInt(150) + 50);
            bloodResult.setBloodSugar(random.nextInt(150) + 50);
            bloodResult.setPatientId(patient.getId());
            bloodResultList.add(bloodResult);
            minutesCounter++;
            createdTime = sensorTestTime * minutesCounter;
        }

        Collections.reverse(bloodResultList);
        log.info(LogUtil.withPrefix("bloodResultList size: " + bloodResultList.size()));
        bloodResultService.saveList(bloodResultList);
    }


    void saveBloodResult_17_Days_16_Hours(Patient patient) {

//        int retrivedBloodResultData = retrivedBloodResultList.size();
//        List<Patient> patientList = patientController.getPatientList().getBody().getData();
//        Patient patient = patientList.get(patientList.size() - 1);
        PatientTimer patientTimer = timerController.findPatientTimerByPatientId(patient.getId()).getBody().getData();
        log.info(LogUtil.withPrefix(patientTimer.toString()));
        final int maxMinutes = (24 * 17 + 16) * 60;
        int minutesCounter = 0;
        int sensorTestTime = 60 + 17;
        int createdTime = 0;//useMinute * minutesCounter;
        List<BloodResult> bloodResultList = new ArrayList<>();
        while (createdTime < maxMinutes) {
            BloodResult bloodResult = new BloodResult(createdTime);
            bloodResult.setBloodPressure(random.nextInt(150) + 50);
            bloodResult.setBloodSugar(random.nextInt(150) + 50);
            bloodResult.setPatientId(patient.getId());
            bloodResultList.add(bloodResult);
            minutesCounter++;
            createdTime = sensorTestTime * minutesCounter;
        }

        Collections.reverse(bloodResultList);
        log.info(LogUtil.withPrefix("bloodResultList size: " + bloodResultList.size()));
        bloodResultService.saveList(bloodResultList);
    }

    private void savePatientTimer() {
        List<Patient> patientList = (List<Patient>) patientController.getPatientList().getBody().getData();
        List<PatientTimer> patientTimerList = new ArrayList<>();
        patientList.forEach(e -> {
            PatientTimer timer = new PatientTimer(0, random.nextInt(24), (random.nextInt(59) + 1), e.getId());
            patientTimerList.add(timer);
        });
        int firstPatientIndex = (patientTimerList.size() - 1);
        patientTimerList.set(firstPatientIndex, new PatientTimer(0, 1, 17, patientList.get(firstPatientIndex).getId()));
//        patientTimerList.set(0, new PatientTimer(0, 1, 17, patientList.get(0).getId()));
        System.out.println("-------------------------------- " + patientTimerList.get(0));
        System.out.println("-------------------------------- " + patientTimerList.get(patientTimerList.size() - 1));
        patientTimerList.forEach(e -> log.info(timerController.savePatientTimer(e).toString()));
    }

    private void saveBloodResult() {
        List<Patient> patientList = (List<Patient>) patientController.getPatientList().getBody().getData();
        for (int i = 0; i < patientList.size(); i++) {
            int bloodResultNumber = 50;//random.nextInt(70) + 30;
            List<BloodResult> bloodResultList = new ArrayList<>();
            for (int j = 0; j < bloodResultNumber; j++) {
                BloodResult bloodResult = new BloodResult(j * (i + 1) * 5);
                bloodResult.setBloodPressure(random.nextInt(100) + 50);
                bloodResult.setBloodSugar(random.nextInt(100) + 50);
                bloodResult.setPatientId(patientList.get(i).getId());
                bloodResultList.add(bloodResult);
            }
            bloodResultService.saveList(bloodResultList);
        }
    }

    private void saveDiabeticTypeData() {
        List<Diabetic> list = getDiabeticTypeList();
        list.forEach(e -> diabeticService.save(e));
    }

    private void saveUserRoleData() {
        List<UserRole> list = roleService.saveAll(getStandartUserRoleList());
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
            user.setDiabeticTypeId((i % 4 + 1));
            int doctor_id = random.nextInt(totalDoctorNumber - 1) + doctorIdStartingIndex + 1;
            Doctor personnel = (Doctor) userService.findById(doctor_id);
            user.setDoctorId(personnel.getId());
            user.setRoleId(EnumUserRole.PATIENT.getId());
            list.add(user);
        }
        return list;
    }

}
