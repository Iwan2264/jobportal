package com.jobportal.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordHasher {
    public static String hashPassword(String password) {
        try {
            // Create MessageDigest instance for SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            
            // Generate random salt
            SecureRandom random = new SecureRandom();
            byte[] salt = new byte[16];
            random.nextBytes(salt);
            
            // Add salt to digest
            md.update(salt);
            
            // Get the hash bytes
            byte[] hashedPassword = md.digest(password.getBytes());
            
            // Combine salt and hashed password
            return Base64.getEncoder().encodeToString(salt) + 
                   "$" + 
                   Base64.getEncoder().encodeToString(hashedPassword);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
    
    public static boolean verifyPassword(String inputPassword, String storedPassword) {
        try {
            // Split stored password into salt and hash
            String[] parts = storedPassword.split("\\$");
            if (parts.length != 2) return false;
            
            byte[] salt = Base64.getDecoder().decode(parts[0]);
            byte[] storedHash = Base64.getDecoder().decode(parts[1]);
            
            // Compute hash of input password with same salt
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] inputHash = md.digest(inputPassword.getBytes());
            
            // Compare hashes
            return MessageDigest.isEqual(storedHash, inputHash);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error verifying password", e);
        }
    }
}