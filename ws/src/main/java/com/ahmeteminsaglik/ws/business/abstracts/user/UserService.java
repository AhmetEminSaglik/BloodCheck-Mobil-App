package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.business.abstracts.util.DeleteService;
import com.ahmeteminsaglik.ws.model.users.User;

import java.time.LocalDateTime;
import java.util.List;

public interface UserService extends DeleteService, AdminDataFilter {
    User save(User u);

    List<User> saveAll(List<User> list);

    User findById(long id);

    User findByUsernameAndPassword(String username, String password);

    User findByUsername(String username);

    List<User> findAllByCreatedTimeAfter(LocalDateTime time);

    List<User> findAll();

    List<User> findAllByRoleId(int roleId);

    List<User> findAllByCreatedAtAfter(LocalDateTime localDateTime);

    void delete(User user);
}
