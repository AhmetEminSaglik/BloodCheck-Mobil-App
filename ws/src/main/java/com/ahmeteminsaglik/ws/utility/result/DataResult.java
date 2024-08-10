package com.ahmeteminsaglik.ws.utility.result;

import com.ahmeteminsaglik.ws.utility.result.Result;

public class DataResult<T> extends Result {

    private T data;

    public DataResult(T data, boolean success, String message) {
        super(success, message);
        this.data = data;
    }

    public DataResult(T data, boolean success) {
        super(success);
        this.data = data;
    }

    public T getData() {
        return this.data;
    }

    @Override
    public String toString() {
        return "DataResult{" +
                "success=" + isSuccess() + "\ndata=" + data + ",\n message : " + getMessage() +
                '}';
    }
}
