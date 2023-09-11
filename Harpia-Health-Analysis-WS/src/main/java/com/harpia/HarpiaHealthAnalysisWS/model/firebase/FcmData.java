package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmData {
    String url = "";
    String msgTitle = "";
    String msg = "";
    String reasonSend = "";
    int reasonCode;
    boolean showNotification = false;
    long patientId;

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

    public long getPatientId() {
        return patientId;
    }

    public void setPatientId(long patientId) {
        this.patientId = patientId;
    }

    public String getReasonSend() {
        return reasonSend;
    }

    public void setReasonSend(String reasonSend) {
        this.reasonSend = reasonSend;
    }

    public int getReasonCode() {
        return reasonCode;
    }

    public void setReasonCode(int reasonCode) {
        this.reasonCode = reasonCode;
    }

    @Override
    public String toString() {
        return "FcmData{" +
                "url='" + url + '\'' +
                ", msgTitle='" + msgTitle + '\'' +
                ", msg='" + msg + '\'' +
                ", reasonSend='" + reasonSend + '\'' +
                ", reasonCode=" + reasonCode +
                ", showNotification=" + showNotification +
                ", patientId=" + patientId +
                '}';
    }
}
