package com.harpia.HarpiaHealthAnalysisWS.business;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;

import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

public class FakeSensors {
    ScheduledExecutorService executorService = Executors.newScheduledThreadPool(1);
    Random random = new Random();
    private static CustomLog log = new CustomLog(SignupUser.class);


//    @Autowired
//    PatientTimerService patientTimerService;
//    @Autowired
//    BloodResultService bloodResultService;

    public void runFakeSensors(List<PatientTimer> patientTimerList, BloodResultService bloodResultService) {
//        System.out.println("BLOOD RESULT SERVICE :" + bloodResultService);
//        System.out.println("PATITENT TIMER LIST SIZE :" + patientTimerList.size());
//        this.bloodResultService

        List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getBloodResultAndSaveToDB(e, bloodResultService));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {
            addRunnableToExecutorService(runableList.get(i), patientTimerList.get(i));
        }
//        bloodResultService=bloodResultService;
      /*  List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getRunnable(e));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {
            addRunnableToExecutorService(runableList.get(i), patientTimerList.get(i));
        }*/

    }
/*
    public static void main(String[] args) {
        List<PatientTimer> patientTimerList = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            patientTimerList.add(new PatientTimer(i+1, i));
        }
        List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e->{
            runableList.add(getRunnable(e));
        });
        for(int i=0;i<patientTimerList.size();i++){
            addRunnableToExecutorService(runableList.get(i),patientTimerList.get(i));
        }
//        executorService.scheduleAtFixedRate(runnable2, 0, 1, TimeUnit.SECONDS);
    }
*/


    Runnable getBloodResultAndSaveToDB(PatientTimer patientTimer, BloodResultService bloodResultService) {
        return new Runnable() {
            @Override
            public void run() {
                BloodResult bloodResult = new BloodResult();
                bloodResult.setBloodPressure(random.nextInt(250));
                bloodResult.setBloodSugar(random.nextInt(250));
                bloodResult.setPatientId(patientTimer.getPatientId());
                bloodResultService.save(bloodResult);
            }
        };
    }


    void addRunnableToExecutorService(Runnable runnable, PatientTimer patientTimer) {
        executorService.scheduleAtFixedRate(runnable, 0, patientTimer.getMinutes(), TimeUnit.MINUTES);
    }


}
