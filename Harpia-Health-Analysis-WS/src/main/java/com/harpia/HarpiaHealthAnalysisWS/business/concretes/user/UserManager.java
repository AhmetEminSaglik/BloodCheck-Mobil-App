package com.harpia.HarpiaHealthAnalysisWS.business.concretes.user;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.dataaccess.user.UserRepository;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserManager implements UserService {


    @Autowired
    UserRepository userRepository;

    PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Override
    public User save(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }

    @Override
    public List<User> saveAll(List<User> list) {
        list.forEach(user -> {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        });
        return userRepository.saveAll(list);
    }

    public List<User> findAll() {
        return userRepository.findAll();
    }

    @Override
    public List<User> findAllByRoleId(int roleId) {
        return userRepository.findAllByRoleId(roleId);
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).get();
    }

//    @Override
//    public List<User> findAllByRoleId(int id) {
//        return userRepository.findAllByRoleId(id);
//    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
}
