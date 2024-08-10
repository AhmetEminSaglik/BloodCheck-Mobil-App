package com.ahmeteminsaglik.ws.utility.result;

import com.ahmeteminsaglik.ws.utility.result.Result;

public class SuccessResult extends Result {
    public SuccessResult() {
        super(true);
    }

    public SuccessResult(String message) {
        super(true, message);
    }
}
