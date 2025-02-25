package com.ahmeteminsaglik.ws.controller;

import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
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

        // Endpoint ve rolleri depolamak için bir Map
        Map<String, List<String>> endpoints = new HashMap<>();

        // Gerçek endpointler ve roller
        endpoints.put(baseUrl + "/login", List.of("Anyone(Post Request)"));

        endpoints.put(baseUrl + "/patients", List.of("Patient", "Doctor", "Admin"));
        endpoints.put(baseUrl + "/patients/{patientId}", List.of("Patient"));
        endpoints.put(baseUrl + "/patients/{patientId}/doctors", List.of("Patient"));

        endpoints.put(baseUrl + "/doctors", List.of("Doctor", "Admin"));
        endpoints.put(baseUrl + "/doctors/{doctorId}", List.of("Doctor", "Admin"));
        endpoints.put(baseUrl + "/doctors/{doctorId}/patients", List.of("Doctor", "Admin"));

        endpoints.put(baseUrl + "/timers", List.of("Patient"));
        endpoints.put(baseUrl + "/timers/patients/{id}", List.of("Patient"));

        endpoints.put(baseUrl + "/patients/{id}/doctors", List.of("Patient"));

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
                            ul { list-style-type: none; padding: 0; }
                            li { margin: 10px 0; }
                            a { text-decoration: none; color: #1565c0; font-weight: bold; }
                            .role { font-size: 0.9em; color: gray; }
                            .notes-container {
                                text-align: center;
                                margin-bottom: 20px;
                            }
                            .notes {
                                text-align: left;
                                margin-left: auto;
                                margin-right: auto;
                                width: 80%;
                            }
                        </style>
                    </head>
                    <body>
                        <h1>Welcome to Bloodcheck API</h1>
                        <p>Explore the available endpoints below:</p>
                        <div class="notes-container">
                            <div class="notes">
                                <h3 style="color:red">Important Notes</h3>
                                <p>- Only GET requests are listed except for the login endpoint, which only accepts POST requests.</p>
                                <p>- Patients can only access endpoints with Patient role permissions.</p>
                                <p>- Doctors can request endpoints with both Patient and Doctor role permissions.</p>
                                <p>- Admins can access all endpoints.</p>
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
