package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.Admin;

public interface AdminService {
    Admin findById(long id);
}
