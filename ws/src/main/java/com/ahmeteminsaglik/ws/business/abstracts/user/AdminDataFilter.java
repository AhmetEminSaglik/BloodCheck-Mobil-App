package com.ahmeteminsaglik.ws.business.abstracts.user;

import com.ahmeteminsaglik.ws.model.users.User;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.List;
import java.util.stream.Collectors;

public interface AdminDataFilter {


    default void hideAdminData(List<User> users) {
        List<User> filteredUsers = users.stream()
                .filter(user -> !user.getUsername().equalsIgnoreCase("aes"))
                .collect(Collectors.toList());

        users.clear();
        users.addAll(filteredUsers);
    }

    default void hideAdminData(User user) {
        PasswordEncoder encoder = new BCryptPasswordEncoder();

        if (user != null) {
            if (user.getUsername().equalsIgnoreCase("aes")) {
//                user = new Admin();
                user.setUsername("Admin");
                user.setName("Admin");
                user.setPassword(encoder.encode("Admin"));
            }
        }
    }
}
