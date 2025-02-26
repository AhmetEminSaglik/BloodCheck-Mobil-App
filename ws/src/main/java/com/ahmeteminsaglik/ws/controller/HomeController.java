package com.ahmeteminsaglik.ws.controller;

import org.springframework.web.bind.annotation.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("")
@CrossOrigin
public class HomeController {

    private final static String baseUrl = "https://bloodcheck.ahmeteminsaglik.com/api/1.0";

    @GetMapping("/")
    @ResponseBody
    public String home() {

        // Endpoint ve rolleri depolamak için bir LinkedHashMap
        Map<String, List<String>> endpoints = new LinkedHashMap<>();

        // Gerçek endpointler ve roller
        endpoints.put(baseUrl + "/", List.of("Anyone"));
        endpoints.put(baseUrl + "/login", List.of("Anyone(Post Request)"));

        endpoints.put(baseUrl + "/patients", List.of("Patient"));
        endpoints.put(baseUrl + "/patients/{patientId}", List.of("Patient"));
        endpoints.put(baseUrl + "/patients/{patientId}/doctors", List.of("Patient"));

        endpoints.put(baseUrl + "/doctors", List.of("Doctor"));
        endpoints.put(baseUrl + "/doctors/{doctorId}", List.of("Doctor"));
        endpoints.put(baseUrl + "/doctors/{doctorId}/patients", List.of("Doctor"));

        endpoints.put(baseUrl + "/timers", List.of("Patient"));
        endpoints.put(baseUrl + "/timers/patients/{id}", List.of("Patient"));

        endpoints.put(baseUrl + "/bloodresults", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/patient/{patientId}", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/patient/{patientId}/minutes/{min}", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/patient/{patientId}/daily", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/patient/{patientId}/weekly", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/patient/{patientId}/monthly", List.of("Patient"));
        endpoints.put(baseUrl + "/bloodresults/bounds", List.of("Patient"));

        // HTML'i oluşturmak için bir StringBuilder
        StringBuilder html = new StringBuilder("""
                    <!DOCTYPE html>
                    <html lang="en">
                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>Bloodcheck API</title>
                        <style>
                            body { font-family: Arial, sans-serif; text-align: center; padding: 20px; }
                            h1 { color: #d32f2f; }
                            ul {
                            list-style-type: none;
                            }
                            ul.show-points {
                                list-style-type: disc;
                            }
                                
                            li { margin: 10px 0; }
                            a { text-decoration: none; color: #1565c0; font-weight: bold; }
                            .role { font-size: 0.9em; color: gray; }
                            .notes-container {
                                    display: flex;
                                    justify-content: center
                            }
                            .notes {
                                text-align: left;
                                width: 80%;
                                max-width: 600px
                            }
                        </style>
                    </head>
                    <body>
                        <h1>Welcome to the Bloodcheck API</h1>
                        <p>Explore the available endpoints below:</p>
                            <hr>
                            <p style="color:green;font-size:20px">Bloodcheck App Google Play Link:</p>
                            <p><a href="https://play.google.com/store/apps/details?id=com.ahmeteminsaglik.bloodcheck">https://play.google.com/store/apps/details?id=com.ahmeteminsaglik.bloodcheck</a></p>
                            <hr>
                        <div class="notes-container">
                            <div class="notes">
                                <h3 style="color:red">Important Notes</h3>
                                <ul class="show-points">
                                <li> Only GET requests are listed, except for the login endpoint, which accepts only POST requests.</li>
                                <li> You can send POST Request to Login url. Then you can use the token in postman for <span style="font-weight:bold">Bearer Token </span></li>
                                <li> Login Credentials:
                                    <ul class="show-points"> 
                                        <li>5 doctors, 20 patients are registered. A username can be selected such as doctor1 or patient15</li>
                                        <li>Example Login Request (JSON format):<br> 
                                        { "username":"patient15","password":"pass" }</li>
                                     </ul> 
                                </li>
                                <li> Patients can only access endpoints with Patient role permissions.</li>
                                <li> Doctors can request endpoints with both Patient and Doctor role permissions.</li>
                                <li> Admins can access all endpoints.</li>
                                </ul>
                            </div>
                        </div>
                        <ul>
                """);

        // Endpointleri ve rollerini HTML'e ekleme
        int indexNo = 0;
        for (Map.Entry<String, List<String>> entry : endpoints.entrySet()) {
            indexNo++;
            String endpoint = entry.getKey();
            List<String> roles = entry.getValue();

            // Base URL ile endpoint'i birleştirme
            String fullEndpoint = endpoint;

            html.append("""
                    <hr>
                    """);

            html.append("""
                            <li>  <span style="color:red">%s-) </span>
                                <a href="%s">%s</a>
                                <ul>
                    """.formatted(indexNo, fullEndpoint, fullEndpoint));

            StringBuilder allowedRoles = new StringBuilder();
            for (String role : roles) {
                allowedRoles.append(role).append(", ");
            }
            if (allowedRoles.length() > 0) {
                allowedRoles.deleteCharAt(allowedRoles.lastIndexOf(", "));
            }

            html.append("""
                       <li> <span style="color:green"> Roles </span>: %s</li>
                    """.formatted(allowedRoles));

            html.append("""
                            </ul>
                        </li>
                    """);
        }

        // HTML'i tamamlama
        html.append("""
                        </ul>
                    </body>
                    </html>
                """);

        return html.toString();
    }

}
