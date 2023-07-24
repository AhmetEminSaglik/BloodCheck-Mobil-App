package com.harpia.HarpiaHealthAnalysisWS.dataaccess;

import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;
import org.springframework.data.repository.Repository;

import java.util.List;

public interface UserRoleRepository extends Repository<UserRole, Long> {
    UserRole save(UserRole u);

    Iterable<UserRole> saveAll(Iterable<UserRole> list);
}
