package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmData {
    String url;
    String msgTitle;
    String msg;
//    String dl;

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
//    public String getDl() {
//        return dl;
//    }
//
//    public void setDl(String dl) {
//        this.dl = dl;
//    }
/*
    @Override
    public String toString() {
        return "FcmData{" +
                "url='" + url + '\'' +
                ", dl='" + dl + '\'' +
                '}';
    }*/
}
