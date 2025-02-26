# Online Job Portal

## Project Description
An **Online Job Portal** is a web-based platform where job seekers can search and apply for jobs, while employers can post job vacancies and manage applications. The system streamlines the hiring process by providing an efficient interface for both recruiters and candidates.

---

## Key Features & Functionalities

### User Management
- **Job Seeker Registration & Login**: Username, Email, Password, Resume Upload.
- **Employer Registration & Login**: Company Name, Industry, Email, Password.
- **Admin Panel**: Manage users and job postings.

### Job Listings & Search
- **Job Posting by Employers**: Title, Description, Salary, Location, Experience, Industry.
- **Advanced Search**: Filters by Job Title, Company, Location, Experience, Salary, Job Type.
- **Category-Wise Job Listings**: IT, Healthcare, Finance, Marketing, etc.

### Job Applications
- **Apply for Jobs Online**: Resume submission & Cover Letter.
- **Application Tracking System**: Status (Pending, Reviewed, Shortlisted, Rejected, Hired).
- **Saved Jobs & Application History**: For job seekers.

### Resume & Profile Management
- **Resume Upload & Management**: PDF, DOC format.
- **Profile Creation**: Skills, Experience, Education, Certifications.
- **Profile Visibility Settings**: Public or Private.

### Employer Dashboard
- **Post & Manage Jobs**: Create, update, and delete job postings.
- **Shortlist & Contact Candidates**: Manage applicants.
- **View Applicants**: For posted jobs.
- **Job Analytics & Performance Reports**: Track job performance.

### Admin Panel
- **Manage Users**: Employers & Job Seekers.
- **Approve/Reject Job Listings**: Monitor job postings.
- **Monitor Job Applications**: Track all applications.
- **Generate Reports**: Site activity and usage.

### Notifications & Alerts
- **Email Notifications**: Job updates, application status.
- **Job Alerts**: Via Email & SMS.
- **Employer Notifications**: For new applicants.

### Additional Features
- **AI-Based Job Recommendations**: Based on user profile & job searches.
- **Video Resume & Interview Scheduling**: Enhance candidate profiles.
- **Integration with LinkedIn & Other Job Portals**: Expand reach.
- **Company Reviews & Ratings**: Feedback from job seekers.
- **Blog Section**: Career advice and tips.
- **Subscription Plans**: Premium job listings for employers.

---

## Technology Stack
- **Frontend**: HTML, CSS, JavaScript, Bootstrap, JSP.
- **Backend**: Java Servlet, JSP.
- **Database**: Oracle Database, MySQL Database.
- **Server**: Apache Tomcat.
- **Tools**: Eclipse/NetBeans, SQL Developer.

---

## Folder Structure
```
ONLINEPORTAL
│
├── src
│   ├── main
│   │   ├── java
│   │   │   ├── com
│   │   │   │   └── onlineportal
│   │   │   │       ├── controller (Servlets)
│   │   │   │       ├── dao (Database Access Objects)
│   │   │   │       ├── model (Java Beans/POJOs)
│   │   │   │       └── util (Utility classes)
│   │   ├── webapp
│   │   │   ├── WEB-INF
│   │   │   │   ├── web.xml (Servlet configurations)
│   │   │   │   └── classes (Compiled classes will go here automatically)
│   │   │   ├── css (CSS files for styling)
│   │   │   ├── js (JavaScript files)
│   │   │   ├── images (Images for the website)
│   │   │   ├── jsp (JSP files for views)
│   │   │   │   ├── user (Job Seeker views)
│   │   │   │   ├── employer (Employer views)
│   │   │   │   ├── admin (Admin views)
│   │   │   │   └── shared (Common views like header, footer)
│   │   │   └── index.jsp (Homepage)
│   │   └── resources
│   │       └── db.properties (Database configuration file)
│   └── test (For unit testing, optional for now)
│
├── target
│   ├── maven-archiver
│   ├── onlineportal
│   │   ├── META-INF
│   │   └── WEB-INF
│   └── onlineportal.war (Generated WAR file for deployment)
│
├── pom.xml (Maven configuration file)
│
└── README.md (Project documentation)
```

---

## How to Get Started

### Prerequisites
1. **Java Development Kit (JDK)**: Install JDK 8 or higher.
2. **Apache Tomcat**: Download and set up Tomcat 9 or higher.
3. **MySQL/Oracle Database**: Install and configure the database.
4. **Eclipse/NetBeans IDE**: Set up your development environment.
5. **Maven**: Ensure Maven is installed for dependency management.

### Step 1: Set Up the Project
1. Clone or download the project to your local machine.
2. Open the project in Eclipse/NetBeans as a **Maven Project**.
3. Ensure the `pom.xml` file is correctly configured with dependencies for Servlets, JSP, and MySQL/Oracle JDBC.

### Step 2: Configure the Database
1. Create a database named `onlineportal` in MySQL/Oracle.
2. Update the `db.properties` file in `src/main/resources` with your database credentials:
   ```properties
   db.url=jdbc:mysql://localhost:3306/onlineportal
   db.user=root
   db.password=yourpassword
   ```

### Step 3: Run the Project
Build the project using Maven:
```bash
mvn clean install
```
Deploy the generated `onlineportal.war` file from the target folder to Apache Tomcat.

Start the Tomcat server and access the application at:
```
http://localhost:8080/onlineportal
```

### Step 4: Explore the Application
- **Homepage**: Access the homepage at `index.jsp`.
- **Job Seeker**: Register, log in, search for jobs, and apply.
- **Employer**: Register, log in, post jobs, and manage applications.
- **Admin**: Manage users, job postings, and monitor site activity.

---

## Support
For any issues or questions, feel free to reach out to the development team.

## License
This project is licensed under the MIT License. See the LICENSE file for details.