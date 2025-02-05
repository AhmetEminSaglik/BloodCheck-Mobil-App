package com.ahmeteminsaglik.ws.business.abstracts.diabetic;

import com.ahmeteminsaglik.ws.business.abstracts.util.DeleteService;
import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;

import java.util.List;

public interface DiabeticService extends DeleteService {
    Diabetic save(Diabetic diabetic);

    List<Diabetic> findAll();
}
