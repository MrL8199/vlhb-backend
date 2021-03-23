/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : onlinebookstore

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 21/03/2021 22:46:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `user_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `default` tinyint(1) NOT NULL,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `state` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('13ad0d94-74f0-11eb-a21f-0620d1835099', 1614407908, '5fc5f970100333097e15017b', 1, 'Nguyễn Hữu Tiến', '84326463468', 'tien.nguyen1@boot.ai', 'Số 56', 'Đan Phượng', 'Hà Nội', 'Hồng Hà');
INSERT INTO `address` VALUES ('2083b684-8874-11eb-8891-3ed9a78ec8cb', 1616130198, '5fc5f970100333097e15017b', 0, 'Hiu', '840948154265', 'luc.dinh@gmail.ai', 'Asd', 'Thành phố Hà Nội', 'Phường Ngọc Khánh', 'Quận Ba Đình');
INSERT INTO `address` VALUES ('384438ce-74f2-11eb-a21f-0620d1835099', 1614407908, '5fc5f970100333097e15017b', 0, 'DVL', '8.40132E+11', 'luc.dinh@boot.ai', 'Aa', 'Thành phố Hà Nội', 'Phường Phúc Xá', 'Quận Ba Đình');
INSERT INTO `address` VALUES ('57b39fd2-74f8-11eb-a21f-0620d1835099', 1614407908, '5fc5f970100333097e15017b', 0, 'Hiu', '8.40932E+11', 'luc.dinh@gmail.ai', 'Ha noi', 'Thành phố Hà Nội', 'Phường Phúc Xá', 'Quận Ba Đình');
INSERT INTO `address` VALUES ('57f3a622-74f8-11eb-a21f-0620d1835099', 1614407908, '5fc5f970100333097e15017b', 0, 'Hiu', '8.40932E+11', 'luc.dinh@gmail.ai', 'Ha noi', 'Thành phố Hà Nội', 'Phường Phúc Xá', 'Quận Ba Đình');

-- ----------------------------
-- Table structure for authors
-- ----------------------------
DROP TABLE IF EXISTS `authors`;
CREATE TABLE `authors`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `picture` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of authors
-- ----------------------------
INSERT INTO `authors` VALUES ('9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'Tô Hoài', 'https://upload.wikimedia.org/wikipedia/vi/7/73/Nhavan_t%C3%B4_ho%C3%A0i.jpg', 'Tô Hoài (tên khai sinh: Nguyễn Sen; 27 tháng 9 năm 1920 – 6 tháng 7 năm 2014)[1] là một nhà văn Việt Nam. Một số tác phẩm đề tài thiếu nhi của ông được dịch ra ngoại ngữ. Ông được nhà nước Việt Nam trao tặng Giải thưởng Hồ Chí Minh về Văn học – Nghệ thuật Đợt 1 (1996) cho các tác phẩm: Xóm giếng, Nhà nghèo, O chuột, Dế mèn phiêu lưu ký, Núi Cứu quốc, Truyện Tây Bắc, Mười năm, Xuống làng, Vỡ tỉnh, Tào lường, Họ Giàng ở Phìn Sa, Miền Tây, Vợ chồng A Phủ, Tuổi trẻ Hoàng Văn Thụ.', 1614407908);
INSERT INTO `authors` VALUES ('9d99d182-668f-11eb-9fe5-e673ac9d1856', 'Tố Hữu', 'https://upload.wikimedia.org/wikipedia/vi/thumb/1/18/To_Huu.jpg/175px-To_Huu.jpg', 'Tố Hữu, tên thật là Nguyễn Kim Thành (4 tháng 10 năm 1920 – 9 tháng 12 năm 2002), quê gốc ở làng Phù Lai, nay thuộc xã Quảng Thọ, huyện Quảng Điền, tỉnh Thừa Thiên - Huế. Ông là một nhà thơ tiêu biểu của thơ cách mạng Việt Nam, đồng thời ông còn là một chính khách, một cán bộ cách mạng lão thành. Ông đã từng giữ các chức vụ quan trọng trong hệ thống chính trị của Việt Nam như Ủy viên Bộ Chính trị, Bí thư Ban Chấp hành Trung ương Đảng Cộng sản Việt Nam, Phó Chủ tịch thứ Nhất Hội đồng Bộ trưởng nước Cộng hòa Xã hội Chủ nghĩa Việt Nam.', 1614407908);
INSERT INTO `authors` VALUES ('9e4b2fd6-668f-11eb-9fe5-e673ac9d1856', 'Nguyễn Nhật Ánh', 'https://upload.wikimedia.org/wikipedia/commons/9/96/Nguyen_Nhat_Anh.jpg', '\\\"Nguyễn Nhật Ánh (sinh ngày 7 tháng 5 năm 1955) là một nhà văn người Việt. Ông được biết đến qua nhiều tác phẩm văn học về đề tài tuổi mới lớn, các tác phẩm của ông rất được độc giả ưa chuộng và nhiều tác phẩm đã được chuyển thể thành phim. Ông lần lượt viết về sân khấu, phụ trách mục tiểu phẩm, phụ trách trang thiếu nhi và hiện nay là bình luận viên thể thao trên báo Sài Gòn Giải phóng Chủ nhật với bút danh Chu Đình Ngạn. Ngoài ra, ông còn có những bút danh khác như Anh Bồ Câu, Lê Duy Cật, Đông Phương Sóc, Sóc Phương Đông,...\\\"', 1614407908);
INSERT INTO `authors` VALUES ('9f0c46e4-668f-11eb-9fe5-e673ac9d1856', 'Xuân Quỳnh', 'https://upload.wikimedia.org/wikipedia/vi/thumb/8/80/Xuan_Quynh.jpg/240px-Xuan_Quynh.jpg', 'Xuân Quỳnh (1942 – 1988) tên thật là Nguyễn Thị Xuân Quỳnh, là một nhà thơ nữ của Việt Nam. Bà được xem là nữ thi sĩ nổi tiếng với nhiều bài thơ được nhiều người biết đến như Thuyền và biển, Sóng, Thơ tình cuối mùa thu, Tiếng gà trưa,...... Bà được Nhà nước Việt Nam truy tặng Giải thưởng Nhà nước (Việt Nam) và Giải thưởng Hồ Chí Minh vì những thành tựu cho nền văn học nước nhà.', 1614407908);
INSERT INTO `authors` VALUES ('a17e9a26-668f-11eb-9fe5-e673ac9d1856', 'Nguyễn Ngọc Thạch', 'https://toplist.vn/images/800px/nha-van-noi-tieng-nhat-viet-nam-16396.jpg', '\\\"Nguyễn Ngọc Thạch (sinh năm 1987) là một tác giả trẻ được đông đảo bạn trẻ biết đến và yêu mến). Anh nổi tiếng với những tác phẩm chuyên viết về đồng tính và những góc khuất trong thế giới thứ ba. Những tác phẩm “Đời Callboy”, hay “Chênh vênh 25” của nhà văn sinh 28 tuổi này được bạn đọc nhiệt tình đón nhận. Việc tạo dựng một phong cách riêng cho mình có vẻ đã đem đến cho Nguyễn Ngọc Thạch những thành công nhất định.', 1614407908);
INSERT INTO `authors` VALUES ('a24c222a-668f-11eb-9fe5-e673ac9d1856', 'Hamlet Trương', 'https://toplist.vn/images/800px/hamlet-truong-299075.jpg', 'Hamlet Trương tên thật là Lê Văn Trương, sinh năm 1988, anh hoạt động trong nhiều lĩnh vực: ca sĩ, nhạc sĩ, nhà văn, MC cho Radio và Talk show trên truyền hình. Mặc dù phủ sóng ở nhiều lĩnh vực khác nhau nhưng cái tên Hamlet Trương khá lu mờ trong showbiz Việt, cho tới khi bén duyên với nghề viết, anh mới được biết tới rộng rãi và sở hữu một lượng độc giả nhất nhì làng sách.', 1614407908);
INSERT INTO `authors` VALUES ('a2fab2c2-668f-11eb-9fe5-e673ac9d1856', 'Đỗ Nhật Nam', 'https://toplist.vn/images/800px/do-nhat-nam-299074.jpg', 'Người ta thường nói \\\" Tuổi trẻ tài cao\\\" là câu nói không ngoa khi dành cho cậu bé thần đồng Việt Nam Đỗ Nhật Nam. “Bố mẹ đã cưa đổ tớ” là cuốn sách thứ 3 sau “Những con chữ biết hát” và “Tớ đã học tiếng Anh như thế nào”. Ở tuổi 13, với những thành tích mà Nhật Nam làm được, người ta không chỉ dành cho em một tràng pháo tay cổ vũ, mà đó là sự thán phục, ngưỡng mộ. Cậu bé tài năng xuất chúng này trước đây cũng thường xuyên xuất hiện trên một số chương trình truyền hình nhưng hiện nay cậu đã lên đường xuất ngoại.', 1614407908);
INSERT INTO `authors` VALUES ('a3b5f73a-668f-11eb-9fe5-e673ac9d1856', 'Nguyễn Ngọc Sơn (Sơn Paris)', 'https://toplist.vn/images/800px/nha-van-noi-tieng-nhat-viet-nam-16392.jpg', 'Nguyễn Ngọc Sơn, nghệ danh là Sơn Paris sinh năm 1994, dù tuổi đời còn non trẻ nhưng những tác phẩm anh mang lại cho người đọc, đặc biệt là giới trẻ lại chiếm được nhiều tình cảm và sự hâm mộ dành cho anh. Hiện nay anh đã xuất bản được hai cuốn sách ăn khách mang tên: “Trót lỡ chạm môi nhau”, “Muốn khóc thật to”. Từng là thủ khoa Học viện Ngoại giao và gặt hái được nhiều thành tích đáng nể, nhưng Sơn Paris lựa chọn viết sách là con đường lớn nhất cho mình. Sách của Sơn Paris luôn nằm trong những tác phẩm được đón đợi nhất, đặc biệt phù hợp với lứa tuổi học sinh và độc giả nữ.', 1614407908);
INSERT INTO `authors` VALUES ('f4822e92-887f-11eb-9a21-9a22a40a03e5', 'Ở Đây Zui Nè', 'https://res.cloudinary.com/demo/image/upload/w_150,c_scale/v1616136865/69817911_646077425914558_9131404323052322816_n_zhkqxg.jpg', 'Ở ĐÂY ZUI LẮM LUÔN ÓH', 1616135307);

-- ----------------------------
-- Table structure for cart_items
-- ----------------------------
DROP TABLE IF EXISTS `cart_items`;
CREATE TABLE `cart_items`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `price` float NOT NULL,
  `discount` float NOT NULL,
  `quantity` smallint NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `product_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cart_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `cart_id`(`cart_id`) USING BTREE,
  CONSTRAINT `cart_items_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `cart_items_ibfk_2` FOREIGN KEY (`cart_id`) REFERENCES `carts` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart_items
-- ----------------------------
INSERT INTO `cart_items` VALUES ('0a8897a0-78ca-11eb-925f-8e9e0d9a6912', 1614407908, 1614409472, 91358, 6118, 1, NULL, '9650227e-66a7-11eb-ae93-0242ac130002', 'c6137a40-78c9-11eb-925f-8e9e0d9a6912');
INSERT INTO `cart_items` VALUES ('11b582f6-88a4-11eb-8a72-069f31a319ab', 1616150447, 1616152388, 206478, 6773, 2, NULL, '964f943a-66a7-11eb-ae93-0242ac130002', 'e110ef44-7581-11eb-b414-e6d65bd6c1b4');

-- ----------------------------
-- Table structure for carts
-- ----------------------------
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `subtotal` float NOT NULL,
  `item_discount` float NOT NULL,
  `tax` float NOT NULL,
  `shipping` float NOT NULL,
  `total` float NOT NULL,
  `promo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `discount` float NULL DEFAULT NULL,
  `grand_total` float NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of carts
-- ----------------------------
INSERT INTO `carts` VALUES ('c6137a40-78c9-11eb-925f-8e9e0d9a6912', 1614407908, 1614410696, 91358, 6118, 0, 20000, 105240, 'hiu', 20000, 85240, NULL, '284dcd9c-78c9-11eb-925f-8e9e0d9a6912');
INSERT INTO `carts` VALUES ('e110ef44-7581-11eb-b414-e6d65bd6c1b4', 1614048594, 1616213761, 412956, 13546, 0, 20000, 419410, 'None', 0, 419410, NULL, '5fc5f970100333097e15017b');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES ('3454a4ba-7c36-11eb-bd18-86a19eb826b2', 'Thiếu Nhi', 1614407908);
INSERT INTO `categories` VALUES ('3d9cd940-80b7-11eb-b2b2-12425fdab01d', 'Pháp Luật', 1614407908);
INSERT INTO `categories` VALUES ('4bd016ae-668f-11eb-9fe5-e673ac9d1856', 'Văn Học', 1614407908);
INSERT INTO `categories` VALUES ('4d1f327e-668f-11eb-9fe5-e673ac9d1856', 'Tiểu Sử Hồi Kí', 1614407908);
INSERT INTO `categories` VALUES ('4dd75bba-668f-11eb-9fe5-e673ac9d1856', 'Giáo Khoa - Tham Khảo', 1614407908);
INSERT INTO `categories` VALUES ('4e6d0ba6-668f-11eb-9fe5-e673ac9d1856', 'Ngoại Ngữ', 1614407908);
INSERT INTO `categories` VALUES ('4f03f7fa-668f-11eb-9fe5-e673ac9d1856', 'Kinh Tế', 1614407908);
INSERT INTO `categories` VALUES ('4f971f08-668f-11eb-9fe5-e673ac9d1856', 'Tâm Lí - Kĩ Năng Sống', 1614407908);
INSERT INTO `categories` VALUES ('502ac08c-668f-11eb-9fe5-e673ac9d1856', 'Nuôi Dạy Con', 1614407908);
INSERT INTO `categories` VALUES ('50da8a6c-668f-11eb-9fe5-e673ac9d1856', 'Văn Phòng Phẩm', 1614407908);

-- ----------------------------
-- Table structure for coupons
-- ----------------------------
DROP TABLE IF EXISTS `coupons`;
CREATE TABLE `coupons`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `code` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `value` float NOT NULL,
  `max_value` float NOT NULL,
  `amount` smallint NOT NULL,
  `start_date` int NOT NULL,
  `end_date` int NOT NULL,
  `is_enable` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `code`(`code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of coupons
-- ----------------------------
INSERT INTO `coupons` VALUES ('0a4016cc-75ca-11eb-91a7-fa45ade5da4f', 1614075480, 1616174588, 'lucdeptrai12', 'Mã giảm giá cho người đẹp trai. Tối đa 20k', 25, 20000, 9, 1616174584, 1618939384, 1);
INSERT INTO `coupons` VALUES ('293df384-78ca-11eb-925f-8e9e0d9a6912', 1614407908, 1616174606, 'hiu', 'Mã giảm giá cho người đẹp trai. Tối đa 20k', 11, 20000, 10, 1614533002, 1617125002, 1);

-- ----------------------------
-- Table structure for order_details
-- ----------------------------
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE `order_details`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `product_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `order_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` float NOT NULL,
  `quantity` smallint NOT NULL,
  `discount` float NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `order_id`(`order_id`) USING BTREE,
  CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_details
-- ----------------------------
INSERT INTO `order_details` VALUES ('2b56d30e-80b6-11eb-b2b2-12425fdab01d', 1615269070, 1615280546, '964f937c-66a7-11eb-ae93-0242ac130002', '2b505466-80b6-11eb-b2b2-12425fdab01d', 176718, 5, 13356, NULL);
INSERT INTO `order_details` VALUES ('2b5913e4-80b6-11eb-b2b2-12425fdab01d', 1615269070, 1615280546, '964f943a-66a7-11eb-ae93-0242ac130002', '2b505466-80b6-11eb-b2b2-12425fdab01d', 206478, 3, 6773, NULL);
INSERT INTO `order_details` VALUES ('2b5ac658-80b6-11eb-b2b2-12425fdab01d', 1615269070, 1615280546, '964f8f44-66a7-11eb-ae93-0242ac130002', '2b505466-80b6-11eb-b2b2-12425fdab01d', 49312, 17, 2518, NULL);
INSERT INTO `order_details` VALUES ('2e1865c0-83e1-11eb-9fea-f6ab2c016046', 1615617972, 1615628872, '964f8f44-66a7-11eb-ae93-0242ac130002', '2e1708e2-83e1-11eb-9fea-f6ab2c016046', 49312, 1, 2518, NULL);
INSERT INTO `order_details` VALUES ('2e1928fc-83e1-11eb-9fea-f6ab2c016046', 1615617972, 1615628872, '964f943a-66a7-11eb-ae93-0242ac130002', '2e1708e2-83e1-11eb-9fea-f6ab2c016046', 206478, 2, 6773, NULL);
INSERT INTO `order_details` VALUES ('2e19c28a-83e1-11eb-9fea-f6ab2c016046', 1615617972, 1615628872, '9650227e-66a7-11eb-ae93-0242ac130002', '2e1708e2-83e1-11eb-9fea-f6ab2c016046', 91358, 1, 6118, NULL);
INSERT INTO `order_details` VALUES ('3548082e-75cb-11eb-91a7-fa45ade5da4f', 1614075480, 1614080119, '964f8f44-66a7-11eb-ae93-0242ac130002', '3541504c-75cb-11eb-91a7-fa45ade5da4f', 49312, 1, 2518, NULL);
INSERT INTO `order_details` VALUES ('3549ceca-75cb-11eb-91a7-fa45ade5da4f', 1614075480, 1614080119, '96500ee2-66a7-11eb-ae93-0242ac130002', '3541504c-75cb-11eb-91a7-fa45ade5da4f', 89409, 2, 11643, NULL);
INSERT INTO `order_details` VALUES ('354b025e-75cb-11eb-91a7-fa45ade5da4f', 1614075480, 1614080119, '9650227e-66a7-11eb-ae93-0242ac130002', '3541504c-75cb-11eb-91a7-fa45ade5da4f', 91358, 3, 6118, NULL);
INSERT INTO `order_details` VALUES ('4cd15f4e-887d-11eb-9a21-9a22a40a03e5', 1616135307, 1616135730, '964f8f44-66a7-11eb-ae93-0242ac130002', '4cce871a-887d-11eb-9a21-9a22a40a03e5', 49312, 2, 2518, NULL);
INSERT INTO `order_details` VALUES ('7adc3334-775f-11eb-8658-ba2b37327332', 1614251196, 1614253753, '96503dcc-66a7-11eb-ae93-0242ac130002', '7ad74d38-775f-11eb-8658-ba2b37327332', 39780, 3, 14885, NULL);
INSERT INTO `order_details` VALUES ('7ae26006-775f-11eb-8658-ba2b37327332', 1614251196, 1614253753, '964f8f44-66a7-11eb-ae93-0242ac130002', '7ad74d38-775f-11eb-8658-ba2b37327332', 49312, 4, 2518, NULL);
INSERT INTO `order_details` VALUES ('92943286-75d1-11eb-90e2-8a09e634f4e5', 1614080976, 1614082853, '964f8f44-66a7-11eb-ae93-0242ac130002', '928e7404-75d1-11eb-90e2-8a09e634f4e5', 49312, 6, 2518, NULL);
INSERT INTO `order_details` VALUES ('929d9dd0-75d1-11eb-90e2-8a09e634f4e5', 1614080976, 1614082853, '9650227e-66a7-11eb-ae93-0242ac130002', '928e7404-75d1-11eb-90e2-8a09e634f4e5', 91358, 2, 6118, NULL);

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `status` smallint NOT NULL,
  `subtotal` float NOT NULL,
  `item_discount` float NOT NULL,
  `tax` float NOT NULL,
  `shipping` float NOT NULL,
  `total` float NOT NULL,
  `promo` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `discount` float NULL DEFAULT NULL,
  `grand_total` float NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `user_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `address_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  INDEX `address_id`(`address_id`) USING BTREE,
  CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES ('2b505466-80b6-11eb-b2b2-12425fdab01d', 1615269070, 1615280546, 1, 2341330, 129905, 0, 20000, 2231420, 'lucdeptrai12', 20000, 2211420, '', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');
INSERT INTO `orders` VALUES ('2e1708e2-83e1-11eb-9fea-f6ab2c016046', 1615617972, 1615628872, 1, 553626, 22182, 0, 20000, 551444, 'None', 0, 551444, '', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');
INSERT INTO `orders` VALUES ('3541504c-75cb-11eb-91a7-fa45ade5da4f', 1614075480, 1614080119, 4, 274074, 18354, 0, 20000, 275720, NULL, 0, 275720, '', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');
INSERT INTO `orders` VALUES ('4cce871a-887d-11eb-9a21-9a22a40a03e5', 1616135307, 1616135730, 1, 98624, 5036, 0, 20000, 113588, 'None', 0, 113588, 'God', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');
INSERT INTO `orders` VALUES ('7ad74d38-775f-11eb-8658-ba2b37327332', 1614251196, 1614253753, 2, 316588, 54727, 0, 20000, 281861, 'None', 0, 281861, '', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');
INSERT INTO `orders` VALUES ('928e7404-75d1-11eb-90e2-8a09e634f4e5', 1614080976, 1614082853, 3, 478588, 27344, 0, 20000, 471244, 'None', 0, 471244, 'Hiu', '5fc5f970100333097e15017b', '13ad0d94-74f0-11eb-a21f-0620d1835099');

-- ----------------------------
-- Table structure for product_cost
-- ----------------------------
DROP TABLE IF EXISTS `product_cost`;
CREATE TABLE `product_cost`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `cost` float NOT NULL,
  `quantity` smallint NOT NULL,
  `total` float NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `product_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `product_cost_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_cost
-- ----------------------------
INSERT INTO `product_cost` VALUES ('09203ad0-8a5b-11eb-8e32-3417eb638a82', 1616339190, 33000, 10, 330000, 'Nhap hang luc: 1616340916', 'd55f0ae8-8a56-11eb-a9ae-3417eb638a82');
INSERT INTO `product_cost` VALUES ('a91467b2-8939-11eb-8dcd-0242ac130003', 1612404265, 34518.4, 148, 5108720, 'Nhap hang', '964f8f44-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9146a00-8939-11eb-8dcd-0242ac130003', 1612404629, 71360.8, 12, 856330, 'Nhap hang', '964f91a6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9146d34-8939-11eb-8dcd-0242ac130003', 1612404633, 147190, 164, 24139200, 'Nhap hang', '964f92a0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9146e10-8939-11eb-8dcd-0242ac130003', 1612404855, 123703, 91, 11256900, 'Nhap hang', '964f937c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9146ed8-8939-11eb-8dcd-0242ac130003', 1612404829, 144535, 139, 20090300, 'Nhap hang', '964f943a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9146f8c-8939-11eb-8dcd-0242ac130003', 1612404465, 139588, 126, 17588000, 'Nhap hang', '964f9502-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147036-8939-11eb-8dcd-0242ac130003', 1612404516, 93455.6, 76, 7102630, 'Nhap hang', '964f9890-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91470ea-8939-11eb-8dcd-0242ac130003', 1612404958, 165371, 3, 496112, 'Nhap hang', '964f994e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914719e-8939-11eb-8dcd-0242ac130003', 1612404870, 118843, 19, 2258020, 'Nhap hang', '964f9a0c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91473ec-8939-11eb-8dcd-0242ac130003', 1612404695, 112632, 76, 8560040, 'Nhap hang', '964f9ac0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91474b4-8939-11eb-8dcd-0242ac130003', 1612405033, 113268, 84, 9514550, 'Nhap hang', '964f9b74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147568-8939-11eb-8dcd-0242ac130003', 1612404394, 38292.1, 197, 7543540, 'Nhap hang', '964f9c28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914761c-8939-11eb-8dcd-0242ac130003', 1612404851, 135839, 197, 26760300, 'Nhap hang', '964f9cd2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91476c6-8939-11eb-8dcd-0242ac130003', 1612404850, 74946.9, 19, 1423990, 'Nhap hang', '964f9d86-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914777a-8939-11eb-8dcd-0242ac130003', 1612404720, 47937.4, 52, 2492740, 'Nhap hang', '964fa074-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914782e-8939-11eb-8dcd-0242ac130003', 1612404464, 99162, 92, 9122900, 'Nhap hang', '964fa132-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147b08-8939-11eb-8dcd-0242ac130003', 1612404404, 120848, 13, 1571020, 'Nhap hang', '964fa1dc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147bd0-8939-11eb-8dcd-0242ac130003', 1612404022, 30174.2, 78, 2353590, 'Nhap hang', '964fa290-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147c84-8939-11eb-8dcd-0242ac130003', 1612404934, 92077.3, 132, 12154200, 'Nhap hang', '964fa344-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147d38-8939-11eb-8dcd-0242ac130003', 1612404110, 155394, 130, 20201200, 'Nhap hang', '964fa3f8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147de2-8939-11eb-8dcd-0242ac130003', 1612404291, 133961, 158, 21165900, 'Nhap hang', '964fa4ac-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147e96-8939-11eb-8dcd-0242ac130003', 1612404952, 23123.8, 82, 1896150, 'Nhap hang', '964fa560-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9147f40-8939-11eb-8dcd-0242ac130003', 1612404304, 20831.3, 150, 3124700, 'Nhap hang', '964fa858-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148206-8939-11eb-8dcd-0242ac130003', 1612404294, 20788.6, 175, 3638000, 'Nhap hang', '964fa916-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91482c4-8939-11eb-8dcd-0242ac130003', 1612404537, 197680, 94, 18581900, 'Nhap hang', '964fa9c0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148378-8939-11eb-8dcd-0242ac130003', 1612404131, 159069, 61, 9703190, 'Nhap hang', '964faa74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914842c-8939-11eb-8dcd-0242ac130003', 1612404736, 74566.8, 170, 12676400, 'Nhap hang', '964fab28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91484e0-8939-11eb-8dcd-0242ac130003', 1612404889, 147466, 33, 4866360, 'Nhap hang', '964fabdc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914858a-8939-11eb-8dcd-0242ac130003', 1612404425, 104382, 123, 12839000, 'Nhap hang', '964fac90-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148652-8939-11eb-8dcd-0242ac130003', 1612404234, 44522.8, 83, 3695390, 'Nhap hang', '964faf42-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914888c-8939-11eb-8dcd-0242ac130003', 1612404647, 139099, 124, 17248300, 'Nhap hang', '964fb00a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148954-8939-11eb-8dcd-0242ac130003', 1612404848, 165686, 167, 27669600, 'Nhap hang', '964fb0b4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148a08-8939-11eb-8dcd-0242ac130003', 1612404661, 75137.3, 54, 4057410, 'Nhap hang', '964fb17c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148ad0-8939-11eb-8dcd-0242ac130003', 1612404857, 87035.2, 57, 4961010, 'Nhap hang', '964fb244-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148b98-8939-11eb-8dcd-0242ac130003', 1612404222, 127623, 186, 23737900, 'Nhap hang', '964fb302-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148c56-8939-11eb-8dcd-0242ac130003', 1612404379, 39361, 23, 905303, 'Nhap hang', '964fb3b6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148d0a-8939-11eb-8dcd-0242ac130003', 1612404076, 114232, 145, 16563700, 'Nhap hang', '964fb474-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9148fc6-8939-11eb-8dcd-0242ac130003', 1612404499, 19870.9, 4, 79483.6, 'Nhap hang', '964fb6ae-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149084-8939-11eb-8dcd-0242ac130003', 1612404129, 203802, 190, 38722400, 'Nhap hang', '964fb776-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149138-8939-11eb-8dcd-0242ac130003', 1612404153, 53425.4, 120, 6411050, 'Nhap hang', '964fb834-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91491e2-8939-11eb-8dcd-0242ac130003', 1612404310, 61908.7, 179, 11081700, 'Nhap hang', '964fb8e8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149296-8939-11eb-8dcd-0242ac130003', 1612404503, 81430.3, 110, 8957330, 'Nhap hang', '964fb9a6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914934a-8939-11eb-8dcd-0242ac130003', 1612404237, 115245, 193, 22242300, 'Nhap hang', '964fba5a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149566-8939-11eb-8dcd-0242ac130003', 1612404243, 51119.6, 191, 9763840, 'Nhap hang', '964fbb18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914962e-8939-11eb-8dcd-0242ac130003', 1612404095, 161841, 162, 26218200, 'Nhap hang', '964fbd7a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91496d8-8939-11eb-8dcd-0242ac130003', 1612404480, 122327, 182, 22263500, 'Nhap hang', '964fbe42-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914978c-8939-11eb-8dcd-0242ac130003', 1612404429, 150483, 3, 451450, 'Nhap hang', '964fbeec-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149840-8939-11eb-8dcd-0242ac130003', 1612404416, 104105, 98, 10202300, 'Nhap hang', '964fbfa0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91498f4-8939-11eb-8dcd-0242ac130003', 1612404942, 143372, 129, 18495000, 'Nhap hang', '964fc054-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91499b2-8939-11eb-8dcd-0242ac130003', 1612404826, 174198, 189, 32923400, 'Nhap hang', '964fc108-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149c0a-8939-11eb-8dcd-0242ac130003', 1612404264, 99740.2, 146, 14562100, 'Nhap hang', '964fc1bc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149cd2-8939-11eb-8dcd-0242ac130003', 1612404352, 95837, 40, 3833480, 'Nhap hang', '964fc446-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149d86-8939-11eb-8dcd-0242ac130003', 1612404272, 110741, 2, 221481, 'Nhap hang', '964fc50e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149e44-8939-11eb-8dcd-0242ac130003', 1612404017, 117608, 47, 5527560, 'Nhap hang', '964fc5c2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9149f02-8939-11eb-8dcd-0242ac130003', 1612404700, 164156, 93, 15266500, 'Nhap hang', '964fc676-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a1dc-8939-11eb-8dcd-0242ac130003', 1612404845, 71411.2, 133, 9497690, 'Nhap hang', '964fc72a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a2c2-8939-11eb-8dcd-0242ac130003', 1612405051, 123811, 171, 21171700, 'Nhap hang', '964fc7de-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a542-8939-11eb-8dcd-0242ac130003', 1612404871, 139978, 100, 13997800, 'Nhap hang', '964fc892-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a614-8939-11eb-8dcd-0242ac130003', 1612404136, 189295, 39, 7382490, 'Nhap hang', '964fc950-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a6d2-8939-11eb-8dcd-0242ac130003', 1612404665, 72377.9, 7, 506645, 'Nhap hang', '964fcc3e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a790-8939-11eb-8dcd-0242ac130003', 1612404030, 118097, 164, 19367900, 'Nhap hang', '964fccf2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a84e-8939-11eb-8dcd-0242ac130003', 1612404700, 20535.2, 2, 41070.4, 'Nhap hang', '964fcda6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a902-8939-11eb-8dcd-0242ac130003', 1612404872, 142036, 23, 3266820, 'Nhap hang', '964fce50-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914a9c0-8939-11eb-8dcd-0242ac130003', 1612404117, 77644.7, 48, 3726950, 'Nhap hang', '964fcf04-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914aa7e-8939-11eb-8dcd-0242ac130003', 1612405023, 101921, 107, 10905600, 'Nhap hang', '964fcfb8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ad3a-8939-11eb-8dcd-0242ac130003', 1612404189, 200913, 154, 30940500, 'Nhap hang', '964fd06c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ae02-8939-11eb-8dcd-0242ac130003', 1612404550, 71515.5, 123, 8796410, 'Nhap hang', '964fd27e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914aeb6-8939-11eb-8dcd-0242ac130003', 1612404128, 95506.6, 58, 5539380, 'Nhap hang', '964fd33c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914af74-8939-11eb-8dcd-0242ac130003', 1612404254, 25008.9, 125, 3126110, 'Nhap hang', '964fd3f0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b028-8939-11eb-8dcd-0242ac130003', 1612404837, 69010.2, 5, 345051, 'Nhap hang', '964fd4a4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b0e6-8939-11eb-8dcd-0242ac130003', 1612404200, 158220, 52, 8227420, 'Nhap hang', '964fd558-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b1a4-8939-11eb-8dcd-0242ac130003', 1612404052, 163497, 20, 3269940, 'Nhap hang', '964fd602-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b456-8939-11eb-8dcd-0242ac130003', 1612404476, 127462, 98, 12491300, 'Nhap hang', '964fd8fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b51e-8939-11eb-8dcd-0242ac130003', 1612404204, 88459, 19, 1680720, 'Nhap hang', '964fd9c2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b5d2-8939-11eb-8dcd-0242ac130003', 1612404902, 137659, 1, 137659, 'Nhap hang', '964fda6c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b686-8939-11eb-8dcd-0242ac130003', 1612404389, 186073, 58, 10792300, 'Nhap hang', '964fdb20-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b744-8939-11eb-8dcd-0242ac130003', 1612404743, 96326.3, 43, 4142030, 'Nhap hang', '964fdbd4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b7f8-8939-11eb-8dcd-0242ac130003', 1612404248, 83553.4, 162, 13535700, 'Nhap hang', '964fdc88-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b8c0-8939-11eb-8dcd-0242ac130003', 1612405041, 53334.4, 196, 10453500, 'Nhap hang', '964fdd46-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914b974-8939-11eb-8dcd-0242ac130003', 1612404571, 124832, 12, 1497990, 'Nhap hang', '964fddfa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914bc80-8939-11eb-8dcd-0242ac130003', 1612404805, 36426.6, 123, 4480470, 'Nhap hang', '964fe048-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914bd48-8939-11eb-8dcd-0242ac130003', 1612404364, 147001, 51, 7497070, 'Nhap hang', '964fe106-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914be06-8939-11eb-8dcd-0242ac130003', 1612405008, 76696.9, 16, 1227150, 'Nhap hang', '964fe1ba-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914beba-8939-11eb-8dcd-0242ac130003', 1612404371, 177829, 120, 21339400, 'Nhap hang', '964fe26e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914bf64-8939-11eb-8dcd-0242ac130003', 1612404340, 187520, 185, 34691100, 'Nhap hang', '964fe322-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c022-8939-11eb-8dcd-0242ac130003', 1612404610, 184582, 110, 20304100, 'Nhap hang', '964fe3e0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c0e0-8939-11eb-8dcd-0242ac130003', 1612404529, 115386, 0, 0, 'Nhap hang', '964fe494-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c194-8939-11eb-8dcd-0242ac130003', 1612404264, 143456, 19, 2725660, 'Nhap hang', '964fe6f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c450-8939-11eb-8dcd-0242ac130003', 1612404974, 132784, 72, 9560480, 'Nhap hang', '964fe7be-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c518-8939-11eb-8dcd-0242ac130003', 1612404724, 72969.4, 199, 14520900, 'Nhap hang', '964fe872-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c5cc-8939-11eb-8dcd-0242ac130003', 1612404115, 164195, 198, 32510600, 'Nhap hang', '964fe930-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c676-8939-11eb-8dcd-0242ac130003', 1612404297, 95016.6, 91, 8646510, 'Nhap hang', '964fe9e4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c734-8939-11eb-8dcd-0242ac130003', 1612404538, 199556, 154, 30731600, 'Nhap hang', '964fea98-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c7f2-8939-11eb-8dcd-0242ac130003', 1612404886, 180891, 91, 16461100, 'Nhap hang', '964feb56-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c8b0-8939-11eb-8dcd-0242ac130003', 1612404199, 33920.6, 19, 644491, 'Nhap hang', '964fed90-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914c96e-8939-11eb-8dcd-0242ac130003', 1612404696, 140725, 107, 15057600, 'Nhap hang', '964fee58-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914cbda-8939-11eb-8dcd-0242ac130003', 1612404207, 207962, 155, 32234200, 'Nhap hang', '964fef0c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914cca2-8939-11eb-8dcd-0242ac130003', 1612404574, 164844, 190, 31320400, 'Nhap hang', '964fefca-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914cd56-8939-11eb-8dcd-0242ac130003', 1612404722, 49531.3, 71, 3516720, 'Nhap hang', '964ff07e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ce0a-8939-11eb-8dcd-0242ac130003', 1612404286, 24980.9, 160, 3996940, 'Nhap hang', '964ff132-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914cec8-8939-11eb-8dcd-0242ac130003', 1612404637, 29386, 19, 558334, 'Nhap hang', '964ff1f0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914cf86-8939-11eb-8dcd-0242ac130003', 1612404899, 56791, 6, 340746, 'Nhap hang', '964ff2ae-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d03a-8939-11eb-8dcd-0242ac130003', 1612404944, 188802, 150, 28320300, 'Nhap hang', '964ff4ca-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d0f8-8939-11eb-8dcd-0242ac130003', 1612404309, 20489, 128, 2622590, 'Nhap hang', '964ff592-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d382-8939-11eb-8dcd-0242ac130003', 1612404747, 82220.6, 109, 8962040, 'Nhap hang', '964ff646-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d44a-8939-11eb-8dcd-0242ac130003', 1612404170, 206754, 176, 36388700, 'Nhap hang', '964ff6fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d4fe-8939-11eb-8dcd-0242ac130003', 1612404137, 43259.3, 110, 4758520, 'Nhap hang', '964ff7a4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d5a8-8939-11eb-8dcd-0242ac130003', 1612404282, 65716, 75, 4928700, 'Nhap hang', '964ff858-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d666-8939-11eb-8dcd-0242ac130003', 1612404100, 76596.1, 106, 8119190, 'Nhap hang', '964ff90c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d724-8939-11eb-8dcd-0242ac130003', 1612404448, 143720, 86, 12360000, 'Nhap hang', '964fff74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914d7d8-8939-11eb-8dcd-0242ac130003', 1612404528, 72088.8, 151, 10885400, 'Nhap hang', '965000a0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914da80-8939-11eb-8dcd-0242ac130003', 1612404989, 58289.7, 167, 9734380, 'Nhap hang', '96500168-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914db48-8939-11eb-8dcd-0242ac130003', 1612405049, 24229.8, 108, 2616820, 'Nhap hang', '96500230-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914dbfc-8939-11eb-8dcd-0242ac130003', 1612404684, 40552.4, 172, 6975010, 'Nhap hang', '965002ee-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914dca6-8939-11eb-8dcd-0242ac130003', 1612404150, 182142, 155, 28232000, 'Nhap hang', '965004b0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914dd64-8939-11eb-8dcd-0242ac130003', 1612404432, 49580.3, 160, 7932850, 'Nhap hang', '96500582-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914de18-8939-11eb-8dcd-0242ac130003', 1612404931, 80331.3, 85, 6828160, 'Nhap hang', '965007c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914decc-8939-11eb-8dcd-0242ac130003', 1612404979, 122276, 101, 12349900, 'Nhap hang', '96500898-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914df8a-8939-11eb-8dcd-0242ac130003', 1612404520, 91023.8, 34, 3094810, 'Nhap hang', '96500942-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e1ce-8939-11eb-8dcd-0242ac130003', 1612404005, 23795.8, 133, 3164840, 'Nhap hang', '965009f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e296-8939-11eb-8dcd-0242ac130003', 1612404198, 105904, 174, 18427400, 'Nhap hang', '96500ab4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e34a-8939-11eb-8dcd-0242ac130003', 1612405034, 113550, 113, 12831100, 'Nhap hang', '96500b68-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e408-8939-11eb-8dcd-0242ac130003', 1612404870, 151849, 71, 10781300, 'Nhap hang', '96500e1a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e4bc-8939-11eb-8dcd-0242ac130003', 1612404158, 62586.3, 181, 11328100, 'Nhap hang', '96500ee2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e57a-8939-11eb-8dcd-0242ac130003', 1612404928, 171342, 102, 17476900, 'Nhap hang', '96500f96-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e62e-8939-11eb-8dcd-0242ac130003', 1612405058, 174179, 186, 32397300, 'Nhap hang', '9650104a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e6ec-8939-11eb-8dcd-0242ac130003', 1612404140, 185301, 37, 6856140, 'Nhap hang', '96501108-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914e99e-8939-11eb-8dcd-0242ac130003', 1612404462, 165574, 162, 26823000, 'Nhap hang', '965011c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ea5c-8939-11eb-8dcd-0242ac130003', 1612404083, 28259, 183, 5171400, 'Nhap hang', '96501284-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914eb10-8939-11eb-8dcd-0242ac130003', 1612404321, 191911, 47, 9019800, 'Nhap hang', '96501342-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ebc4-8939-11eb-8dcd-0242ac130003', 1612404769, 103435, 161, 16653000, 'Nhap hang', '96501a18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ec82-8939-11eb-8dcd-0242ac130003', 1612404541, 176935, 94, 16631900, 'Nhap hang', '96501b3a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ed36-8939-11eb-8dcd-0242ac130003', 1612404655, 136984, 55, 7534100, 'Nhap hang', '96501bf8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914edf4-8939-11eb-8dcd-0242ac130003', 1612404019, 118868, 121, 14383000, 'Nhap hang', '96501cac-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f01a-8939-11eb-8dcd-0242ac130003', 1612404522, 58229.5, 152, 8850880, 'Nhap hang', '96501d6a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f0ec-8939-11eb-8dcd-0242ac130003', 1612404674, 108842, 99, 10775300, 'Nhap hang', '96501e28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f1a0-8939-11eb-8dcd-0242ac130003', 1612404507, 29760.5, 177, 5267610, 'Nhap hang', '96501ee6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f25e-8939-11eb-8dcd-0242ac130003', 1612404321, 24626.7, 148, 3644750, 'Nhap hang', '96501fa4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f312-8939-11eb-8dcd-0242ac130003', 1612404560, 138984, 101, 14037300, 'Nhap hang', '965021c0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f3d0-8939-11eb-8dcd-0242ac130003', 1612404602, 63950.6, 59, 3773090, 'Nhap hang', '9650227e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f484-8939-11eb-8dcd-0242ac130003', 1612404581, 197798, 53, 10483300, 'Nhap hang', '9650233c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f72c-8939-11eb-8dcd-0242ac130003', 1612404990, 26880.7, 167, 4489080, 'Nhap hang', '965023fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f7ea-8939-11eb-8dcd-0242ac130003', 1612404691, 161287, 45, 7257920, 'Nhap hang', '965024b8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f89e-8939-11eb-8dcd-0242ac130003', 1612405022, 98326.2, 138, 13569000, 'Nhap hang', '96502576-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914f952-8939-11eb-8dcd-0242ac130003', 1612404174, 113300, 118, 13369400, 'Nhap hang', '96502634-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914fa10-8939-11eb-8dcd-0242ac130003', 1612404961, 35534.1, 16, 568546, 'Nhap hang', '965028aa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914fac4-8939-11eb-8dcd-0242ac130003', 1612404505, 140552, 97, 13633500, 'Nhap hang', '9650295e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914fb82-8939-11eb-8dcd-0242ac130003', 1612404622, 185622, 137, 25430300, 'Nhap hang', '96502a1c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914fc36-8939-11eb-8dcd-0242ac130003', 1612404745, 159540, 128, 20421100, 'Nhap hang', '96502ad0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914feac-8939-11eb-8dcd-0242ac130003', 1612404690, 47737.9, 18, 859282, 'Nhap hang', '96502b8e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a914ff6a-8939-11eb-8dcd-0242ac130003', 1612404612, 27965, 38, 1062670, 'Nhap hang', '96502c4c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a915001e-8939-11eb-8dcd-0242ac130003', 1612404739, 46080.3, 134, 6174760, 'Nhap hang', '96502e5e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91500d2-8939-11eb-8dcd-0242ac130003', 1612404471, 183085, 125, 22885600, 'Nhap hang', '96502f26-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150186-8939-11eb-8dcd-0242ac130003', 1612404825, 158390, 77, 12196100, 'Nhap hang', '96502fe4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150244-8939-11eb-8dcd-0242ac130003', 1612404349, 63540.4, 16, 1016650, 'Nhap hang', '965030a2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91502f8-8939-11eb-8dcd-0242ac130003', 1612404867, 118068, 109, 12869400, 'Nhap hang', '96503160-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a915053c-8939-11eb-8dcd-0242ac130003', 1612404348, 96403.3, 109, 10508000, 'Nhap hang', '96503214-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91505fa-8939-11eb-8dcd-0242ac130003', 1612404447, 169639, 192, 32570800, 'Nhap hang', '965033fe-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91506ae-8939-11eb-8dcd-0242ac130003', 1612404196, 153323, 41, 6286250, 'Nhap hang', '965034c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150762-8939-11eb-8dcd-0242ac130003', 1612404316, 25064.2, 194, 4862460, 'Nhap hang', '9650357a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150820-8939-11eb-8dcd-0242ac130003', 1612404782, 159036, 49, 7792750, 'Nhap hang', '96503638-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91508d4-8939-11eb-8dcd-0242ac130003', 1612404549, 139717, 93, 12993700, 'Nhap hang', '965036f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150992-8939-11eb-8dcd-0242ac130003', 1612404646, 183417, 48, 8804010, 'Nhap hang', '96503980-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150a46-8939-11eb-8dcd-0242ac130003', 1612405048, 168004, 65, 10920200, 'Nhap hang', '96503a3e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150d2a-8939-11eb-8dcd-0242ac130003', 1612404099, 109042, 190, 20718100, 'Nhap hang', '96503af2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150df2-8939-11eb-8dcd-0242ac130003', 1612404663, 58146.9, 102, 5930980, 'Nhap hang', '96503b9c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150ea6-8939-11eb-8dcd-0242ac130003', 1612404449, 24665.2, 133, 3280470, 'Nhap hang', '96503c5a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a9150f5a-8939-11eb-8dcd-0242ac130003', 1612404913, 79383.5, 55, 4366090, 'Nhap hang', '96503d18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a915100e-8939-11eb-8dcd-0242ac130003', 1612404202, 27846, 158, 4399670, 'Nhap hang', '96503dcc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91510c2-8939-11eb-8dcd-0242ac130003', 1612404799, 176279, 70, 12339500, 'Nhap hang', '96503fde-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a915118a-8939-11eb-8dcd-0242ac130003', 1612404143, 122229, 12, 1466750, 'Nhap hang', '9650409c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a915123e-8939-11eb-8dcd-0242ac130003', 1612404982, 165737, 138, 22871700, 'Nhap hang', '96504150-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('a91514a0-8939-11eb-8dcd-0242ac130003', 1612404115, 152224, 50, 7611200, 'Nhap hang', '9650420e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_cost` VALUES ('d55f0ae9-8a56-11eb-81ae-3417eb638a82', 1616338330, 32000, 20, 640000, 'Nhap hang luc: 1616339111', 'd55f0ae8-8a56-11eb-a9ae-3417eb638a82');
INSERT INTO `product_cost` VALUES ('f92fb820-8955-11eb-8dcd-0242ac130003', 1612405312, 100000, 10, 1000000, 'Luc nhap', '964f937c-66a7-11eb-ae93-0242ac130002');

-- ----------------------------
-- Table structure for product_images
-- ----------------------------
DROP TABLE IF EXISTS `product_images`;
CREATE TABLE `product_images`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `imageURL` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `filename` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `product_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_images
-- ----------------------------
INSERT INTO `product_images` VALUES ('16252896-88d6-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616173863/VLHB_shop/z7l9wfquajvc9wp7un4o.jpg', 'VLHB_shop/z7l9wfquajvc9wp7un4o', NULL);
INSERT INTO `product_images` VALUES ('1bc55bcc-8930-11eb-82ee-dea52fa1801d', 'https://res.cloudinary.com/vlcoder/image/upload/v1616212527/VLHB_shop/yafu6lqlfqyzapoukkdd.png', 'VLHB_shop/yafu6lqlfqyzapoukkdd', NULL);
INSERT INTO `product_images` VALUES ('2dccfb62-88d2-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616172184/VLHB_shop/ndkxrcwdmym6zyv9a5go.png', 'VLHB_shop/ndkxrcwdmym6zyv9a5go', NULL);
INSERT INTO `product_images` VALUES ('2fb12f62-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_33312.jpg', 'hhihi', '964f8f44-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb131d8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia-1_kinhvanhoa_tap-4_mem.jpg', 'hhihi', '964f91a6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13430-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_187843.jpg', 'hhihi', '964f92a0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13502-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_182041.jpg', 'hhihi', '964f937c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb135ca-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_174210.jpg', 'hhihi', '964f943a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13688-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nhungngaybuonchongqua.jpg', 'hhihi', '964f9502-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13962-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cuoicungnguoivandi_1.jpg', 'hhihi', '964f9890-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13a48-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_23062.jpg', 'hhihi', '964f994e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13cf0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935235213746.jpg', 'hhihi', '964f9a0c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13db8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936071673800.jpg', 'hhihi', '964f9ac0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13e6c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_130113.jpg', 'hhihi', '964f9b74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb13f2a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936067597936.jpg', 'hhihi', '964f9c28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb140e2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_58819.jpg', 'hhihi', '964f9cd2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb141a0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2199.jpg', 'hhihi', '964f9d86-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1425e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_140322.jpg', 'hhihi', '964fa074-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14420-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936067595758.jpg', 'hhihi', '964fa132-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb144e8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_181813.jpg', 'hhihi', '964fa1dc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1459c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_187195.jpg', 'hhihi', '964fa290-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb146d2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_136963.jpg', 'hhihi', '964fa344-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14862-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nguoncoi.jpg', 'hhihi', '964fa3f8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14916-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bieutuongthattruyen.jpg', 'hhihi', '964fa4ac-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb149de-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/91727.jpg', 'hhihi', '964fa560-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14bb4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936186544125.jpg', 'hhihi', '964fa858-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14c72-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8934974164135-qt.jpg', 'hhihi', '964fa916-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14d26-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_21580.jpg', 'hhihi', '964fa9c0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14dda-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/187.jpg', 'hhihi', '964faa74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb14f42-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bialondithoi.jpg', 'hhihi', '964fab28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15118-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cover-chi_n-thu_t-lo_i-b_-lo-l_ng.jpg', 'hhihi', '964fabdc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb151d6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cover-chi_n-thu_t-qu_n-l_-th_i-gian.jpg', 'hhihi', '964fac90-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1528a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_olaithanhphohayveque-01_1.jpg', 'hhihi', '964faf42-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1533e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_186710.jpg', 'hhihi', '964fb00a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15514-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/6e076a9087583e35575486c5cbc45ffa.jpg', 'hhihi', '964fb0b4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb155c8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_134016.jpg', 'hhihi', '964fb17c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1567c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_35.gif', 'hhihi', '964fb244-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15866-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_86237.jpg', 'hhihi', '964fb302-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15924-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cs-19-tinvaongaymai.u84.d20161126.t011006.704696.jpg', 'hhihi', '964fb3b6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb159d8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935086838808.jpg', 'hhihi', '964fb474-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15a8c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_127127.jpg', 'hhihi', '964fb6ae-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15c08-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_26_8.jpg', 'hhihi', '964fb776-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15cbc-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_can-bang-cam-xuc.jpg', 'hhihi', '964fb834-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15eb0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_cu-song-tam-bo-mai-duoc-sao-final-1.jpg', 'hhihi', '964fb8e8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb15f6e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_990.jpg', 'hhihi', '964fb9a6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16022-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nong-gian-la-ban-nang-1.jpg', 'hhihi', '964fba5a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb160ea-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/muon-an-thi-duoc-an.jpg', 'hhihi', '964fbb18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb161a8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/combo-8936037711331-8936037799834.jpg', 'hhihi', '964fbd7a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16324-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_song-don-gian-cho-minh-thanh-than.jpg', 'hhihi', '964fbe42-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb163e2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/hanh_phuc_khong_nam_trong_vi_bia_1.jpg', 'hhihi', '964fbeec-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb165ae-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/huyen-thuat-va-cac-dao-sy-tay-tang.jpg', 'hhihi', '964fbfa0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb166e4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/resize_w500_hauto_nhan-sinh-muon-ve-dung-voi-so-do-bia-1-5e5f68d009a2f.jpg', 'hhihi', '964fc054-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb167a2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_nang_len_duoc_dat_xuong_duoc-1.jpg', 'hhihi', '964fc108-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1696e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935235215283.jpg', 'hhihi', '964fc1bc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16a2c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9789822288988.jpg', 'hhihi', '964fc446-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16ae0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_4953.jpg', 'hhihi', '964fc50e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16c48-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786047736041_2.jpg', 'hhihi', '964fc5c2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16cfc-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786047736058.jpg', 'hhihi', '964fc676-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16e32-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935251405873.jpg', 'hhihi', '964fc72a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb16fd6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_17267.jpg', 'hhihi', '964fc7de-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17094-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/14_1.png', 'hhihi', '964fc892-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17148-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_189157_1.jpg', 'hhihi', '964fc950-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb172b0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_188733_1.jpg', 'hhihi', '964fcc3e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1736e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/tim-minh-trong-the-gioi-hau-tuoi-tho-01-_2_.jpg', 'hhihi', '964fccf2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1749a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_29509_1.jpg', 'hhihi', '964fcda6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17558-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_vongquanhnoibuon.jpg', 'hhihi', '964fce50-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17774-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_183259.jpg', 'hhihi', '964fcf04-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17832-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_31590.jpg', 'hhihi', '964fcfb8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb178f0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_16482.jpg', 'hhihi', '964fd06c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb179a4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936037710358.png', 'hhihi', '964fd27e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17b48-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/duongmayxutuyetnew.u5762.d20171011.t095442.6383_1.jpg', 'hhihi', '964fd33c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17c06-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_188014.jpg', 'hhihi', '964fd3f0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17cc4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/untitled-1_122_1.jpg', 'hhihi', '964fd4a4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17dc8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/b_a-trc-y_u-m_nh-trc-_-01.jpg', 'hhihi', '964fd558-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb17f94-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia---dam-thay-doi.jpg', 'hhihi', '964fd602-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18052-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_123079.jpg', 'hhihi', '964fd8fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18106-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_179061.jpg', 'hhihi', '964fd9c2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18250-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935251405972_1.jpg', 'hhihi', '964fda6c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18304-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_14922.jpg', 'hhihi', '964fdb20-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb184c6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_184792.jpg', 'hhihi', '964fdbd4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1857a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/untitled-1_9_25_1.jpg', 'hhihi', '964fdc88-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1862e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nghe_thuat_tu_duy_ranh_mach_u2487_d20161129_t103616_398639_550x550.jpg', 'hhihi', '964fdd46-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18782-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/5555555555555555555555555.jpg', 'hhihi', '964fddfa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18840-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/kynanglamviecnhomcuanguoinhat_bia1.jpg', 'hhihi', '964fe048-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb188f4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_177780.jpg', 'hhihi', '964fe106-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18af2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936067598643.jpg', 'hhihi', '964fe1ba-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18ba6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_182745.jpg', 'hhihi', '964fe26e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18c5a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_192656.jpg', 'hhihi', '964fe322-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18df4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_189591.jpg', 'hhihi', '964fe3e0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb18ec6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/fffffffffffffff_1_3_2.jpg', 'hhihi', '964fe494-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19114-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_25998.jpg', 'hhihi', '964fe6f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb191d2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935251414585.jpg', 'hhihi', '964fe7be-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19290-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/the-small-big.jpg', 'hhihi', '964fe872-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1934e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936037710761_1.jpg', 'hhihi', '964fe930-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19402-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786047740277.jpg', 'hhihi', '964fe9e4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19588-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_23994.jpg', 'hhihi', '964fea98-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1963c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_191588.jpg', 'hhihi', '964feb56-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb196f0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_37937.jpg', 'hhihi', '964fed90-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb198d0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_190115.jpg', 'hhihi', '964fee58-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1998e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/untitled-ssssssssss1.jpg', 'hhihi', '964fef0c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19a4c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/untitled-1_33_7.jpg', 'hhihi', '964fefca-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19c0e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/untitled-1_42.jpg', 'hhihi', '964ff07e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19ccc-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia_final.jpg', 'hhihi', '964ff132-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19d8a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935212330305.jpg', 'hhihi', '964ff1f0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19efc-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_188285.jpg', 'hhihi', '964ff2ae-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb19fb0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_20355.jpg', 'hhihi', '964ff4ca-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a14a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_187010.jpg', 'hhihi', '964ff592-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a208-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936037799797.jpg', 'hhihi', '964ff646-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a2bc-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_138366.jpg', 'hhihi', '964ff6fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a438-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/neuocsencotinhyeu-1.jpg', 'hhihi', '964ff7a4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a4ec-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786049573569_1.jpg', 'hhihi', '964ff858-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a5aa-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia-am-da-hanh-01.jpg', 'hhihi', '964ff90c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a71c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nxbtre_thumb_21542017_035423.jpg', 'hhihi', '964fff74-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a7da-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/buoc_cham_lai_giua_the_gian_voi_va.u335.d20160817.t102115.612356.jpg', 'hhihi', '965000a0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a88e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_187012.jpg', 'hhihi', '96500168-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1a99c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_180812.jpg', 'hhihi', '96500230-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1aafa-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/bia-toi_no_tuong_lai_mot_ngay_hanh_phuc.jpg', 'hhihi', '965002ee-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1abae-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/conchonhobiathuong.jpg', 'hhihi', '965004b0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1acee-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935235216884.jpg', 'hhihi', '96500582-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1adac-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/roi_trong_choi_voi_full_final_1.jpg', 'hhihi', '965007c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1af00-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_190512.jpg', 'hhihi', '96500898-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1afbe-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/ngancanhhac_bia1_2.jpg', 'hhihi', '96500942-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b144-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/unnamed_2_6.jpg', 'hhihi', '965009f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b27a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/161.jpg', 'hhihi', '96500ab4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b32e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_188807.jpg', 'hhihi', '96500b68-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b4d2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936049524905.jpg', 'hhihi', '96500e1a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b586-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935251403862.jpg', 'hhihi', '96500ee2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b63a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/khongconthoigiandebuon.jpg', 'hhihi', '96500f96-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b766-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_187738.jpg', 'hhihi', '9650104a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b8e2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cover-1---m_-_om-_m.jpg', 'hhihi', '96501108-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1b9a0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_28975.jpg', 'hhihi', '965011c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1baf4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_1233.jpg', 'hhihi', '96501284-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1bbb2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/91727.jpg', 'hhihi', '96501342-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1bce8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_12629.jpg', 'hhihi', '96501a18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1bda6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935250712002.jpg', 'hhihi', '96501b3a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1bfc2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786045641040.jpg', 'hhihi', '96501bf8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c080-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_23371.jpg', 'hhihi', '96501cac-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c13e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936040589583.jpg', 'hhihi', '96501d6a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c1f2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935270700058-1_1_1.jpg', 'hhihi', '96501e28-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c2b0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936071674579.jpg', 'hhihi', '96501ee6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c4ae-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_29802.jpg', 'hhihi', '96501fa4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c562-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/ww_1.jpg', 'hhihi', '965021c0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c620-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_188104.jpg', 'hhihi', '9650227e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c6d4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nnn_2.jpg', 'hhihi', '9650233c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c88c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195135.jpg', 'hhihi', '965023fa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1c94a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/9786048434052.jpg', 'hhihi', '965024b8-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1cb0c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_26631.jpg', 'hhihi', '96502576-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1cbd4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935211187269.jpg', 'hhihi', '96502634-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1cd0a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/hoang-loan-hon-loan-va-cuong-loan--01.jpg', 'hhihi', '965028aa-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1cde6-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_22722.jpg', 'hhihi', '9650295e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1cfe4-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_38858.jpg', 'hhihi', '96502a1c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d0a2-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_180164_1_43_1_57_1_4_1_2_1_210_1_29_1_98_1_25_1_21_1_5_1_3_1_18_1_18_1_45_1_26_1_32_1_14_1_2662.jpg', 'hhihi', '96502ad0-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d160-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_34396.jpg', 'hhihi', '96502b8e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d21e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_37347.jpg', 'hhihi', '96502c4c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d552-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_37353.jpg', 'hhihi', '96502e5e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d656-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936062804527-qt.jpg', 'hhihi', '96502f26-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d70a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/sach.jpg', 'hhihi', '96502fe4-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d7c8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/nhangoaicamphanthibichhang.jpg', 'hhihi', '965030a2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1d9d0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_30721.jpg', 'hhihi', '96503160-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1da8e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_37348.jpg', 'hhihi', '96503214-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1db4c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/tu_truyen_le_cong_vinh-phut_89.jpg', 'hhihi', '965033fe-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1dc00-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/cristiano-_-leo---bia-1.jpg', 'hhihi', '965034c6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1ddb8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936071674173.jpg', 'hhihi', '9650357a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1de76-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936066702621_1_2.jpg', 'hhihi', '96503638-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1df2a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935251407655.jpg', 'hhihi', '965036f6-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e10a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8934974150879.jpg', 'hhihi', '96503980-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e1c8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8936186544071_1_1.jpg', 'hhihi', '96503a3e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e27c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/l_-ti_u-long---m_t-cu_c-_i-phi-th_ng.jpg', 'hhihi', '96503af2-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e39e-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/b_a-chu_n-_1_.jpg', 'hhihi', '96503b9c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e45c-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_192661.jpg', 'hhihi', '96503c5a-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e5b0-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_22978.jpg', 'hhihi', '96503d18-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e6c8-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_134014.jpg', 'hhihi', '96503dcc-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e7fe-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/8935086843611.jpg', 'hhihi', '96503fde-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1e934-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/hoi-ky-bui-kien-thanh-b_a-1.jpg', 'hhihi', '9650409c-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1eb0a-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_27262.jpg', 'hhihi', '96504150-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('2fb1ebbe-66a8-11eb-ae93-0242ac130002', 'https://raw.githubusercontent.com/MrL8199/Online-Bookstore/main/TriThucOnline_TTN/TriThucOnline_TTN/Content/HinhAnhSP/image_195509_1_7222.jpg', 'hhihi', '9650420e-66a7-11eb-ae93-0242ac130002');
INSERT INTO `product_images` VALUES ('641928a4-8930-11eb-82ee-dea52fa1801d', 'https://res.cloudinary.com/vlcoder/image/upload/v1616212648/VLHB_shop/refqlkalxk27gzzw0wv3.png', 'VLHB_shop/refqlkalxk27gzzw0wv3', NULL);
INSERT INTO `product_images` VALUES ('6735db14-88d5-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616173569/VLHB_shop/jphf1ccfuojx4fd4idcs.png', 'VLHB_shop/jphf1ccfuojx4fd4idcs', NULL);
INSERT INTO `product_images` VALUES ('92b0a6c2-88ce-11eb-833e-261ed7bee09b', 'https://res.cloudinary.com/vlcoder/image/upload/v1616170636/VLHB_shop/hdngvuclwltmkx24abi4.jpg', 'VLHB_shop/hdngvuclwltmkx24abi4', 'bc693308-88ce-11eb-833e-261ed7bee09b');
INSERT INTO `product_images` VALUES ('9db113ac-857e-11eb-8486-022f881fd553', 'https://res.cloudinary.com/vlcoder/image/upload/v1615806441/VLHB_shop/xasa04wpngdsfmalnjbb.jpg', 'VLHB_shop/xasa04wpngdsfmalnjbb', NULL);
INSERT INTO `product_images` VALUES ('a4239b44-88d3-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616172813/VLHB_shop/jikj43cykaiatkgnm3dr.png', 'VLHB_shop/jikj43cykaiatkgnm3dr', NULL);
INSERT INTO `product_images` VALUES ('a8ba6ff2-88d3-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616172821/VLHB_shop/vd52mij8r04kvjqtm55m.png', 'VLHB_shop/vd52mij8r04kvjqtm55m', NULL);
INSERT INTO `product_images` VALUES ('b7bb6296-88d2-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616172416/VLHB_shop/krsizycrfj24frbu4ijv.jpg', 'VLHB_shop/krsizycrfj24frbu4ijv', NULL);
INSERT INTO `product_images` VALUES ('bd069e56-88d1-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616171995/VLHB_shop/vuujxxic1ouztjtyfxaw.png', 'VLHB_shop/vuujxxic1ouztjtyfxaw', NULL);
INSERT INTO `product_images` VALUES ('bd825d1a-88d2-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616172426/VLHB_shop/xkv7qvt7ivwzeyl6tn5i.png', 'VLHB_shop/xkv7qvt7ivwzeyl6tn5i', NULL);
INSERT INTO `product_images` VALUES ('cfa719de-88d4-11eb-bd38-5abc72cafad9', 'https://res.cloudinary.com/vlcoder/image/upload/v1616173315/VLHB_shop/f6yhwekksxw06gcydnrx.png', 'VLHB_shop/f6yhwekksxw06gcydnrx', NULL);
INSERT INTO `product_images` VALUES ('d4589990-8a56-11eb-a2cf-3417eb638a82', 'https://res.cloudinary.com/vlcoder/image/upload/v1616339109/VLHB_shop/rf2gom1bmezzyueatnhn.jpg', 'VLHB_shop/rf2gom1bmezzyueatnhn', 'd55f0ae8-8a56-11eb-a9ae-3417eb638a82');

-- ----------------------------
-- Table structure for products
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `title` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price` float NOT NULL,
  `publish_year` int NULL DEFAULT NULL,
  `page_number` int NULL DEFAULT NULL,
  `quantity` int NOT NULL,
  `quotes_about` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `discount` float NOT NULL,
  `start_at` int NULL DEFAULT NULL,
  `end_at` int NULL DEFAULT NULL,
  `author_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `publisher_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `category_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `author_id`(`author_id`) USING BTREE,
  INDEX `publisher_id`(`publisher_id`) USING BTREE,
  INDEX `category_id`(`category_id`) USING BTREE,
  CONSTRAINT `products_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `authors` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_2` FOREIGN KEY (`publisher_id`) REFERENCES `publishers` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `products_ibfk_3` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES ('964f8f44-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Vui Vẻ Không Quạu Nha', 49312, 2007, 691, 148, 'Chưa có trích dẫn.', 5424.32, 1612405067, 1612405067, 'a24c222a-668f-11eb-9fe5-e673ac9d1856', 'cb843858-668f-11eb-9fe5-e673ac9d1856', '4f03f7fa-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f91a6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Kính Vạn Hoa Chết Chóc (Tập 4)', 101944, 2012, 159, 12, 'Chưa có trích dẫn.', 9174.96, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f92a0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thiên Hạ Chi Vương (Tái Bản 2019)', 210272, 2015, 453, 164, 'Chưa có trích dẫn.', 35746.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f937c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Người Chết Thuê', 176718, 2013, 343, 91, 'Chưa có trích dẫn.', 21206.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f943a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Gam Lam Không Thực', 206478, 2012, 250, 139, 'Chưa có trích dẫn.', 28906.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9502-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Ngày Buồn Chóng Qua', 199411, 2005, 328, 126, 'Chưa có trích dẫn.', 35894, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9890-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cuối Cùng, Người Vẫn Đi', 133508, 2017, 581, 76, 'Chưa có trích dẫn.', 22696.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f994e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Có Nhiều Người Trong Một Người', 236244, 2009, 354, 3, 'Chưa có trích dẫn.', 21262, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9a0c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhà Gỉa Kim( Tái Bản 2017)', 169776, 2013, 312, 19, 'Chưa có trích dẫn.', 27164.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9ac0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hảo Hán Nơi Trảng Cát', 160903, 2013, 164, 76, 'Chưa có trích dẫn.', 24135.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9b74-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bên Bờ Sông Piedra Tôi Ngồi Khóc', 161812, 2003, 400, 84, 'Chưa có trích dẫn.', 21035.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9c28-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ông Gìa Và Biển Cả', 54703, 2008, 697, 197, 'Chưa có trích dẫn.', 7111.39, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9cd2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tiếng Chim Hót Trong Bụi Mận Gai (Tái Bản)', 194056, 2011, 425, 197, 'Chưa có trích dẫn.', 31049, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964f9d86-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tôi Thấy Hoa Vàng Trên Cỏ Xanh (Bản Mới - 2018)', 107067, 2005, 592, 19, 'Chưa có trích dẫn.', 17130.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa074-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Không Gia Đình', 68482, 2010, 236, 52, 'Chưa có trích dẫn.', 7533.02, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa132-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Tấm Lòng Cao Cả', 141660, 2020, 172, 92, 'Chưa có trích dẫn.', 19832.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa1dc-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chuyện Con Mèo Và Con Chuột Bạn Thân Của Nó (Tái Bản 2019)', 172640, 2011, 627, 13, 'Chưa có trích dẫn.', 18990.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa290-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, '999 Lá Thư Gửi Cho Chính Mình - Mong Bạn Trở Thành Phiên Bản Hoàn Hảo Nhất (Tái ', 43106, 2012, 297, 78, 'Chưa có trích dẫn.', 7759.08, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa344-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cấu Tạo Một Gái Lệch Chuẩn', 131539, 2001, 320, 132, 'Chưa có trích dẫn.', 15784.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa3f8-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nguồn Cội', 221991, 2011, 567, 130, 'Chưa có trích dẫn.', 28858.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa4ac-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Combo Nguồn Cội + Biểu Tượng Thất Truyền (Bộ 2 Cuốn) (Tái Bản 2020)', 191373, 2016, 320, 158, 'Chưa có trích dẫn.', 22964.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa560-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mắt Biếc - Tặng Kèm Postcard + 1 Số Tay Phiên Bản Phim (Mẫu Sổ Giao Ngẫu Nhiên)', 33034, 2016, 517, 82, 'Chưa có trích dẫn.', 4294.42, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa858-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bữa Cơm Ngày Mai Chúng Ta Cùng Chờ Đợi', 29759, 2000, 137, 150, 'Chưa có trích dẫn.', 3868.67, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa916-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Làm Bạn Với Bầu Trời - Tặng Kèm Khung Hình Xinh Xắn (Số Lượng Có Hạn)', 29698, 2012, 566, 175, 'Chưa có trích dẫn.', 3860.74, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fa9c0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Lặng Thương Đến Hoàng Hôn (Tái Bản 2019)', 282400, 2008, 309, 94, 'Chưa có trích dẫn.', 53656, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964faa74-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hay Là Hạnh Phúc Trừ Mình Ra', 227241, 2007, 254, 61, 'Chưa có trích dẫn.', 40903.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fab28-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Lớn Đi Thôi Cho Kịp Cuộc Đời', 106524, 2008, 407, 170, 'Chưa có trích dẫn.', 11717.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fabdc-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chiến Thuật Loại Bỏ Lo Lắng - Dành Cho Người Lười: Đọc Ít, Nghĩ Nhiều', 210665, 2011, 364, 33, 'Chưa có trích dẫn.', 18959.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fac90-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chiến Thuật Quản Lý Thời Gian - Dành Cho Người Lười: Đọc Ít, Nghĩ Nhiều', 149117, 2004, 547, 123, 'Chưa có trích dẫn.', 20876.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964faf42-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ở Lại Thành Phố Hay Về Quê?', 63604, 2013, 308, 83, 'Chưa có trích dẫn.', 12084.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb00a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Khi Tài Năng Không Theo Kịp Giấc Mơ (Tái Bản 2019)', 198713, 2020, 409, 124, 'Chưa có trích dẫn.', 17884.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb0b4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Giới Hạn Của Bạn Chỉ Là Xuất Phát Điểm Của Tôi (Tái Bản 2019)', 236695, 2002, 560, 167, 'Chưa có trích dẫn.', 21302.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb17c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hạt Giống Tâm Hồn - Khi Bạn Mất Niềm Tin', 107339, 2012, 498, 54, 'Chưa có trích dẫn.', 15027.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb244-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Khoảng Lặng Cuộc Sống (Tái Bản 2016)', 124336, 2012, 627, 57, 'Chưa có trích dẫn.', 16163.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb302-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hạt Giống Tâm Hồn - Tập 11 - Những Trải Nghiệm Cuộc Sống (Tái Bản 2016)', 182319, 2012, 642, 186, 'Chưa có trích dẫn.', 16408.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb3b6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chicken Soup For The Soul - Tin Vào Ngày Mai', 56230, 2007, 163, 23, 'Chưa có trích dẫn.', 6747.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb474-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chicken Soup For The Soul - Cảm Hứng Cuộc Sống (Tái Bản 2016)', 163189, 2002, 441, 145, 'Chưa có trích dẫn.', 22846.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb6ae-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chicken Soup For The Soul 1 - Chia Sẻ Tâm Hồn Và Quà Tặng Cuộc Sống (Tái Bản 201', 28387, 2004, 174, 4, 'Chưa có trích dẫn.', 4825.79, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb776-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Khéo Ăn Nói Sẽ Có Được Thiên Hạ - Bản Mới', 291146, 2009, 369, 190, 'Chưa có trích dẫn.', 32026.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb834-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cân Bằng Cảm Xúc, Cả Lúc Bão Giông', 76322, 2015, 553, 120, 'Chưa có trích dẫn.', 14501.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb8e8-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cứ Sống Tạm Bợ Mãi Được Sao?', 88441, 2001, 552, 179, 'Chưa có trích dẫn.', 15919.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fb9a6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thử Thách 52 Nghề - Mỗi Tuần 1 Nghề Bạn Có Dám Không', 116329, 2015, 230, 110, 'Chưa có trích dẫn.', 12796.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fba5a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nóng Giận Là Bản Năng, Tĩnh Lặng Là Bản Lĩnh', 164636, 2009, 117, 193, 'Chưa có trích dẫn.', 21402.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fbb18-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Muốn An được An (Tái Bản 2018)', 73028, 2002, 679, 191, 'Chưa có trích dẫn.', 10223.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fbd7a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Combo Muốn An Được An + Tĩnh Lặng - Sức Mạnh Tĩnh Lặng Trong Thế Giới Huyền Ảo (', 231201, 2002, 227, 162, 'Chưa có trích dẫn.', 43928.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fbe42-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sống Đơn Giản Cho Mình Thanh Thản', 174753, 2002, 635, 182, 'Chưa có trích dẫn.', 24465.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fbeec-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hạnh Phúc Không Nằm Trong Ví', 214976, 2012, 212, 3, 'Chưa có trích dẫn.', 32246.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fbfa0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Huyền Thuật Và Các Đạo Sĩ Tây Tạng', 148721, 2010, 322, 98, 'Chưa có trích dẫn.', 16359.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc054-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhân Sinh Muôn Vẻ, Đừng Vội So Đo', 204817, 2001, 160, 129, 'Chưa có trích dẫn.', 18433.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc108-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nâng Lên Được, Đặt Xuống Được', 248854, 2000, 364, 189, 'Chưa có trích dẫn.', 24885.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc1bc-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Dám Bị Ghét', 142486, 2003, 408, 146, 'Chưa có trích dẫn.', 12823.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc446-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tôi Tài Giỏi, Bạn Cũng Thế! (Tái Bản 2019)', 136910, 2012, 526, 40, 'Chưa có trích dẫn.', 24643.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc50e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Dạy Con Dùng Tiền (Tái Bản 2019)', 158201, 2003, 129, 2, 'Chưa có trích dẫn.', 18984.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc5c2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Con Có Thể Tự Bảo Vệ Mình - Cơ Thể Con Là Của Con', 168011, 2014, 215, 47, 'Chưa có trích dẫn.', 23521.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc676-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Con Có Thể Tự Bảo Vệ Mình - Con Không Bao Giờ Đi Lạc', 234508, 2014, 247, 93, 'Chưa có trích dẫn.', 42211.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc72a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Vô Cùng Tàn Nhẫn, Vô Cùng Yêu Thương (Tái Bản 2017)', 102016, 2001, 559, 133, 'Chưa có trích dẫn.', 15302.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc7de-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cách Trò Chuyện Với Con Trước 10 Tuổi Quyết Định Tương Lai Của Con', 176873, 1999, 393, 171, 'Chưa có trích dẫn.', 21224.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc892-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nghệ Thuật Tinh Tế Của Việc \"Đếch\" Quan Tâm', 199968, 1999, 356, 100, 'Chưa có trích dẫn.', 31994.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fc950-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bạn Đắt Giá Bao Nhiêu? (Tái Bản 2019)', 270421, 1999, 505, 39, 'Chưa có trích dẫn.', 45971.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fcc3e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Khí Chất Bao Nhiêu, Hạnh Phúc Bấy Nhiêu (Tái Bản 2019 - Lần 2)', 103397, 2010, 452, 7, 'Chưa có trích dẫn.', 18611.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fccf2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tìm Mình Trong Thế Giới Hậu Tuổi Thơ', 168710, 2007, 272, 164, 'Chưa có trích dẫn.', 16871, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fcda6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Dăm Ba Cái Tuổi Trẻ (Tái Bản 2020)', 29336, 2012, 464, 2, 'Chưa có trích dẫn.', 4693.76, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fce50-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Vòng Quanh Nỗi Buồn', 202908, 1999, 146, 23, 'Chưa có trích dẫn.', 30436.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fcf04-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đàn Ông Sao Hỏa Đàn Bà Sao Kim', 110921, 2011, 665, 48, 'Chưa có trích dẫn.', 12201.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fcfb8-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Gắn Bó Yêu Thương', 145602, 2001, 165, 107, 'Chưa có trích dẫn.', 26208.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd06c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sự Thật Tàn Nhẫn Về Gia Đình, Con Cái Và Tiền Bạc', 287018, 2005, 291, 154, 'Chưa có trích dẫn.', 34442.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd27e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đọc Nhanh, Hiểu Sâu, Nhớ Lâu Trọn Đời', 102165, 2019, 254, 123, 'Chưa có trích dẫn.', 12259.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd33c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đường Mây Qua Xứ Tuyết - Tái Bản 2018', 136438, 2014, 250, 58, 'Chưa có trích dẫn.', 16372.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd3f0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mỉm Cười Dù Cuộc Đời Là Thế (Tái Bản 2019)', 35727, 2015, 269, 125, 'Chưa có trích dẫn.', 3572.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd4a4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Combo Fahasa (Cà Phê Cùng Tony + Trên Đường Băng) (2018)', 98586, 2007, 289, 5, 'Chưa có trích dẫn.', 9858.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd558-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Yêu Mình Trước Đã, Yêu Đời Để Sau', 226028, 2011, 353, 52, 'Chưa có trích dẫn.', 24863.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd602-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Dám Thay Đổi - 52 Bài Thực Hành Sống Bằng Cả Trái Tim', 233567, 2005, 109, 20, 'Chưa có trích dẫn.', 25692.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd8fa-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sống Trọn Vẹn Mỗi Ngày', 182089, 2016, 350, 98, 'Chưa có trích dẫn.', 30955.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fd9c2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Siêu Trí Nhớ', 126370, 2001, 318, 19, 'Chưa có trích dẫn.', 18955.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fda6c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tư Duy Nhanh Và Chậm (Tái Bản)', 196656, 2011, 540, 1, 'Chưa có trích dẫn.', 19665.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fdb20-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hiểu Về Trái Tim (Tái Bản 2019)', 265819, 2003, 636, 58, 'Chưa có trích dẫn.', 45189.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fdbd4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ta Vui Đời Sẽ Vui', 137609, 2006, 274, 43, 'Chưa có trích dẫn.', 23393.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fdc88-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tôi Thích Bản Thân Nỗ Lực Hơn (Tái bản 2019)', 119362, 2013, 422, 162, 'Chưa có trích dẫn.', 13129.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fdd46-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nghệ Thuật Tư Duy Rành Mạch (Tái Bản 2018)', 76192, 2003, 104, 196, 'Chưa có trích dẫn.', 6857.28, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fddfa-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Combo Kỹ Năng Tư Duy (Bộ 5 Cuốn)', 178332, 2002, 405, 12, 'Chưa có trích dẫn.', 23183.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe048-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Kỹ Năng Làm Việc Nhóm Của Người Nhật', 52038, 2014, 259, 123, 'Chưa có trích dẫn.', 7285.32, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe106-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mặc Kệ Thiên Hạ Sống Như Người Nhật (Tái Bản 2018)', 210002, 2005, 347, 51, 'Chưa có trích dẫn.', 29400.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe1ba-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Bài Học Không Có Nơi Giảng Đường', 109567, 2015, 420, 16, 'Chưa có trích dẫn.', 18626.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe26e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hành Trang Vào Đời', 254041, 2011, 584, 120, 'Chưa có trích dẫn.', 33025.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe322-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sống Với Niềm Vui Mỗi Ngày (Tái Bản 2019)', 267885, 1999, 567, 185, 'Chưa có trích dẫn.', 37503.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe3e0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thái Độ Sống Tạo Nên Tất Cả (Tái Bản)', 263689, 2007, 227, 110, 'Chưa có trích dẫn.', 23732, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe494-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cảm Xúc Là Kẻ Thù Số Một Của Thành Công 2 - Tặng Kèm Chữ Ký Tác Giả + 2 Bưu Thiế', 164837, 1999, 698, 0, 'Chưa có trích dẫn.', 29670.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe6f6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Kinh Nghiệm Thành Công Của Ông Chủ Nhỏ', 204937, 2018, 651, 19, 'Chưa có trích dẫn.', 22543.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe7be-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Đòn Tâm Lý Trong Thuyết Phục (Tái Bản 2019)', 189692, 2003, 575, 72, 'Chưa có trích dẫn.', 26556.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe872-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'The Small Big - Tuyệt Chiêu Thuyết Phục, Hạ Gục Khách Hàng', 104242, 2003, 409, 199, 'Chưa có trích dẫn.', 19806, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe930-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chiến Thắng Con Quỷ Trong Bạn (Tái Bản 2018)', 234564, 2011, 498, 198, 'Chưa có trích dẫn.', 35184.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fe9e4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tốt Như Vàng - Bí Quyết Làm Giàu Và Sống Hạnh Phúc', 135738, 2018, 597, 91, 'Chưa có trích dẫn.', 20360.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fea98-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Làm Thế Nào Để Tăng Lương?', 285080, 2011, 106, 154, 'Chưa có trích dẫn.', 45612.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964feb56-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Những Nguyên Tắc Vàng Của Napoleon Hill', 258416, 2001, 166, 91, 'Chưa có trích dẫn.', 49099, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fed90-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, '79 Quy Tắc Hay Trong Giao Tiếp (Tái Bản 2019)', 48458, 2003, 372, 19, 'Chưa có trích dẫn.', 6784.12, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fee58-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sức Mạnh Của Ngôn Từ (Tái Bản 2019)', 201036, 2001, 430, 107, 'Chưa có trích dẫn.', 18093.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fef0c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hiệu Ứng Đèn Gas', 297089, 2011, 615, 155, 'Chưa có trích dẫn.', 47534.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fefca-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Gia Đình Mình Hòa Hợp Là Được', 235492, 2013, 232, 190, 'Chưa có trích dẫn.', 40033.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff07e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hoàn Hảo Cũng Được, Không Hoàn Hảo Cũng Được (Trọn Bộ 3 Cuốn)', 70759, 2000, 613, 71, 'Chưa có trích dẫn.', 8491.08, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff132-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đặc Quyền Của Gái Hư', 35687, 2000, 449, 160, 'Chưa có trích dẫn.', 3925.57, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff1f0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nghìn Lẻ Một Đêm - Tập 2', 41980, 2000, 123, 19, 'Chưa có trích dẫn.', 4617.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff2ae-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chuyện Con Mèo Dạy Hải Âu Bay (Tái Bản 2019)', 81130, 2004, 431, 6, 'Chưa có trích dẫn.', 11358.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff4ca-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhật Ký Chú Bé Nhút Nhát - Tập 1', 269717, 2003, 193, 150, 'Chưa có trích dẫn.', 32366, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff592-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hoàng Tử Bé (Tái Bản 2019)', 29270, 2015, 597, 128, 'Chưa có trích dẫn.', 4390.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff646-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ehon - Cây Sồi', 117458, 2000, 150, 109, 'Chưa có trích dẫn.', 21142.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff6fa-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Yêu Không Bến Bờ', 295363, 2007, 302, 176, 'Chưa có trích dẫn.', 32489.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff7a4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nếu Ốc Sên Có Tình Yêu (Tái Bản 2017)', 61799, 2011, 700, 110, 'Chưa có trích dẫn.', 6179.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff858-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhật Ký Săn Đuổi Tội Ác', 93880, 2019, 291, 75, 'Chưa có trích dẫn.', 8449.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964ff90c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ám Dạ Hành', 109423, 2020, 524, 106, 'Chưa có trích dẫn.', 18601.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('964fff74-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Harry Potter Và Hòn Đá Phù Thuỷ - Tập 1 (Tái Bản 2017)', 205315, 2006, 188, 86, 'Chưa có trích dẫn.', 18478.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965000a0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bước Chậm Lại Giữa Thế Gian Vội Vã (Tái Bản 2018)', 102984, 2013, 206, 151, 'Chưa có trích dẫn.', 12358.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500168-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Vừa Buông Tay Đã Thành Xa Lạ', 83271, 2012, 371, 167, 'Chưa có trích dẫn.', 12490.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500230-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sự Im Lặng Của Bầy Cừu (Tái Bản 2019)', 34614, 2017, 436, 108, 'Chưa có trích dẫn.', 5538.24, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965002ee-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tôi Nợ Tương Lai Một Ngày Hạnh Phúc', 57932, 2010, 646, 172, 'Chưa có trích dẫn.', 11007.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965004b0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Con Chó Nhỏ Mang Giỏ Hoa Hồng (Bìa Mềm)', 260203, 2009, 410, 155, 'Chưa có trích dẫn.', 44234.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500582-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chuyện Con Ốc Sên Muốn Biết Tại Sao Nó Chậm Chạp (Tái Bản 2018)', 70829, 2017, 601, 160, 'Chưa có trích dẫn.', 13457.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965007c6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Rơi Trong Chơi Vơi', 114759, 1999, 195, 85, 'Chưa có trích dẫn.', 11475.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500898-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chuyện Con Chó Tên Là Trung Thành', 174680, 2020, 655, 101, 'Chưa có trích dẫn.', 26202, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500942-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Ngàn Cánh Hạc - Bản Bìa Cứng - Tặng Kèm Bookmark', 130034, 2009, 457, 34, 'Chưa có trích dẫn.', 15604.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965009f6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sống Đời Bình An', 33994, 2008, 107, 133, 'Chưa có trích dẫn.', 6118.92, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500ab4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Điều Bí Mật', 151292, 2006, 384, 174, 'Chưa có trích dẫn.', 18155, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500b68-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Quái Vật Trong Đêm', 162214, 1999, 674, 113, 'Chưa có trích dẫn.', 16221.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500e1a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, '5 Centimet Trên Giây', 216927, 2011, 473, 71, 'Chưa có trích dẫn.', 32539.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500ee2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhật Ký Son Môi (Tái Bản 2016)', 89409, 2015, 610, 181, 'Chưa có trích dẫn.', 10729.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96500f96-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Không Còn Thời Gian Để Buồn', 244774, 2005, 430, 102, 'Chưa có trích dẫn.', 46507.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650104a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Phía Sau Nghi Can X (Tái Bản 2019)', 248827, 2014, 664, 186, 'Chưa có trích dẫn.', 34835.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501108-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mộ Đom Đóm', 264716, 2012, 285, 37, 'Chưa có trích dẫn.', 50296, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965011c6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tình Và Rác', 236534, 2004, 462, 162, 'Chưa có trích dẫn.', 26018.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501284-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cho Tôi Xin Một Vé Đi Tuổi Thơ (Bìa Mềm) (Tái Bản 2018)', 40370, 2016, 411, 183, 'Chưa có trích dẫn.', 7266.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501342-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mắt Biếc', 274158, 1999, 371, 47, 'Chưa có trích dẫn.', 43865.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501a18-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Dấu Chân Trên Cát', 147764, 2012, 320, 161, 'Chưa có trích dẫn.', 16254, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501b3a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Người Thắp Sao Trời', 252764, 2009, 140, 94, 'Chưa có trích dẫn.', 37914.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501bf8-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hồ Dương - Tập 2 - Nam Bắc Đại Thống', 195691, 2007, 398, 55, 'Chưa có trích dẫn.', 37181.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501cac-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hào Khí Đông A - Nhân Huệ Vương Trần Khánh Dư', 169811, 2020, 205, 121, 'Chưa có trích dẫn.', 25471.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501d6a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đại Việt Sử Ký Toàn Thư', 83185, 2006, 151, 152, 'Chưa có trích dẫn.', 13309.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501e28-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Sapiens: Lược Sử Loài Người (Tái Bản)', 155488, 2001, 198, 99, 'Chưa có trích dẫn.', 21768.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501ee6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Các Nền Văn Minh Thế Giới - Trung Quốc Cổ Đại', 42515, 2000, 659, 177, 'Chưa có trích dẫn.', 7652.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96501fa4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Súng, Vi Trùng Và Thép (Tái Bản 2020)', 35181, 2006, 497, 148, 'Chưa có trích dẫn.', 3518.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965021c0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thế Giới Cho Đến Ngày Hôm Qua (Tái Bản 2018)', 198548, 2014, 109, 101, 'Chưa có trích dẫn.', 29782.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650227e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tâm Lý Dân Tộc An Nam', 91358, 2014, 151, 59, 'Chưa có trích dẫn.', 11876.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650233c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Non Nước Việt Nam 63 Tỉnh Thành', 282569, 2005, 228, 53, 'Chưa có trích dẫn.', 42385.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965023fa-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hào Kiệt Nước Nam - Tường Quân Hoàng Hoa Thám', 38401, 2007, 196, 167, 'Chưa có trích dẫn.', 4608.12, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965024b8-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Phong Trào Chấn Hưng Phật Giáo Miền Trung Việt Nam (1932-1951)', 230410, 2017, 529, 45, 'Chưa có trích dẫn.', 36865.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502576-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Một Góc Nhìn Thời Cuộc', 140466, 2004, 537, 138, 'Chưa có trích dẫn.', 26688.5, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502634-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Donald Trump - Lựa Chọn Lịch Sử Của Nước Mỹ', 161857, 2002, 142, 118, 'Chưa có trích dẫn.', 22660, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965028aa-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hoảng Loạn, Hỗn Loạn Và Cuồng Loạn', 50763, 2020, 556, 16, 'Chưa có trích dẫn.', 5076.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650295e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Lee Kun Hee - Những Lựa Chọn Chiến Lược Và Kỳ Tích SamSung', 200788, 2002, 531, 97, 'Chưa có trích dẫn.', 22086.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502a1c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhớ Nghĩ Chiều Hôm', 265175, 2002, 677, 137, 'Chưa có trích dẫn.', 23865.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502ad0-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Hồi Ức Tuổi Tám Mươi - Hành Trình Từ Điện Tử Đến Vi Mạch', 227914, 2000, 619, 128, 'Chưa có trích dẫn.', 38745.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502b8e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Khi Hơi Thở Hóa Thinh Không (Tái Bản 2020)', 68197, 2017, 398, 18, 'Chưa có trích dẫn.', 6819.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502c4c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thời Khắc Tươi Đẹp (Bìa Cứng)', 39950, 2011, 338, 38, 'Chưa có trích dẫn.', 6392, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502e5e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bước Vào Cửa Hiệu Nhiệm Màu - Câu Chuyện Kỳ Diệu Về Cuộc Đời Của Một Bác Sĩ Phẫu', 65829, 2009, 680, 134, 'Chưa có trích dẫn.', 9874.35, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502f26-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'BTS - Ở Đâu Có Hy Vọng Ở Đó Có Khó Khăn', 261550, 2019, 639, 125, 'Chưa có trích dẫn.', 47079, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96502fe4-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Becoming - Chất Michelle', 226272, 2001, 563, 77, 'Chưa có trích dẫn.', 40729, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965030a2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Nhà Ngoại Cảm Phan Thị Bích Hằng', 90772, 2003, 293, 16, 'Chưa có trích dẫn.', 9077.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503160-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Đường Ngược Chiều - Từ Bản Người Dao Đến Học Bổng Erasmus', 168669, 2006, 253, 109, 'Chưa có trích dẫn.', 21927, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503214-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Chạy Bộ Cùng Người Kenya', 137719, 2001, 503, 109, 'Chưa có trích dẫn.', 13771.9, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965033fe-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tự Truyện Lê Công Vinh – Phút 89', 242342, 1999, 319, 192, 'Chưa có trích dẫn.', 24234.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965034c6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Cuộc Đua Trở Thành Cầu Thủ Vĩ Đại Nhất: Cristiano Và Leo - Khổ Luyện Và Thiên Tà', 219033, 2007, 308, 41, 'Chưa có trích dẫn.', 35045.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650357a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Mike Tyson - Sự Thật Trần Trụi (Sách Dành Cho Độc Giả Trên 18 Tuổi)', 35806, 2015, 637, 194, 'Chưa có trích dẫn.', 3580.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503638-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tỷ Phú Bán Giày (Tái Bản 2018)', 227194, 2003, 677, 49, 'Chưa có trích dẫn.', 24991.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('965036f6-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Trước Bình Minh Luôn Là Đêm Tối', 199596, 2002, 660, 93, 'Chưa có trích dẫn.', 21955.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503980-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thế Giới Alibaba Của Jack Ma', 262024, 2017, 618, 48, 'Chưa có trích dẫn.', 34063.1, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503a3e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, '[Bản Đặc Biệt] Huyền Thoại Marvel - Stan Lee', 240005, 2010, 301, 65, 'Chưa có trích dẫn.', 28800.6, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503af2-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Lý Tiểu Long - Một Cuộc Đời Phi Thường', 155775, 2010, 339, 190, 'Chưa có trích dẫn.', 20250.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503b9c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Stephen Hawking: Một Trí Tuệ Không Giới Hạn', 83067, 2005, 480, 102, 'Chưa có trích dẫn.', 14121.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503c5a-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Không Gục Ngã - Tự Truyện Nguyễn Bích Lan (Tái Bản)', 35236, 2002, 258, 133, 'Chưa có trích dẫn.', 3875.96, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503d18-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Làm Dâu Nước Anh', 113405, 2011, 665, 55, 'Chưa có trích dẫn.', 14742.7, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503dcc-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tôi Học Đại Học - Nguyễn Ngọc Ký', 39780, 2000, 318, 158, 'Chưa có trích dẫn.', 3580.2, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96503fde-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tâm Huyết Trao Đời - Tự Truyện Nguyễn Ngọc Ký', 251827, 2013, 333, 70, 'Chưa có trích dẫn.', 35255.8, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650409c-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Bùi Kiến Thành - Người Mở Khóa Lãng Du', 174613, 2003, 255, 12, 'Chưa có trích dẫn.', 19207.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('96504150-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Thành Đoàn Cùng Quân Và Dân Sài Gòn - Gia Định Tham Gia Chiến Dịch Hồ Chí Minh', 236767, 2018, 447, 138, 'Chưa có trích dẫn.', 33147.4, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('9650420e-66a7-11eb-ae93-0242ac130002', 1612405067, 1612405067, 'Tổng Tập Hồi Ký Của Đại Tướng Võ Nguyên Giáp', 217463, 2009, 475, 50, 'Chưa có trích dẫn.', 21746.3, 1612405067, 1612405067, '9cd1ebcc-668f-11eb-9fe5-e673ac9d1856', 'c61502a8-668f-11eb-9fe5-e673ac9d1856', '4bd016ae-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('bc693308-88ce-11eb-833e-261ed7bee09b', 1616170337, 1616170337, 'Thế giới mới', 45000, 2020, 129, 120, 'hi', 5000, 1612405067, 1612405067, '9f0c46e4-668f-11eb-9fe5-e673ac9d1856', 'cb843858-668f-11eb-9fe5-e673ac9d1856', '4f971f08-668f-11eb-9fe5-e673ac9d1856');
INSERT INTO `products` VALUES ('d55f0ae8-8a56-11eb-a9ae-3417eb638a82', 1616338330, 1616338330, 'Thế giới mới', 48000, 2020, 238, 30, 'Ở thế giới này mọi thứ có thể \"hack\" để cuộc sống dễ dàng hơn', 1200, NULL, NULL, 'a24c222a-668f-11eb-9fe5-e673ac9d1856', 'cf3e738c-668f-11eb-9fe5-e673ac9d1856', '4f971f08-668f-11eb-9fe5-e673ac9d1856');

-- ----------------------------
-- Table structure for publishers
-- ----------------------------
DROP TABLE IF EXISTS `publishers`;
CREATE TABLE `publishers`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of publishers
-- ----------------------------
INSERT INTO `publishers` VALUES ('c61502a8-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Chính trị Quốc gia', 1614407908);
INSERT INTO `publishers` VALUES ('c6eb6e9c-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Hồng Đức', 1614407908);
INSERT INTO `publishers` VALUES ('c786fcb8-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Kim Đồng', 1614407908);
INSERT INTO `publishers` VALUES ('cac4f786-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Quân đội', 1614407908);
INSERT INTO `publishers` VALUES ('cb843858-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Thanh niên', 1614407908);
INSERT INTO `publishers` VALUES ('cc6ece86-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Phụ nữ', 1614407908);
INSERT INTO `publishers` VALUES ('cd15e464-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Lao động xã hội', 1614407908);
INSERT INTO `publishers` VALUES ('cdc49554-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Tài chính', 1614407908);
INSERT INTO `publishers` VALUES ('ce6f1100-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Lao động xã hội', 1614407908);
INSERT INTO `publishers` VALUES ('cf3e738c-668f-11eb-9fe5-e673ac9d1856', 'Nhà xuất bản Tri thức', 1614407908);
INSERT INTO `publishers` VALUES ('f21786b8-8341-11eb-9de7-aafbb98c42f2', 'Nhiều loại bánh kem111ádfasdf', 1614407908);
INSERT INTO `publishers` VALUES ('f6a7faa6-6491-11eb-93be-1278a374dc20', 'Nhà xuất bản Tư Pháp', 1614407908);

-- ----------------------------
-- Table structure for reviews
-- ----------------------------
DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `user_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `title` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `rating` smallint NOT NULL,
  `published` tinyint(1) NOT NULL,
  `published_at` int NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `product_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `product_id`(`product_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of reviews
-- ----------------------------
INSERT INTO `reviews` VALUES ('b4a8f796-769c-11eb-949b-667a6342b68f', 1614170098, 'Dinh Luc', 'Sách rất hay', 5, 1, 1614170098, 'Quyển sách về nhân số học rất hữu ích, nó giúp mình &quot;hiểu&quot; bản thân hơn, cho mình thấy giải pháp và cuộc sống cơ bản phía trước. Tuy nhiên, sách mình mua về rồi có một số trang bị lộn ngược và đảo thứ tự nên đọc hơi bất tiện, nhà xuất bản cần lưu ý hơn về chất lượng in sách', '964f8f44-66a7-11eb-ae93-0242ac130002', '5fc5f970100333097e15017b');
INSERT INTO `reviews` VALUES ('b7c451de-775d-11eb-8658-ba2b37327332', 1614252996, 'Dinh Luc', 'wow', 1, 1, 1614252996, 'Good book(Hiu)', '9650227e-66a7-11eb-ae93-0242ac130002', '5fc5f970100333097e15017b');

-- ----------------------------
-- Table structure for tokens
-- ----------------------------
DROP TABLE IF EXISTS `tokens`;
CREATE TABLE `tokens`  (
  `jti` varchar(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `token_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `user_identity` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires` int NOT NULL,
  PRIMARY KEY (`jti`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tokens
-- ----------------------------
INSERT INTO `tokens` VALUES ('0102fffd-d6b9-4804-b4fb-c0d1b4e60c21', 'refresh', '5fc5f970100333097e15017b', 0, 1618728209);
INSERT INTO `tokens` VALUES ('0162199a-ea16-4bf1-8196-136a9ead0fba', 'refresh', '5fc5f970100333097e15017b', 0, 1618458448);
INSERT INTO `tokens` VALUES ('045673af-29b4-4f63-bc17-054a80260db7', 'refresh', '5fc5f970100333097e15017b', 0, 1618762498);
INSERT INTO `tokens` VALUES ('06b2af3e-0b8c-48fc-9ccd-0434992c5b95', 'refresh', '5fc5f970100333097e15017b', 0, 1618253975);
INSERT INTO `tokens` VALUES ('0817580b-ea31-42f6-af2a-da306e251596', 'refresh', '5fc5f970100333097e15017b', 0, 1618397246);
INSERT INTO `tokens` VALUES ('083e68c6-005f-48e7-b05e-ff786a6847fa', 'refresh', '5fc5f970100333097e15017b', 0, 1618476185);
INSERT INTO `tokens` VALUES ('100bc5d2-4459-41ab-9149-21e3582148af', 'refresh', '5fc5f970100333097e15017b', 0, 1618372332);
INSERT INTO `tokens` VALUES ('198e29b5-0652-4402-b5dd-38407d18c53c', 'refresh', '5fc5f970100333097e15017b', 0, 1618250184);
INSERT INTO `tokens` VALUES ('1dbc1435-535a-4bb6-9c95-9b2a339424fa', 'refresh', '5fc5f970100333097e15017b', 0, 1618478633);
INSERT INTO `tokens` VALUES ('1f2e7a1b-9c75-49cd-b2ae-07d00684a7db', 'refresh', '5fc5f970100333097e15017b', 0, 1618203724);
INSERT INTO `tokens` VALUES ('306fe8a4-9562-4f35-a9c3-a4e93729419c', 'refresh', '5fc5f970100333097e15017b', 0, 1618796731);
INSERT INTO `tokens` VALUES ('30b1bed3-0958-4e2e-a6a7-edb038b7d585', 'refresh', '5fc5f970100333097e15017b', 0, 1618468798);
INSERT INTO `tokens` VALUES ('346e23bf-848f-49aa-8e34-16263411b811', 'access', '5fc5f970100333097e15017b', 0, 1618805638);
INSERT INTO `tokens` VALUES ('35ba2a0b-be1d-42ba-be12-4860605760ab', 'access', '5fc5f970100333097e15017b', 0, 1618930895);
INSERT INTO `tokens` VALUES ('37a0c7a9-aa53-4b9a-8dce-2edb32d045e6', 'refresh', '5fc5f970100333097e15017b', 0, 1618466638);
INSERT INTO `tokens` VALUES ('45e4d7b2-bf3d-4837-821e-10628a824f72', 'refresh', '5fc5f970100333097e15017b', 0, 1618215536);
INSERT INTO `tokens` VALUES ('477c7f25-d301-4ea4-ba4a-9f612b2e9cd8', 'refresh', '5fc5f970100333097e15017b', 0, 1618370881);
INSERT INTO `tokens` VALUES ('5d42ff10-0e46-4211-a930-963c4d1ac6d0', 'refresh', '5fc5f970100333097e15017b', 0, 1618727322);
INSERT INTO `tokens` VALUES ('774a926b-e0f3-46f9-9094-666c6bfd8f83', 'refresh', '5fc5f970100333097e15017b', 0, 1618474127);
INSERT INTO `tokens` VALUES ('79985588-4c7c-4188-86c7-3c6dae05286e', 'access', '5fc5f970100333097e15017b', 0, 1618764386);
INSERT INTO `tokens` VALUES ('83575f92-5b4f-4620-ad08-db5ca1ab58de', 'refresh', '5fc5f970100333097e15017b', 0, 1618724768);
INSERT INTO `tokens` VALUES ('84f210c9-3824-490e-831d-923e574bd5d5', 'refresh', '5fc5f970100333097e15017b', 0, 1618364577);
INSERT INTO `tokens` VALUES ('85bbef9b-7a90-4b8b-b9ee-99fe5ebc0809', 'access', '5fc5f970100333097e15017b', 0, 1618796731);
INSERT INTO `tokens` VALUES ('89147ee9-52fa-442e-8c7b-4af7e370d2ab', 'refresh', '5fc5f970100333097e15017b', 0, 1618764386);
INSERT INTO `tokens` VALUES ('8beb1c29-ed8e-49cf-b046-3644f7c8b50a', 'refresh', '5fc5f970100333097e15017b', 0, 1618712084);
INSERT INTO `tokens` VALUES ('8d1727a6-d7c9-4e48-b37f-ec9814fbced6', 'refresh', '5fc5f970100333097e15017b', 0, 1618368948);
INSERT INTO `tokens` VALUES ('8e6c44d9-2e32-4b27-a44a-522b261ede56', 'refresh', '5fc5f970100333097e15017b', 0, 1618930895);
INSERT INTO `tokens` VALUES ('9b4b495a-47c2-4ea0-bc48-c5f711769a86', 'refresh', '5fc5f970100333097e15017b', 0, 1618209989);
INSERT INTO `tokens` VALUES ('a54d0f8b-330b-4892-89af-89005f0af16d', 'refresh', '5fc5f970100333097e15017b', 0, 1618219219);
INSERT INTO `tokens` VALUES ('a7640f48-7fa4-4d9f-9782-b6231a5c9744', 'refresh', '5fc5f970100333097e15017b', 0, 1618220136);
INSERT INTO `tokens` VALUES ('afc16d88-c356-45bc-a22f-524aa0a9e6b9', 'refresh', '5fc5f970100333097e15017b', 0, 1618728554);
INSERT INTO `tokens` VALUES ('b3575fe7-08e4-4e6e-9196-7c96c7de355d', 'refresh', '5fc5f970100333097e15017b', 0, 1618462372);
INSERT INTO `tokens` VALUES ('b8576776-60d9-457c-9059-38d782f1b5d4', 'refresh', '5fc5f970100333097e15017b', 0, 1618419636);
INSERT INTO `tokens` VALUES ('bc2faa6d-dca9-4a9b-b0ba-7f9570c2a55d', 'refresh', '5fc5f970100333097e15017b', 0, 1618252084);
INSERT INTO `tokens` VALUES ('be7e21ad-988b-4b4c-9aa8-e8e2931fef57', 'refresh', '5fc5f970100333097e15017b', 0, 1618367449);
INSERT INTO `tokens` VALUES ('c6e02209-6e54-4955-a11e-c88cc838153d', 'refresh', '5fc5f970100333097e15017b', 0, 1618398315);
INSERT INTO `tokens` VALUES ('c8408da0-7659-4bea-9c57-3a3eebd35cb7', 'refresh', '5fc5f970100333097e15017b', 0, 1618823509);
INSERT INTO `tokens` VALUES ('d3167a7e-d258-4361-a967-8302a4abab82', 'refresh', '5fc5f970100333097e15017b', 0, 1618742490);
INSERT INTO `tokens` VALUES ('d5df60c5-4053-47c1-8de5-24008674280c', 'access', '5fc5f970100333097e15017b', 0, 1618823509);
INSERT INTO `tokens` VALUES ('d8e0bea8-160a-43c7-8c55-46f4e90f7c37', 'refresh', '5fc5f970100333097e15017b', 0, 1618217509);
INSERT INTO `tokens` VALUES ('da132a12-a382-49e3-b068-2c14b009eea2', 'refresh', '5fc5f970100333097e15017b', 0, 1618372186);
INSERT INTO `tokens` VALUES ('dd71078e-b243-46fd-8548-213bfd4c1f4b', 'refresh', '5fc5f970100333097e15017b', 0, 1618744344);
INSERT INTO `tokens` VALUES ('e2849b09-36ac-43fd-a955-34ba03a6bd63', 'refresh', '5fc5f970100333097e15017b', 0, 1618805638);
INSERT INTO `tokens` VALUES ('ed0e0449-8d2f-44b9-a058-936633ef5ac5', 'refresh', '5fc5f970100333097e15017b', 0, 1618372460);
INSERT INTO `tokens` VALUES ('fbebf546-b83e-443a-b546-bc065ddb5609', 'refresh', '5fc5f970100333097e15017b', 0, 1618722870);
INSERT INTO `tokens` VALUES ('fd3461ea-ba49-46d5-926d-f232747064f5', 'refresh', '5fc5f970100333097e15017b', 0, 1618372530);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` int NOT NULL,
  `updated_at` int NULL DEFAULT NULL,
  `avatar_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `nickname` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_name` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `status` tinyint(1) NULL DEFAULT NULL,
  `is_admin` tinyint(1) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ix_users_user_name`(`user_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('284dcd9c-78c9-11eb-925f-8e9e0d9a6912', 1614407908, 1614407908, 'https://leaa-api.qcolate.com/assets/images/default-avatar.svg\r\n', NULL, 'hiuhiuhiu', 'pbkdf2:sha256:150000$3TlsgbOX$c6e46f696a4132ba3963dacf17b7cc67ed163461fd4c570b170c53eb8bdd2c3a', 'userr@gmail.com', '912345678', 1, 0);
INSERT INTO `users` VALUES ('5d7a26b0-8354-11eb-90db-feff76423e33', 1615568106, 1615568106, 'https://leaa-api.qcolate.com/assets/images/default-avatar.svg\r\n', NULL, 'admin123', 'pbkdf2:sha256:150000$cA99IDEy$fefe33d2dbe23bef3050571bbfcb205ab33a0cc1b5e6f9160b336b646dcce1d1', 'tien.nguyen1@boot.ai', '326463468', 1, 1);
INSERT INTO `users` VALUES ('5fc5f970100333097e15017b', 1611990100, 1611990100, 'avatar_url\': \'https://leaa-api.qcolate.com/assets/images/default-avatar.svg', 'Dinh Luc', 'admin', 'pbkdf2:sha256:150000$5AqLSbPI$9251a40195a7546ff4e4576dfd04d028fc2aea80e65328464516a06f343bbd94', 'luc.dinh@gmail.ai', '0132465876', 1, 1);

-- ----------------------------
-- Triggers structure for table order_details
-- ----------------------------
DROP TRIGGER IF EXISTS `after_insert_order_detail`;
delimiter ;;
CREATE TRIGGER `after_insert_order_detail` AFTER INSERT ON `order_details` FOR EACH ROW UPDATE products SET quantity = quantity - NEW.quantity WHERE products.id = NEW.product_id
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table order_details
-- ----------------------------
DROP TRIGGER IF EXISTS `after_delete_order_detail`;
delimiter ;;
CREATE TRIGGER `after_delete_order_detail` AFTER DELETE ON `order_details` FOR EACH ROW UPDATE products SET quantity = quantity + OLD.quantity WHERE products.id = OLD.product_id
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `after_update_order`;
delimiter ;;
CREATE TRIGGER `after_update_order` AFTER UPDATE ON `orders` FOR EACH ROW IF(NEW.status = 0)
THEN
BEGIN
UPDATE products INNER JOIN order_details ON order_details.product_id = products.id SET products.quantity = products.quantity - order_details.quantity WHERE products.id = order_details.product_id AND order_details.order_id = NEW.id;
END;
END IF
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orders
-- ----------------------------
DROP TRIGGER IF EXISTS `after_insert_order`;
delimiter ;;
CREATE TRIGGER `after_insert_order` AFTER INSERT ON `orders` FOR EACH ROW IF(NEW.promo != 'None')
THEN UPDATE coupons SET amount = amount - 1 WHERE coupons.code = NEW.promo;
END IF
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
