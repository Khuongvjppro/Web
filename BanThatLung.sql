/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MariaDB
 Source Server Version : 100432 (10.4.32-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : shop_that_lung

 Target Server Type    : MariaDB
 Target Server Version : 100432 (10.4.32-MariaDB)
 File Encoding         : 65001

 Date: 14/01/2025 00:01:25
*/
drop database if exists shop_that_lung;
create database shop_that_lung;
use shop_that_lung;

DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS brands;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS materials;
drop table if exists roles;
drop table if exists log;
drop table if exists resources;
DROP table if exists accounts;
SET FOREIGN_KEY_CHECKS = 1;
-- ----------------------------
-- Table structure for brands
-- ----------------------------
CREATE TABLE accounts (
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci primary key,
  username VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL
) ENGINE=InnoDB;

INSERT INTO accounts VALUES('u1', 'admin', '123');
INSERT INTO accounts VALUES('u2', 'user', '123');
INSERT INTO accounts VALUES('u3', 'john_doe', '123');
INSERT INTO accounts VALUES('u4', 'jane_doe', '123');
INSERT INTO accounts VALUES('u5', 'alice', '123');
INSERT INTO accounts VALUES('u6', 'bob', '123');
INSERT INTO accounts VALUES('u7', 'charlie', '123');
INSERT INTO accounts VALUES('u8', 'dave', '123');
INSERT INTO accounts VALUES('u9', 'eve', '123');
INSERT INTO accounts VALUES('u10', 'frank', '123');

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  full_name varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Chưa cập nhật',
  email varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'example@example.com',
  phone_number varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0000000000',
  date_of_birth date NOT NULL DEFAULT '2000-01-01',
  gender enum('Nam','Nữ','Khác') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'Khác',
  avatar_url varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'default_avatar.png',
  created_at timestamp NOT NULL DEFAULT current_timestamp(),
  updated_at timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO users VALUES (1, 'u1', 'Admin', 'adminu@gmail.com', '0123456788', '2000-10-07', 'Nam', 'https://cdn-icons-png.flaticon.com/512/219/219969.png', '2025-01-04 00:15:19', '2025-01-13 01:09:33');
INSERT INTO users VALUES (10, 'u10', 'Frank Grey', 'frank@example.com', '0888999000', '1993-10-10', 'Nam', 'https://cdn-icons-png.flaticon.com/512/219/219969.png', '2025-01-04 00:15:19', '2025-01-13 01:09:38');
INSERT INTO users VALUES (2, 'u2', 'Regular User', 'user@example.com', '0987654321', '2000-02-02', 'Nữ', 'https://cdn-icons-png.flaticon.com/512/219/219969.png', '2025-01-04 00:15:19', '2025-01-13 01:09:41');
INSERT INTO users VALUES (3, 'u3', 'John Doe', 'johndoe@example.com', '0111222333', '1995-03-03', 'Nam', 'https://cdn-icons-png.flaticon.com/512/219/219969.png', '2025-01-04 00:15:19', '2025-01-13 01:09:51');
INSERT INTO users VALUES (4, 'u4', 'Jane Doe', 'janedoe@example.com', '0222333444', '1998-04-04', 'Nữ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXjT9coLhuSOYCNtfegZnTDfGgz5BhEQyCkQ&s', '2025-01-04 00:15:19', '2025-01-13 01:09:54');
INSERT INTO users VALUES (5, 'u5', 'Alice Smith', 'alice@example.com', '0333444555', '1992-05-05', 'Nữ', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXjT9coLhuSOYCNtfegZnTDfGgz5BhEQyCkQ&s', '2025-01-04 00:15:19', '2025-01-13 01:09:57');
INSERT INTO users VALUES (6, 'u6', 'Bob Brown', 'bob@example.com', '0444555666', '1997-06-06', 'Nam', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQXjT9coLhuSOYCNtfegZnTDfGgz5BhEQyCkQ&s', '2025-01-04 00:15:19', '2025-01-13 01:10:06');
INSERT INTO users VALUES (7, 'u7', 'Charlie Black', 'charlie@example.com', '0555666777', '1989-07-07', 'Nam', 'https://cdn-icons-png.flaticon.com/512/219/219983.png', '2025-01-04 00:15:19', '2025-01-13 01:10:09');
INSERT INTO users VALUES (8, 'u8', 'Dave White', 'dave@example.com', '0666777888', '1991-08-08', 'Nam', 'https://cdn-icons-png.flaticon.com/512/219/219983.png', '2025-01-04 00:15:19', '2025-01-13 01:10:13');
INSERT INTO users VALUES (9, 'u9', 'Eve Green', 'eve@example.com', '0777888999', '1994-09-09', 'Nữ', 'https://cdn-icons-png.flaticon.com/512/219/219983.png', '2025-01-04 00:15:19', '2025-01-13 01:10:19');

CREATE TABLE roles (
  role_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  role int not null default 0, -- 0 la user 1 la admin
  check (role in (0, 1)),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB;

insert into roles values(1, 'u1', 1);
insert into roles values(2, 'u2', 0);
insert into roles values(3, 'u3', 0);
insert into roles values(4, 'u4', 0);
insert into roles values(5, 'u5', 0);
insert into roles values(6, 'u6', 0);
insert into roles values(7, 'u7', 0);
insert into roles values(8, 'u8', 0);
insert into roles values(9, 'u9', 0);
insert into roles values(10, 'u10', 0);

CREATE TABLE resources (
  resource_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  permission INT NOT NULL,
  CHECK (permission = -1 OR (permission BETWEEN 0 AND 7)),
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB;

insert into resources values(1, 'u1', 7);
insert into resources values(2, 'u2', 7);
insert into resources values(3, 'u3', 7);
insert into resources values(4, 'u4', 6);
insert into resources values(5, 'u5', 5);
insert into resources values(6, 'u6', 0);
insert into resources values(7, 'u7', 5);
insert into resources values(8, 'u8', 6);
insert into resources values(9, 'u9', 6);
insert into resources values(10, 'u10', 7);

CREATE TABLE log (
  log_id INT AUTO_INCREMENT PRIMARY KEY,
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  event_type INT NOT NULL,
  check (event_type between 1 and 4),
  event_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  description TEXT,         -- Mô tả chi tiết nếu cần
  FOREIGN KEY (account_id) REFERENCES accounts(account_id)
) ENGINE=InnoDB;

insert into log(log_id, account_id, event_type, description) values(1, 'u1', 2, 'Admin dang nhap vao web');
insert into log(log_id, account_id, event_type, description) values(2, 'u10', 2, 'User dang nhap vao web');
insert into log(log_id, account_id, event_type, description) values(3, 'u10', 3, 'User doi mat khau');

CREATE TABLE brands  (
  id int NOT NULL,
  name varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  create_at date NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of brands
-- ----------------------------
INSERT INTO brands VALUES (1, 'Gucci', '2025-01-09');
INSERT INTO brands VALUES (2, 'Dior', '2125-01-14');
INSERT INTO brands VALUES (3, 'Balancia', '2025-01-14');
INSERT INTO brands VALUES (4, 'DirtyOldMsa', '2025-01-14');
INSERT INTO brands VALUES (5, 'MilkTea', '2125-01-21');
INSERT INTO brands VALUES (6, 'Thắt lưng đi hội', '2025-01-21');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
CREATE TABLE categories  (
  id int NOT NULL,
  name varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  Description varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO categories VALUES (1, 'zzdsadazzz', 'zzcấcz');
INSERT INTO categories VALUES (2, 'Thắt lưng casual', 'Chất lượng tuyệt vời');
INSERT INTO categories VALUES (3, 'Thắt lưng thể thao', NULL);
INSERT INTO categories VALUES (4, 'Thắt lưng đi chơi', 'đâs');
INSERT INTO categories VALUES (5, 'Thắt lưng đi hối adasdasd', NULL);
INSERT INTO categories VALUES (14, 'dsadas', NULL);

-- ----------------------------
-- Table structure for materials
-- ----------------------------
CREATE TABLE materials  (
  id int NOT NULL,
  name varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of materials
-- ----------------------------
INSERT INTO materials VALUES (0, 'Thắt lưng lông');
INSERT INTO materials VALUES (1, 'Thắt lưng da');
INSERT INTO materials VALUES (2, 'Thắt lưng vải');
INSERT INTO materials VALUES (3, 'Thắt lưng kim loại');
INSERT INTO materials VALUES (4, 'Thắt lưng nhựa');
INSERT INTO materials VALUES (5, 'Thắt lưng thiếc');

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
CREATE TABLE order_details  (
  id int NOT NULL,
  order_id int NOT NULL,
  product_id int NOT NULL,
  quantity int NOT NULL,
  price int NOT NULL,
  created_at datetime NULL DEFAULT current_timestamp(),
  updated_at datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO order_details VALUES (33, 32, 24, 2, 44000, '2025-01-09 23:00:39', '2025-01-09 23:00:39');
INSERT INTO order_details VALUES (34, 33, 23, 1, 25000, '2025-01-09 23:01:19', '2025-01-09 23:01:19');
INSERT INTO order_details VALUES (35, 33, 24, 2, 44000, '2025-01-09 23:01:19', '2025-01-09 23:01:19');
INSERT INTO order_details VALUES (36, 33, 25, 1, 30000, '2025-01-09 23:01:19', '2025-01-09 23:01:19');
INSERT INTO order_details VALUES (37, 34, 33, 2, 54000, '2025-01-09 23:06:08', '2025-01-09 23:06:08');
INSERT INTO order_details VALUES (38, 34, 23, 3, 75000, '2025-01-09 23:06:08', '2025-01-09 23:06:08');
INSERT INTO order_details VALUES (39, 34, 25, 2, 60000, '2025-01-09 23:06:08', '2025-01-09 23:06:08');
INSERT INTO order_details VALUES (40, 35, 24, 2, 44000, '2025-01-09 23:07:21', '2025-01-09 23:07:21');
INSERT INTO order_details VALUES (41, 35, 25, 1, 30000, '2025-01-09 23:07:21', '2025-01-09 23:07:21');
INSERT INTO order_details VALUES (42, 36, 24, 1, 22000, '2025-01-09 23:07:49', '2025-01-09 23:07:49');
INSERT INTO order_details VALUES (43, 37, 23, 1, 25000, '2025-01-09 23:08:36', '2025-01-09 23:08:36');
INSERT INTO order_details VALUES (44, 37, 24, 1, 22000, '2025-01-09 23:08:36', '2025-01-09 23:08:36');
INSERT INTO order_details VALUES (45, 37, 25, 1, 30000, '2025-01-09 23:08:36', '2025-01-09 23:08:36');
INSERT INTO order_details VALUES (46, 38, 33, 2, 54000, '2025-01-09 23:09:54', '2025-01-09 23:09:54');
INSERT INTO order_details VALUES (47, 38, 35, 2, 60000, '2025-01-09 23:09:54', '2025-01-09 23:09:54');
INSERT INTO order_details VALUES (48, 38, 23, 1, 25000, '2025-01-09 23:09:54', '2025-01-09 23:09:54');
INSERT INTO order_details VALUES (49, 38, 24, 1, 22000, '2025-01-09 23:09:54', '2025-01-09 23:09:54');
INSERT INTO order_details VALUES (50, 38, 29, 1, 19000, '2025-01-09 23:09:54', '2025-01-09 23:09:54');
INSERT INTO order_details VALUES (51, 39, 24, 1, 22000, '2025-01-09 23:25:45', '2025-01-09 23:25:45');
INSERT INTO order_details VALUES (0, -1, 22, 1, 20000, '2025-01-12 23:00:40', '2025-01-12 23:00:40');

-- ----------------------------
-- Table structure for orders
-- ----------------------------
CREATE TABLE orders  (
  id int NOT NULL,
  name varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  phone varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  address varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  update_date datetime NULL DEFAULT current_timestamp() ON UPDATE CURRENT_TIMESTAMP,
  status varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  total_amount int NULL DEFAULT NULL,
  orderDate datetime NULL DEFAULT current_timestamp()
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO orders VALUES (32, 'Thắt lưng đi hộig', '0354947146', NULL, '2025-01-09 23:00:39', 'Chờ xác thực', 22000, '2025-01-09 23:00:39');
INSERT INTO orders VALUES (33, 'Xin chào', '0354947146', NULL, '2025-01-09 23:01:19', 'Chờ xác thực', 77000, '2025-01-09 23:01:19');
INSERT INTO orders VALUES (34, 'Thắt lưng đi hộig', '0354947146', NULL, '2025-01-09 23:06:08', 'Chờ xác thực', 82000, '2025-01-09 23:06:08');
INSERT INTO orders VALUES (35, 'Thắt lưng đi hộig', '0354947146', NULL, '2025-01-09 23:07:21', 'Chờ xác thực', 52000, '2025-01-09 23:07:21');
INSERT INTO orders VALUES (36, 'Thắt lưng đi hộig', '0354947146', NULL, '2025-01-09 23:07:49', 'Chờ xác thực', 22000, '2025-01-09 23:07:49');
INSERT INTO orders VALUES (37, 'Thắt lưng đi hộig', '0354947146', NULL, '2025-01-09 23:08:36', 'Chờ xác thực', 77000, '2025-01-09 23:08:36');
INSERT INTO orders VALUES (38, 'Thắt lưng đi hối adasdasd', '0354947146', NULL, '2025-01-09 23:09:54', 'Chờ xác thực', 123000, '2025-01-09 23:09:54');
INSERT INTO orders VALUES (39, 'Thắt lưng đi hối adasdasd', '0354947146', NULL, '2025-01-09 23:25:45', 'Chờ xác thực', 22000, '2025-01-09 23:25:45');

-- ----------------------------
-- Table structure for products
-- ----------------------------
CREATE TABLE products  (
  id int primary key,
  name varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  price int NOT NULL,
  description text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  status int NULL DEFAULT 1,
  quantity int NULL DEFAULT 0,
  created datetime NULL DEFAULT current_timestamp(),
  category_id int NULL DEFAULT NULL,
  brand_id int NULL DEFAULT NULL,
  material_id int NULL DEFAULT NULL,
  image varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO products VALUES (22, 'Leather Casual Belt', 20000, 'High-quality leather belt', 1, 120, '2024-02-05', 2, 2, 5, 'thatlung1.jpg');
INSERT INTO products VALUES (23, 'Navy Canvas Belt', 25000, 'Durable fabric belt', 1, 130, '2024-08-27', 2, 2, 3, 'thatlung2.jpg');
INSERT INTO products VALUES (24, 'Slim Black Leather Belt', 22000, 'Stylish casual belt', 1, 100123, '2024-01-16', 2, 1, 5, 'thatlung3.jpg');
INSERT INTO products VALUES (25, 'Classic Brown Belt', 30000, 'Classic leather belt', 1, 10021, '2024-09-24', 4, 3, 2, 'thatlung4.jpg');
INSERT INTO products VALUES (26, 'Designer Adjustable Belt', 28000, 'Designer belt', 1, 1002, '2024-08-24', 4, 5, 5, 'thatlung5.jpg');
INSERT INTO products VALUES (27, 'Woven Fabric Belt', 23000, 'Comfortable adjustable belt', 1, 1003, '2024-02-11', 5, 3, 1, 'thatlung6.jpg');
INSERT INTO products VALUES (28, 'Casual Stretch Belt', 21000, 'Casual wear belt', 1, 1004, '2024-01-12', 3, 5, 2, 'thatlung7.jpg');
INSERT INTO products VALUES (29, 'Sport Belt with Clips', 19000, 'Sporty belt', 1, 10051, '2024-12-12', 4, 2, 4, 'thatlung8.jpg');
INSERT INTO products VALUES (30, 'Formal Dress Belt', 26000, 'Formal belt', 1, 10051, '2024-07-02', 2, 3, 1, 'thatlung9.jpg');
INSERT INTO products VALUES (31, 'Vintage Leather Belt', 24000, 'Versatile leather belt', 1, 1002, '2024-03-28', 5, 5, 4, 'thatlung10.jpg');
INSERT INTO products VALUES (32, 'Elegant Gold Buckle Belt', 20000, 'Elegant belt', 1, 10052, '2024-09-15', 2, 2, 2, 'thatlung11.jpg');
INSERT INTO products VALUES (33, 'Rugged Outdoor Belt', 27000, 'Rugged outdoor belt', 1, 100765, '2024-11-02', 5, 3, 3, 'thatlung12.jpg');
INSERT INTO products VALUES (34, 'Classic Casual Belt', 22000, 'Stylish leather belt', 1, 1002, '2024-08-20', 4, 1, 3, 'thatlung13.jpg');
INSERT INTO products VALUES (35, 'Fashion Statement Belt', 30000, 'Fashion belt', 1, 10053, '2024-10-13', 4, 4, 2, 'thatlung14.jpg');
INSERT INTO products VALUES (36, 'Unique Artisan Belt', 28000, 'Unique design belt', 1, 10073, '2024-02-20', 2, 4, 3, 'thatlung15.jpg');
INSERT INTO products VALUES (37, 'Everyday Wear Belt', 23000, 'Everyday belt', 1, 100543, '2024-09-05', 2, 4, 2, 'thatlung16.jpg');
INSERT INTO products VALUES (38, 'Simple Casual Fabric Belt', 21000, 'Simple fabric belt', 1, 10043, '2024-04-10', 4, 1, 3, 'thatlung17.jpg');
INSERT INTO products VALUES (39, 'Trendy Casual Belt', 19000, 'Trendy belt', 1, 100753, '2024-10-16', 4, 3, 2, 'thatlung18.jpg');
INSERT INTO products VALUES (40, 'Office Attire Belt', 26000, 'Office belt', 1, 100543, '2024-12-12', 3, 3, 1, 'thatlung19.jpg');
INSERT INTO products VALUES (41, 'Casual Stylish Leather Belt', 24000, 'Casual leather belt', 1, 1002, '2024-04-15', 3, 1, 4, 'thatlung20.jpg');

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
CREATE TABLE reviews  (
  review_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  product_id int NOT NULL,
  account_id varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  rating int NULL DEFAULT NULL CHECK (`rating` between 1 and 5),
  url varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  review_text text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  review_date date NULL DEFAULT NULL,
  PRIMARY KEY (review_id) USING BTREE,
  INDEX fk_product(product_id) USING BTREE,
  INDEX fk_user(account_id) USING BTREE,
  CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT fk_user FOREIGN KEY (account_id) REFERENCES accounts (account_id) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO reviews VALUES ('r1', 22, 'u1', 5, 'https://down-vn.img.susercontent.com/file/vn-11134207-7r98o-lp853h1izgb251@resize_w450_nl.webp', 'Sản phẩm rất tốt!', '2025-01-01');
INSERT INTO reviews VALUES ('r10', 35, 'u10', 1, 'https://example.com/image10.jpg', 'Hoàn toàn không hài lòng.', '2025-01-10');
INSERT INTO reviews VALUES ('r11', 22, 'u1', 4, 'https://example.com/image11.jpg', 'Hài lòng.', '2025-01-11');
INSERT INTO reviews VALUES ('r12', 22, 'u2', 5, 'https://example.com/image12.jpg', 'Sản phẩm rất tốt!', '2025-01-12');
INSERT INTO reviews VALUES ('r13', 22, 'u3', 3, 'https://example.com/image13.jpg', 'Ổn, giá hơi cao.', '2025-01-13');
INSERT INTO reviews VALUES ('r14', 32, 'u4', 2, 'https://example.com/image14.jpg', 'Không đạt kỳ vọng.', '2025-01-14');
INSERT INTO reviews VALUES ('r15', 27, 'u5', 1, 'https://example.com/image15.jpg', 'Chất lượng kém.', '2025-01-15');
INSERT INTO reviews VALUES ('r16', 36, 'u6', 5, 'https://example.com/image16.jpg', 'Tuyệt vời!', '2025-01-16');
INSERT INTO reviews VALUES ('r17', 39, 'u7', 4, 'https://example.com/image17.jpg', 'Tốt, nhưng cần cải tiến.', '2025-01-17');
INSERT INTO reviews VALUES ('r18', 37, 'u8', 3, 'https://example.com/image18.jpg', 'Chấp nhận được.', '2025-01-18');
INSERT INTO reviews VALUES ('r19', 41, 'u9', 2, 'https://example.com/image19.jpg', 'Không ổn.', '2025-01-19');
INSERT INTO reviews VALUES ('r2', 22, 'u2', 4, 'https://example.com/image2.jpg', 'Hài lòng với sản phẩm.', '2025-01-02');
INSERT INTO reviews VALUES ('r20', 25, 'u10', 1, 'https://example.com/image20.jpg', 'Tệ!', '2025-01-20');
INSERT INTO reviews VALUES ('r21', 35, 'u1', 4, 'https://example.com/image21.jpg', 'Sản phẩm khá tốt.', '2025-01-21');
INSERT INTO reviews VALUES ('r22', 35, 'u2', 5, 'https://example.com/image22.jpg', 'Xuất sắc!', '2025-01-22');
INSERT INTO reviews VALUES ('r23', 26, 'u3', 3, 'https://example.com/image23.jpg', 'Cần cải thiện.', '2025-01-23');
INSERT INTO reviews VALUES ('r24', 26, 'u4', 2, 'https://example.com/image24.jpg', 'Không đạt chuẩn.', '2025-01-24');
INSERT INTO reviews VALUES ('r25', 36, 'u5', 1, 'https://example.com/image25.jpg', 'Chất lượng kém.', '2025-01-25');
INSERT INTO reviews VALUES ('r26', 36, 'u6', 5, 'https://example.com/image26.jpg', 'Đáng tiền!', '2025-01-26');
INSERT INTO reviews VALUES ('r27', 27, 'u7', 4, 'https://example.com/image27.jpg', 'Hài lòng.', '2025-01-27');
INSERT INTO reviews VALUES ('r28', 27, 'u8', 3, 'https://example.com/image28.jpg', 'Không quá tệ.', '2025-01-28');
INSERT INTO reviews VALUES ('r29', 37, 'u9', 2, 'https://example.com/image29.jpg', 'Chưa tốt.', '2025-01-29');
INSERT INTO reviews VALUES ('r3', 22, 'u3', 3, 'https://example.com/image3.jpg', 'Sản phẩm ổn, nhưng giao hàng chậm.', '2025-01-03');
INSERT INTO reviews VALUES ('r30', 38, 'u10', 1, 'https://example.com/image30.jpg', 'Tệ!', '2025-01-30');
INSERT INTO reviews VALUES ('r31', 38, 'u1', 4, 'https://example.com/image31.jpg', 'Tạm ổn.', '2025-01-31');
INSERT INTO reviews VALUES ('r32', 28, 'u2', 5, 'https://example.com/image32.jpg', 'Rất hài lòng!', '2025-02-01');
INSERT INTO reviews VALUES ('r33', 29, 'u3', 3, 'https://example.com/image33.jpg', 'Ổn.', '2025-02-02');
INSERT INTO reviews VALUES ('r34', 29, 'u4', 2, 'https://example.com/image34.jpg', 'Không như mong đợi.', '2025-02-03');
INSERT INTO reviews VALUES ('r35', 40, 'u5', 1, 'https://example.com/image35.jpg', 'Quá tệ.', '2025-02-04');
INSERT INTO reviews VALUES ('r36', 40, 'u6', 5, 'https://example.com/image36.jpg', 'Đỉnh!', '2025-02-05');
INSERT INTO reviews VALUES ('r37', 30, 'u7', 4, 'https://example.com/image37.jpg', 'Tốt.', '2025-02-06');
INSERT INTO reviews VALUES ('r38', 30, 'u8', 3, 'https://example.com/image38.jpg', 'Chấp nhận được.', '2025-02-07');
INSERT INTO reviews VALUES ('r39', 30, 'u9', 2, 'https://example.com/image39.jpg', 'Không tốt.', '2025-02-08');
INSERT INTO reviews VALUES ('r4', 24, 'u4', 2, 'https://example.com/image4.jpg', 'Chưa hài lòng, sản phẩm bị lỗi.', '2025-01-04');
INSERT INTO reviews VALUES ('r40', 31, 'u10', 1, 'https://example.com/image40.jpg', 'Kém chất lượng.', '2025-02-09');
INSERT INTO reviews VALUES ('r41', 41, 'u1', 4, 'https://example.com/image41.jpg', 'Ổn.', '2025-02-10');
INSERT INTO reviews VALUES ('r42', 31, 'u2', 5, 'https://example.com/image42.jpg', 'Xuất sắc!', '2025-02-11');
INSERT INTO reviews VALUES ('r43', 32, 'u3', 3, 'https://example.com/image43.jpg', 'Bình thường.', '2025-02-12');
INSERT INTO reviews VALUES ('r44', 32, 'u4', 2, 'https://example.com/image44.jpg', 'Chưa tốt.', '2025-02-13');
INSERT INTO reviews VALUES ('r45', 32, 'u5', 1, 'https://example.com/image45.jpg', 'Tệ!', '2025-02-14');
INSERT INTO reviews VALUES ('r46', 33, 'u6', 5, 'https://example.com/image46.jpg', 'Rất tốt!', '2025-02-15');
INSERT INTO reviews VALUES ('r47', 33, 'u7', 4, 'https://example.com/image47.jpg', 'Tốt.', '2025-02-16');
INSERT INTO reviews VALUES ('r48', 24, 'u8', 3, 'https://example.com/image48.jpg', 'Ổn.', '2025-02-17');
INSERT INTO reviews VALUES ('r49', 24, 'u9', 2, 'https://example.com/image49.jpg', 'Không đạt.', '2025-02-18');
INSERT INTO reviews VALUES ('r5', 29, 'u5', 1, 'https://example.com/image5.jpg', 'Rất thất vọng!', '2025-01-05');
INSERT INTO reviews VALUES ('r50', 34, 'u10', 1, 'https://example.com/image50.jpg', 'Tệ.', '2025-02-19');
INSERT INTO reviews VALUES ('r6', 35, 'u6', 4, 'https://example.com/image6.jpg', 'Sản phẩm đáng giá tiền.', '2025-01-06');
INSERT INTO reviews VALUES ('r7', 34, 'u7', 5, 'https://example.com/image7.jpg', 'Xuất sắc!', '2025-01-07');
INSERT INTO reviews VALUES ('r8', 40, 'u8', 3, 'https://example.com/image8.jpg', 'Bình thường.', '2025-01-08');
INSERT INTO reviews VALUES ('r9', 41, 'u9', 2, 'https://example.com/image9.jpg', 'Không tốt lắm.', '2025-01-09');

SET FOREIGN_KEY_CHECKS = 1;
