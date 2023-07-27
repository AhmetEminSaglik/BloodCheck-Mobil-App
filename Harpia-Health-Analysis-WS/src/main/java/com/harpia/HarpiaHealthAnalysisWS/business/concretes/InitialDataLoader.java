package com.harpia.HarpiaHealthAnalysisWS.business.concretes;

import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserRoleService;
import com.harpia.HarpiaHealthAnalysisWS.business.abstracts.user.UserService;
import com.harpia.HarpiaHealthAnalysisWS.model.enums.EnumUserRole;
import com.harpia.HarpiaHealthAnalysisWS.model.users.Admin;
import com.harpia.HarpiaHealthAnalysisWS.model.users.User;
import com.harpia.HarpiaHealthAnalysisWS.model.users.role.UserRole;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.DataResult;
import com.harpia.HarpiaHealthAnalysisWS.utility.result.SuccessDataResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class InitialDataLoader implements CommandLineRunner {
    @Override
    public void run(String... args) throws Exception {
        saveInitilizateData();
    }

    @Autowired
    private UserService userService;
    @Autowired
    private UserRoleService roleService;
    private static final Logger log = LoggerFactory.getLogger(InitialDataLoader.class);

    public void saveInitilizateData() {

        saveUserRoleData();
        saveAdminData();
    }


    private void saveUserRoleData() {
        List<UserRole> data = roleService.saveAll(getStandartUserRoleList());
        String msg = "3 roles are added";
        DataResult result = new SuccessDataResult<>(data, msg);
        log.info(result.toString());
    }

    private void saveAdminData() {
        List<User> list = getAdminList();
        for (int i = 0; i < list.size(); i++) {
            String username = list.get(i).getUsername();
            String pass = list.get(i).getPassword();
            User user = userService.findByUsernameAndPassword(username, pass);
            if (user == null) {
                userService.save(list.get(i));
            } else {
                log.info("Admin(" + (i + 1) + ") data is already registered.");
            }
        }
    }

    private List<UserRole> getStandartUserRoleList() {
        List<UserRole> list = new ArrayList<>();
        list.add(new UserRole(1, EnumUserRole.ADMIN.getName()));
        list.add(new UserRole(2, EnumUserRole.HEALTHCARE_PERSONAL.getName()));
        list.add(new UserRole(3, EnumUserRole.PATIENT.getName()));
        return list;
    }

    private List<User> getAdminList() {
        List<User> list = new ArrayList<>();
        User admin = new Admin();
        admin.setName("Bulut");
        admin.setLastname("AKAY");
        admin.setUsername("bulut");
        admin.setPassword("akay");
        admin.setRoleId(EnumUserRole.ADMIN.getId());
        list.add(admin);

        admin = new Admin();
        admin.setName("Ahmet Emin");
        admin.setLastname("SAGLIK");
        admin.setUsername("emin");
        admin.setPassword("saglik");
        admin.setRoleId(EnumUserRole.ADMIN.getId());
        list.add(admin);
        return list;
    }


}
