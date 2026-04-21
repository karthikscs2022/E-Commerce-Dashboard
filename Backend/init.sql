-- CREATE NEW DATABASE 
CREATE DATABASE OnlineCommerce;

--CREATE ENUM TYPE FOR USERS 
CREATE TYPE status AS ENUM('active','suspended','deactivated');
CREATE TYPE role AS ENUM ('customer','admin','moderator');

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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    last_login TIMESTAMP   
);

--CREATE ENUM TYPE FOR ADDRESSES
CREATE TYPE address_type AS ENUM('home','work','other');

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
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP   
);

--CREATE CATEGORIES TABLE 
CREATE TABLE categories(
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT,
    description TEXT NOT NULL,
    image_url TEXT NOT NULL,
    icon TEXT,
    is_active BOOLEAN DEFAULT true,
    parent_id INT FOREIGN KEY REFERENCES categories(id) ON DELETE SET NULL
);


--CREATE PRODUCT TABLE 
CREATE TABLE products(
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255),
    description TEXT NOT NULL,
    short_description VARCHAR(255),
    category_id INT FOREIGN KEY REFERENCES categories(id) ON DELETE SET NULL,
    brand VARCHAR(255) NOT NULL,
    tags TEXT[],
    base_price NUMERIC(10,2) NOT NULL,
    compare_at_price NUMERIC(10,2),
    cost_price NUMERIC(10,2),
    thumbnail_url TEXT NOT NULL,
    is_featured BOOLEAN DEFAULT false,
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    sku_master VARCHAR(255),
);

--CREATE PRODUCT VARIANTS 
CREATE TABLE product_variants(
    id SERIAL PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES products(id) ON DELETE CASCADE,
    color VARCHAR(255) NOT NULL,
    size VARCHAR(255) NOT NULL,
    stock_qty INT,
);

--CREATE TABLE FOR PRODUCT IMAGES 
CREATE TABLE product_images(
    id SERIAL PRIMARY KEY,
    product_id INT FOREIGN KEY REFERENCES products(id) ON DELETE CASCADE,
    variant_id INT FOREIGN KEY REFERENCES product_variants(id) ON DELETE SET NULL,
    url TEXT NOT NULL,
    ismain BOOLEAN NOT NULL,
    sort_order INT DEFAULT 0
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


--CREATE TABLE FOR CART ITEMS 
CREATE TABLE cart_items(
    id SERIAL PRIMARY KEY,
    user_id INT FOREIGN KEY REFERENCES users(id) ON DELETE CASCADE,
    variant_id INT FOREIGN KEY REFERENCES product_variants(id) ON DELETE SET NULL,
    quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP
)

--CREATE ENUM TYPE FOR ORDERS
CREATE TYPE status AS ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled');
CREATE TYPE payment_status AS ENUM('unpaid', 'paid', 'refunded', 'failed')

--CREATE ORDERS TABLE 
CREATE TABLE ORDERS(
  id SERIAL PRIMARY KEY ,
  user_id INT FOREIGN KEY REFERENCES users(id),
  total_amount NUMERIC(10,2) NOT NULL,
  status status,
  payment_status payment_status,
  shipping_address_id INT FOREIGN KEY REFERENCES addresses(id),
  billing_address_id INT FOREIGN KEY REFERENCES addresses(id),
  payment_method VARCHAR(100) NOT NULL,
  tracking_number TEXT,
  placed_at TIMESTAMP NOT NULL
)