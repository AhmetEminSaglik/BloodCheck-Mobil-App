package com.harpia.HarpiaHealthAnalysisWS.utility.validator;

import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumInputName;
import com.harpia.HarpiaHealthAnalysisWS.utility.CustomLog;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.ErrorResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessResult;

public class LengthValidator {
    private static CustomLog log = new CustomLog(LengthValidator.class);

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
