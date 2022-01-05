/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import DAO.UserDAO;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author HarveyNguyen
 */
public class DateUtil {

    static final Logger logger = Logger.getLogger(UserDAO.class.getName());
    public static SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd");

    public static Date convertStringToDate(final String str) {
        try {
            return DATE_FORMAT.parse(str);
        } catch (Exception ex) {
            logger.log(Level.WARNING, "Error convertStringToDate", ex);
            return null;
        }
    }

    public static String convertDateToString(final Date date) {
        try {
            return DATE_FORMAT.format(date);
        } catch (Exception ex) {
            logger.log(Level.WARNING, "Error convertDateToString", ex);
            return null;
        }
    }

    public static Date getNDaysLater(int n) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DATE, n);
        return c.getTime();
    }
}
