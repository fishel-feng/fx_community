package com.fx.util;

import java.math.BigInteger;
import java.security.MessageDigest;

public final class StringUtils {

    private static final String EMPTY_STRING = "";

    private static boolean isEmpty(String str) {
        return str == null || str.length() == 0;
    }

    public static String MD5(String str) {
        try {
            if (!StringUtils.isEmpty(str)) {
                MessageDigest messageDigest = MessageDigest.getInstance("MD5");
                byte[] digest = messageDigest.digest(str.getBytes("utf-8"));
                return new BigInteger(digest).toString(16);
            } else {
                return "";
            }
        } catch (Exception e) {
            throw new RuntimeException("字符串加密失败!" + e);
        }
    }


}