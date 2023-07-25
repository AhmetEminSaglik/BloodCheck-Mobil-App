package com.harpia.HarpiaHealthAnalysisWS.business.abstracts.singup;

import com.harpia.HarpiaHealthAnalysisWS.utility.result.Result;

public interface SignupValidationService {
    Result validateSingupCredentials(String username);
}
