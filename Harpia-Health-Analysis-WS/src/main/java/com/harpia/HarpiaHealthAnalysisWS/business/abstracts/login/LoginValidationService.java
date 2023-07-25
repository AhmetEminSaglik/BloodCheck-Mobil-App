package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.login;

import com.harpia.HarpiaHealthAnalysisWS.model.User;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;

public interface LoginValidationService {
    DataResult<User> validateLogin(String username, String password);

}
