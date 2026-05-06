package com.electronicstore.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;
import java.awt.Desktop;
import java.net.URI;

@WebListener
public class AppSessionListener implements HttpSessionListener, ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String contextPath = sce.getServletContext().getContextPath();
        String url = "http://localhost:8080" + contextPath + "/";
        
        System.out.println("\n========================================================================");
        System.out.println("ElectronicStore started successfully!");
        System.out.println("Attempting to open browser automatically...");
        System.out.println("Home Page URL: " + url);
        System.out.println("========================================================================\n");

        try {
            if (Desktop.isDesktopSupported()) {
                Desktop.getDesktop().browse(new URI(url));
            }
        } catch (Exception e) {
            System.err.println("Note: Could not open browser automatically. Please click the link above.");
        }
    }

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        System.out.println("Session Created: " + se.getSession().getId());
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        System.out.println("Session Destroyed: " + se.getSession().getId());
    }
}