package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.UserRoleRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.UserRole;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class UserRoleManager implements UserRoleService {
    @Autowired
    UserRoleRepository repository;

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
        return repository.findById(id);
    }
}
