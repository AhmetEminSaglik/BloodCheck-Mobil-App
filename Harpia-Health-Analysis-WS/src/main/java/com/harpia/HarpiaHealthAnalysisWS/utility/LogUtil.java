package com.harpia.HarpiaHealthAnalysisWS.utility;

public class LogUtil {
    public  static String withPrefix(String text){
        return  "---AES---> "+text;
    }

    /*public class LogCustom {

    private final Logger log;//= LoggerFactory.getLogger(BloodResultParseManager.class);

    public LogCustom(Class clazz) {
        log = LoggerFactory.getLogger(clazz);
    }

    public void info(String text) {
        log.info("---AES---> " + text);
    }


}
*/
}
