package com.ahmeteminsaglik.ws.business.concretes.user;

import com.ahmeteminsaglik.ws.business.abstracts.user.UserService;
import com.ahmeteminsaglik.ws.dataaccess.user.UserRepository;
import com.ahmeteminsaglik.ws.model.users.User;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserManager implements UserService {
    private final UserRepository userRepository;

    @Autowired
    public UserManager(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    @Override
    public User save(User user) {
        return userRepository.save(user);
    }

    @Override
    public List<User> saveAll(List<User> list) {
        return userRepository.saveAll(list);
    }

    public List<User> findAll() {
        return userRepository.findAllByOrderByIdAsc();
    }

    @Override
    public List<User> findAllByRoleId(int roleId) {
        return userRepository.findAllByRoleIdOrderByIdDesc(roleId);
    }

    @Override
    public List<User> findAllByCreatedAtAfter(LocalDateTime localDateTime) {
        return userRepository.findAllByCreatedAtAfter(localDateTime);
    }

    @Override
    public void delete(User user) {
        userRepository.delete(user);
    }

    @Override
    @Transactional
    public void deleteAll() {
        userRepository.deleteAll();
        userRepository.resetAutoIncrement();
    }

    @Override
    public User findById(long id) {
        return userRepository.findById(id).get();
    }

    @Override
    public User findByUsernameAndPassword(String username, String password) {
        return userRepository.findByUsernameAndPassword(username, password);
    }

    @Override
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public List<User> findAllByCreatedTimeAfter(LocalDateTime time) {
        return userRepository.findAllByCreatedAtAfter(time);
    }
}
