-- START RESTAURANT
-- **INFO
DROP TABLE IF EXISTS restaurants;
CREATE TABLE restaurants(
	res_id SMALLINT NOT NULL AUTO_INCREMENT,
	res_name VARCHAR(50) ,
	image VARCHAR(255) ,
	description VARCHAR(50) ,
	last_update TIMESTAMP,
	PRIMARY KEY (res_id)
);

INSERT INTO restaurants(res_id, res_name, image, description, last_update) 
VALUES
	(NULL, 'HAHAHA', 'IMAGE1', 'HAHAHA XINCHAO', NOW()),
	(NULL, 'HEHEHE', 'IMAGE2', 'HEHEHE XINCHAO', NOW()),
	(NULL, 'LIULIU', 'IMAGE3', 'LIULIU XINCHAO', NOW()),
	(NULL, 'BAIBAI', 'IMAGE4', 'BAIBAI XINCHAO', NOW());


-- **INTERACTION
DROP TABLE IF EXISTS like_res;
CREATE TABLE like_res(
	user_id INT,
	res_id INT,
	date_like DATETIME,
	last_update TIMESTAMP
);
INSERT INTO like_res(user_id, res_id, date_like, last_update)
VALUES
	(1, 2, '2022-12-06 13:52:32', NOW()),
	(2, 1, '2022-12-06 13:51:45', NOW()),
	(3, 1, '2022-12-06 13:50:51', NOW()),
	(1, 4, '2022-12-06 13:52:54', NOW());

DROP TABLE IF EXISTS rate_res;
CREATE TABLE rate_res(
	user_id INT,
	res_id INT,
	amount INT,
	date_res DATE,
	last_update TIMESTAMP
);
INSERT INTO rate_res(user_id, res_id, amount, date_res, last_update)
VALUES
	(1, 2, 80, '2022-12-05 23:45:34', NOW()),
	(1, 3, 70, '2022-12-05 23:45:34', NOW()),
	(2, 2, 50, '2022-12-05 23:45:34', NOW()),
	(3, 1, 30, '2022-12-05 23:45:34', NOW());

-- **FOOD
DROP TABLE IF EXISTS foods;
CREATE TABLE foods(
	food_id SMALLINT NOT NULL AUTO_INCREMENT,
	food_name VARCHAR(50),
	image VARCHAR(255),
	price FLOAT,
	description VARCHAR(50),
	type_id SMALLINT,
	last_update TIMESTAMP,
	PRIMARY KEY (food_id)
);

INSERT INTO foods(food_id, food_name, image, price, description, type_id, last_update) 
VALUES
	(NULL, 'com chien', 'comchiencamanImage', 300, 'Com Chien ca man', 1, NOW()),
	(NULL, 'canh rong bien', 'canhrongbienImage', 30, 'Canh rong bien', 3, NOW()),
	(NULL, 'thit kho', 'thitkhoduaImage', 150, 'thit kho dua', 2, NOW()),
	(NULL, 'bun xao', 'bunxaochayImage', 250, 'bun xao chay', 1, NOW());

DROP TABLE IF EXISTS food_type;
CREATE TABLE food_type(
	type_id SMALLINT NOT NULL AUTO_INCREMENT,
	type_name VARCHAR(50),
	last_update TIMESTAMP,
	PRIMARY KEY (type_id)
);

INSERT INTO food_type(type_id, type_name, last_update) 
VALUES
	(NULL, 'chien/xao', NOW()),
	(NULL, 'kho', NOW()),
	(NULL, 'nuoc', NOW()),
	(NULL, 'do uong', NOW());

-- **ORDERS
DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
	order_id VARCHAR(50) NOT NULL UNIQUE,
	user_id INT,
	food_id INT,
	res_id INT,
	amount INT,
	code VARCHAR(50),
	last_update TIMESTAMP,
	PRIMARY KEY (order_id)
);

INSERT INTO orders(order_id, user_id, food_id, res_id, amount, code, last_update) 
VALUES
	('OD1', 1, 1, 2, 20, 'ABC', NOW()),
	('OD2', 2, 3, 1, 30, 'DEF', NOW()),
	('OD3', 3, 1, 3, 21, 'ABCG', NOW()),
	('OD4', 1, 4, 4, 40, 'DEFW', NOW());
-- END RESTAURANT

-- START USERS
DROP TABLE IF EXISTS users;
CREATE TABLE users(
	user_id SMALLINT NOT NULL AUTO_INCREMENT,
	user_name VARCHAR(50) UNIQUE NOT NULL,
	user_pass VARCHAR(50) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	active BOOLEAN,
	create_date DATETIME,
	last_update TIMESTAMP,
	PRIMARY KEY (user_id)
);

INSERT INTO users(user_id, user_name, user_pass, email, active, create_date, last_update)
VALUES
	(NULL, 'hellokitty', 'hellokitty', 'hellokitty@gmail.com', true, '2022-12-06 13:49:20', NOW()),
	(NULL, 'hellokitty1', 'hellokitty1', 'hellokitty1@gmail.com', true, '2022-12-06 13:49:20', NOW()),
	(NULL, 'hellokitty2', 'hellokitty2', 'hellokitty2@gmail.com', true, '2022-12-06 13:49:20', NOW()),
	(NULL, 'hellokitty3', 'hellokitty3', 'hellokitty3@gmail.com', true, '2022-12-06 13:49:20', NOW());
-- END USERS


-- 2 người đẫ like nhà hàng nhiều nhất
SELECT users.user_id, users.user_name, COUNT(like_res.res_id) AS total_like FROM users
INNER JOIN like_res
	ON users.user_id = like_res.user_id
GROUP BY users.user_id, users.user_name
ORDER BY total_like DESC
	LIMIT 5;


-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT restaurants.res_id, restaurants.res_name, COUNT(like_res.res_id) as total_like FROM restaurants
INNER JOIN like_res
	ON restaurants.res_id = like_res.res_id
GROUP BY restaurants.res_id, restaurants.res_name
ORDER BY total_like DESC
	LIMIT 2;

-- Tìm người đã đặt hàng nhiều nhất
SELECT users.user_id, SUM(orders.amount) as total_order FROM users
INNER JOIN orders
	ON users.user_id = orders.user_id
GROUP BY users.user_id
ORDER BY total_order DESC
	LIMIT 1;

-- Tìm người dùng không hoạt động trong hệ thống
SELECT users.user_id, users.user_name FROM users
LEFT JOIN like_res
	ON users.user_id = like_res.user_id
LEFT JOIN orders
	ON users.user_id = orders.user_id
LEFT JOIN rate_res
	ON users.user_id = rate_res.user_id
	WHERE like_res.res_id is null && rate_res.res_id is null && orders.food_id is null;

