package com.harpia.HarpiaHealthAnalysisWS;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;


@SpringBootApplication
//@ComponentScan("com.harpia.HarpiaHealthAnalysisWS.model.bloodresult")
public class HarpiaHealthAnalysisWsApplication {
    public static void main(String[] args) {
        SpringApplication.run(HarpiaHealthAnalysisWsApplication.class, args);
    }

}
