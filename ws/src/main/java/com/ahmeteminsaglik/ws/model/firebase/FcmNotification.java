package com.ahmeteminsaglik.ws.model.firebase;

public class FcmNotification {
    private String title = "";
    private String body = "";

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    @Override
    public String toString() {
        return "FcmNotification{" +
                "title='" + title + '\'' +
                ", body='" + body + '\'' +
                '}';
    }
}
