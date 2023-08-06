package com.harpia.HarpiaHealthAnalysisWS.business.concretes.login;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupCredentialsValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup.SignupValidationService;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumInputName;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.ErrorDataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.validator.LengthValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class SignupCredentialsValidation implements SignupValidationService, SignupCredentialsValidationService {
    private static final Logger log = LoggerFactory.getLogger(SignupCredentialsValidation.class);
    private final UserService userService;
    private final int usernameMinLength = 3;
    private final int usernameMaxLength = 10;

    public SignupCredentialsValidation(UserService userService) {
        this.userService = userService;
    }

    @Override
    public Result validateSingupCredentials(String username) {
        isUsernameValid(username);
        Result result = isUsernameRegistered(username);
        if (!result.isSuccess()) {
            return new ErrorDataResult<>(result.getMessage());
        }
        return isUsernameRegistered(username);
    }

    @Override
    public Result isUsernameRegistered(String username) {
        User user = userService.findByUsername(username);
        String msg;
        if (user != null) {
            msg = "Username is already exist.";
            log.info(msg);
            return new ErrorDataResult<>(null, msg);
        }
        msg = "Username is valid to signup";
        log.info(msg);
        return new SuccessDataResult<>(user, msg);
    }

    @Override
    public Result isUsernameValid(String username) {
        return LengthValidator.isLengthValid(
                EnumInputName.USERNAME, username, usernameMinLength, usernameMaxLength);
    }
}
