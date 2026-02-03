-- =========================================================
-- DQL SCRIPT FOR ECOMMERCE APPLICATION
-- PostgreSQL Compatible
-- =========================================================


-- ---------------------------------------------------------
-- 1. SIGN-UP (Create User)
-- ---------------------------------------------------------

INSERT INTO users (username, password, full_name, email)
VALUES (?, ?, ?, ?);


-- ---------------------------------------------------------
-- 2. SIGN-IN (Login)
-- ---------------------------------------------------------

SELECT
    user_id,
    username,
    full_name
FROM users
WHERE username = ? AND password = ?;


-- ---------------------------------------------------------
-- 3. PROFILE FETCH
-- ---------------------------------------------------------

SELECT
    username,
    full_name,
    email,
    created_at
FROM users
WHERE user_id = ?;


-- ---------------------------------------------------------
-- 4. PROFILE UPDATE
-- ---------------------------------------------------------

UPDATE users
SET full_name = ?,
    email = ?
WHERE user_id = ?;


-- ---------------------------------------------------------
-- 5. PRODUCT SEARCH
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
-- 6. GET CART ID
-- ---------------------------------------------------------

SELECT cart_id
FROM cart
WHERE user_id = ?;


-- ---------------------------------------------------------
-- 7. ADD PRODUCT TO CART
-- ---------------------------------------------------------

INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES (?, ?, ?);


-- ---------------------------------------------------------
-- 8. UPDATE CART ITEM QUANTITY
-- ---------------------------------------------------------

UPDATE cart_items
SET quantity = ?
WHERE cart_id = ? AND product_id = ?;


-- ---------------------------------------------------------
-- 9. VIEW CART WITH TOTAL PRICE
-- ---------------------------------------------------------

SELECT
    p.product_id,
    p.product_name,
    p.price,
    ci.quantity,
    (p.price * ci.quantity) AS item_total
FROM cart c
JOIN cart_items ci ON c.cart_id = ci.cart_id
JOIN products p ON ci.product_id = p.product_id
WHERE c.user_id = ?;


-- ---------------------------------------------------------
-- 10. CART GRAND TOTAL
-- ---------------------------------------------------------

SELECT
    SUM(p.price * ci.quantity) AS cart_total
FROM cart c
JOIN cart_items ci ON c.cart_id = ci.cart_id
JOIN products p ON ci.product_id = p.product_id
WHERE c.user_id = ?;
