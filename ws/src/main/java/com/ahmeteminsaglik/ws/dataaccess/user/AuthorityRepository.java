package com.ahmeteminsaglik.ws.dataaccess.user;

import com.ahmeteminsaglik.ws.model.users.role.Authority;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface AuthorityRepository extends JpaRepository<Authority, Integer> {
    @Modifying
    @Query(value = "ALTER TABLE user_roles AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();

    Authority findByAuthority(String authority);
}
