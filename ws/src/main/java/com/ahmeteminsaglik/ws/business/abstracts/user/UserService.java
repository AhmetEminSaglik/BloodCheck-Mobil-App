package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.User;

import java.time.LocalDateTime;
import java.time.OffsetDateTime;
import java.util.List;

public interface UserService {
    User save(User u);

    List<User> saveAll(List<User> list);

    User findById(long id);

    User findByUsernameAndPassword(String username, String password);

    User findByUsername(String username);

    List<User> findAllByCreatedTimeAfter(OffsetDateTime time);

    List<User> findAll();

    List<User> findAllByRoleId(int roleId);

    List<User> findAllByCreatedAtAfter(OffsetDateTime localDateTime);

    void delete(User user);
}
