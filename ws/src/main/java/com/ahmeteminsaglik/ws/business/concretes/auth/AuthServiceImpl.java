package com.ahmeteminsaglik.ws.business.concretes.auth;


import com.ahmeteminsaglik.ws.business.abstracts.auth.AuthService;
import com.ahmeteminsaglik.ws.model.LoginCredentials;
import com.ahmeteminsaglik.ws.utility.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.stereotype.Service;

@Service
public class AuthServiceImpl implements AuthService {

    @Autowired
    private AuthenticationManager authenticationManager;

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    @Override
    public String login(LoginCredentials loginDto) {
        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(loginDto.getUsername(), loginDto.getPassword())
        );

        UserDetails userDetails = userDetailsService.loadUserByUsername(loginDto.getUsername());
        return jwtUtil.generateToken(userDetails.getUsername());
    }
}

