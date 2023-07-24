package com.harpia.HarpiaHealthAnalysisWS.utility.result;

public class Result { // super type olarak geciyor. Tek basina da anlami olmasi yani sira interface gorevi gormektedir
    private boolean success;
    private String message;

    public Result(boolean success) {
        this.success = success;
    }

    public Result(boolean success, String message) {
        this(success);
        this.message = message;
    }

    public boolean isSuccess() {
        return success;
    }

    public String getMessage() {
        return message;
    }
}
