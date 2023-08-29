package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmData {
    String url;
    String msgTitle;
    String msg;

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

    @Override
    public String toString() {
        return "FcmData{" +
                "url='" + url + '\'' +
                ", msgTitle='" + msgTitle + '\'' +
                ", msg='" + msg + '\'' +
                '}';
    }
}
