package com.ahmeteminsaglik.ws.business.concretes.auth;

import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthorityService;
import com.ahmeteminsaglik.ws.dataaccess.user.AuthorityRepository;
import com.ahmeteminsaglik.ws.model.enums.EnumAuthority;
import com.ahmeteminsaglik.ws.model.users.role.Authority;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuthorityServiceImpl implements AuthorityService {
    private final AuthorityRepository repository;

    @Autowired
    public AuthorityServiceImpl(AuthorityRepository repository) {
        this.repository = repository;
    }

    @Override
    public Authority save(Authority authority) {
        return repository.save(authority);
    }

    @Override
    public List<Authority> findAll() {
        return repository.findAll();
    }

    @Override
    public Authority findByAuthority(EnumAuthority enumAuthority) {
        return repository.findByAuthority(enumAuthority.name());
    }
}
