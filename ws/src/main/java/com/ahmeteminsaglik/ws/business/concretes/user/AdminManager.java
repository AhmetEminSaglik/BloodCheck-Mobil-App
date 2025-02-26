package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.AdminService;
import com.ahmeteminsaglik.ws.dataaccess.user.UserRepository;
import com.ahmeteminsaglik.ws.model.users.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminManager implements AdminService {
    private final UserRepository userRepository;

    @Autowired
    public AdminManager(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public Admin findById(long id) {
        return (Admin) userRepository.findById(id).get();
    }
}
