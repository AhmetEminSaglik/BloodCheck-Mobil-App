package com.harpia.HarpiaHealthAnalysisWS.business.abstracts;

import com.harpia.HarpiaHealthAnalysisWS.model.User;

import java.util.List;

public interface UserService {
    User save(User u);

    List<User> saveAll(List<User> list);

    List<User> findAll();

    User findById(long id);

    List<User> findAllByRoleId(int id);
}
