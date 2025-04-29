->Job Portal Web Application

This is a Java-based web application that facilitates job recruitment and seeking. It enables **recruiters** to post jobs and manage applicants, and **job seekers** to register, apply for jobs, and manage their profiles.


->Features

User Roles
-Admin
  -Manage recruiters, seekers, and jobs
-Recruiter
  -Register and login
  -Post jobs
  -View and manage applicants
  -Update profile
-Job Seeker
  -Register and login
  -Apply for jobs (with resume upload)
  -Update profile


->Core Modules

| Servlet File                       | Description                                                          |
|------------------------------------|----------------------------------------------------------------------|
| `RegisterRecruiterServlet.java`    | Handles recruiter registration with duplicate email/phone validation |
| `RegisterSeekerServlet.java`       | Handles seeker registration and data validation                      |
| `LoginCredentialCheckServlet.java` | Authenticates users based on role (Admin / Recruiter / Seeker)       |
| `postJobServlet.java` 	           | Allows recruiters to post job listings with skill tags               |
| `ApplyJobServlet.java` 	           | Allows seekers to apply for jobs and upload resumes                  |
| `AcceptRejectServlet.java` 	       | Recruiters can accept or reject job applications                     |
| `delOpAdmin.java` 		             | Admin functionality to delete users, recruiters, or job posts        |
| `SeekerProfileUpdate.java` 	       | Seeker can update personal information                               |
| `RecruiterProfileUpdate.java`	     | Recruiter can update company and contact details                     |



->Tech Stack

-Java EE (Servlets & JSP)
-MySQL   (Database)
-JDBC    (Database Connectivity)
-Jakarta Servlet API
-HTML/CSS/JS (Frontend JSPs)


->Database

Database: `job_portal`  
Tables:
- `users` (seeker info)
- `recruiter` (recruiter info)
- `jobs` (job posts)
- `job_applications` (applications with resume path)
- `job_skills` (skills per job)



->Directory Structure

/src/com/suraj/
├── RegisterSeekerServlet.java
├── RegisterRecruiterServlet.java
├── LoginCredentialCheckServlet.java
├── postJobServlet.java
├── ApplyJobServlet.java
├── AcceptRejectServlet.java
├── RecruiterProfileUpdate.java
├── SeekerProfileUpdate.java
└── delOpAdmin.java

JobPortal
└── src
    └── main
        └── webapp
            ├── css
            ├── images
            ├── META-INF
            └── WEB-INF
            ├── adminDashboard.jsp
            ├── ApplyJobPanel.jsp
            ├── editProfile.jsp
            ├── editProfileRecruiter.jsp
            ├── FilterSeeker.jsp
            ├── JobListing.jsp
            ├── loginPage.jsp
            ├── logout.jsp
            ├── ManageApplicationsAdmin.jsp
            ├── ManageJobsAdmin.jsp
            ├── ManageRecruiterAdmin.jsp
            ├── ManageUsersAdmin.jsp
            ├── MyApplicationSeeker.jsp
            ├── MyProfileRecruiter.jsp
            ├── MyProfileSeeker.jsp
            ├── recruiterDashboard.jsp
            ├── recruiterJobPosting.jsp
            ├── RecruiterPostJob.jsp
            ├── RecruiterViewApplicants.jsp
            ├── registerRecruiter.jsp
            ├── seekerDashboard.jsp
            ├── SignInPageRecruiter.jsp
            ├── SignInPageSeeker.jsp
            └── start.jsp


->Setup Instructions

1. Clone the repo and import it into your Java EE-compatible IDE (Eclipse/IntelliJ).
2. Configure `Tomcat Server`.
3. Update DB credentials in all servlet files if needed.
4. Create the `job_portal` MySQL DB and required tables.
5. Run the project and access via `localhost`.
