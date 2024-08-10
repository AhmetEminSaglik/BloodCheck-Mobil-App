package com.ahmeteminsaglik.ws.utility.exception;

import com.ahmeteminsaglik.ws.utility.result.ErrorDataResult;
import org.springframework.cache.support.NullValue;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(ApiRequestException.class)
    public ResponseEntity<ErrorDataResult<NullValue>> handleCustomException(ApiRequestException ex) {
        return ResponseEntity.status(ex.getHttpStatus())
                .body(new ErrorDataResult<>(ex.getMessage()));
    }
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorDataResult<NullValue>> handleException(Exception ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                .body(new ErrorDataResult<>("Exception Handler :"+ex.getMessage()));
    }

}
