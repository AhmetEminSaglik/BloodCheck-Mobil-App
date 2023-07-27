package com.harpia.HarpiaHealthAnalysisWS.business.concretes.login;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginValidationService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login.LoginCredentialsValidationService;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumInputName;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.*;
import com.harpia.HarpiaHealthAnalysisWS.utility.validator.LengthValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoginCredentialsValidation implements LoginValidationService, LoginCredentialsValidationService {
    private static final Logger log = LoggerFactory.getLogger(LoginCredentialsValidation.class);
    private final UserService userService;

    private final int usernameMinLength = 3;
    private final int usernameMaxLength = 10;
    private final int passwordMinLength = 3;
    private final int passwordMaxLength = 10;

    public LoginCredentialsValidation(UserService userService) {
        this.userService = userService;
    }

    @Override
    public DataResult<User> validateLoginCredentials(String username, String password) {
        Result result = isUsernameValid(username);
        if (!result.isSuccess()) {
            return new ErrorDataResult<>(result.getMessage());
        }
        result = isPasswordValid(password);
        if (!result.isSuccess()) {
            return new ErrorDataResult<>(result.getMessage());
        }
        return isUsernameAndPasswordRegistered(username, password);

    }

    @Override
    public Result isUsernameValid(String username) {
        return LengthValidator.isLengthValid(
                EnumInputName.USERNAME, username, usernameMinLength, usernameMaxLength);
    }

    @Override
    public Result isPasswordValid(String password) {
        return LengthValidator.isLengthValid(
                EnumInputName.PASSWORD, password, passwordMinLength, passwordMaxLength);
    }

    @Override
    public DataResult<User> isUsernameAndPasswordRegistered(String username, String password) {
        User user = userService.findByUsernameAndPassword(username, password);
        if (user == null) {
            String error = "Username or Password is Invalid.";
            log.info(error);
            return new ErrorDataResult<>(null, error);
        }
        log.info("User Object is retrived by username and password from Database : " + user);
        return new SuccessDataResult<>(user, "Login Successfull.");
    }
}
