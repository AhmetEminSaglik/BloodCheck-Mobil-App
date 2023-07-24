package com.harpia.HarpiaHealthAnalysisWS.business.abstracts;

import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;

import java.util.List;

public interface UserRoleService {
    UserRole save(UserRole u);

    List<UserRole> saveAll(List<UserRole> list);

    UserRole findById(int id);
}
