
---

## 📝 Project Title:  
**Online Leave Management System**

---

## 📄 Project Description:

The **Online Leave Management System** is a web-based application developed using **Java Servlets, JSP (JavaServer Pages)**, and **MySQL** for managing employee leave requests in an organization.

This system streamlines the leave application and approval process by allowing employees to apply for leave and enabling administrators to approve or reject these requests online. The project supports different user roles such as **Admin** and **Employee**, each with specific access and functionality.

---

## 🎯 Key Features:

### 👥 User Roles:
- **Admin**:
  - Manage employee accounts
  - View all leave requests
  - Approve or reject leave requests
- **Employee**:
  - Register and log in
  - Apply for leave
  - Track the status of their leave applications

### 📌 Core Functionalities:
- Secure login and registration
- Leave application submission form
- Leave status tracking (Pending / Approved / Rejected)
- Admin panel for managing leave applications
- Leave history view for each employee
- Dynamic interaction using Servlet-based backend
- Persistent data management with MySQL

---

## 🛠️ Technologies Used:

| Technology | Purpose |
|-----------|---------|
| **Java (Servlets & JSP)** | Backend Logic & Web Pages |
| **MySQL** | Database Management |
| **JDBC** | Database Connectivity |
| **HTML/CSS** | Frontend Layout |
| **Apache Tomcat** | Web Server |
| **Eclipse IDE** | Development Environment |

---

## ✅ Benefits:

- Digitizes leave tracking and approval process
- Reduces paperwork and manual HR involvement
- Accessible anytime within an internal network
- Improves organizational efficiency and transparency

---

## 🐳 How to Run with Docker (Persistent Data)

To build the Docker image and run it without losing database data upon restarts/rebuilds, run the following commands:

### 1. Build the Docker Image
```bash
docker build -t leave-system .
```

### 2. Run the Container with a Volume Mount
Mount the internal MariaDB database directory (`/var/lib/mysql`) to a Docker volume so your data persists:
```bash
docker run -d \
  -p 8080:8080 \
  -v lms-db-volume:/var/lib/mysql \
  --name lms-app \
  leave-system
```
Your application will be live at: [http://localhost:8080/](http://localhost:8080/)

