package com.ahmeteminsaglik.ws.dataaccess.diabetic;

import com.ahmeteminsaglik.ws.model.diabetic.Diabetic;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

public interface DiabeticRepository extends JpaRepository<Diabetic, Long> {
    @Modifying
    @Query(value = "ALTER TABLE diabetic_types AUTO_INCREMENT = 1", nativeQuery = true)
    void resetAutoIncrement();
}
