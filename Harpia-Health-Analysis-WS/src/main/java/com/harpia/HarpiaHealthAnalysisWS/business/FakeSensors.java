package com.harpia.HarpiaHealthAnalysisWS.business;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.diabetic.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.FcmManager;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.signup.SignupUser;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

import java.util.*;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Component
public class FakeSensors {
    ScheduledExecutorService executorService = Executors.newScheduledThreadPool(1);
    Random random = new Random();
    private static CustomLog log = new CustomLog(SignupUser.class);
    FcmTokenService fcmTokenService;

    public FakeSensors(FcmTokenService fcmTokenService) {
        this.fcmTokenService = fcmTokenService;
    }

    //    @Autowired
//    PatientTimerService patientTimerService;
//    @Autowired
//    BloodResultService bloodResultService;

    public void runFakeSensors(List<PatientTimer> patientTimerList, BloodResultService bloodResultService) {

        addRunnableToExecutorServiceFor5Seconds(getBloodResultAndSaveToDBPer5Seconds(bloodResultService));

//        System.out.println("BLOOD RESULT SERVICE :" + bloodResultService);
//        System.out.println("PATITENT TIMER LIST SIZE :" + patientTimerList.size());
//        this.bloodResultService
//        List<Runnable> runableList = new ArrayList<>();
        /*List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getBloodResultAndSaveToDB(e, bloodResultService));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {
            addRunnableToExecutorService(runableList.get(i), patientTimerList.get(i));
        }*/

//        bloodResultService=bloodResultService;
      /*  List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getRunnable(e));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {3
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

    static int counter = 0;
    static int rangeBound = 0;
    static int LowRangeBound = 10;
    static int NormalRangeBound = 90;
    static int HighRangeBound = 150;
//    static int rangeBoundHigh = 0;

    Runnable getBloodResultAndSaveToDBPer5Seconds(BloodResultService bloodResultService) {
        return new Runnable() {
            @Override
            public void run() {
                counter++;
                if (counter % 3 == 0) {
                    rangeBound = LowRangeBound;// low
                } else if (counter % 3 == 1) {
                    rangeBound = NormalRangeBound;// normal
                } else {
                    rangeBound = HighRangeBound;// high
                }
                BloodResult bloodResult = new BloodResult();
                bloodResult.setBloodPressure(random.nextInt(30) + rangeBound + 110);
                bloodResult.setBloodSugar(random.nextInt(30) + rangeBound + 110);
                bloodResult.setPatientId(6); // patient id
                bloodResultService.save(bloodResult);
                log.info("Runnabledayiz : BloodResult : " + bloodResult);
                sendFcmNotificationOutOfBoundsBloodResult(bloodResult);
            }
        };
    }

    //    @Autowired
    FcmManager fcmService = new FcmManager();
    //    @Autowired


    void sendFcmNotificationOutOfBoundsBloodResult(BloodResult bloodResult) {
        FcmMessage fcmMessage = null;
        log.info("gelen  BloodPressure : " + bloodResult.getBloodPressure());
        try {
            if (bloodResult.getBloodPressure() < NormalRangeBound) {
                String msg = "Blood Pressure : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar();
                fcmMessage = getFcmMessageLowBoundRange(msg);
            }
            if (bloodResult.getBloodPressure() > HighRangeBound) {
                String msg = "Blood Pressure : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar();
                fcmMessage = getFcmMessageHighBoundRange(msg);
            }

            if (fcmMessage != null) {
                log.info("NOTIFICATION GONDERILECEK : " + bloodResult);
                log.info("FcmMessage : " + fcmMessage);
                fcmService.sendFcmNotification(fcmMessage);
            } else {
                log.info("fcmMessage IS : " + fcmMessage);
            }

        } catch (Exception e) {
            log.error(e.getMessage());
        }

    }

    FcmMessage getFcmMessageLowBoundRange(String text) {
        FcmData fcmData = new FcmData();
        fcmData.setDl("Low BR (DL)");
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle("Blood Result IS LOW");
        fcmNotification.setBody(text);
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        log.warn(" 1111 BU MU BOS : fcmTokenService " + fcmTokenService);
        fcmMessage.setToken(fcmTokenService.findByPatientId(6).getToken());
        return fcmMessage;
    }

    FcmMessage getFcmMessageHighBoundRange(String text) {
        FcmData fcmData = new FcmData();
        fcmData.setDl("HIGH BR (DL)");
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle("Blood Result IS HIGH");
        fcmNotification.setBody(text);
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        log.warn(" 2222 BU MU BOS : fcmTokenService " + fcmTokenService);
        log.info(" fcmTokenService.findByPatientId(6).getToken() : " + fcmTokenService.findByPatientId(6).getToken());
        log.info(" fcmMessage.setToken(fcmTokenService.findByPatientId(6).getToken()) : " + fcmTokenService.findByPatientId(6).getToken());
        log.info(" fcmMessage : " + fcmMessage);
        fcmMessage.setToken(fcmTokenService.findByPatientId(6).getToken());
        return fcmMessage;
    }


    void addRunnableToExecutorService(Runnable runnable, PatientTimer patientTimer) {
        executorService.scheduleAtFixedRate(runnable, 0, patientTimer.getMinutes(), TimeUnit.MINUTES);
    }

    void addRunnableToExecutorServiceFor5Seconds(Runnable runnable) {
        executorService.scheduleAtFixedRate(runnable, 0, 2, TimeUnit.SECONDS);
    }


}
