package com.harpia.HarpiaHealthAnalysisWS.model;


import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(name = "admins")
public class Admin extends User {

    public Admin() {
        setUserRoleId(EnumUserRole.ADMIN.getId());
    }
}
