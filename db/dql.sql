-- =========================================================
-- DQL SCRIPT FOR ECOMMERCE BROWNFIELD APPLICATION
-- PostgreSQL Compatible
-- =========================================================
-- This file contains all SELECT / INSERT queries used by
-- the application across Login, Profile, Product Search
-- and Cart screens.
-- =========================================================


-- ---------------------------------------------------------
-- 1. USER LOGIN
-- ---------------------------------------------------------
-- Validates user credentials and returns basic user info
-- Used by Login screen
-- ---------------------------------------------------------

SELECT
    user_id,
    username,
    full_name
FROM users
WHERE username = ? AND password = ?;


-- ---------------------------------------------------------
-- 2. USER PROFILE
-- ---------------------------------------------------------
-- Fetches user profile details
-- Used by Profile screen
-- ---------------------------------------------------------

SELECT
    username,
    full_name,
    email,
    created_at
FROM users
WHERE user_id = ?;


-- ---------------------------------------------------------
-- 3. PRODUCT SEARCH
-- ---------------------------------------------------------
-- Case-insensitive product search
-- Used by Product Search screen
-- ---------------------------------------------------------

SELECT
    product_id,
    product_name,
    description,
    price,
    available_qty
FROM products
WHERE product_name ILIKE '%' || ? || '%';


-- ---------------------------------------------------------
-- 4. VIEW CART
-- ---------------------------------------------------------
-- Retrieves all items in the user's cart along with pricing
-- Used by Cart screen
-- ---------------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    p.price,
    ci.quantity,
    (p.price * ci.quantity) AS total_price
FROM cart c
JOIN cart_items ci ON c.cart_id = ci.cart_id
JOIN products p ON ci.product_id = p.product_id
WHERE c.user_id = ?;


-- ---------------------------------------------------------
-- 5. ADD PRODUCT TO CART
-- ---------------------------------------------------------
-- Adds a product to the user's cart
-- Used by Cart screen
-- ---------------------------------------------------------

INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES (?, ?, ?);


-- ---------------------------------------------------------
-- 6. UPDATE CART ITEM QUANTITY
-- ---------------------------------------------------------
-- Updates quantity of an existing cart item
-- ---------------------------------------------------------

UPDATE cart_items
SET quantity = ?
WHERE cart_id = ? AND product_id = ?;


-- ---------------------------------------------------------
-- 7. REMOVE ITEM FROM CART
-- ---------------------------------------------------------
-- Removes a product from the user's cart
-- ---------------------------------------------------------

DELETE FROM cart_items
WHERE cart_id = ? AND product_id = ?;


-- ---------------------------------------------------------
-- 8. CLEAR CART
-- ---------------------------------------------------------
-- Removes all items from the user's cart
-- ---------------------------------------------------------

DELETE FROM cart_items
WHERE cart_id = ?;


-- ---------------------------------------------------------
-- 9. GET CART ID FOR USER
-- ---------------------------------------------------------
-- Utility query used internally by API
-- ---------------------------------------------------------

SELECT cart_id
FROM cart
WHERE user_id = ?;


-- =========================================================
-- END OF DQL SCRIPT
-- =========================================================
