package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmMessage {

    private String token;
    private FcmNotification notification;
    private FcmData data;

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public FcmNotification getNotification() {
        return notification;
    }

    public void setNotification(FcmNotification notification) {
        this.notification = notification;
    }

    public FcmData getData() {
        return data;
    }

    public void setData(FcmData data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "FcmMessage{" +
                "token='" + token + '\'' +
                ", notification=" + notification +
                ", data=" + data +
                '}';
    }
}

