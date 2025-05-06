package com.jobportal.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/set-theme")
public class ThemeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String theme = request.getParameter("theme");
        HttpSession session = request.getSession();
        session.setAttribute("theme", theme);
    }
}