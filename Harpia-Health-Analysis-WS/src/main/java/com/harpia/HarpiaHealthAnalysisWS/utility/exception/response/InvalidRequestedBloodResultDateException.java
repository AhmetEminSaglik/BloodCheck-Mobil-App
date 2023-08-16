package com.harpia.HarpiaHealthAnalysisWS.utility.exception.response;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

@ResponseStatus(HttpStatus.NOT_FOUND)
public class InvalidRequestedBloodResultDateException extends RuntimeException {
    public InvalidRequestedBloodResultDateException(int time) {
        super(time+" minute is not an available date. You can retrive the maximum 6 months data.");
    }
}
