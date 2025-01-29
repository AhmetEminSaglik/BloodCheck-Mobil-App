package com.ahmeteminsaglik.ws.business.abstracts.auth;


import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.role.Authority;

import java.util.List;

public interface AuthorityService {
    Authority save(Authority authority);

//    List<Authority> saveAll(List<Authority> list);

    List<Authority> findAll();

    Authority findByAuthority(EnumAuthority enumAuthority);

//    Authority findById(int id);
}
