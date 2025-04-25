CREATE DATABASE leave_system;


USE leave_system;
CREATE TABLE users (
id INT AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(50) UNIQUE NOT NULL,
password VARCHAR(255) NOT NULL,
role ENUM('admin', 'employee') DEFAULT 'employee'
);
CREATE TABLE leave_applications (
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
start_date DATE,
end_date DATE,
reason TEXT,
status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
FOREIGN KEY (user_id) REFERENCES users(id)
);
