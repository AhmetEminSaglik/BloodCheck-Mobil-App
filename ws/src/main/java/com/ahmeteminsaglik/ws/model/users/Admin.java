package com.ahmeteminsaglik.ws.model.users;

import jakarta.persistence.Entity;
import jakarta.persistence.Table;

@Entity
@Table(name = "admins")
public class Admin extends User {
    @Override
    public String toString() {
        return "Admin{" + super.toString() + "}";
    }

}
