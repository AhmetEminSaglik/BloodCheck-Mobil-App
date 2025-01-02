package com.ahmeteminsaglik.ws.business.abstracts.diabetic;

import com.ahmeteminsaglik.ws.business.abstracts.util.DeleteService;
import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface DiabeticService extends DeleteService {
    Diabetic save(Diabetic diabetic);
    List<Diabetic> findAll();
}
