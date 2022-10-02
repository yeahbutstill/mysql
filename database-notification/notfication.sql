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