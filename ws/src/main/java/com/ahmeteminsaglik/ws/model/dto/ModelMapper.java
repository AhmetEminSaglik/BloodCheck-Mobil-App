package com.ahmeteminsaglik.ws.model.dto;

import com.ahmeteminsaglik.ws.model.users.Doctor;
import com.ahmeteminsaglik.ws.model.users.Patient;
import com.ahmeteminsaglik.ws.model.users.User;

public class ModelMapper {
    public static UserDto convertToUserDto(User user) {
        UserDto userDto = new UserDto(user);
        return userDto;
    }

    public static PatientDto convertToPatientDto(User user) {
        PatientDto userDto = new PatientDto((Patient) user);
        return userDto;
    }

    public static DoctorDto convertToDoctorDto(User user) {
        DoctorDto userDto = new DoctorDto((Doctor) user);
        return userDto;
    }
}
