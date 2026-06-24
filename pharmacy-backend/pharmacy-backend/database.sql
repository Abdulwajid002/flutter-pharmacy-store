-- ============================================================
--  PHARMACY APP - COMPLETE DATABASE SCHEMA
-- ============================================================

CREATE DATABASE IF NOT EXISTS pharmacy_app;
USE pharmacy_app;

-- -------------------------------------------------------
-- USERS TABLE
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(100)        NOT NULL,
    email       VARCHAR(150)        NOT NULL UNIQUE,
    password    VARCHAR(255)        NOT NULL,
    role        ENUM('user','admin') NOT NULL DEFAULT 'user',
    is_deleted  TINYINT(1)          NOT NULL DEFAULT 0,
    created_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------------------------------------
-- MEDICINES TABLE
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS medicines (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(150)        NOT NULL,
    price       DECIMAL(10,2)       NOT NULL,
    category    ENUM('Medicine','Vitamins','Herbal','Supplement') NOT NULL DEFAULT 'Medicine',
    description TEXT,
    image_url   VARCHAR(300),
    stock       INT                 NOT NULL DEFAULT 0,
    is_active   TINYINT(1)          NOT NULL DEFAULT 1,
    created_at  TIMESTAMP           DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------------------------------------
-- WALLET TABLE  (one row per user)
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS wallets (
    id         INT AUTO_INCREMENT PRIMARY KEY,
    user_id    INT            NOT NULL UNIQUE,
    balance    DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    updated_at TIMESTAMP      DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- WALLET TRANSACTIONS TABLE
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS wallet_transactions (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT            NOT NULL,
    type        ENUM('credit','debit') NOT NULL,
    amount      DECIMAL(10,2)  NOT NULL,
    description VARCHAR(255),
    created_at  TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- ORDERS TABLE
-- -------------------------------------------------------
CREATE TABLE IF NOT EXISTS orders (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    user_id       INT            NOT NULL,
    medicine_name VARCHAR(150)   NOT NULL,
    quantity      INT            NOT NULL,
    total         DECIMAL(10,2)  NOT NULL,
    status        ENUM('pending','confirmed','delivered','cancelled') NOT NULL DEFAULT 'pending',
    created_at    TIMESTAMP      DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- -------------------------------------------------------
-- SEED: default admin account  (password: admin123)
-- bcrypt hash of "admin123" with saltRounds=10
-- -------------------------------------------------------
INSERT IGNORE INTO users (name, email, password, role)
VALUES (
    'Super Admin',
    'admin@pharmacy.com',
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhy2',
    'admin'
);
