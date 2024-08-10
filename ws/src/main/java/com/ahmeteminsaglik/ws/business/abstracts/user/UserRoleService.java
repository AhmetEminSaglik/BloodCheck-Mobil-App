package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.role.UserRole;

import java.util.List;

public interface UserRoleService {
    UserRole save(UserRole u);

    List<UserRole> saveAll(List<UserRole> list);

    UserRole findById(int id);
}
