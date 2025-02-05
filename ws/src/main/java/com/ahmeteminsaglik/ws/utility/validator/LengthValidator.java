package com.ahmeteminsaglik.ws.utility.validator;

import com.ahmeteminsaglik.ws.model.enums.EnumInputName;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.result.ErrorResult;
import com.ahmeteminsaglik.ws.utility.result.Result;
import com.ahmeteminsaglik.ws.utility.result.SuccessResult;

public class LengthValidator {
    private static final CustomLog log = new CustomLog(LengthValidator.class);

    public static Result isLengthValid(EnumInputName enumInputName, String input, int minLength, int maxLength) {
        final String inputName = enumInputName.getName();
        String errMsg;
        if (input == null) {
            errMsg = "Data is null";
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }

        if (input.length() < minLength) {
            errMsg = inputName + " length must be min " + minLength;
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }
        if (input.length() > maxLength) {
            errMsg = inputName + " length must be max " + maxLength;
            log.info(errMsg);
            return new ErrorResult(errMsg);
        }
        return new SuccessResult(inputName + " length is valid");
    }
}
