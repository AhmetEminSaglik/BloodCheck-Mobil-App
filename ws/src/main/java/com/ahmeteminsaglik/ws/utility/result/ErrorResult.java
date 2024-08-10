package com.ahmeteminsaglik.ws.utility.result;

import com.ahmeteminsaglik.ws.utility.result.Result;

public class ErrorResult extends Result {
    public ErrorResult() {
        super(false);
    }

    public ErrorResult( String message) {
        super(false, message);
    }
}
