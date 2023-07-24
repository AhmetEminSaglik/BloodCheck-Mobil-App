package com.harpia.HarpiaHealthAnalysisWS.utility.exception;

public class InvalidLoginInputException extends Exception{
    public InvalidLoginInputException() {
        super("Invalid username or password.");
    }
}
