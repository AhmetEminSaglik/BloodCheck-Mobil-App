package com.harpia.HarpiaHealthAnalysisWS.model.firebase;

public class FcmData {
    String url;
    String dl;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDl() {
        return dl;
    }

    public void setDl(String dl) {
        this.dl = dl;
    }

    @Override
    public String toString() {
        return "FcmData{" +
                "url='" + url + '\'' +
                ", dl='" + dl + '\'' +
                '}';
    }
}
