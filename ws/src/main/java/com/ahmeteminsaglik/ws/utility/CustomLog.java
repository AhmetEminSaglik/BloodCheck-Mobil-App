package com.ahmeteminsaglik.ws.utility;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class CustomLog {
    static final String prefix = "---AES-DEV.-MODE---> :";
    private final Logger log;

    public CustomLog(Class clazz) {
        log = LoggerFactory.getLogger(clazz);
    }

    public void info(String text) {
        log.info(prefix + text);
    }

    public void warn(String text) {
        log.warn(prefix + text);
    }
    public void error(String text) {
        log.error(prefix + text);
    }


}
