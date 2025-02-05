package com.ahmeteminsaglik.ws.business.concretes.login;

import com.ahmeteminsaglik.ws.business.abstracts.singup.SignupCredentialsValidationService;
import com.ahmeteminsaglik.ws.business.abstracts.singup.SignupValidationService;
import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.model.enums.EnumInputName;
import com.ahmeteminsaglik.ws.model.users.User;
import com.ahmeteminsaglik.ws.utility.CustomLog;
import com.ahmeteminsaglik.ws.utility.result.ErrorDataResult;
import com.ahmeteminsaglik.ws.utility.result.Result;
import com.ahmeteminsaglik.ws.utility.result.SuccessDataResult;
import com.ahmeteminsaglik.ws.utility.validator.LengthValidator;

public class SignupCredentialsValidation implements SignupValidationService, SignupCredentialsValidationService {
    private static final CustomLog log = new CustomLog(SignupCredentialsValidation.class);
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
