package com.jobportal.dao;

import com.jobportal.model.Application;
import com.jobportal.model.Job;
import com.jobportal.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {
    private Connection conn;

    // Constructor that receives a DB connection
    public ApplicationDAO(Connection conn) {
        this.conn = conn;
    }

    // Method to insert a new application
    public boolean createApplication(Application application) {
        String sql = "INSERT INTO applications (job_id, seeker_id, applied_at, status) VALUES (?, ?, NOW(), ?)";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, application.getJobId());
            stmt.setInt(2, application.getSeekerId());
            stmt.setString(3, application.getStatus()); // e.g., "applied"
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error creating application: " + e.getMessage());
            return false;
        }
    }

    // Method to retrieve applications submitted by a specific job seeker
    public List<Application> getApplicationsBySeeker(int seekerId) {
        List<Application> applications = new ArrayList<>();

        String sql = "SELECT a.application_id, a.job_id, a.applied_at, a.status, " +
                     "       j.title AS job_title, j.location, j.salary, " +
                     "       c.name AS company_name " +
                     "FROM applications a " +
                     "JOIN jobs j ON a.job_id = j.job_id " +
                     "JOIN companies c ON j.company_id = c.company_id " +
                     "WHERE a.seeker_id = ? ORDER BY a.applied_at DESC";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seekerId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Application app = new Application();
                app.setApplicationId(rs.getInt("application_id"));
                app.setJobId(rs.getInt("job_id"));
                app.setSeekerId(seekerId);
                app.setApplicationDate(rs.getTimestamp("applied_at").toLocalDateTime());
                app.setStatus(rs.getString("status"));

                Job job = new Job();
                job.setTitle(rs.getString("job_title"));
                job.setLocation(rs.getString("location"));
                job.setSalary(rs.getDouble("salary"));
                job.setCompanyName(rs.getString("company_name"));

                app.setJobDetails(job);
                applications.add(app);
            }

        } catch (SQLException e) {
            System.err.println("Error fetching applications: " + e.getMessage());
        }

        return applications;
    }
}
