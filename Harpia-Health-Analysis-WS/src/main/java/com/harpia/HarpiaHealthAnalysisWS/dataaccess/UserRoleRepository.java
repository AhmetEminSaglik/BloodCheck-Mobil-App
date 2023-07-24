package com.harpia.HarpiaHealthAnalysisWS.dataaccess;

import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRoleRepository extends JpaRepository<UserRole, Long> {
    UserRole save(UserRole u);

}
