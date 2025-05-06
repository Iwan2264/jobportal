package com.jobportal.model;

import java.time.LocalDateTime;

public class Application {
    private int applicationId;
    private int jobId;
    private int seekerId;
    private LocalDateTime applicationDate;
    private String status;
    private Job jobDetails;

    public int getApplicationId() {
        return applicationId;
    }

    public void setApplicationId(int applicationId) {
        this.applicationId = applicationId;
    }

    public int getJobId() {
        return jobId;
    }

    public void setJobId(int jobId) {
        this.jobId = jobId;
    }

    public int getSeekerId() {
        return seekerId;
    }

    public void setSeekerId(int seekerId) {
        this.seekerId = seekerId;
    }

    public LocalDateTime getApplicationDate() {
        return applicationDate;
    }

    public void setApplicationDate(LocalDateTime applicationDate) {
        this.applicationDate = applicationDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Job getJobDetails() {
        return jobDetails;
    }

    public void setJobDetails(Job jobDetails) {
        this.jobDetails = jobDetails;
    }
}
