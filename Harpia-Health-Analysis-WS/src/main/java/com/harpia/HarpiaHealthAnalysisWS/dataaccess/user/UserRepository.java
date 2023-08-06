package com.harpia.HarpiaHealthAnalysisWS.dataaccess.user;


import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User save(User u);

    @Override
    <S extends User> List<S> saveAll(Iterable<S> entities);

    User findByUsernameAndPassword(String username, String password);

    User findByUsername(String username);

    List<User> findAll();
//    @Query("SELECT e FROM User e WHERE e.createdTime >= :timeThreshold")
//    List<User> findCreatedAfter(LocalDateTime timeThreshold);
    List<User> findAllByCreatedTimeAfter(LocalDateTime time);
    List<User> findAllByRoleId(int roleId);
//    List<User> findUse

//    List<User> findAllByRoleId(int id);
}
