-- CREATE NEW DATABASE 
CREATE DATABASE OnlineCommerce;

--CREATE ENUM TYPE FOR USERS 
CREATE TYPE status AS ENUM('active','suspended','deactivated')
CREATE TYPE role AS ENUM ('customer','admin','moderator')

--CREATE TABLE USERS 
CREATE TABLE users(
    id SERIAL PRIMARY KEY,
    email VARCHAR(100) UNIQUE,
    password_hash TEXT NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number CHAR(10) NOT NULL,
    avatar_url TEXT 'https://surl.li/bjhtin',
    role role NOT NULL,
    status status NOT NULL, 
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP,
    last_login TIMESTAMP   
)

--CREATE ENUM TYPE FOR ADDRESSES
CREATE TYPE address_type AS ENUM('home','work','other')

--CREATE TABLE ADDRESSES 
CREATE TABLE addresses(
    id SERIAL PRIMARY KEY,
    user_id INT,
    FOREIGN KEY user_id REFERENCES users(id) ON DELETE SET NULL,
    is_default BOOLEAN DEFAULT FALSE,
    full_name VARCHAR(50),
    phone_number CHAR(10) NOT NULL,
    address_line1 TEXT NOT NULL,
    address_line2 TEXT NOT NULL,
    city VARCHAR(20) NOT NULL,
    state_province VARCHAR(20) NOT NULL,
    postal_code VARCHAR(10) NOT NULL,
    country VARCHAR(5) NOT NULL,
    address_type address_type NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP   
)


