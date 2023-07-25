package com.harpia.HarpiaHealthAnalysisWS.dataaccess;


import com.harpia.HarpiaHealthAnalysisWS.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {

    User save(User u);

    @Override
    <S extends User> List<S> saveAll(Iterable<S> entities);

    User findByUsernameAndPassword(String username, String password);

    List<User> findAll();

    List<User> findAllByRoleId(int id);
}
