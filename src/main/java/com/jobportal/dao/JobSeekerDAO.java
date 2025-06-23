package com.jobportal.dao;

import com.jobportal.model.JobSeeker;
import com.jobportal.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JobSeekerDAO {

    public JobSeeker getJobSeekerByUserId(int userId) {
        String sql = "SELECT * FROM job_seekers WHERE user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                JobSeeker seeker = new JobSeeker();
                seeker.setSeekerId(rs.getInt("seeker_id"));
                package com.jobportal.dao;

                import com.jobportal.model.JobSeeker;
                import com.jobportal.util.DatabaseUtil;

                import java.sql.Connection;
                import java.sql.PreparedStatement;
                import java.sql.ResultSet;
                import java.sql.SQLException;

                public class JobSeekerDAO {

                    // Fetch a job seeker's profile by their user ID
                    public JobSeeker getJobSeekerByUserId(int userId) {
                        String sql = "SELECT * FROM job_seekers WHERE user_id = ?";
                        JobSeeker seeker = null;

                        try (Connection conn = DatabaseUtil.getConnection();
                             PreparedStatement stmt = conn.prepareStatement(sql)) {

                            stmt.setInt(1, userId);
                            try (ResultSet rs = stmt.executeQuery()) {
                                if (rs.next()) {
                                    seeker = new JobSeeker();
                                    seeker.setSeekerId(rs.getInt("seeker_id"));
                                    seeker.setUserId(rs.getInt("user_id"));
                                    seeker.setFullName(rs.getString("full_name"));
                                    seeker.setEmail(rs.getString("email"));
                                    seeker.setAge(rs.getInt("age"));
                                    seeker.setPhone(rs.getString("phone"));
                                    seeker.setLocation(rs.getString("location"));
                                    seeker.setSkills(rs.getString("skills"));
                                    seeker.setExperienceYears(rs.getInt("experience_years"));
                                    seeker.setEducation(rs.getString("education"));
                                    seeker.setUniversity(rs.getString("university"));
                                    seeker.setBio(rs.getString("bio"));
                                    seeker.setResumePath(rs.getString("resume_path"));
                                    seeker.setProfilePicture(rs.getString("profile_picture"));
                                } else {
                                    System.out.println("No job seeker found for user_id: " + userId);
                                }
                            }

                        } catch (SQLException e) {
                            System.err.println("Error fetching job seeker for user_id: " + userId);
                            e.printStackTrace();
                        }

                        return seeker;
                    }

                    // Save a new job seeker profile
                    public boolean createJobSeeker(JobSeeker seeker) {
                        String sql = "INSERT INTO job_seekers " +
                                "(user_id, full_name, email, age, phone, location, skills, experience_years, " +
                                "education, university, bio, resume_path, profile_picture) " +
                                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                        try (Connection conn = DatabaseUtil.getConnection();
                             PreparedStatement stmt = conn.prepareStatement(sql)) {

                            stmt.setInt(1, seeker.getUserId());
                            stmt.setString(2, seeker.getFullName());
                            stmt.setString(3, seeker.getEmail());
                            stmt.setInt(4, seeker.getAge());
                            stmt.setString(5, seeker.getPhone());
                            stmt.setString(6, seeker.getLocation());
                            stmt.setString(7, seeker.getSkills());
                            stmt.setInt(8, seeker.getExperienceYears());
                            stmt.setString(9, seeker.getEducation());
                            stmt.setString(10, seeker.getUniversity());
                            stmt.setString(11, seeker.getBio());
                            stmt.setString(12, seeker.getResumePath());
                            stmt.setString(13, seeker.getProfilePicture());

                            return stmt.executeUpdate() > 0;

                        } catch (SQLException e) {
                            System.err.println("Error inserting job seeker: " + seeker.getEmail());
                            e.printStackTrace();
                            return false;
                        }
                    }
                }
              seeker.setUserId(rs.getInt("user_id"));
                seeker.setFullName(rs.getString("full_name"));
                seeker.setEmail(rs.getString("email"));
                seeker.setAge(rs.getInt("age"));
                seeker.setPhone(rs.getString("phone"));
                seeker.setLocation(rs.getString("location"));
                seeker.setSkills(rs.getString("skills"));
                seeker.setExperienceYears(rs.getInt("experience_years"));
                seeker.setEducation(rs.getString("education"));
                seeker.setUniversity(rs.getString("university"));
                seeker.setBio(rs.getString("bio"));
                seeker.setResumePath(rs.getString("resume_path"));
                seeker.setProfilePicture(rs.getString("profile_picture"));
                return seeker;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createJobSeeker(JobSeeker seeker) {
        String sql = "INSERT INTO job_seekers " +
                "(user_id, full_name, email, age, phone, location, skills, experience_years, " +
                "education, university, bio, resume_path, profile_picture) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, seeker.getUserId());
            stmt.setString(2, seeker.getFullName());
            stmt.setString(3, seeker.getEmail());
            stmt.setInt(4, seeker.getAge());
            stmt.setString(5, seeker.getPhone());
            stmt.setString(6, seeker.getLocation());
            stmt.setString(7, seeker.getSkills());
            stmt.setInt(8, seeker.getExperienceYears());
            stmt.setString(9, seeker.getEducation());
            stmt.setString(10, seeker.getUniversity());
            stmt.setString(11, seeker.getBio());
            stmt.setString(12, seeker.getResumePath());
            stmt.setString(13, seeker.getProfilePicture());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}