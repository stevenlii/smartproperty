package com.zyd.common;


import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;

/**
 * @author liu_gl
 * 
 */
public class CreateResource implements ApplicationContextAware {

    /*
     * @see
     * org.springframework.context.ApplicationContextAware#setApplicationContext
     * (org.springframework.context.ApplicationContext)
     */

    private static CreateResource _instance = null;
    private static ApplicationContext ctx = null;

    public static CreateResource create() {
        if (_instance == null) {
            _instance = new CreateResource();
        }
        return _instance;
    }

    public void setApplicationContext(ApplicationContext context)
            throws BeansException {
        ctx = context;
    }

    public static Object getBean(String bean) {
        return ctx.getBean(bean);
    }

}
