/*
package com.ahmeteminsaglik.ws.dataaccess.user;

import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

//public interface UserRoleRepository extends JpaRepository<UserRole, Integer> {
public interface UserRoleRepository extends JpaRepository<EnumAuthority, Integer> {
    @Modifying
    @Query(value = "ALTER TABLE user_roles AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
*/
