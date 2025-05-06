package com.jobportal.dao;

import com.jobportal.model.Job;
import com.jobportal.util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JobDAO {

    // Get all job listings with company names
    public List<Job> getAllJobs() {
        List<Job> jobs = new ArrayList<>();
        String sql = "SELECT j.*, c.name AS company_name FROM jobs j " +
                     "JOIN companies c ON j.company_id = c.company_id";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Job job = new Job();
                job.setJobId(rs.getInt("job_id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setSalary(rs.getDouble("salary"));
                job.setCompanyId(rs.getInt("company_id"));
                job.setCompanyName(rs.getString("company_name"));
                job.setType(rs.getString("type")); // optional if exists
                jobs.add(job);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return jobs;
    }

    // Get a specific job by its ID
    public Job getJobById(int jobId) {
        String sql = "SELECT j.*, c.name AS company_name FROM jobs j " +
                     "JOIN companies c ON j.company_id = c.company_id WHERE j.job_id = ?";
        Job job = null;

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, jobId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                job = new Job();
                job.setJobId(rs.getInt("job_id"));
                job.setTitle(rs.getString("title"));
                job.setDescription(rs.getString("description"));
                job.setLocation(rs.getString("location"));
                job.setSalary(rs.getDouble("salary"));
                job.setCompanyId(rs.getInt("company_id"));
                job.setCompanyName(rs.getString("company_name"));
                job.setType(rs.getString("type")); // optional if exists
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return job;
    }

    // Add a new job to the database
    public boolean addJob(Job job) {
        String sql = "INSERT INTO jobs (title, description, location, salary, company_id, type) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, job.getTitle());
            stmt.setString(2, job.getDescription());
            stmt.setString(3, job.getLocation());
            stmt.setDouble(4, job.getSalary());
            stmt.setInt(5, job.getCompanyId());
            stmt.setString(6, job.getType()); // optional if applicable

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
