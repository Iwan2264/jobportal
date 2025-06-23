package com.jobportal.listener;

import com.jobportal.util.DatabaseUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("🟢 Application started - Initializing resources");
        // You can add other initialization code here if needed
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("🔴 Application shutting down - Cleaning up resources");
        DatabaseUtil.shutdown();
    }
}