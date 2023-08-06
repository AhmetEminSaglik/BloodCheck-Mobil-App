package com.harpia.HarpiaHealthAnalysisWS.model.users;


import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "admins")
public class Admin extends User {
    @Override
    public String toString() {
        return "Admin{" + super.toString() + "}";
    }
}
