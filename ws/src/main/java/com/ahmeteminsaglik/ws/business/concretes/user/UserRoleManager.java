package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserRoleService;
import com.ahmeteminsaglik.ws.dataaccess.user.UserRoleRepository;
import com.ahmeteminsaglik.ws.model.users.role.UserRole;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserRoleManager implements UserRoleService {
    @Autowired
    private UserRoleRepository repository;

    @Override
    public UserRole save(UserRole u) {
        return repository.save(u);
    }

    @Override
    public List<UserRole> saveAll(List<UserRole> list) {
        return repository.saveAll(list);
    }

    @Override
    public UserRole findById(int id) {
        return repository.findById(id).get();
    }

    @Override
    public List<UserRole> findAll() {
        return repository.findAll();
    }

    @Override
    @Transactional
    public void deleteAll() {
        repository.deleteAll();
        repository.resetAutoIncrement();
    }
}
