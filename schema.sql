CREATE DATABASE IF NOT EXISTS `LinkedIn`;
USE `LinkedIn`;

/*
--Users

The heart of LinkedIn’s platform is its people. Your database should be able
to represent the following information about LinkedIn’s users:

Their first and last name
Their username
Their password

Keep in mind that, if a company is following best practices, application
passwords are “hashed.” No need to worry about hashing passwords here, though
it might be helpful to know that some hashing algorithms can produce strings
up to 128 characters long.
*/

CREATE TABLE `users` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(50) NOT NULL,
    `last_name` VARCHAR(50) NOT NULL,
    `username` VARCHAR(64) UNIQUE,
    `password` VARCHAR(128) NOT NULL
);

/*
--Schools and Universities

LinkedIn also allows for official school or university accounts, such as that
for Harvard, so alumni (i.e., those who’ve attended) can identify their
affiliation. Ensure that LinkedIn’s database can store the following
information about each school:

The name of the school
The type of school
The school’s location
The year in which the school was founded
You should assume that LinkedIn only allows schools to choose one of three
types: “Primary,” “Secondary,” and “Higher Education.”
*/

CREATE TABLE `school_and_university` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `school_name` VARCHAR(100) NOT NULL,
    `school_type` ENUM ('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `school_location` VARCHAR(100) NOT NULL,
    `year_school_founded` INT NOT NULL
);

/*
--Companies

LinkedIn allows companies to create their own pages, like the one for
LinkedIn itself, so employees can identify their past or current employment
with the company. Ensure that LinkedIn’s database can store the following
information for each company:

The name of the company
The company’s industry
The company’s location
You should assume that LinkedIn only allows companies to choose from one of
three industries: “Technology,” “Education,” and “Business.”
*/

CREATE TABLE `companies` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `company_name` VARCHAR(100) NOT NULL,
    `company_industry` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `company_location` VARCHAR(100) NOT NULL
);

/*
--Connections with People
LinkedIn’s database should be able to represent mutual (reciprocal, two-way)
connections between users. No need to worry about one-way connections user A
“following” user B without user B “following” user A.
*/

CREATE TABLE `connect_w_ppl` (
    `user_id_a` INT,
    `user_id_b` INT,
    PRIMARY KEY (`user_id_a`, `user_id_b`),
    FOREIGN KEY (`user_id_a`) REFERENCES `users`(`id`),
    FOREIGN KEY (`user_id_b`) REFERENCES `users`(`id`),
    CONSTRAINT `chk_users` CHECK (`user_id_a` < `user_id_b`)
);

/*
--Connections with Schools
A user should be able to create an affiliation with a given school.
And similarly, that school should be able to find its alumni.
Additionally, allow a user to define:

The start date of their affiliation
(i.e., when they started to attend the school)
The end date of their affiliation
(i.e., when they graduated), if applicable
The type of degree earned/pursued
(e.g., “BA”, “MA”, “PhD”, etc.)
*/

CREATE TABLE `connect_w_school` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `school_id` INT NOT NULL,
    `affiliation_start_date` DATE NOT NULL,
    `affiliation_end_date` DATE,
    `degree_type` ENUM ('BA', 'MA', 'PHD'),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`school_id`) REFERENCES `school_and_university`(`id`)
);

/*
Connections with Companies
A user should be able to create an affiliation with a given company.
And similarly, a company should be able to find its current and
past employees. Additionally, allow a user to define:

The start date of their affiliation
(i.e., the date they began work with the company)
The end date of their affiliation (i.e., when left the company), if applicable
*/

CREATE TABLE `connect_w_companies` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `user_id` INT NOT NULL,
    `company_id` INT NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE,
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`company_id`) REFERENCES `companies`(`id`)
);


