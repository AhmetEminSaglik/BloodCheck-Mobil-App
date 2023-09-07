package com.harpia.HarpiaHealthAnalysisWS.dataaccess.user;

import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
}
