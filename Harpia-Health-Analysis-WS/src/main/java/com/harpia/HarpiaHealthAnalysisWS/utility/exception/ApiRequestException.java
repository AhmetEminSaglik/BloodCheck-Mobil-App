package com.harpia.HarpiaHealthAnalysisWS.utility.exception;

import org.springframework.http.HttpStatus;

public class ApiRequestException extends RuntimeException {
    private final HttpStatus httpStatus;

    public ApiRequestException(HttpStatus httpStatus, String message) {
        super(message);
        this.httpStatus = httpStatus;
    }

    public ApiRequestException(String message, Throwable cause, HttpStatus httpStatus) {
        super(message, cause);
        this.httpStatus = httpStatus;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
