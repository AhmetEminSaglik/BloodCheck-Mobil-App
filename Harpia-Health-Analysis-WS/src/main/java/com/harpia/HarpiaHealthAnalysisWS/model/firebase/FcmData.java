package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmData {
    String url="";
    String msgTitle="";
    String msg="";
    boolean showNotification = false;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getMsgTitle() {
        return msgTitle;
    }

    public void setMsgTitle(String msgTitle) {
        this.msgTitle = msgTitle;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public boolean isShowNotification() {
        return showNotification;
    }

    public void setShowNotification(boolean showNotification) {
        this.showNotification = showNotification;
    }

    @Override
    public String toString() {
        return "FcmData{" +
                "url='" + url + '\'' +
                ", msgTitle='" + msgTitle + '\'' +
                ", msg='" + msg + '\'' +
                ", showNotification=" + showNotification +
                '}';
    }
}
