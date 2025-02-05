package com.ahmeteminsaglik.ws.business.concretes;

import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthorityService;
import com.ahmeteminsaglik.ws.business.abstracts.bloodresult.BloodResultService;
import com.ahmeteminsaglik.ws.business.abstracts.diabetic.DiabeticService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.notification.FcmService;
import com.ahmeteminsaglik.ws.business.abstracts.firebase.token.FcmTokenService;
import com.ahmeteminsaglik.ws.business.abstracts.timer.PatientTimerService;
import com.ahmeteminsaglik.ws.business.abstracts.user.DoctorService;
import com.ahmeteminsaglik.ws.business.abstracts.user.PatientService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.controller.bloodresult.BloodResultController;
import com.ahmeteminsaglik.ws.controller.timer.PatientTimerController;
import com.ahmeteminsaglik.ws.controller.user.PatientController;
import com.ahmeteminsaglik.ws.model.bloodresult.BloodResult;
import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.enums.EnumDiabeticType;
import com.ahmeteminsaglik.ws.model.timer.PatientTimer;
import com.ahmeteminsaglik.ws.model.users.Admin;
import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.model.users.role.Authority;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.CustomUTCTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

@Component
public class InitialData {
    static String[] maleName = {"James", "Robert", "John", "Michael", "David", "William", "Richard", "Joseph", "Thomas", "Charles", "Christopher", "Daniel", "Matthew", "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua"};
    static String[] femaleName = {"Mary", "Patricia", "Jennifer", "Linda", "Elizabeth", "Barbara", "Susan", "Jessica", "Sarah", "Karen", "Lisa", "Nancy", "Betty", "Margaret", "Sandra", "Ashley", "Kimberly", "Emily", "Donna", "Michelle", "Carol", "Amanda"};
    static int doctorIdStartingIndex = 1;
    static int totalDoctorNumber = 5;
    private static final CustomLog log = new CustomLog(InitialDataLoader.class);
    private static final Random random = new Random();
    //    @Autowired
    private final BloodResultService bloodResultService;
    //    @Autowired
    private final PatientController patientController;
    //    @Autowired
    private final UserService userService;
    //    @Autowired
    private final PatientService patientService;
    //    @Autowired
    private final DoctorService doctorService;
    //    @Autowired
    private final AuthorityService roleService;
    //    @Autowired
    private final DiabeticService diabeticService;
    //    @Autowired
    private final PatientTimerController timerController;
    //    @Autowired
    private final PatientTimerService timerService;
    //    @Autowired
    private final FcmTokenService fcmTokenService;
    //    @Autowired
    private final FcmService fcmService;
    //    @Autowired
    private final BloodResultController bloodResultController;
    private final PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
    @Autowired
    public InitialData(BloodResultService bloodResultService, PatientController patientController, UserService userService, PatientService patientService, DoctorService doctorService, AuthorityService roleService, DiabeticService diabeticService, PatientTimerController timerController, PatientTimerService timerService, FcmTokenService fcmTokenService, FcmService fcmService, BloodResultController bloodResultController) {
        this.bloodResultService = bloodResultService;
        this.patientController = patientController;
        this.userService = userService;
        this.patientService = patientService;
        this.doctorService = doctorService;
        this.roleService = roleService;
        this.diabeticService = diabeticService;
        this.timerController = timerController;
        this.timerService = timerService;
        this.fcmTokenService = fcmTokenService;
        this.fcmService = fcmService;
        this.bloodResultController = bloodResultController;
    }

    private static String createName(int i) {
        return i % 2 == 0 ? maleName[random.nextInt(maleName.length)] : femaleName[random.nextInt(femaleName.length)];
    }

    void saveBloodResultDataForPatient(PatientTimer patientTimer, int maxMinutes) {
        int sensorTestTime = getTotalMinuteOfPatientTimer(patientTimer);
        int minutesCounter = 0;
        int createdTime = 0;
        List<BloodResult> bloodResults = new ArrayList<>();
        int maxBound = 81;
        int minBound = 20;
        while (createdTime < maxMinutes) {
            BloodResult bloodResult = new BloodResult(createdTime);
            bloodResult.setBloodPressure(random.nextInt(maxBound) + minBound);
            bloodResult.setBloodSugar(random.nextInt(maxBound) + minBound);
            bloodResult.setMagnesium(random.nextInt(maxBound) + minBound);
            bloodResult.setCalcium(random.nextInt(maxBound) + minBound);
            bloodResult.setPatientId(patientTimer.getPatientId());
            bloodResults.add(bloodResult);
            bloodResult.setCreatedAt(CustomUTCTime.getUTCTime().minusMinutes((long) minutesCounter * sensorTestTime));
            minutesCounter++;
            createdTime = sensorTestTime * minutesCounter;
        }

        Collections.reverse(bloodResults);
        bloodResultService.saveList(bloodResults);
    }

    public void saveInitializedData() {
        if (!isDataSavedBefore()) {
            saveDiabeticTypeData();
            saveAuthorityData();
            saveUserData(getAdminList());
            saveUserData(getDoctorList());
            savePatient(getPatientList());
//            saveUserData(getPatientList());
            addAuthoritiesToUsers();
            savePatientTimer();

            List<Patient> patientList = patientController.getPatientList().getBody().getData();
            for (int i = 0; i < patientList.size(); i++) {
                Patient patient = patientList.get(i);
                PatientTimer patientTimer = timerService.findByPatientId(patient.getId());
                int totalMinute = getTotalMinuteOfPatientTimer(patientTimer);
                if (totalMinute <= 70) {
                    saveBloodResultDataForPatient(patientTimer, 60 * (25)); // 25 hours
                } else if (totalMinute <= 240) {
                    saveBloodResultDataForPatient(patientTimer, (60 * 24) * 8); // 8 days
                } else {
                    saveBloodResultDataForPatient(patientTimer, (60 * 24) * 33); // 33 days
                }
            }

        }
//        new FakeSensors(bloodResultController, fcmTokenService, fcmService).runFakeSensors(timerController.findAllPatientTimers().getBody().getData(), bloodResultService);
    }

    private int getTotalMinuteOfPatientTimer(PatientTimer patientTimer) {
        return patientTimer.getHours() * 60 + patientTimer.getMinutes();
    }

    boolean isDataSavedBefore() {
        List<BloodResult> retrievedBloodResultList = bloodResultService.findAll();
        return retrievedBloodResultList.size() > 1;
    }

    private void savePatientTimer() {
        List<Patient> patientList = patientController.getPatientList().getBody().getData();
        List<PatientTimer> patientTimerList = new ArrayList<>();

        /*
        1-10 --> --> 36 hours
        11-30--> --> 8 days
        31-60  --> --> 31 days
        120- 240--> --> 31 days
         */
        for (int i = 0; i < patientList.size(); i++) {
            Patient tmp = patientList.get(i);
            PatientTimer patientTimer = new PatientTimer();
            patientTimer.setPatientId(tmp.getId());
            int minute;
            int hour = 0;
            if (i % 4 == 0) {
                minute = random.nextInt(20) + 11;
            } else if (i % 4 == 1) {
                hour = 1;
                minute = random.nextInt(20) + 11;
            } else if (i % 4 == 2) {
                hour = random.nextInt(2) + 3;
                minute = random.nextInt(30) + 1;
            } else {
                hour = random.nextInt(3) + 6;
                minute = random.nextInt(30) + 1;
            }
            patientTimer.setMinutes(minute);
            patientTimer.setHours(hour);
            patientTimerList.add(patientTimer);
        }

        for (PatientTimer e : patientTimerList) {
            timerService.update(e);
        }
    }

    private void saveDiabeticTypeData() {
        List<Diabetic> list = getDiabeticTypeList();
        list.forEach(e -> diabeticService.save(e));
    }

    private void saveAuthorityData() {
//        List<Authority> list = roleService.saveAll();
//        list.forEach(System.out::println);
        getStandartAuthorityList().forEach(e -> roleService.save(e));
    }

    private boolean isUserRegistered(String username) {
        User user = userService.findByUsername(username);
        return user != null;
    }

    private void saveUserData(List<User> list) {
        for (int i = 0; i < list.size(); i++) {
            String username = list.get(i).getUsername();
            if (isUserRegistered(username)) {
                log.info(username + " data is already registered.");
            } else {
                User user = userService.save(list.get(i));
                System.out.println(user);
            }
        }
    }

    private void savePatient(List<Patient> list) {
        for (int i = 0; i < list.size(); i++) {
            String username = list.get(i).getUsername();
            if (isUserRegistered(username)) {
                log.info(username + " data is already registered.");
            } else {
//                Patient patient = (Patient) patientController.savePatient(list.get(i)).getBody().getData();// userService.save(list.get(i));
                Patient patient = (Patient) patientController.savePatient(list.get(i)).getBody().getData();// userService.save(list.get(i));
//                Patient patient = (Patient) userService.save(list.get(i))
                // userService.save(list.get(i));
                log.info("Created Patient : " + patient);
            }
        }
    }

    private void addAuthoritiesToUsers() {
        Authority patientAuth = roleService.findByAuthority(EnumAuthority.ROLE_PATIENT);
        Authority doctorAuth = roleService.findByAuthority(EnumAuthority.ROLE_DOCTOR);
        Authority adminAuth = roleService.findByAuthority(EnumAuthority.ROLE_ADMIN);

        User adminuser = userService.findById(1);
        adminuser.addAuthority(patientAuth);
        adminuser.addAuthority(doctorAuth);
        adminuser.addAuthority(adminAuth);
        userService.save(adminuser);

        List<Patient> patientList = patientService.findAll();
        for (int i = 0; i < patientList.size(); i++) {
            Patient patient = patientList.get(i);
            patient.addAuthority(patientAuth);
            userService.save(patient);
        }

        List<Doctor> doctorList = doctorService.findAll();
        for (int i = 0; i < doctorList.size(); i++) {
            Doctor doctor = doctorList.get(i);
            doctor.addAuthority(patientAuth);
            doctor.addAuthority(doctorAuth);
            userService.save(doctor);
        }
    }

    private List<Authority> getStandartAuthorityList() {
        List<Authority> list = new ArrayList<>();
        list.add(new Authority(1, EnumAuthority.ROLE_ADMIN));
        list.add(new Authority(2, EnumAuthority.ROLE_DOCTOR));
        list.add(new Authority(3, EnumAuthority.ROLE_PATIENT));
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
        admin.setName("Ahmet Emin");
        admin.setLastname("SAGLIK");
        admin.setUsername("AES");
        admin.setPassword(getPassword());
        admin.setRoleId(EnumAuthority.ROLE_ADMIN.getId());
        list.add(admin);

        return list;
    }

    private List<User> getDoctorList() {
        List<User> list = new ArrayList<>();
        for (int i = 1; i <= totalDoctorNumber; i++) {
            Doctor user = new Doctor();
            user.setName(createName(i));
            user.setLastname(createName(i));
            user.setUsername("doctor" + i);
            user.setPassword(getPassword());

            if (i < 3) {
                user.setGraduate("Karadeniz Teknik University");
            } else {
                user.setGraduate("Marmara University ");
            }
            if (i % 2 == 0) {
                user.setSpecialization("Internal Medicine");
            } else {
                user.setSpecialization("Endocrinology");
            }
            user.setRoleId(EnumAuthority.ROLE_DOCTOR.getId());
            list.add(user);
        }
        return list;
    }

    private List<Patient> getPatientList() {
        List<Patient> list = new ArrayList<>();
        for (int i = 1; i <= 20; i++) {
            Patient user = new Patient();
            user.setName(createName(i));
            user.setLastname(createName(i));
            user.setUsername("patient" + i);
//            user.setPassword(getPassword());
            user.setPassword("pass");
            user.setDiabeticTypeId((i % 4 + 1));
            int doctor_id = (i - 1) / 4 + doctorIdStartingIndex + 1;
            Doctor personnel = (Doctor) userService.findById(doctor_id);
            user.setDoctorId(personnel.getId());
            user.setRoleId(EnumAuthority.ROLE_PATIENT.getId());
            list.add(user);
        }
        return list;
    }

    private String getPassword() {
        return "{bcrypt}" + passwordEncoder.encode("pass");
    }
}
