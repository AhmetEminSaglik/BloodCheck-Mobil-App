package com.ahmeteminsaglik.ws.dataaccess.user;

import com.ahmeteminsaglik.ws.model.users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User save(User u);

    @Override
    <S extends User> List<S> saveAll(Iterable<S> entities);

    User findByUsernameAndPassword(String username, String password);

    User findByUsername(String username);

    List<User> findAllByOrderByIdAsc();

    List<User> findAllByCreatedAtAfter(LocalDateTime time);

    List<User> findAllByRoleIdOrderByIdDesc(int roleId);

    @Modifying
    @Query(value = "ALTER TABLE users AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();

}
