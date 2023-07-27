package com.harpia.HarpiaHealthAnalysisWS.business.concretes.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.UserRoleRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
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
}
