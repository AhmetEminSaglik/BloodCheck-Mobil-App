package com.ahmeteminsaglik.ws.mapper;

import com.ahmeteminsaglik.ws.model.firebase.FcmData;
import com.ahmeteminsaglik.ws.model.firebase.FcmMessage;
import com.ahmeteminsaglik.ws.model.firebase.FcmNotification;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;

import java.util.HashMap;
import java.util.Map;

public class FcmToMessageMapper {
    public static Message map(FcmMessage fcmMessage) {
        return Message.builder()
                .setNotification(mapNotification(fcmMessage.getNotification()))
                .setToken(fcmMessage.getTo())
                .putAllData(mapData(fcmMessage.getData())).build();
    }

    private static Notification mapNotification(FcmNotification fcmNotification) {
        if (fcmNotification == null) {
            return null;
        }
        return Notification.builder()
                .setTitle(fcmNotification.getTitle())
                .setBody(fcmNotification.getBody()).build();
    }

    private static Map<String, String> mapData(FcmData fcmData) {
        if (fcmData == null) {
            return null;
        }
        Map<String, String> data = new HashMap<>();
        data.put("url", fcmData.getUrl());
        data.put("msgTitle", fcmData.getMsgTitle());
        data.put("msg", fcmData.getMsg());
        data.put("patientId", Long.toString(fcmData.getPatientId()));
        data.put("reasonCode", Integer.toString(fcmData.getReasonCode()));
        data.put("reasonSend", fcmData.getReasonSend());
        data.put("showNotification", Boolean.toString(fcmData.isShowNotification()));
        System.out.println("-----> eklenen reasonCode " + fcmData.getReasonCode());
        System.out.println("-----> eklenen reasonSend " + fcmData.getReasonSend());
        return data;
    }
}
