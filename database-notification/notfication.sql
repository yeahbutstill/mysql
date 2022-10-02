CREATE DATABASE notification;
USE notification;
SHOW TABLES;

CREATE TABLE user (
    id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY(id)
) ENGINE = InnoDB;

INSERT INTO user(id, name) VALUES ('dani', 'Dani Setiawan');
INSERT INTO user(id, name) VALUES ('maya', 'Maya Triyanti');

# Notification
CREATE TABLE notifications (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    detail TEXT NOT NULL,
    created_at TIMESTAMP NOT NULL,
    user_id VARCHAR(100),
    PRIMARY KEY(id)
) ENGINE = InnoDB;

ALTER TABLE notifications
ADD CONSTRAINT fk_notifications_user
FOREIGN KEY (user_id) REFERENCES user (id);

INSERT INTO notifications(title, detail, created_at, user_id)
VALUES ('Bakso T-rex', 'Yang lain langsung mundur', CURRENT_TIMESTAMP(), 'dani');
INSERT INTO notifications(title, detail, created_at, user_id)
VALUES ('Bakso Ababil', 'Kadang bikin aku kesal', CURRENT_TIMESTAMP(), null);
INSERT INTO notifications(title, detail, created_at, user_id)
VALUES ('Pembayaran pay fucking latter', 'hidup hutang hutang hidup', CURRENT_TIMESTAMP(), 'maya');

SELECT * FROM notifications WHERE user_id = 'dani';
SELECT * FROM notifications WHERE (user_id = 'dani' OR user_id IS NULL );
SELECT * FROM notifications WHERE (user_id = 'dani' OR user_id IS NULL ) ORDER BY created_at DESC;

SELECT * FROM notifications WHERE user_id = 'maya';
SELECT * FROM notifications WHERE (user_id = 'maya' OR user_id IS NULL );
SELECT * FROM notifications WHERE (user_id = 'maya' OR user_id IS NULL ) ORDER BY created_at DESC;

# Category
CREATE TABLE category (
    id VARCHAR(100) NOT NULL,
    name VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

ALTER TABLE notifications
ADD COLUMN category_id VARCHAR(100);

DESCRIBE notifications;

ALTER TABLE notifications
ADD CONSTRAINT fk_notifications_category
FOREIGN KEY (category_id) REFERENCES category(id);

INSERT INTO category(id, name) VALUES ('INFO', 'info');
INSERT INTO category(id, name) VALUES ('PROMO', 'promo');

UPDATE notifications SET category_id = 'INFO'
WHERE id = 1;
UPDATE notifications SET category_id = 'PROMO'
WHERE id = 2;
UPDATE notifications SET category_id = 'INFO'
WHERE id = 3;

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id);

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id) WHERE (n.user_id = 'dani' OR n.user_id IS NULL)
ORDER BY n.created_at DESC;

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id) WHERE (n.user_id = 'maya' OR n.user_id IS NULL)
ORDER BY n.created_at DESC;

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id) WHERE (n.user_id = 'maya' OR n.user_id IS NULL)
AND c.id = 'PROMO' ORDER BY n.created_at DESC;

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id) WHERE (n.user_id = 'maya' OR n.user_id IS NULL)
AND c.id = 'INFO' ORDER BY n.created_at DESC;

# Notification Read
CREATE TABLE notification_read (
    id INT NOT NULL AUTO_INCREMENT,
    is_read BOOLEAN NOT NULL,
    notification_id INT NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;

ALTER TABLE notification_read
ADD CONSTRAINT  fk_notification_read_notification
FOREIGN KEY (notification_id) REFERENCES notifications(id);

ALTER TABLE notification_read
ADD CONSTRAINT fk_notification_read_user
FOREIGN KEY (user_id) REFERENCES user(id);

DESCRIBE notification_read;

SELECT * FROM notifications;
INSERT INTO notification_read(is_read, notification_id, user_id) VALUES (true, 2, 'dani');
INSERT INTO notification_read(is_read, notification_id, user_id) VALUES (true, 2, 'maya');

SELECT * FROM notifications
n JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = 'dani' OR n.user_id IS NULL)
AND (nr.user_id = 'dani' OR nr.user_id IS NULL)
ORDER BY n.created_at DESC;

INSERT INTO notifications(title, detail, category_id, user_id, created_at)
VALUES ('Pesan lagi aja', 'AYo ayo jing pesan lagi', 'INFO', 'dani', CURRENT_TIMESTAMP());
INSERT INTO notifications(title, detail, category_id, user_id, created_at)
VALUES ('Pesan global lagi aja', 'AYo ayo jing globa pesanan lagi loh', 'PROMO', NULL, CURRENT_TIMESTAMP());

# Counter
SELECT COUNT(*) FROM notifications
n JOIN category c ON (n.category_id = c.id)
LEFT JOIN notification_read nr ON (nr.notification_id = n.id)
WHERE (n.user_id = 'dani' OR n.user_id IS NULL)
AND (nr.user_id IS NULL)
ORDER BY n.created_at DESC;

INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 4, 'dani');
INSERT INTO notification_read(is_read, notification_id, user_id)
VALUES (true, 5, 'dani');