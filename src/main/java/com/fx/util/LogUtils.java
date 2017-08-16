package com.fx.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public final class LogUtils {

    private static boolean FLAG = true;

    private static Logger logger = LoggerFactory.getLogger(LogUtils.class);

    public static void info(String msg) {
        if (FLAG) {
            logger.info(msg);
        }
    }

    public static void info(String format, Object... arguments) {
        if (FLAG) {
            logger.info(format, arguments);
        }
    }
}
