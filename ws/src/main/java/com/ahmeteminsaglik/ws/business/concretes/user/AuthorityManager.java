/*
package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthorityService;
import com.ahmeteminsaglik.ws.dataaccess.user.AuthorityRepository;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.role.Authority;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorityManager implements AuthorityService {
    @Autowired
    private AuthorityRepository repository;

    @Override
    public Authority save(Authority u) {
        return repository.save(u);
    }

    @Override
    public List<Authority> saveAll(List<Authority> list) {
        return repository.saveAll(list);
    }

    @Override
    public Authority findById(int id) {
        return repository.findById(id).get();
    }

    @Override
    public List<Authority> findAll() {
        return repository.findAll();
    }

    @Override
    public Authority findByAuthority(EnumAuthority enumAuthority) {
        return null;
    }

    @Override
    @Transactional
    public void deleteAll() {
        repository.deleteAll();
        repository.resetAutoIncrement();
    }
}
*/
