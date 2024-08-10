package com.ahmeteminsaglik.ws.utility.exception;

public class InvalidInputException extends Exception {
    final static String errMsgPrefix = "Invalid Input Exception :";

    public InvalidInputException(String inputArea, int min, int max) {
        super(inputArea + " must be between " + min + " and " + max);
    }

    public InvalidInputException(String inputArea) {
        super(inputArea + " is empty.  Please fill input.");
    }
}
