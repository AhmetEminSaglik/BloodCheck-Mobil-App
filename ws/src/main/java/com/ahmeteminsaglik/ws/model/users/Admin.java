package com.ahmeteminsaglik.ws.model.users;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.List;

@Entity
@Table(name = "admins")
public class Admin extends User {
    @Override
    public String toString() {
        return "Admin{" + super.toString() + "}";
    }

}
