package com.ahmeteminsaglik.ws.model.dto;

import com.ahmeteminsaglik.ws.model.users.User;

public class ModelMapper {
    public static UserDto convertToUserDto(User user) {
        UserDto userDto = new UserDto(user);
        return userDto;
    }
}
