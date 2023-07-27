package com.harpia.HarpiaHealthAnalysisWS.dataaccess.user;


import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User save(User u);

    @Override
    <S extends User> List<S> saveAll(Iterable<S> entities);

    User findByUsernameAndPassword(String username, String password);

    User findByUsername(String username);

    List<User> findAll();

//    List<User> findAllByRoleId(int id);
}
