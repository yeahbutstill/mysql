use `mysqlpzn-db`;
show tables;
CREATE TABLE barang (
    id INT NOT NULL,
    kode INT NOT NULL,
    nama VARCHAR(100) NOT NULL,
    harga INT NOT NULL DEFAULT 0,
    jumlah INT NOT NULL DEFAULT 0
) ENGINE = InnoDB;

DESCRIBE barang;
SHOW CREATE TABLE barang;

DROP TABLE barang;

ALTER TABLE barang ADD COLUMN nama TEXT;
ALTER TABLE barang ADD COLUMN deskripsi TEXT;
ALTER TABLE barang RENAME COLUMN nama TO nama_baru;
ALTER TABLE barang MODIFY nama_baru VARCHAR(100) AFTER jumlah;
ALTER TABLE barang MODIFY nama_baru VARCHAR(100) FIRST;
ALTER TABLE barang DROP COLUMN nama_baru;
ALTER TABLE barang MODIFY id INT NOT NULL;
ALTER TABLE barang MODIFY kode INT NOT NULL;
ALTER TABLE barang MODIFY nama VARCHAR(200) NOT NULL;

ALTER TABLE barang modify jumlah INT NOT NULL DEFAULT 0;
ALTER TABLE barang modify harga INT NOT NULL DEFAULT 0;
ALTER TABLE barang add waktu_dibuat TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

INSERT INTO barang (id, kode, nama, harga, jumlah) VALUES (1, 01, 'Apple Iphone 13', 15000000, 1000);
SELECT * FROM barang;

ALTER TABLE barang ADD PRIMARY KEY (id);

TRUNCATE barang;
DROP TABLE barang;

CREATE TABLE products (
    id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB;

SHOW TABLES;
DESCRIBE products;

INSERT INTO products(id, name, price, quantity)
VALUES ('P0001', 'Mie Ayam Original', 15000, 1000);

INSERT INTO products(id, name, description, price, quantity)
VALUES ('P0002', 'Mie Ayam Bakso Tahu', 'Mie Ayam Original + Bakso Tahu', 20000, 1000);

INSERT INTO products(id, name, description, price, quantity)
VALUES ('P0003', 'Mie Ayam Ceker', 'Mie Ayam Original + Ceker', 20000, 100),
       ('P0004', 'Mie Ayam Special', 'Mie Ayam Original + Bakso Tahu + Ceker + Yamin', 25000, 100),
       ('P0005', 'Mie Ayam Yamin', 'Mie Ayam Original + Yamin', 15000, 100),
       ('P0006', 'Mie Ayam Yamin', 'Mie Ayam Yamin Original', 15000, 100),
       ('P0007', 'Mie Ayam Yamin', 'Mie Ayam Cabe Rawit Original + Yamin', 15000, 100),
       ('P0008', 'Mie Ayam Yamin', 'Mie Ayam Jumbo Original + Yamin', 15000, 100),
       ('P0009', 'Mie Ayam Yamin', 'Mie Ayam Kids Original + Yamin', 15000, 100);

INSERT INTO products(id, name, description, price, quantity)
VALUES ('P0006', 'Mie Ayam Bakso Rudal', 'Mie Ayam Original + Bakso Rudal', 30000, 0);

SELECT * FROM products;
DROP TABLE products;

SELECT id, name, price, quantity FROM products;
SELECT name, quantity, id FROM products;

CREATE TABLE products (
    id VARCHAR(10) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price INT UNSIGNED NOT NULL,
    quantity INT UNSIGNED NOT NULL DEFAULT 0,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

DESCRIBE products;

SELECT id, name, price, quantity FROM products WHERE quantity = 0;

SELECT * FROM products WHERE id = 'P0001';

ALTER TABLE products
ADD COLUMN category ENUM('Makanan', 'Minuman', 'Lain-Lain')
AFTER name;

UPDATE products
SET category = 'Makanan'
WHERE id = 'P0001';

UPDATE products SET description = 'Makan Makan Aja' WHERE id = 'P0001';
UPDATE products SET category = 'Makanan', description = 'Mie Ayam + Ceker' WHERE id = 'P0003';
UPDATE products SET price = price + 5000 WHERE id = 'P0004';
SELECT * FROM products;

DELETE FROM products WHERE id = 'P0009';

# Alias untuk Kolom
SELECT id as 'Kode',
       name as 'Nama',
       category as 'Kategori',
       price as 'Harga',
       quantity as 'Stok'
FROM products;

# Alias untuk Table
SELECT p.id as 'Kode',
       p.name as 'Nama',
       p.category as 'Kategori',
       p.price as 'Harga',
       p.quantity as 'Stok'
FROM products AS p;

SELECT id, name, price, quantity
FROM products
WHERE quantity > 100;

INSERT INTO products(id, category, name, price, quantity)
VALUES ('P0010', 'Makanan', 'Bakso Rusuk', 20000, 300),
       ('P0011', 'Minuman', 'Es Jeruk', 2500, 200),
       ('P0012', 'Minuman', 'Es Campur', 5500, 100),
       ('P0013', 'Minuman', 'Es Teh Manis', 5000, 300),
       ('P0014', 'Lain-Lain', 'Kerupuk', 1500, 200),
       ('P0015', 'Lain-Lain', 'Keripik Udang', 10000, 400),
       ('P0016', 'Lain-Lain', 'Es Krim', 5000, 110),
       ('P0017', 'Makanan', 'Mie Ayam Jamur', 5000, 110),
       ('P0018', 'Makanan', 'Bakso Telur', 20000, 150),
       ('P0018', 'Makanan', 'Bakso Jando', 25000, 300);
SELECT * FROM products WHERE quantity > 100;
SELECT * FROM products WHERE quantity >= 100;
SELECT * FROM products WHERE category != 'Makanan';
SELECT * FROM products WHERE category <> 'Minuman';
SELECT * FROM products WHERE quantity > 100 AND price > 20000;
SELECT * FROM products WHERE category = 'Makanan' AND price < 20000;

SELECT * FROM products WHERE quantity > 100 OR price > 20000;

# Kalau tidak pake tanda pioritas () defaultnya yang AND dulu di eksekusi
SELECT id, name, price, quantity FROM products WHERE (category = 'Makanan' OR quantity > 500) AND price > 10000;

# Kalau datanya sudah terlalu besar jangan gunakan LIKE
SELECT * FROM products WHERE name LIKE '%mie%';

SELECT * FROM products WHERE description IS NULL;
SELECT * FROM products WHERE description IS NOT NULL;
SELECT * FROM products WHERE price BETWEEN 10000 AND 20000;
SELECT * FROM products WHERE price NOT BETWEEN 10000 AND 20000;

SELECT * FROM products WHERE category IN ('Makanan', 'Minuman') ORDER BY category DESC;
SELECT * FROM products WHERE category NOT IN ('Makanan', 'Minuman') ORDER BY category DESC;
SELECT * FROM products WHERE category = 'Makanan' OR category = 'Minuman';

SELECT * FROM products ORDER BY price ASC, id DESC;
SELECT id, category, name FROM products ORDER BY category;

SELECT * FROM products WHERE price > 0 ORDER BY price LIMIT 5;
SELECT * FROM products ORDER BY price LIMIT 5;

#page 1
SELECT * FROM products WHERE quantity > 100 ORDER BY price LIMIT 2, 5;
#page 2
SELECT * FROM products WHERE quantity > 100 ORDER BY price LIMIT 0, 5;
#page 3
SELECT * FROM products WHERE quantity > 100 ORDER BY price LIMIT 10, 5;

