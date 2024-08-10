package com.ahmeteminsaglik.ws.model.firebase;

public class FcmMessage {

    private String to;
    private FcmNotification notification;
    private FcmData data;

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
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
                "to='" + to + '\'' +
                ", notification=" + notification +
                ", data=" + data +
                '}';
    }
}

