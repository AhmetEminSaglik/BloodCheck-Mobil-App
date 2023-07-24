package com.harpia.HarpiaHealthAnalysisWS.business.abstracts;

import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;

import java.util.List;

public interface UserRoleService {
    UserRole save(UserRole u);

    Iterable<UserRole> saveAll(Iterable<UserRole> list);
}
