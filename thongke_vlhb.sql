-- Top 10 sản phẩm có doanh thu cao nhất
SELECT
	product_id,
	SUM(price-discount)* SUM(quantity ) AS TotalRevenue 
FROM
	order_details 
GROUP BY
	product_id 
ORDER BY
	SUM( price - discount )*SUM(quantity) DESC 
	LIMIT 10;
	
-- Top 10 sản phẩm bán được nhiều nhất
SELECT
	product_id,
	SUM(quantity ) AS TotalQuantity 
FROM
	order_details 
GROUP BY
	product_id 
ORDER BY
	SUM(quantity) DESC 
	LIMIT 10;

-- Thống kê 10 sản phẩm có doanh thu, lợi nhuận nhiều nhất
SELECT
	order_details.product_id,
	products.title,
	SUM( order_details.price ) AS 'Gia ban',
	SUM( order_details.discount ) AS 'Giam gia',
	SUM( order_details.price - order_details.discount ) AS 'Doanh thu',
	AVG( cost ) AS 'Chi phi',
	SUM( order_details.price - order_details.discount )- AVG( cost ) AS 'Loi nhuan',
	SUM( order_details.quantity ) AS 'So luong ban',
	SUM( order_details.price - order_details.discount )* SUM( order_details.quantity ) AS 'Tong doanh thu',
	(
	SUM( order_details.price - order_details.discount ) - AVG( cost ))* SUM( order_details.quantity ) AS 'Tong loi nhuan' 
FROM
	order_details
	INNER JOIN product_cost ON order_details.product_id = product_cost.product_id
	INNER JOIN products ON products.id = order_details.product_id 
WHERE
	order_details.created_at BETWEEN 1614075480 
	AND 1614251196 
GROUP BY
	order_details.product_id 
ORDER BY
	SUM( order_details.price - order_details.discount )* SUM( order_details.quantity ) DESC 
	LIMIT 10;
	
	
-- Thống kê nhập sản phẩm
SELECT
	product_id,
	products.title,
	AVG( product_cost.cost ) AS GiaNhapTB1SP,
	SUM( product_cost.quantity ) AS SoLuongNhap,
	SUM( product_cost.total ) AS TongCong 
FROM
	product_cost
	INNER JOIN products ON products.id = product_cost.product_id 
WHERE
	product_cost.created_at BETWEEN 1612404982 
	AND 1612405312 
GROUP BY
	product_cost.product_id 
ORDER BY
	SUM( product_cost.total ) DESC