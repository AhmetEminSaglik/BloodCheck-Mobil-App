/*
package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.bloodresult.BloodResultService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.notification.FcmService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.firebase.token.FcmTokenService;
import com.harpia.HarpiaHealthAnalysisWS.business.concretes.firebase.notification.FcmManager;
import com.harpia.HarpiaHealthAnalysisWS.controller.bloodresult.BloodResultController;
import com.harpia.HarpiaHealthAnalysisWS.model.bloodresult.BloodResult;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmData;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmMessage;
import com.harpia.HarpiaHealthAnalysisWS.model.firebase.FcmNotification;
import com.harpia.HarpiaHealthAnalysisWS.model.timer.PatientTimer;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.awt.*;
import java.util.*;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

@Component
public class FakeSensors {
    ScheduledExecutorService executorService = Executors.newScheduledThreadPool(1);
    Random random = new Random();
    private static CustomLog log = new CustomLog(FakeSensors.class);
    FcmTokenService fcmTokenService;
    FcmService fcmService;
    BloodResultController bloodResultController;

    public FakeSensors(BloodResultController bloodResultController, FcmTokenService fcmTokenService, FcmService fcmService) {
        this.bloodResultController = bloodResultController;
        this.fcmTokenService = fcmTokenService;
        this.fcmService = fcmService;
    }

    //    @Autowired
//    PatientTimerService patientTimerService;
//    @Autowired
//    BloodResultService bloodResultService;

    public void runFakeSensors(List<PatientTimer> patientTimerList, BloodResultService bloodResultService) {

        addRunnableToExecutorServiceFor10Seconds(getBloodResultAndSaveToDBPer10Seconds(bloodResultService));

//        System.out.println("BLOOD RESULT SERVICE :" + bloodResultService);
//        System.out.println("PATITENT TIMER LIST SIZE :" + patientTimerList.size());
//        this.bloodResultService
//        List<Runnable> runableList = new ArrayList<>();
        */
/*List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getBloodResultAndSaveToDB(e, bloodResultService));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {
            addRunnableToExecutorService(runableList.get(i), patientTimerList.get(i));
        }*//*


//        bloodResultService=bloodResultService;
      */
/*  List<Runnable> runableList = new ArrayList<>();
        patientTimerList.forEach(e -> {
            runableList.add(getRunnable(e));
        });
        for (int i = 0; i < patientTimerList.size(); i++) {3
            addRunnableToExecutorService(runableList.get(i), patientTimerList.get(i));
        }*//*


    }
*/
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
*//*



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
    static int NormalRangeBound = 100;
    static int HighRangeBound = 200;
//    static int rangeBoundHigh = 0;

    Runnable getBloodResultAndSaveToDBPer10Seconds(BloodResultService bloodResultService) {
        return new Runnable() {
            @Override
            public void run() {
                if (fcmTokenService.findByUserId(6) != null) {

                    if (counter % 3 == 0) {
                        rangeBound = LowRangeBound;// low
                    } else if (counter % 3 == 1) {
                        rangeBound = NormalRangeBound;// normal
                    } else {
                        rangeBound = HighRangeBound;// high
                    }
                    BloodResult bloodResult = new BloodResult();
                    bloodResult.setBloodPressure(random.nextInt(30) + rangeBound + 10);
                    bloodResult.setBloodSugar(random.nextInt(30) + rangeBound + 10);
                    bloodResult.setPatientId(6); // patient id
                    bloodResultService.save(bloodResult);
                    bloodResultController.saveBloodResult(bloodResult);
//                    sendFcmNotificationBloodResult(bloodResult);
                  */
/*  List<String> bloodResultSubItemNames = new ArrayList<>();
                    bloodResultSubItemNames.add("BloodSugar");
                    bloodResultSubItemNames.add("BloodPressure");
                    bloodResultSubItemNames.add("Calcium");
                    bloodResultSubItemNames.add("Magnesium");

                    List<Integer> bloodResulListValues = new ArrayList<>();
                    bloodResulListValues.add(bloodResult.getBloodSugar());
                    bloodResulListValues.add(bloodResult.getBloodPressure());
                    bloodResulListValues.add(bloodResult.getCalcium());
                    bloodResulListValues.add(bloodResult.getMagnesium());
                    try {
                        sendFcmNotification(bloodResultSubItemNames, bloodResulListValues);
                    } catch (Exception e) {
                        log.error("EXCEPTION OCCURED : " + e.getMessage());
                    }*//*

                    counter++;

                } else {
                    log.info("Waiting patient to login");
                }
            }
        };
    }

    //    @Autowired
//    @Autowired
//    FcmService fcmService = new FcmManager();
//    FcmNotificationService fcmNotificationService = new FcmNotificationManager();
//    FcmMsgService fcmMsgService = new FcmMsgManager();

    void sendFcmNotification(List<String> bloodResultItemNames, List<Integer> bloodResultItemValues) {
        StringBuffer notificationBody = new StringBuffer();
        boolean high = false;
        boolean low = false;
        for (int i = 0; i < bloodResultItemValues.size(); i++) {
            if (bloodResultItemValues.get(i) > HighRangeBound) {
                high = true;
                log.info("sendFcmNotification  : tmp  IS  HighRangeBound ");
                notificationBody.append(bloodResultItemNames.get(i) + " : " + bloodResultItemValues.get(i) + "; ");
            } else if (bloodResultItemValues.get(i) < NormalRangeBound) {
                low = true;
                log.info("sendFcmNotification  : tmp IS  LowRangeBound ");
                notificationBody.append(bloodResultItemNames.get(i) + " : " + bloodResultItemValues.get(i) + "; ");
            } else {
                log.info("sendFcmNotification  : tmp IS NormalRangeBound ");
            }
        }
        StringBuffer notificationTitle = new StringBuffer("DANGEROUS");
        if (high) {
            notificationTitle.append(fcmService.generateTextWithHtmlColor("HIGH", Color.RED));
        }
        if (low) {
            notificationTitle.append(fcmService.generateTextWithHtmlColor("LOW", Color.BLUE));
        }
        FcmMessage fcmMessage = createFcmMessage(notificationTitle.toString(), notificationBody.toString());
        if (high || low) {
            log.info("IF GIRDI :" + high + " ; LOW " + low);
            log.info("BEFORE SHOW : " + fcmMessage.getData().isShowNotification());
            fcmMessage.getData().setShowNotification(true);
            log.info("AFTER  SHOW : " + fcmMessage.getData().isShowNotification());
        } else {
            log.info("ELSEYE GIRDI HIGH:" + high + " ; LOW " + low);
        }
        fcmService.sendNotification(fcmMessage);
    }

    FcmMessage createFcmMessage(String title, String body) {

        FcmData fcmData = new FcmData();
//        fcmData.setShowNotification(true);
//        fcmData.setMsgTitle("DANGEROUS : Some Blood Result is too LOW");
//        String textDangerous = "DANGEROUS";
//        textDangerous = fcmNotificationService.generateTextWithHtmlColor(textDangerous, Color.BLUE);
        fcmData.setMsgTitle(title);
        fcmData.setMsg(body);
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle(title);
        fcmNotification.setBody(body);
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        fcmMessage.setTo(fcmTokenService.findByUserId(6).getToken());
        log.info("GONDERILECEK FCM MESSAGE : " + fcmMessage);
        return fcmMessage;

    }

    void sendFcmNotificationBloodResult(BloodResult bloodResult) {
        FcmMessage fcmMessage = null;
        log.info("gelen  BloodPressure : " + bloodResult.getBloodPressure());
        try {
            if (bloodResult.getBloodPressure() < NormalRangeBound) {
                log.info("getBloodPressure is TOO LOW : " + bloodResult.getBloodPressure());
                String msg = "Blood Pressure : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar();
                fcmMessage = getFcmMessageLowBoundRange(msg);
//                fcmMessage.getData().setShowNotification(true);
            } else if (bloodResult.getBloodPressure() > HighRangeBound) {
                log.info("getBloodPressure is TOO HIGH : " + bloodResult.getBloodPressure());
                String msg = "Blood Pressure : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar();*/
/* +
                        "\nAAAAAAAA : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nBBBBBBB : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nCCCCCCCCCC : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nDDDDDDDD : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nEEEEEEE : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nFFFFFFFFF : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar() +
                        "\nGGGGGGGG : " + bloodResult.getBloodPressure() + "\nBlood Sugar : " + bloodResult.getBloodSugar();*//*

                fcmMessage = getFcmMessageHighBoundRange(msg);
//                fcmMessage.getData().setShowNotification(true);
            } else {
                fcmMessage = getFcmMessageNormalBoundRange();
            }

            if (fcmMessage != null) {
                log.info("NOTIFICATION GONDERILECEK : " + bloodResult);
                log.info("FcmMessage : " + fcmMessage);
                fcmService.sendNotification(fcmMessage);
            } else {
                log.info("getBloodPressure is GOOD : " + bloodResult.getBloodPressure());
                log.info("fcmMessage IS : " + fcmMessage);
            }
        } catch (Exception e) {
            log.error("EXCEPTION : " + e.getMessage());
        }

    }

//    FcmNotificationService fcmNotificationService = new FcmNotificationManager();

    FcmMessage getFcmMessageNormalBoundRange() {
        FcmData fcmData = new FcmData();
        fcmData.setShowNotification(false);
//        fcmData.setMsgTitle("DANGEROUS : Some Blood Result is too LOW");
        fcmData.setMsgTitle("Blood Result Tested ");
        fcmData.setMsg("Values Are Good");
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle("Blood Result Tested");
        fcmNotification.setBody("Values Are Good");
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        fcmMessage.setTo(fcmTokenService.findByUserId(6).getToken());
        return fcmMessage;
    }

    FcmMessage getFcmMessageLowBoundRange(String text) {
        FcmData fcmData = new FcmData();
        fcmData.setShowNotification(true);
//        fcmData.setMsgTitle("DANGEROUS : Some Blood Result is too LOW");
        String textDangerous = "DANGEROUS";
        textDangerous = fcmService.generateTextWithHtmlColor(textDangerous, Color.BLUE);
        fcmData.setMsgTitle(textDangerous + " - LOW");
        fcmData.setMsg(text);
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle("Blood Result IS LOW");
        fcmNotification.setBody(text);
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        fcmMessage.setTo(fcmTokenService.findByUserId(6).getToken());
        return fcmMessage;
    }

    FcmMessage getFcmMessageHighBoundRange(String text) {
        String textDangerous = "DANGEROUS";

        textDangerous = fcmService.generateTextWithHtmlColor(textDangerous, Color.RED);

        FcmData fcmData = new FcmData();
        fcmData.setShowNotification(true);
        fcmData.setMsgTitle(textDangerous + " - HIGH");
        fcmData.setMsg(text);
        fcmData.setUrl("https://cdn-icons-png.flaticon.com/512/504/504276.png");

        FcmNotification fcmNotification = new FcmNotification();
        fcmNotification.setTitle("Blood Result IS HIGH");
        fcmNotification.setBody(text);
        FcmMessage fcmMessage = new FcmMessage();

        fcmMessage.setNotification(fcmNotification);
        fcmMessage.setData(fcmData);
        fcmMessage.setTo(fcmTokenService.findByUserId(6).getToken());


//        fcmMessage.getData().setMsgTitle(fcmNotificationService.generateTextWithHtmlColor(fcmMessage.getData().getMsgTitle(), Color.RED));
        return fcmMessage;
    }


    void addRunnableToExecutorService(Runnable runnable, PatientTimer patientTimer) {
        executorService.scheduleAtFixedRate(runnable, 0, patientTimer.getMinutes(), TimeUnit.MINUTES);
    }

    void addRunnableToExecutorServiceFor10Seconds(Runnable runnable) {
        executorService.scheduleAtFixedRate(runnable, 0, 5, TimeUnit.SECONDS);
    }


}
*/
