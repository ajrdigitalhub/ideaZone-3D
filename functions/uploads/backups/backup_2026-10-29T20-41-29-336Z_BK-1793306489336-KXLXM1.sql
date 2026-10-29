-- IDEAZONE 3D PostgreSQL Snapshot Backup
-- Generated: 2026-10-29T20:41:29.460Z
-- Backup ID: BK-1793306489336-KXLXM1
-- Type: MANUAL
-- Tables count: 19

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET session_replication_role = 'replica';

-- Table: abouts
CREATE TABLE IF NOT EXISTS "abouts" (
  "id" INTEGER DEFAULT nextval('abouts_id_seq'::regclass) NOT NULL,
  "title" CHARACTER VARYING,
  "subtitle" CHARACTER VARYING,
  "description" TEXT,
  "mission" TEXT,
  "vision" TEXT,
  "last_updated" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "abouts" CASCADE;

-- Inserting 1 rows into "abouts"
INSERT INTO "abouts" ("id", "title", "subtitle", "description", "mission", "vision", "last_updated") VALUES (1, '', '', '', '', '', '2026-04-04T12:43:33.703Z');

SELECT setval(pg_get_serial_sequence('"abouts"', 'id'), COALESCE((SELECT MAX("id") FROM "abouts"), 1), true);

-- Table: categories
CREATE TABLE IF NOT EXISTS "categories" (
  "id" INTEGER DEFAULT nextval('categories_id_seq'::regclass) NOT NULL,
  "name" CHARACTER VARYING NOT NULL,
  "description" TEXT,
  "image" CHARACTER VARYING,
  "active" BOOLEAN DEFAULT true,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "categories" CASCADE;

-- Inserting 6 rows into "categories"
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (4, 'Car Dashboard Idols', '', '', TRUE, '2026-05-26T04:28:18.425Z', '2026-05-26T04:28:18.425Z');
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (5, '3D PEN', '', '', TRUE, '2026-05-30T04:03:26.319Z', '2026-05-30T04:03:26.319Z');
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (6, '3D Printers', '', '', TRUE, '2026-05-30T04:11:35.807Z', '2026-05-30T04:11:35.807Z');
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (7, 'GOD IDOLS', '', '', TRUE, '2026-06-24T10:34:09.550Z', '2026-06-24T10:34:09.550Z');
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (8, ' 3D Human Miniature ', '', '', TRUE, '2026-07-07T09:10:19.308Z', '2026-07-07T09:10:19.308Z');
INSERT INTO "categories" ("id", "name", "description", "image", "active", "created_at", "updated_at") VALUES (9, 'Birthday Gift ', '', '', TRUE, '2026-07-07T09:17:43.677Z', '2026-07-07T09:17:43.677Z');

SELECT setval(pg_get_serial_sequence('"categories"', 'id'), COALESCE((SELECT MAX("id") FROM "categories"), 1), true);

-- Table: chats
CREATE TABLE IF NOT EXISTS "chats" (
  "id" INTEGER DEFAULT nextval('chats_id_seq'::regclass) NOT NULL,
  "customer_id" INTEGER,
  "customer_name" CHARACTER VARYING,
  "messages" JSONB DEFAULT '[]'::jsonb,
  "last_message" TEXT,
  "last_message_at" TIMESTAMP WITHOUT TIME ZONE,
  "is_active" BOOLEAN DEFAULT true,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "chats" CASCADE;

SELECT setval(pg_get_serial_sequence('"chats"', 'id'), COALESCE((SELECT MAX("id") FROM "chats"), 1), true);

-- Table: config
CREATE TABLE IF NOT EXISTS "config" (
  "key" CHARACTER VARYING NOT NULL,
  "value" JSONB NOT NULL,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("key")
);
TRUNCATE TABLE "config" CASCADE;

-- Inserting 2 rows into "config"
INSERT INTO "config" ("key", "value", "updated_at") VALUES ('razorpay_secret', '{"keySecret":"TIwK9lHEX2H9TI5ifbqzIHfy"}', '2026-05-31T04:32:25.529Z');
INSERT INTO "config" ("key", "value", "updated_at") VALUES ('app', '{"hero":{"slides":[{"title":"IDEAZONE3D","imageUrl":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1776353865229-307486516.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=dBZHWRXfuNxqbLS84%2F9wrdpZE7bkySEhddIJGi%2BHKniNE6gzsnrIXvu%2BFQELBNAYUSW9jiBePC2rfj%2BTkOuH2hN4mZGMP8%2FM7cC1iKa7xyjdWzaiR9Y8XhnXkSwi8U217mOYf7Q22fadghkUu4Pm3%2BJA7xEHFeVSIVLLVdBFEGZ2sx%2F9xFAqmHheVrjqDWHEpFMyeI9a6d7WS8hwWzMrcoVODRnlBiCpmzmiWkyDTwY4RomHZDkpuUJZRksXXd7JUcWUUpNOdrtZ0p7zKREiSf0DB7pTnr1fGixghKRrgxZ%2F81nUAyDD7RTNcUOaEX1bospbh7cmNPpWPahv91pewQ%3D%3D","subtitle":"Engineered materials designed for extreme performance and durability.","buttonLink":"/about","buttonText":"View Materials"},{"title":"FUTURE FABRICATION","imageUrl":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1776356688108-925465605.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=JfiddInsot1pVfklAqhea2awUnXZ14bh5RQ9w%2FTC9B33twUshDDYlUoqa9c57mYxuTBMWuECJ0NmEO%2F1Zjp3YpBPKFjN0eCnYRbFvKF%2BN%2FkgkGj8PZXD2dRCFbBgBoMCWFExG8jKlcRdOQ8wr5dW4nkpZYP%2Fo8q1lqCZBDicKDXhECfNnouCJEC2Uc6TpvLDuU4Yte3rUqEcVca1%2FPVSeYct6j9p5F8OPAXErWDKac2Q%2FT8p6a4Ql7%2Bo5fuFWkTx6hsAY0ZTUXq4f4fx%2FE2dyNNQnrhBuKWcXIL4bcYFXd9XTv099q6ZHluHuEXV2vFkkwe9O6i4lCgkf%2Bi6HVdW%2Bg%3D%3D","subtitle":"Rapid prototyping and small-batch production at the speed of thought.","buttonLink":"/contact","buttonText":"Get Started"}]},"about":{"title":"About IDEAZONE3D","values":[{"icon":"biotech","title":"Precision","description":"We maintain aerospace-grade tolerances in every print we produce."},{"icon":"lightbulb","title":"Innovation","description":"Constantly exploring new materials and printing techniques."},{"icon":"eco","title":"Sustainability","description":"Committed to using eco-friendly materials and reducing waste."}],"vision":"To become the global standard for on-demand manufacturing, where any idea can be transformed into a physical reality within hours.","content":"Founded in 2020, IDEAZONE3D started with a simple mission: to make industrial-grade 3D printing accessible to everyone. What began as a small workshop with two printers has evolved into a state-of-the-art fabrication hub serving clients across the globe.\n\nWe believe that the only limit to what you can create should be your imagination. Our team of engineers and designers works tirelessly to push the boundaries of what''s possible with 3D printing technology, from rapid prototyping to final production parts.","mission":"To empower creators by providing the most advanced, reliable, and accessible 3D printing solutions in the industry.","imageUrl":"https://images.unsplash.com/photo-1581092160562-40aa08e78837?auto=format&fit=crop&q=80&w=2000","subtitle":"Pioneering the future of additive manufacturing with precision and passion."},"footer":{"description":"Premium 3D printing solutions for creators, engineers, and dreamers. Quality meets innovation in every layer.","socialLinks":[{"url":"https://www.facebook.com/share/1DvE1VzLuQ/?mibextid=wwXIfr","icon":"facebook","platform":"Facebook"},{"url":"","icon":"share","platform":"Twitter"},{"url":"https://www.instagram.com/ideazone3d?igsh=eWhjbHZiMTlpYmE4&utm_source=qr","icon":"camera_alt","platform":"Instagram"}],"copyrightText":"© 2026 IDEAZONE3D. All rights reserved."},"contact":{"email":"ideazone3d.com","phone":"9989013142","mapUrl":"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3153.097746536531!2d-122.39568368468205!3d37.79252897975618!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x8085806255555555%3A0x1234567890abcdef!2sTech%20Hub!5e0!3m2!1sen!2sus!4v1611234567890!5m2!1sen!2sus","address":"Hyderabad, Kistareddypet-502032"},"razorpay":{"keyId":"rzp_live_Sd1pO46Ggu1Ku0","enabled":true,"codEnabled":true},"whatsapp":{"apiKey":"EAAezSc2fdmQBRitZAbgSLNH9qZBC7xOsNK5dAwuR2fQYdUHrNnDjIMvtxngzl0m1uuabY9FVoOvuD8cj4BGzYkRrIKq0pmH3MrZBEwxO19j83ZBofZAXlqqMoAfZB4deU0ZAVgCdduzoMrGDzPVBcIWZCQZBQfQ3PfWJE7A5J5wnkzlQlxSWpaUpK4NZAat50ZBPwZDZD","apiUrl":"https://graph.facebook.com/v22.0/1141890679005435/messages","apiEnabled":true,"adminPhoneNumber":"+919989013142","welcomeMessageTemplateName":"welcome_message","orderStatusUpdateTemplateName":"order_status_update","orderConfirmationAdminTemplateName":"order_confirmation_admin","orderConfirmationClientTemplateName":"order_confirmation_client"}}', '2026-05-31T11:58:00.429Z');

-- Table: contact_configs
CREATE TABLE IF NOT EXISTS "contact_configs" (
  "id" INTEGER DEFAULT nextval('contact_configs_id_seq'::regclass) NOT NULL,
  "address" TEXT,
  "phone" CHARACTER VARYING,
  "email" CHARACTER VARYING,
  "working_hours" TEXT,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "contact_configs" CASCADE;

-- Inserting 1 rows into "contact_configs"
INSERT INTO "contact_configs" ("id", "address", "phone", "email", "working_hours", "updated_at") VALUES (1, '', '', '', '', '2026-04-04T12:43:33.703Z');

SELECT setval(pg_get_serial_sequence('"contact_configs"', 'id'), COALESCE((SELECT MAX("id") FROM "contact_configs"), 1), true);

-- Table: conversion_events
CREATE TABLE IF NOT EXISTS "conversion_events" (
  "id" INTEGER DEFAULT nextval('conversion_events_id_seq'::regclass) NOT NULL,
  "event_type" CHARACTER VARYING NOT NULL,
  "amount" NUMERIC DEFAULT 0,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "conversion_events" CASCADE;

-- Inserting 31 rows into "conversion_events"
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (1, 'checkout_start_guest', '0.00', '2026-07-09T11:07:03.218Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (2, 'checkout_start_guest', '0.00', '2026-07-10T12:23:40.006Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (3, 'checkout_complete_guest', '799.00', '2026-07-10T12:34:22.546Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (4, 'checkout_start_guest', '0.00', '2026-07-10T14:31:04.583Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (5, 'checkout_complete_guest', '1999.00', '2026-07-10T14:31:35.683Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (6, 'checkout_start_guest', '0.00', '2026-07-10T14:42:37.236Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (7, 'checkout_complete_guest', '299.00', '2026-07-10T14:43:06.493Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (8, 'checkout_start_guest', '0.00', '2026-07-10T22:37:49.011Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (9, 'checkout_complete_guest', '499.00', '2026-07-10T22:38:23.908Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (10, 'checkout_start_guest', '0.00', '2026-07-10T22:38:37.510Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (11, 'checkout_start_guest', '0.00', '2026-07-10T22:39:11.261Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (12, 'checkout_start_guest', '0.00', '2026-07-10T23:03:57.464Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (13, 'checkout_complete_guest', '1999.00', '2026-07-10T23:06:08.963Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (14, 'checkout_start_guest', '0.00', '2026-07-10T23:09:45.190Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (15, 'checkout_complete_guest', '499.00', '2026-07-10T23:09:56.551Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (16, 'checkout_start_guest', '0.00', '2026-07-10T23:17:59.098Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (17, 'checkout_complete_guest', '1999.00', '2026-07-10T23:19:03.851Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (18, 'checkout_start_guest', '0.00', '2026-07-11T01:31:58.654Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (19, 'checkout_complete_guest', '799.00', '2026-07-11T01:33:13.253Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (20, 'checkout_start_registered', '0.00', '2026-07-11T02:23:45.355Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (21, 'checkout_start_guest', '0.00', '2026-07-11T02:24:25.014Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (22, 'checkout_start_guest', '0.00', '2026-07-11T02:37:29.001Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (23, 'checkout_start_guest', '0.00', '2026-07-13T13:23:09.227Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (24, 'checkout_start_guest', '0.00', '2026-07-16T01:29:08.455Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (25, 'checkout_start_guest', '0.00', '2026-07-30T11:46:08.828Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (26, 'checkout_start_guest', '0.00', '2026-08-22T12:22:27.282Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (27, 'checkout_start_guest', '0.00', '2026-09-03T22:36:39.926Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (28, 'checkout_start_guest', '0.00', '2026-09-06T10:07:55.727Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (29, 'checkout_start_guest', '0.00', '2026-09-28T14:19:38.862Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (30, 'checkout_start_guest', '0.00', '2026-10-04T08:47:31.736Z');
INSERT INTO "conversion_events" ("id", "event_type", "amount", "created_at") VALUES (31, 'checkout_start_guest', '0.00', '2026-10-08T07:36:01.213Z');

SELECT setval(pg_get_serial_sequence('"conversion_events"', 'id'), COALESCE((SELECT MAX("id") FROM "conversion_events"), 1), true);

-- Table: messages
CREATE TABLE IF NOT EXISTS "messages" (
  "id" INTEGER DEFAULT nextval('messages_id_seq'::regclass) NOT NULL,
  "name" CHARACTER VARYING NOT NULL,
  "email" CHARACTER VARYING NOT NULL,
  "subject" CHARACTER VARYING,
  "message" TEXT NOT NULL,
  "status" CHARACTER VARYING DEFAULT 'new'::character varying,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "messages" CASCADE;

SELECT setval(pg_get_serial_sequence('"messages"', 'id'), COALESCE((SELECT MAX("id") FROM "messages"), 1), true);

-- Table: orders
CREATE TABLE IF NOT EXISTS "orders" (
  "id" INTEGER DEFAULT nextval('orders_id_seq'::regclass) NOT NULL,
  "user_id" INTEGER,
  "items" JSONB DEFAULT '[]'::jsonb NOT NULL,
  "total_amount" NUMERIC NOT NULL,
  "shipping_address" JSONB,
  "payment_method" CHARACTER VARYING DEFAULT 'cod'::character varying,
  "payment_status" CHARACTER VARYING DEFAULT 'pending'::character varying,
  "order_status" CHARACTER VARYING DEFAULT 'pending'::character varying,
  "razorpay_order_id" CHARACTER VARYING,
  "razorpay_payment_id" CHARACTER VARYING,
  "razorpay_signature" CHARACTER VARYING,
  "order_number" CHARACTER VARYING NOT NULL,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "razorpay_orderid" CHARACTER VARYING,
  "razorpay_paymentid" CHARACTER VARYING,
  "gst_amount" NUMERIC DEFAULT 0,
  "shipping_charge" NUMERIC DEFAULT 0,
  "is_guest" BOOLEAN DEFAULT false,
  "guest_name" CHARACTER VARYING,
  "guest_phone" CHARACTER VARYING,
  "guest_email" CHARACTER VARYING,
  "firebase_uid" CHARACTER VARYING,
  "courier_name" CHARACTER VARYING,
  "tracking_number" CHARACTER VARYING,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "orders" CASCADE;

-- Inserting 9 rows into "orders"
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (22, 14, '[{"name":"Venkateswara swamy","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783432895580-183643197.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=hDyIoNDuN0BjLULVIbWePE%2F4blB7KDJoSNX417puBKn9DhTzjvJTMD5gepsSQ4n6aeOpiz1RrwhYVvNa6em4hwFYefDg%2Bl2clh53Fhr%2B%2Bu8AhJ3Kq1lWkMOFr2fp9p5soBucPUzM3ql6EmaDWDD6AGxjoblraYKJszdnI1pNzGnb55e4Z%2B%2BIktGd7BaTYJ8DptWyQcLmpL%2BibeEo2U%2BWWQ2NKRa3IXRjPlZgasvRi2xffQaz3nmlI8Y%2Fh4eVFfSJSc26LlxrOaLBpIRCE9IR6M6vtmxo0dFG2HKWmIohDliQAPQGEmnQ9zAs%2FxPUrcQFOykufhyd%2Bu5uzWBZaHHiDA%3D%3D","price":499,"product":12,"quantity":1}]', '499.00', '{"zip":"60304","city":"tindivanam","name":"Jayakumar R","email":"ajrgroupconnect@gmail.com","phone":"9597935647","state":"Tamil Nadu","address":"8, Mettu Street, pathirapuliyur village"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-140300', '2026-07-10T22:38:21.725Z', '2026-07-10T22:38:21.725Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar R', '9597935647', 'ajrgroupconnect@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (19, 14, '[{"name":"Smart 3D Printing Pen with PLA Filament Starter Pack","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1780133850344-214131874.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=krw5iWvXgO5wEKPIlLQSAnOiE4H%2FttoeSXyeJskLCa4KN%2BbcFLLcbtfSwTbyEfk6xkf1ibVULurXX%2Fos0MuGupcEzaqDCQOr8gMMXxzJ6dktKOtokhUtR%2FHWc0yre8cg4XvTbquxWZb%2F%2FLmr33urQK3FdYhCafcrMGE6HshTM4jED9sPKV%2Fv1sc%2BsbaNL2Ju8lxSYLE0MYsjn%2BpruUCvDlEjNN7wINQJ4V78WJ888Z%2BxUzrFl2E1TENFuaQvyBBeE0mm2esaTI2qKClfGmFYF04ycJdyqiz%2FCbz3SrdMiN1MMxf%2BwHOXaVvzwpdnFSgLvP0DE5SCoyaVXHKZNe0jFg%3D%3D","price":799,"product":10,"quantity":1}]', '799.00', '{"zip":"604302","city":"chennai","name":"Jayakumar","email":"arunjaya1999@gmail.com","phone":"9597935647","state":"tn","address":"8"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-809083', '2026-07-10T12:34:20.815Z', '2026-07-10T12:39:22.938Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar', '9597935647', 'arunjaya1999@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (25, 14, '[{"name":"Custom 3D Human Miniature ","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783435471588-772043986.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=SE8NgrhkibOjGts3ycnOXboQUwF%2BS60VDd%2FYKUuUrlCYy4llzodCeZhiHEH6%2Bb6CekdKUvLw3xM0EusQtIxMkmdxDOrVnzL12EDMKo8XhNDsxkwa6BRsA0WARUHRScL%2Bl24aMQZZXYROwky6sLiiZ1VYWbhtxPtOpu6YVLpvYUYlurU%2FXHxUKLduMhfRmV9CRf%2FbdP8jSPA39O0mfuRrjlOxCHP6KG2Wd0lbGlJSXGThNwHpHlOjiA4kb%2F5yrsnuttO%2BJQ9ejnB7yWwDCEzA1AFBZugc8CO64tslv1PEV3Qs3r7Hu2qYf4L1YA94FXi7htZowc7DHqt%2FNL8WK0ASZg%3D%3D","price":1999,"product":13,"quantity":1}]', '1999.00', '{"zip":"604304","city":"tindivanam","name":"Jayakumar R","email":"ajrgroupconnect@gmail.com","phone":"9597935647","state":"Tamil Nadu","address":"8, Mettu Street, pathirapuliyur village"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-611280', '2026-07-10T23:19:02.185Z', '2026-07-10T23:19:02.185Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar R', '9597935647', 'ajrgroupconnect@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (24, 14, '[{"name":"Venkateswara swamy","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783432895580-183643197.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=hDyIoNDuN0BjLULVIbWePE%2F4blB7KDJoSNX417puBKn9DhTzjvJTMD5gepsSQ4n6aeOpiz1RrwhYVvNa6em4hwFYefDg%2Bl2clh53Fhr%2B%2Bu8AhJ3Kq1lWkMOFr2fp9p5soBucPUzM3ql6EmaDWDD6AGxjoblraYKJszdnI1pNzGnb55e4Z%2B%2BIktGd7BaTYJ8DptWyQcLmpL%2BibeEo2U%2BWWQ2NKRa3IXRjPlZgasvRi2xffQaz3nmlI8Y%2Fh4eVFfSJSc26LlxrOaLBpIRCE9IR6M6vtmxo0dFG2HKWmIohDliQAPQGEmnQ9zAs%2FxPUrcQFOykufhyd%2Bu5uzWBZaHHiDA%3D%3D","price":499,"product":12,"quantity":1}]', '499.00', '{"zip":"60304","city":"tindivanam","name":"Jayakumar R","email":"ajrgroupconnect@gmail.com","phone":"9597935647","state":"Tamil Nadu","address":"8, Mettu Street, pathirapuliyur village"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-931916', '2026-07-10T23:09:54.543Z', '2026-07-10T23:09:54.543Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar R', '9597935647', 'ajrgroupconnect@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (26, NULL, '[{"name":"Smart 3D Printing Pen with PLA Filament Starter Pack","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1780133850344-214131874.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=krw5iWvXgO5wEKPIlLQSAnOiE4H%2FttoeSXyeJskLCa4KN%2BbcFLLcbtfSwTbyEfk6xkf1ibVULurXX%2Fos0MuGupcEzaqDCQOr8gMMXxzJ6dktKOtokhUtR%2FHWc0yre8cg4XvTbquxWZb%2F%2FLmr33urQK3FdYhCafcrMGE6HshTM4jED9sPKV%2Fv1sc%2BsbaNL2Ju8lxSYLE0MYsjn%2BpruUCvDlEjNN7wINQJ4V78WJ888Z%2BxUzrFl2E1TENFuaQvyBBeE0mm2esaTI2qKClfGmFYF04ycJdyqiz%2FCbz3SrdMiN1MMxf%2BwHOXaVvzwpdnFSgLvP0DE5SCoyaVXHKZNe0jFg%3D%3D","price":799,"product":10,"quantity":1}]', '799.00', '{"zip":"604304","city":"tindivanam","name":"Jayakumar R","email":"ajrgroupconnect@gmail.com","phone":"8903035099","state":"Tamil Nadu","address":"8, Mettu Street, pathirapuliyur village"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-905098', '2026-07-11T01:33:11.021Z', '2026-07-11T01:33:11.021Z', NULL, NULL, '0.00', '0.00', TRUE, 'Jayakumar R', '8903035099', 'ajrgroupconnect@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (20, 14, '[{"name":"Custom 3D Human Miniature ","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783435471588-772043986.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=SE8NgrhkibOjGts3ycnOXboQUwF%2BS60VDd%2FYKUuUrlCYy4llzodCeZhiHEH6%2Bb6CekdKUvLw3xM0EusQtIxMkmdxDOrVnzL12EDMKo8XhNDsxkwa6BRsA0WARUHRScL%2Bl24aMQZZXYROwky6sLiiZ1VYWbhtxPtOpu6YVLpvYUYlurU%2FXHxUKLduMhfRmV9CRf%2FbdP8jSPA39O0mfuRrjlOxCHP6KG2Wd0lbGlJSXGThNwHpHlOjiA4kb%2F5yrsnuttO%2BJQ9ejnB7yWwDCEzA1AFBZugc8CO64tslv1PEV3Qs3r7Hu2qYf4L1YA94FXi7htZowc7DHqt%2FNL8WK0ASZg%3D%3D","price":1999,"product":13,"quantity":1}]', '1999.00', '{"zip":"604301","city":"chennai","name":"Jayakumar","email":"arunjaya1999@gmail.com","phone":"9597935647","state":"tn","address":"9"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-435961', '2026-07-10T14:31:34.097Z', '2026-07-10T14:31:34.097Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar', '9597935647', 'arunjaya1999@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (18, 6, '[{"name":"Custom Birthday Number Frame","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783436420539-613106159.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=Sp%2FWdN%2Fp6kk3fgdoYIwIfEMz%2BPXjC7qHig3rrOSJW07KjgyeS4PvFq2xxiwR8DpeNChsDQqbIL%2F%2B%2FTMjksyYmtNQrL23HMqyEMN58FWFfcVxLI6hCjyvfNP1Wo%2BIIR8T4KgsKbO4XPRmEHYsN8esKI%2FtPHQHDPnX%2FVNo6fid5n54tan9hE7LlHfbHgjnsGznwaIamjwqYY5k8HiGb29jzXC%2BpZj4WzgOVLFmQE4lyWO5yiC6Q%2BIF1U4o0EQxpUDh4icvH4cgNDwzePXz2XsQ6SnmynpkqYwPhxXaLYkZgpBiGxL8pK2CevBKsAD0oRNgAmQ6epYErABJr7ReZrSqtg%3D%3D","price":299,"product":14,"quantity":1}]', '299.00', '{"zip":"533218","city":"amalapuram","name":"Pavan","email":"pavannaidu3000@gmail.com","phone":"+919491201364","state":"Andhra Pradesh","address":"1-133, visweswara agraharam"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-351730', '2026-07-08T10:35:00.650Z', '2026-07-08T10:35:00.650Z', NULL, NULL, '0.00', '0.00', FALSE, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (23, 14, '[{"name":"Custom 3D Human Miniature ","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783435471588-772043986.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=SE8NgrhkibOjGts3ycnOXboQUwF%2BS60VDd%2FYKUuUrlCYy4llzodCeZhiHEH6%2Bb6CekdKUvLw3xM0EusQtIxMkmdxDOrVnzL12EDMKo8XhNDsxkwa6BRsA0WARUHRScL%2Bl24aMQZZXYROwky6sLiiZ1VYWbhtxPtOpu6YVLpvYUYlurU%2FXHxUKLduMhfRmV9CRf%2FbdP8jSPA39O0mfuRrjlOxCHP6KG2Wd0lbGlJSXGThNwHpHlOjiA4kb%2F5yrsnuttO%2BJQ9ejnB7yWwDCEzA1AFBZugc8CO64tslv1PEV3Qs3r7Hu2qYf4L1YA94FXi7htZowc7DHqt%2FNL8WK0ASZg%3D%3D","price":1999,"product":13,"quantity":1}]', '1999.00', '{"zip":"60304","city":"tindivanam","name":"Jayakumar R","email":"ajrgroupconnect@gmail.com","phone":"+919597935647","state":"Tamil Nadu","address":"8, Mettu Street, pathirapuliyur village"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-961262', '2026-07-10T23:06:07.244Z', '2026-07-10T23:06:07.244Z', NULL, NULL, '0.00', '0.00', FALSE, 'Jayakumar R', '+919597935647', 'ajrgroupconnect@gmail.com', NULL, NULL, NULL);
INSERT INTO "orders" ("id", "user_id", "items", "total_amount", "shipping_address", "payment_method", "payment_status", "order_status", "razorpay_order_id", "razorpay_payment_id", "razorpay_signature", "order_number", "created_at", "updated_at", "razorpay_orderid", "razorpay_paymentid", "gst_amount", "shipping_charge", "is_guest", "guest_name", "guest_phone", "guest_email", "firebase_uid", "courier_name", "tracking_number") VALUES (21, 14, '[{"name":"Venkateswara Car Dashboard Idol","image":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1779790465440-535288113.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=gcOecN1wlCuQOknhSVAe7tpYWvbD7K2fWtzjJ2DNEIVh7wN9785X46MBpBW5t0IAA0bhnVrCvoA6OiICK%2B2Pq700pj2HfaDEFrhJPTQ%2BbwHhj4aYxFNM1FDUWqhGWOHKlnRxxmEbP%2BmPWnuEcSULTTQ%2B6F9k%2Fom4jE5udp5Ox%2BWoBBiOp2NBwBpUsanTCNnA7ubfr14F4M8D%2B4WBmPASWGf5AIZobm85%2FAvMxadRW%2FQ1o4Rzrj0xXPgq6oT9EWpPpIp1hi4t6ezzpc42Og2INXv6jyw5nn2VG38MQhaDLh1rYLYlSNXCcLXB6o0cCM5L8uYx7MP73Yaq6cNIG2dt4g%3D%3D","price":299,"product":9,"quantity":1}]', '299.00', '{"zip":"604302","city":"chennai","name":"jk","email":"test1@gmail.com","phone":"9597935647","state":"tn","address":"9"}', 'cod', 'pending', 'pending', NULL, NULL, NULL, 'ORD-179728', '2026-07-10T14:43:04.902Z', '2026-07-10T14:43:04.902Z', NULL, NULL, '0.00', '0.00', FALSE, 'jk', '9597935647', 'test1@gmail.com', NULL, NULL, NULL);

SELECT setval(pg_get_serial_sequence('"orders"', 'id'), COALESCE((SELECT MAX("id") FROM "orders"), 1), true);

-- Table: payment_configs
CREATE TABLE IF NOT EXISTS "payment_configs" (
  "id" INTEGER DEFAULT nextval('payment_configs_id_seq'::regclass) NOT NULL,
  "razorpay_key_id" CHARACTER VARYING,
  "razorpay_key_secret" CHARACTER VARYING,
  "merchant_name" CHARACTER VARYING,
  "merchant_logo" CHARACTER VARYING,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "cod_enabled" BOOLEAN DEFAULT false,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "payment_configs" CASCADE;

-- Inserting 1 rows into "payment_configs"
INSERT INTO "payment_configs" ("id", "razorpay_key_id", "razorpay_key_secret", "merchant_name", "merchant_logo", "updated_at", "cod_enabled") VALUES (1, '', '', '', '', '2026-04-04T12:43:33.703Z', FALSE);

SELECT setval(pg_get_serial_sequence('"payment_configs"', 'id'), COALESCE((SELECT MAX("id") FROM "payment_configs"), 1), true);

-- Table: products
CREATE TABLE IF NOT EXISTS "products" (
  "id" INTEGER DEFAULT nextval('products_id_seq'::regclass) NOT NULL,
  "name" CHARACTER VARYING NOT NULL,
  "description" TEXT,
  "price" NUMERIC NOT NULL,
  "compare_price" NUMERIC,
  "category_id" INTEGER,
  "images" JSONB DEFAULT '[]'::jsonb,
  "stock" INTEGER DEFAULT 0,
  "variants" JSONB DEFAULT '[]'::jsonb,
  "specification" JSONB DEFAULT '{}'::jsonb,
  "tags" JSONB DEFAULT '[]'::jsonb,
  "rating" NUMERIC DEFAULT 0,
  "reviews_count" INTEGER DEFAULT 0,
  "featured" BOOLEAN DEFAULT false,
  "active" BOOLEAN DEFAULT true,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "customizable" BOOLEAN DEFAULT false,
  "customization_type" CHARACTER VARYING DEFAULT 'none'::character varying,
  "enable_tutorials_after_purchase" BOOLEAN DEFAULT false,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "products" CASCADE;

-- Inserting 5 rows into "products"
INSERT INTO "products" ("id", "name", "description", "price", "compare_price", "category_id", "images", "stock", "variants", "specification", "tags", "rating", "reviews_count", "featured", "active", "created_at", "updated_at", "customizable", "customization_type", "enable_tutorials_after_purchase") VALUES (13, 'Custom 3D Human Miniature ', '6 inches 3D Miniature. Need Detailed Image  ', '1999.00', '0.00', 8, '["https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783435471588-772043986.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=SE8NgrhkibOjGts3ycnOXboQUwF%2BS60VDd%2FYKUuUrlCYy4llzodCeZhiHEH6%2Bb6CekdKUvLw3xM0EusQtIxMkmdxDOrVnzL12EDMKo8XhNDsxkwa6BRsA0WARUHRScL%2Bl24aMQZZXYROwky6sLiiZ1VYWbhtxPtOpu6YVLpvYUYlurU%2FXHxUKLduMhfRmV9CRf%2FbdP8jSPA39O0mfuRrjlOxCHP6KG2Wd0lbGlJSXGThNwHpHlOjiA4kb%2F5yrsnuttO%2BJQ9ejnB7yWwDCEzA1AFBZugc8CO64tslv1PEV3Qs3r7Hu2qYf4L1YA94FXi7htZowc7DHqt%2FNL8WK0ASZg%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783435479364-183768231.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=oVZ7097Ilz24U%2BGvtS28kdzDhq9DU6VuMlaw5SG3Vq%2BE2DQR0vzTmxTn9VX%2FK8ACzLkLkKnzqC1WH7SsKNsiIp5%2BHb9A6BNocIFyAnEfdZT4O1sR7RaFUBaMuP5MPOgu6OV6gJpr3gY%2FW9yKXLC0pt7Bczk%2Bemy4yBEI3lEn5pgOPwBUSXdjyQ1jrx%2BMKcx%2FL1ZH0YZ1fWC%2BVyHeruezJWf95%2F28Cn%2F2nbAuN4HdEAcSRCPDad%2Bk7vIkobBW2EdZOWt39CZhwy5yxv%2Bd%2BxxLJasS2Qq3XDwCX6iyUm7k2C%2FTJhTjIGF4C3tigUT7rM%2Bfx00z5HFodlZg%2Fi2VcYDI2g%3D%3D"]', 2, '[]', '{}', '[]', '0.00', 0, FALSE, TRUE, '2026-07-07T09:16:32.719Z', '2026-07-07T09:16:46.857Z', FALSE, 'none', FALSE);
INSERT INTO "products" ("id", "name", "description", "price", "compare_price", "category_id", "images", "stock", "variants", "specification", "tags", "rating", "reviews_count", "featured", "active", "created_at", "updated_at", "customizable", "customization_type", "enable_tutorials_after_purchase") VALUES (11, 'Ayyappa Swamy Idol', '', '499.00', '1996.00', 7, '["https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1782317144360-226929000.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=oM9uGOEFIKa2PcxNGj34%2BRa1H0jQzsaqXmvwVk0UXuV9uYD4JnL%2FHZFCYio5rwTBrYZAz%2FYEJ%2FHUaYrqCn2sBqmsYbSQF3KRZQEp8TzwSvEi5iZgEX9x66BPx2x6s52htSpD2M6RXQmMSAeqg1b5TrUC23tyZTaK3zoSoiInA0ugajyjt1gXXnh2nIjvQbA%2F4ddKLC9LJtRk2Ooc3CmU%2FKilS2CyololH8lvMhj1pevADovH%2B5G1VflC2rhOc4lRB9RubW8hWKxQ%2BJvyFDqlZWxITJccAGAEHK4FIwa8ilV4ipNvHJzdTpDWYRilZfXdjW0Bvw0MN2aEL0dcBilQ7A%3D%3D"]', 5, '[]', '{}', '[]', '0.00', 0, TRUE, TRUE, '2026-06-24T10:38:51.177Z', '2026-07-07T08:26:17.434Z', FALSE, 'none', FALSE);
INSERT INTO "products" ("id", "name", "description", "price", "compare_price", "category_id", "images", "stock", "variants", "specification", "tags", "rating", "reviews_count", "featured", "active", "created_at", "updated_at", "customizable", "customization_type", "enable_tutorials_after_purchase") VALUES (9, 'Venkateswara Car Dashboard Idol', '', '299.00', '0.00', 4, '["https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1779790465440-535288113.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=gcOecN1wlCuQOknhSVAe7tpYWvbD7K2fWtzjJ2DNEIVh7wN9785X46MBpBW5t0IAA0bhnVrCvoA6OiICK%2B2Pq700pj2HfaDEFrhJPTQ%2BbwHhj4aYxFNM1FDUWqhGWOHKlnRxxmEbP%2BmPWnuEcSULTTQ%2B6F9k%2Fom4jE5udp5Ox%2BWoBBiOp2NBwBpUsanTCNnA7ubfr14F4M8D%2B4WBmPASWGf5AIZobm85%2FAvMxadRW%2FQ1o4Rzrj0xXPgq6oT9EWpPpIp1hi4t6ezzpc42Og2INXv6jyw5nn2VG38MQhaDLh1rYLYlSNXCcLXB6o0cCM5L8uYx7MP73Yaq6cNIG2dt4g%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1779790519730-440259761.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=Ojpzu72PmyzjCxSdTaUoiTIttsTRFDRTugCWdDZaV3THqsYjlJrB88%2F%2FUEl6Q3V8Romceno6Iu7m0oZ2RzDrS8A%2BOruLSxSlnhtL%2Ff%2F2XnxXPS4yEW2eG140VFOww3%2B7%2BZJSjKD20TnYcAzh8NVpb6T2aOTLgyB%2FP5bQB4gCTtJafyMzgqB73CJjQiBHSRPOMXNlD5CJQMMfhWS41JmVF9pciTY6mw7MYf2bCQFtAkZGXbDfvwM6UiTAxp3Vm105jko%2Fwo3yCE0AliYhVxs4asFT76LEP981TFer5pguMR%2Bw1bH%2FuMh7MLJL%2F1WCBei3eWgDNz0VjoJRN%2FfubODDOQ%3D%3D"]', 1, '[]', '{}', '[]', '0.00', 0, FALSE, TRUE, '2026-05-26T04:45:24.846Z', '2026-06-24T10:51:41.125Z', FALSE, 'none', FALSE);
INSERT INTO "products" ("id", "name", "description", "price", "compare_price", "category_id", "images", "stock", "variants", "specification", "tags", "rating", "reviews_count", "featured", "active", "created_at", "updated_at", "customizable", "customization_type", "enable_tutorials_after_purchase") VALUES (12, 'Venkateswara swamy', '5 inches Venkateswara Swamy God idol', '499.00', '0.00', 7, '["https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783432895580-183643197.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=hDyIoNDuN0BjLULVIbWePE%2F4blB7KDJoSNX417puBKn9DhTzjvJTMD5gepsSQ4n6aeOpiz1RrwhYVvNa6em4hwFYefDg%2Bl2clh53Fhr%2B%2Bu8AhJ3Kq1lWkMOFr2fp9p5soBucPUzM3ql6EmaDWDD6AGxjoblraYKJszdnI1pNzGnb55e4Z%2B%2BIktGd7BaTYJ8DptWyQcLmpL%2BibeEo2U%2BWWQ2NKRa3IXRjPlZgasvRi2xffQaz3nmlI8Y%2Fh4eVFfSJSc26LlxrOaLBpIRCE9IR6M6vtmxo0dFG2HKWmIohDliQAPQGEmnQ9zAs%2FxPUrcQFOykufhyd%2Bu5uzWBZaHHiDA%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783432895585-906523345.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=pcnW7tzTYIX1hol72nBsnap%2BoD8WjJoqo0Ey1bDLmdRG5n%2FyTA3nUHPQbyj3ijzNDEYO4Av77JuAAZ2KLYoy1PoyJd24R8FyV13kzuu9eUPYss3Kl9ywZaSLD7pqJuRvx3S36WCKG%2BvEmfwkowtH%2BaW1Z9%2FIo5QXmi6thuQ69B%2FMjACqDx4i7JN0fAn7q95I43STpnvJbtygJco6tuFst1QKkmgt%2FETQ8I67lDQRwnwmPjHRNaGsR45qoazJ760ImVoWmX2s9kBUEgsJEK%2BpWUw4H05Qzha5c%2FY8jpyhd1gxO0t5GCHatz3KrORqvHf%2BbKaDG7zpS0iVQJOm8aD1QA%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1783432895587-252091709.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=D1sZgCXXOVArcaw7Yj%2ByEn6Y4GQxhjSiyaJAISWVLm4MsFF8C8krMmbFL6Je5LNmpPPu812g8KimQFrwvg%2BMasIwEfDAS2F3npvcneOiZid8l2mzkOTnWl00VXXveKKLGNyhYIfpgPwrygrWCXSORBSEGpUxa%2F6zlwWjd9s2A65lwZ3JXkmxkPIr04xE%2FqRhOhfGq7xdtQHEZjikLC47dW6%2BxBeO6IVlOmJrPH8FJYblX418A4YZCY7yYdbdaJArO71Z%2BpDFg6nB%2BgZ%2FeqacDt%2F%2B0OugPtSphYFeoiCCEQv3lRr7gvLMwOrP4A1uKkEYa5mHadVxxded3NZjrHdXUA%3D%3D"]', 2, '[]', '{}', '[]', '0.00', 0, TRUE, TRUE, '2026-07-07T08:32:14.032Z', '2026-07-07T08:33:19.937Z', FALSE, 'none', FALSE);
INSERT INTO "products" ("id", "name", "description", "price", "compare_price", "category_id", "images", "stock", "variants", "specification", "tags", "rating", "reviews_count", "featured", "active", "created_at", "updated_at", "customizable", "customization_type", "enable_tutorials_after_purchase") VALUES (10, 'Smart 3D Printing Pen with PLA Filament Starter Pack', '', '799.00', '1499.00', 5, '["https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1780133850344-214131874.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=krw5iWvXgO5wEKPIlLQSAnOiE4H%2FttoeSXyeJskLCa4KN%2BbcFLLcbtfSwTbyEfk6xkf1ibVULurXX%2Fos0MuGupcEzaqDCQOr8gMMXxzJ6dktKOtokhUtR%2FHWc0yre8cg4XvTbquxWZb%2F%2FLmr33urQK3FdYhCafcrMGE6HshTM4jED9sPKV%2Fv1sc%2BsbaNL2Ju8lxSYLE0MYsjn%2BpruUCvDlEjNN7wINQJ4V78WJ888Z%2BxUzrFl2E1TENFuaQvyBBeE0mm2esaTI2qKClfGmFYF04ycJdyqiz%2FCbz3SrdMiN1MMxf%2BwHOXaVvzwpdnFSgLvP0DE5SCoyaVXHKZNe0jFg%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1780133855885-231835913.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=TlVysJNu%2F5Dpkc4RK6qmtUjJeaC3Gr3LXZawwoLJToKgldgoLlfk7%2BzLFXDHN7X%2F%2FWUWoOTZ3ws8afq1mDWQT2OO1W%2F9T3YfYTbWmFY72dM1rSNISF6gASymgugqU9bl9WLX4rSiH6KRlltriHpjL1LQF%2Bm1AYsPyrq0W4gi4%2BzNCwP622RoFRMSRztFsIqsBQv7ylLeVOmdrEGXv5WT0up569f842RAvy82wD2DIvgg4S3XHkXuLj%2Bw2kS%2BNT3Z0PevkA1vv9xscnf3I3H7wD5tzBSQGFZxbAE2jOIbmFfKspcbpQlNzicUzXXVaN1EESwdDK82cMsdeMvkHmp1QA%3D%3D","https://storage.googleapis.com/ideaazone3d.firebasestorage.app/uploads/1780133858582-480778212.jpg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730323200&Signature=IUx58bIpa5c7sjX7PjYffPiJ9eIuNAj8d1DbBVeFiKfNhDa7pWJ0y8OJ%2BapdjjUl7lDu4Iah3E0TiV2HfWacS4dPycubB%2BGkXF7vvCAOvokDNDxanj0u3WoV7c2jCQc5aQcJmr4LZE2dnUZH3S1i9UHuEl5OLfwe%2BND0nBs%2B%2Ff2VFd6Sgv1XcpsT2J%2FGf0PnVqam59kvQYu2bHVR3qPTVvZtXaf0lnUr5xfRx%2BOdFUgeM7lw8ozF0XqFHb8c7Zv6SmZew%2Frjv01eIhx3Z32jrDrfbnvdj%2FRQOsMhsSpRG3SaQYdRI1ZxPMHX3CwI6DPb5bdl7HqHZ3cGEqzmfYo3dA%3D%3D"]', 3, '[]', '{}', '[]', '0.00', 0, FALSE, TRUE, '2026-05-30T04:07:47.212Z', '2026-06-24T10:51:32.312Z', FALSE, 'none', FALSE);

SELECT setval(pg_get_serial_sequence('"products"', 'id'), COALESCE((SELECT MAX("id") FROM "products"), 1), true);

-- Table: tutorial_analytics_events
CREATE TABLE IF NOT EXISTS "tutorial_analytics_events" (
  "id" INTEGER DEFAULT nextval('tutorial_analytics_events_id_seq'::regclass) NOT NULL,
  "user_id" INTEGER,
  "tutorial_id" INTEGER,
  "event_type" CHARACTER VARYING NOT NULL,
  "event_data" JSONB DEFAULT '{}'::jsonb,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "tutorial_analytics_events" CASCADE;

-- Inserting 143 rows into "tutorial_analytics_events"
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (1, 3, 1, 'view', '{}', '2026-07-10T12:54:18.682Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (2, 3, 1, 'view', '{}', '2026-07-10T12:55:39.542Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (3, 3, 1, 'view', '{}', '2026-07-10T12:57:16.115Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (4, 3, 1, 'view', '{}', '2026-07-10T13:02:05.769Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (5, 3, 1, 'view', '{}', '2026-07-10T13:02:11.592Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (6, 3, 1, 'view', '{}', '2026-07-10T13:03:29.613Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (7, 3, 1, 'play', '{"position":0}', '2026-07-10T13:03:46.078Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (8, 3, 1, 'pause', '{"position":0.32}', '2026-07-10T13:04:02.798Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (9, 3, 1, 'pause', '{"position":0.32}', '2026-07-10T13:04:04.533Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (10, 3, 1, 'pause', '{"position":0.32}', '2026-07-10T13:04:04.946Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (11, 3, 1, 'pause', '{"position":0.32}', '2026-07-10T13:04:05.197Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (12, 3, 1, 'pause', '{"position":0.32}', '2026-07-10T13:04:23.133Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (13, 3, 1, 'play', '{"position":0.32}', '2026-07-10T13:04:25.597Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (14, 3, 1, 'pause', '{"position":6.343841}', '2026-07-10T13:05:01.403Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (15, 3, 1, 'complete', '{}', '2026-07-10T13:05:16.030Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (16, 3, 1, 'play', '{"position":0}', '2026-07-10T13:05:19.358Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (17, 3, 1, 'pause', '{"position":20.355344}', '2026-07-10T13:05:29.578Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (18, 3, 1, 'view', '{}', '2026-07-10T13:09:09.566Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (19, 3, 1, 'view', '{}', '2026-07-10T13:11:41.267Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (20, 3, 2, 'view', '{}', '2026-07-10T13:11:44.718Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (21, 3, 2, 'play', '{"position":1}', '2026-07-10T13:12:02.187Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (22, 3, 2, 'pause', '{"position":1.625397}', '2026-07-10T13:12:10.056Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (23, 3, 2, 'pause', '{"position":1.625397}', '2026-07-10T13:12:19.515Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (24, 3, 2, 'play', '{"position":1.626251}', '2026-07-10T13:12:29.264Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (25, 3, 2, 'pause', '{"position":20.131701}', '2026-07-10T13:13:19.345Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (26, 3, 1, 'view', '{}', '2026-07-10T13:13:24.500Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (27, 3, 2, 'view', '{}', '2026-07-10T13:13:26.593Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (28, 3, 2, 'play', '{"position":20.13}', '2026-07-10T13:13:34.504Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (29, 3, 2, 'pause', '{"position":31.745852}', '2026-07-10T13:13:48.059Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (30, 3, 2, 'play', '{"position":31.821247}', '2026-07-10T13:13:48.900Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (31, 3, 2, 'play', '{"position":31.821247}', '2026-07-10T13:13:49.629Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (32, 3, 2, 'play', '{"position":31.821247}', '2026-07-10T13:13:49.741Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (33, 3, 2, 'play', '{"position":31.948957}', '2026-07-10T13:13:50.679Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (34, 3, 2, 'play', '{"position":31.995397}', '2026-07-10T13:13:51.561Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (35, 3, 2, 'play', '{"position":32.065057}', '2026-07-10T13:14:01.308Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (36, 3, 2, 'play', '{"position":32.192766}', '2026-07-10T13:14:04.385Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (37, 3, 2, 'pause', '{"position":37.36386}', '2026-07-10T13:14:08.550Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (38, 3, 2, 'pause', '{"position":37.621949}', '2026-07-10T13:14:15.538Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (39, 3, 1, 'view', '{}', '2026-07-10T13:14:50.062Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (40, 3, 1, 'play', '{"position":0}', '2026-07-10T13:15:04.246Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (41, 3, 1, 'pause', '{"position":7.808216}', '2026-07-10T13:15:14.338Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (42, 3, 2, 'view', '{}', '2026-07-10T13:16:27.642Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (43, 3, 1, 'view', '{}', '2026-07-10T13:16:28.071Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (44, 3, 2, 'view', '{}', '2026-07-10T13:16:28.313Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (45, 3, 1, 'view', '{}', '2026-07-10T13:16:28.791Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (46, 3, 1, 'play', '{"position":0}', '2026-07-10T13:16:29.986Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (47, 3, 1, 'view', '{}', '2026-07-10T13:17:15.976Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (48, 3, 2, 'view', '{}', '2026-07-10T13:17:39.715Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (49, 3, 1, 'view', '{}', '2026-07-10T13:17:52.011Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (50, 3, 1, 'view', '{}', '2026-07-10T13:18:54.291Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (51, 3, 2, 'view', '{}', '2026-07-10T13:18:58.140Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (52, 3, 1, 'view', '{}', '2026-07-10T13:19:56.279Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (53, 3, 1, 'view', '{}', '2026-07-10T13:20:14.604Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (54, 3, 1, 'view', '{}', '2026-07-10T13:23:12.938Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (55, 3, 1, 'view', '{}', '2026-07-10T13:23:17.539Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (56, 3, 2, 'view', '{}', '2026-07-10T13:23:22.479Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (57, 3, 2, 'play', '{"position":23.22}', '2026-07-10T13:23:37.383Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (58, 3, 1, 'view', '{}', '2026-07-10T13:24:10.831Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (59, 3, 1, 'view', '{}', '2026-07-10T13:24:11.661Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (60, 3, 2, 'view', '{}', '2026-07-10T13:24:11.866Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (61, 3, 1, 'play', '{"position":0}', '2026-07-10T13:24:30.793Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (62, 3, 1, 'pause', '{"position":2.005333}', '2026-07-10T13:24:33.804Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (63, 3, 1, 'play', '{"position":0}', '2026-07-10T13:24:37.348Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (64, 3, 1, 'pause', '{"position":3.008}', '2026-07-10T13:24:44.571Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (65, 3, 1, 'play', '{"position":3.008}', '2026-07-10T13:28:18.023Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (66, 3, 1, 'play', '{"position":3.008}', '2026-07-10T13:28:25.964Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (67, 3, 1, 'view', '{}', '2026-07-10T13:29:05.553Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (68, 3, 1, 'view', '{}', '2026-07-10T13:29:36.649Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (69, 3, 1, 'view', '{}', '2026-07-10T13:31:39.995Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (70, 3, 1, 'play', '{"position":2.94}', '2026-07-10T13:31:46.724Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (71, 3, 1, 'complete', '{}', '2026-07-10T13:32:05.204Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (72, 3, 2, 'view', '{}', '2026-07-10T13:32:05.240Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (73, 3, 2, 'complete', '{}', '2026-07-10T13:32:14.088Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (74, 3, 2, 'play', '{"position":0}', '2026-07-10T13:32:17.618Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (75, 3, 2, 'play', '{"position":0.12771}', '2026-07-10T13:32:18.714Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (76, 3, 2, 'play', '{"position":0.20898}', '2026-07-10T13:32:19.204Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (77, 3, 2, 'play', '{"position":0.278639}', '2026-07-10T13:32:19.839Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (78, 3, 2, 'pause', '{"position":33.458142}', '2026-07-10T13:32:28.289Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (79, 3, 1, 'view', '{}', '2026-07-10T13:32:32.519Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (80, 3, 1, 'view', '{}', '2026-07-10T13:33:59.751Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (81, 3, 1, 'play', '{"position":30.526667}', '2026-07-10T13:34:06.532Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (82, 3, 1, 'complete', '{}', '2026-07-10T13:34:06.590Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (83, 3, 2, 'view', '{}', '2026-07-10T13:34:06.627Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (84, 3, 1, 'view', '{}', '2026-07-10T13:35:44.810Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (85, 3, 2, 'view', '{}', '2026-07-10T13:35:47.961Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (86, 3, 2, 'pause', '{"position":33.46}', '2026-07-10T13:36:12.473Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (87, 3, 2, 'play', '{"position":33.46}', '2026-07-10T13:36:15.198Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (88, 3, 2, 'complete', '{}', '2026-07-10T13:36:23.977Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (89, 3, 1, 'view', '{}', '2026-07-10T13:36:25.977Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (90, 3, 1, 'play', '{"position":30.526667}', '2026-07-10T13:36:48.528Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (91, 3, 1, 'complete', '{}', '2026-07-10T13:36:48.614Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (92, 3, 2, 'view', '{}', '2026-07-10T13:36:49.529Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (93, 3, 2, 'play', '{"position":0}', '2026-07-10T13:36:49.687Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (94, 3, 1, 'view', '{}', '2026-07-10T13:36:50.274Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (95, 3, 1, 'complete', '{}', '2026-07-10T13:37:02.049Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (96, 3, 2, 'view', '{}', '2026-07-10T13:37:13.284Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (97, 3, 2, 'play', '{"position":0.47}', '2026-07-10T13:37:26.063Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (98, 3, 2, 'complete', '{}', '2026-07-10T13:38:20.621Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (99, 3, 1, 'view', '{}', '2026-07-10T13:41:27.714Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (100, 3, 1, 'view', '{}', '2026-07-10T13:45:47.992Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (101, 3, 1, 'view', '{}', '2026-07-10T13:50:12.454Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (102, 3, 1, 'view', '{}', '2026-07-10T13:57:12.869Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (103, 3, 1, 'view', '{}', '2026-07-10T13:58:17.827Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (104, 3, 1, 'view', '{}', '2026-07-10T14:01:59.458Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (105, 3, 2, 'view', '{}', '2026-07-10T14:02:13.144Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (106, 3, 2, 'play', '{"position":0}', '2026-07-10T14:02:22.801Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (107, 3, 2, 'complete', '{}', '2026-07-10T14:02:55.274Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (108, 14, 1, 'view', '{}', '2026-07-10T14:08:35.554Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (109, 14, 1, 'view', '{}', '2026-07-10T14:11:40.851Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (110, 14, 1, 'view', '{}', '2026-07-10T14:18:17.555Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (111, 14, 1, 'view', '{}', '2026-07-10T14:24:38.065Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (112, 14, 1, 'view', '{}', '2026-07-10T14:24:40.030Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (113, 14, 1, 'view', '{}', '2026-07-10T14:25:03.890Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (116, 14, 2, 'view', '{}', '2026-07-10T14:25:18.115Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (114, 14, 1, 'view', '{}', '2026-07-10T14:25:11.170Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (120, 14, 1, 'view', '{}', '2026-07-10T14:27:25.669Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (121, 14, 1, 'view', '{}', '2026-07-10T14:29:25.792Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (122, 14, 1, 'view', '{}', '2026-07-10T14:29:55.512Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (115, 14, 1, 'view', '{}', '2026-07-10T14:25:13.382Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (117, 14, 2, 'play', '{"position":0}', '2026-07-10T14:25:26.424Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (118, 14, 2, 'pause', '{"position":4.093747}', '2026-07-10T14:25:30.745Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (119, 14, 1, 'view', '{}', '2026-07-10T14:26:48.314Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (123, 14, 1, 'view', '{}', '2026-07-10T14:30:14.121Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (124, 14, 1, 'view', '{}', '2026-07-11T01:35:34.793Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (125, 14, 2, 'view', '{}', '2026-07-11T01:35:56.521Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (126, 14, 2, 'play', '{"position":4.09}', '2026-07-11T01:36:06.830Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (127, 14, 2, 'play', '{"position":4.09}', '2026-07-11T01:36:07.581Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (128, 14, 2, 'play', '{"position":4.24093}', '2026-07-11T01:36:08.214Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (129, 14, 2, 'pause', '{"position":21.733654}', '2026-07-11T01:36:22.509Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (130, 14, 1, 'view', '{}', '2026-07-11T01:37:10.129Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (131, 14, 1, 'play', '{"position":0}', '2026-07-11T01:37:16.893Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (132, 14, 1, 'pause', '{"position":13.252496}', '2026-07-11T01:37:32.426Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (133, 14, 1, 'pause', '{"position":16.776611}', '2026-07-11T01:37:35.947Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (134, 14, 1, 'view', '{}', '2026-07-11T01:38:00.008Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (135, 14, 1, 'view', '{}', '2026-07-11T01:38:21.494Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (136, 14, 2, 'view', '{}', '2026-07-11T02:34:29.012Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (137, 14, 2, 'play', '{"position":0}', '2026-07-11T02:34:46.361Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (138, 14, 2, 'pause', '{"position":51.33191}', '2026-07-11T02:35:09.093Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (139, 14, 1, 'view', '{}', '2026-07-11T02:35:18.715Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (140, 14, 1, 'play', '{"position":16.78}', '2026-07-11T02:35:26.951Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (141, 14, 1, 'complete', '{}', '2026-07-11T02:35:52.767Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (142, 14, 2, 'view', '{}', '2026-07-11T02:36:10.085Z');
INSERT INTO "tutorial_analytics_events" ("id", "user_id", "tutorial_id", "event_type", "event_data", "created_at") VALUES (143, 14, 2, 'view', '{}', '2026-07-11T02:36:47.730Z');

SELECT setval(pg_get_serial_sequence('"tutorial_analytics_events"', 'id'), COALESCE((SELECT MAX("id") FROM "tutorial_analytics_events"), 1), true);

-- Table: tutorial_categories
CREATE TABLE IF NOT EXISTS "tutorial_categories" (
  "id" INTEGER DEFAULT nextval('tutorial_categories_id_seq'::regclass) NOT NULL,
  "name" CHARACTER VARYING NOT NULL,
  "description" TEXT,
  "display_order" INTEGER DEFAULT 0,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "tutorial_categories" CASCADE;

-- Inserting 1 rows into "tutorial_categories"
INSERT INTO "tutorial_categories" ("id", "name", "description", "display_order", "created_at", "updated_at") VALUES (1, 'Installation', 'installation manual', 0, '2026-07-10T12:41:16.429Z', '2026-07-10T12:41:16.429Z');

SELECT setval(pg_get_serial_sequence('"tutorial_categories"', 'id'), COALESCE((SELECT MAX("id") FROM "tutorial_categories"), 1), true);

-- Table: tutorial_product_mappings
CREATE TABLE IF NOT EXISTS "tutorial_product_mappings" (
  "tutorial_id" INTEGER NOT NULL,
  "product_id" INTEGER NOT NULL,
  PRIMARY KEY ("tutorial_id", "product_id")
);
TRUNCATE TABLE "tutorial_product_mappings" CASCADE;

-- Inserting 8 rows into "tutorial_product_mappings"
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (2, 13);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (2, 12);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (2, 11);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (1, 13);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (1, 12);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (1, 9);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (1, 11);
INSERT INTO "tutorial_product_mappings" ("tutorial_id", "product_id") VALUES (1, 10);

-- Table: tutorials
CREATE TABLE IF NOT EXISTS "tutorials" (
  "id" INTEGER DEFAULT nextval('tutorials_id_seq'::regclass) NOT NULL,
  "title" CHARACTER VARYING NOT NULL,
  "subtitle" CHARACTER VARYING,
  "description" TEXT,
  "thumbnail_url" TEXT,
  "video_url" TEXT,
  "category_id" INTEGER,
  "duration" CHARACTER VARYING,
  "difficulty" CHARACTER VARYING,
  "display_order" INTEGER DEFAULT 0,
  "status" CHARACTER VARYING DEFAULT 'draft'::character varying,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "resources" JSONB DEFAULT '[]'::jsonb,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "tutorials" CASCADE;

-- Inserting 2 rows into "tutorials"
INSERT INTO "tutorials" ("id", "title", "subtitle", "description", "thumbnail_url", "video_url", "category_id", "duration", "difficulty", "display_order", "status", "created_at", "updated_at", "resources") VALUES (2, 'Jailer Trailer', 'Trailer', 'new title relase', 'https://storage.googleapis.com/ideaazone3d.firebasestorage.app/tutorial-thumbnails/1783708868673-986269381.png?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730303400&Signature=MBYuJC7pgOOd%2BGOqUMYa7QIv27%2FM3g7UI6ZIzkayNzaEWxJbMr0nGMWqo5d2Vt8iZhSUA%2BuC%2FwYcFzhqKQbz7sIVs2bZnoyEgtjljRwXdKjsoekHDqH3LSQDCDLpHof9aM%2Brf9eHF81h%2B2za4Sniql%2BM0PM7k12Z2u%2F3Fk4%2BeIiKfZX3hVu0DT9RpeBeeoKnOoxfluQ6J2DxCPQOuxi1z0X3Zp1pmfFJgwOA1h3yqRNQlqq2OhRGay7k5CdXJf%2BJT3Ec4UrqhaAddIYy0tUlt7%2FI60pAmVigVCsOPmrT3zR5e427txP4BXLthOQbnr2%2BQD9OkHHbHgEmb515D2oDoA%3D%3D', 'tutorials/general/1783708859442-183736558.mp4', 1, '00:54', 'Intermediate', 0, 'published', '2026-07-10T13:11:33.048Z', '2026-07-11T02:33:02.928Z', '[{"url":"https://storage.googleapis.com/ideaazone3d.firebasestorage.app/tutorial-resources/1783710315855-343634540.pdf?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730303400&Signature=qFxdM%2FP2Okk6V9nclGVPwxRKPui7vafugo2LgQHblJw3bDRzg94Cmn7sgJXxqELFEHcTPko91sOQQB0q4v4%2BLSCL0MPHl2DxhK3d4QNOtoy%2F0zcEoEFc3XFj%2BfueeSuXMOaQc%2BEM3ug%2FD%2FOoaSTEg0YiC2Z8SQJqNZGt4ujqBZQu743qg62lvlkTg4HNjFJu49wsI7cIk1qiVNBHUHoGNWjDXMok5wz65n50TpUC0Ef4ugQHMRhPLP6J1qMcwHO6k3WlGpOScqs3cbtzinCRgafKDXJ1X9zEaQV00TrdmVtOOCnYuN5E82J2Dmzbn2KhYpAynBwqfVb05x1DCEJekg%3D%3D","name":"AJR_Agent_Commission_Policy.pdf"}]');
INSERT INTO "tutorials" ("id", "title", "subtitle", "description", "thumbnail_url", "video_url", "category_id", "duration", "difficulty", "display_order", "status", "created_at", "updated_at", "resources") VALUES (1, '3D Printer setup', 'Bambulab-a1', 'watch full video', 'https://storage.googleapis.com/ideaazone3d.firebasestorage.app/tutorial-thumbnails/1783707632792-80178527.jpeg?GoogleAccessId=firebase-adminsdk-fbsvc%40ideaazone3d.iam.gserviceaccount.com&Expires=16730303400&Signature=ZHNqrO0pScNyzi%2FKnxvBEE1RGOJJE4TYXAatf95TWWY5%2BG53QH%2BNyJgRfe1pWUQEn49A7ikwiufUcYxXYcxCRR8fCXxxcU2MklFFVG4B4vO3gVLl4Nv46UbKE0x2vQbaaS%2BgpdgFvQ1rtbmpdkXYF8BnbYGI9KpFX5VtTEMRspvAKAyfc8J8%2FhMsIOP9QMDs6f6%2Bx8XRNlpULl9Ej681%2BsH09bq%2BWjY8ZCNVMGniIupwXUp%2FvkAon8DlXNzQevkrs%2F1%2BJhe%2BRanLBJg8B7VK7Hg4oHk7fQm2AP7nY5Kn2ErB%2Bf6hc7RjoxsLYUzHR%2BdMepUH2zzofsoecBKifnppTA%3D%3D', 'tutorials/installation/1783707990749-165719677.mp4', 1, '00:30', 'Beginner', 1, 'published', '2026-07-10T12:54:08.638Z', '2026-07-11T02:33:41.299Z', '[]');

SELECT setval(pg_get_serial_sequence('"tutorials"', 'id'), COALESCE((SELECT MAX("id") FROM "tutorials"), 1), true);

-- Table: user_tutorial_access
CREATE TABLE IF NOT EXISTS "user_tutorial_access" (
  "user_id" INTEGER NOT NULL,
  "tutorial_id" INTEGER NOT NULL,
  PRIMARY KEY ("user_id", "tutorial_id")
);
TRUNCATE TABLE "user_tutorial_access" CASCADE;

-- Table: user_tutorial_progress
CREATE TABLE IF NOT EXISTS "user_tutorial_progress" (
  "id" INTEGER DEFAULT nextval('user_tutorial_progress_id_seq'::regclass) NOT NULL,
  "user_id" INTEGER,
  "tutorial_id" INTEGER,
  "last_watched_position" NUMERIC DEFAULT 0,
  "percentage_watched" INTEGER DEFAULT 0,
  "completed" BOOLEAN DEFAULT false,
  "first_viewed_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "last_viewed_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "total_watch_time" INTEGER DEFAULT 0,
  "sessions_count" INTEGER DEFAULT 1,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "user_tutorial_progress" CASCADE;

-- Inserting 4 rows into "user_tutorial_progress"
INSERT INTO "user_tutorial_progress" ("id", "user_id", "tutorial_id", "last_watched_position", "percentage_watched", "completed", "first_viewed_at", "last_viewed_at", "total_watch_time", "sessions_count") VALUES (1, 3, 1, '30.53', 100, TRUE, '2026-07-10T13:04:26.223Z', '2026-07-10T13:37:13.278Z', 101, 21);
INSERT INTO "user_tutorial_progress" ("id", "user_id", "tutorial_id", "last_watched_position", "percentage_watched", "completed", "first_viewed_at", "last_viewed_at", "total_watch_time", "sessions_count") VALUES (2, 3, 2, '54.08', 100, TRUE, '2026-07-10T13:12:29.787Z', '2026-07-10T14:04:57.646Z', 190, 45);
INSERT INTO "user_tutorial_progress" ("id", "user_id", "tutorial_id", "last_watched_position", "percentage_watched", "completed", "first_viewed_at", "last_viewed_at", "total_watch_time", "sessions_count") VALUES (4, 14, 1, '30.53', 100, TRUE, '2026-07-11T01:37:24.143Z', '2026-07-11T02:36:10.091Z', 37, 9);
INSERT INTO "user_tutorial_progress" ("id", "user_id", "tutorial_id", "last_watched_position", "percentage_watched", "completed", "first_viewed_at", "last_viewed_at", "total_watch_time", "sessions_count") VALUES (3, 14, 2, '51.33', 95, TRUE, '2026-07-10T14:25:33.038Z', '2026-07-11T02:36:46.960Z', 36, 9);

SELECT setval(pg_get_serial_sequence('"user_tutorial_progress"', 'id'), COALESCE((SELECT MAX("id") FROM "user_tutorial_progress"), 1), true);

-- Table: users
CREATE TABLE IF NOT EXISTS "users" (
  "id" INTEGER DEFAULT nextval('users_id_seq'::regclass) NOT NULL,
  "name" CHARACTER VARYING NOT NULL,
  "email" CHARACTER VARYING NOT NULL,
  "password" CHARACTER VARYING NOT NULL,
  "role" CHARACTER VARYING DEFAULT 'customer'::character varying,
  "phone" CHARACTER VARYING,
  "address" JSONB,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "tutorial_access" BOOLEAN DEFAULT false,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "users" CASCADE;

-- Inserting 15 rows into "users"
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (4, 'Test USEr', 'test1@gmail.com', '$2a$12$31fVEdLaeeBRG1AlmiUoXO2uUlSk1yVadww5HxwiXG/umD2p1eV0O', 'customer', NULL, NULL, '2026-04-13T11:27:00.474Z', '2026-04-13T11:27:00.474Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (6, 'pavan', 'pavannaidu3000@gmail.com', '$2a$12$ijW.0.au5ChVHPcioIMTb.eGNYHlzDJ/fxHn/uph0i30SA/8k0Pue', 'customer', NULL, NULL, '2026-04-14T13:02:16.619Z', '2026-04-14T13:02:16.619Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (8, 'Test', 'pavannaidu30@gmail.com', '$2a$12$zklabYd90oka0bfBj/YfB.LfV9iZOOvEPjwnIGNkLsS2Rbrnfwe5W', 'customer', NULL, NULL, '2026-05-10T13:02:24.596Z', '2026-05-10T13:02:24.596Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (9, 'pavan', 'ppavannaidu3000@gmail.com', '$2a$12$430XiZTnmV9di6JDcmznZuIeNaUc3bSwfDmUjySDSs8ll8eGaBKJq', 'customer', NULL, NULL, '2026-05-29T11:51:50.300Z', '2026-05-29T11:51:50.300Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (10, 'Test', 'papew52056@aratrin.com', '$2a$12$hh3YEhCOrTgKIvnavSxk1Omz1FUq7NrKb7TrAl6lHqKI5M6Pb4W1O', 'customer', NULL, NULL, '2026-06-22T01:00:05.264Z', '2026-06-22T01:00:05.264Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (11, 'pavan', 'unknowassassin136@gmail.com', '$2a$12$.pB3eF4yMpDI3OWItBG2eudNs6x15fZ14w3cgf88iKeJzPf/M1fqq', 'customer', NULL, NULL, '2026-06-25T02:36:11.894Z', '2026-06-25T02:36:11.894Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (12, 'manohar', 'nattimanohar@gmail.com', '$2a$12$X5LcCesufepnMLNGB8fj9OgefD4o/rMYsv52wPu.jNv8uixT.3OSu', 'customer', NULL, NULL, '2026-06-25T02:37:22.200Z', '2026-06-25T02:37:22.200Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (13, '3D HUB', 'admin@kallme.com', '$2a$12$giljlp/Cvdhfec8woKt99e3kR/zIcM/kIz0DgP6m08Y0Upe3vou.K', 'customer', NULL, NULL, '2026-06-25T02:38:46.047Z', '2026-07-10T13:44:28.108Z', TRUE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (15, 'Manisankar Dasari', 'dmanisankar2402@gmail.com', '$2a$12$HtKX357I6Twa0maCMKXPrOI7Ww5RJAhTMqr.ee/G6UBRWeP2bLwAO', 'customer', NULL, NULL, '2026-07-10T22:38:48.080Z', '2026-07-10T22:38:48.080Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (14, 'Demo', 'demo1@gmail.com', '$2a$12$DU30JM99Xz8dNUjZ23T7aeAWIYcseBv5puKHZblYnPuxKv0xIoTci', 'customer', '9597935647', NULL, '2026-07-10T14:05:31.090Z', '2026-07-11T02:34:21.586Z', TRUE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (16, 'Abhisheak', 'technoabhi369@gmail.com', '$2a$12$7qcI9KjRKTyGxx4g0g16TeiTmCzN.4uBlwdAjDtAWvPrfXUSaQ4V2', 'customer', NULL, NULL, '2026-08-22T03:13:31.615Z', '2026-08-22T03:13:31.615Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (17, 'Rohith', 'rohith47k@gmail.com', '$2a$12$6Z4rYQdG.HK12XnKPxRuse9LGin4JVl6Wz5eSP7eGW2ZSauB4mHZ6', 'customer', NULL, NULL, '2026-09-05T08:16:05.278Z', '2026-09-05T08:16:05.278Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (1, 'Admin', 'admin@store.com', '$2b$10$YourHashedPasswordHere', 'admin', '9999999999', NULL, '2026-04-04T13:00:03.187Z', '2026-04-04T13:00:03.187Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (3, 'Admin', 'admin@ideazone.com', '$2a$12$ImbLKY5Gg3Tn5pntJrzrjOAwKtz6TMpsHTAnO7p4XmMpFNQ5NvEma', 'admin', NULL, NULL, '2026-04-12T10:32:22.731Z', '2026-04-12T10:32:22.731Z', FALSE);
INSERT INTO "users" ("id", "name", "email", "password", "role", "phone", "address", "created_at", "updated_at", "tutorial_access") VALUES (7, 'AJR Mart', 'arunjaya1999@gmail.com', '$2a$12$G17Au0SLwsHoxd/SwgPbMOhQqldIdEg5uDgnoFmhV8h27aSja4WeG', 'admin', NULL, NULL, '2026-04-26T04:53:46.148Z', '2026-04-26T04:53:46.148Z', FALSE);

SELECT setval(pg_get_serial_sequence('"users"', 'id'), COALESCE((SELECT MAX("id") FROM "users"), 1), true);

-- Table: watch_history
CREATE TABLE IF NOT EXISTS "watch_history" (
  "id" INTEGER DEFAULT nextval('watch_history_id_seq'::regclass) NOT NULL,
  "user_id" INTEGER,
  "tutorial_id" INTEGER,
  "watched_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  "duration" INTEGER,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "watch_history" CASCADE;

-- Inserting 84 rows into "watch_history"
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (1, 3, 1, '2026-07-10T13:04:26.223Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (2, 3, 1, '2026-07-10T13:04:37.193Z', 2);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (3, 3, 1, '2026-07-10T13:04:38.637Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (4, 3, 1, '2026-07-10T13:04:41.213Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (5, 3, 1, '2026-07-10T13:04:46.018Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (6, 3, 1, '2026-07-10T13:04:51.118Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (7, 3, 1, '2026-07-10T13:04:56.063Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (8, 3, 1, '2026-07-10T13:05:02.995Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (9, 3, 1, '2026-07-10T13:05:07.108Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (10, 3, 1, '2026-07-10T13:05:11.047Z', 9);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (11, 3, 1, '2026-07-10T13:05:16.033Z', 10);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (12, 3, 1, '2026-07-10T13:05:21.087Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (13, 3, 1, '2026-07-10T13:05:26.603Z', 10);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (14, 3, 1, '2026-07-10T13:05:31.168Z', 7);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (15, 3, 2, '2026-07-10T13:12:29.787Z', 2);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (16, 3, 2, '2026-07-10T13:12:37.040Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (17, 3, 2, '2026-07-10T13:12:50.177Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (18, 3, 2, '2026-07-10T13:13:04.655Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (19, 3, 2, '2026-07-10T13:13:14.649Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (20, 3, 2, '2026-07-10T13:13:39.786Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (21, 3, 2, '2026-07-10T13:13:47.055Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (22, 3, 2, '2026-07-10T13:13:55.794Z', 2);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (23, 3, 2, '2026-07-10T13:14:06.939Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (24, 3, 2, '2026-07-10T13:14:12.345Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (25, 3, 2, '2026-07-10T13:14:15.620Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (26, 3, 2, '2026-07-10T13:14:23.237Z', 8);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (27, 3, 2, '2026-07-10T13:14:30.182Z', 10);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (28, 3, 2, '2026-07-10T13:14:48.440Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (29, 3, 2, '2026-07-10T13:14:49.092Z', 10);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (30, 3, 1, '2026-07-10T13:15:10.596Z', 6);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (31, 3, 1, '2026-07-10T13:16:27.632Z', 1);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (32, 3, 2, '2026-07-10T13:23:41.763Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (33, 3, 2, '2026-07-10T13:23:46.766Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (34, 3, 2, '2026-07-10T13:23:53.809Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (35, 3, 2, '2026-07-10T13:24:00.058Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (36, 3, 2, '2026-07-10T13:24:02.512Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (37, 3, 2, '2026-07-10T13:24:07.616Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (38, 3, 2, '2026-07-10T13:24:09.127Z', 1);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (39, 3, 1, '2026-07-10T13:24:41.942Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (40, 3, 1, '2026-07-10T13:31:49.285Z', 2);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (41, 3, 1, '2026-07-10T13:31:54.255Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (42, 3, 1, '2026-07-10T13:31:59.260Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (43, 3, 1, '2026-07-10T13:32:04.255Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (44, 3, 2, '2026-07-10T13:32:14.093Z', 1);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (45, 3, 2, '2026-07-10T13:32:24.264Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (46, 3, 2, '2026-07-10T13:32:29.269Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (47, 3, 2, '2026-07-10T13:36:19.472Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (48, 3, 2, '2026-07-10T13:36:23.976Z', 1);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (49, 3, 2, '2026-07-10T13:37:18.203Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (50, 3, 2, '2026-07-10T13:37:33.058Z', 7);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (51, 3, 2, '2026-07-10T13:37:38.044Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (52, 3, 2, '2026-07-10T13:37:43.023Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (53, 3, 2, '2026-07-10T13:37:48.023Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (54, 3, 2, '2026-07-10T13:37:53.048Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (55, 3, 2, '2026-07-10T13:37:58.054Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (56, 3, 2, '2026-07-10T13:38:03.039Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (57, 3, 2, '2026-07-10T13:38:08.064Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (58, 3, 2, '2026-07-10T13:38:13.039Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (59, 3, 2, '2026-07-10T13:38:18.019Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (60, 3, 2, '2026-07-10T13:38:19.759Z', 2);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (61, 3, 2, '2026-07-10T14:02:29.078Z', 6);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (62, 3, 2, '2026-07-10T14:02:34.053Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (63, 3, 2, '2026-07-10T14:02:39.062Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (64, 3, 2, '2026-07-10T14:02:44.048Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (65, 3, 2, '2026-07-10T14:02:49.039Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (66, 3, 2, '2026-07-10T14:02:54.045Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (67, 14, 2, '2026-07-10T14:25:33.038Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (68, 14, 2, '2026-07-11T01:36:13.639Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (69, 14, 2, '2026-07-11T01:36:18.363Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (70, 14, 2, '2026-07-11T01:36:23.683Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (71, 14, 1, '2026-07-11T01:37:24.143Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (72, 14, 1, '2026-07-11T01:37:28.367Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (73, 14, 1, '2026-07-11T01:37:33.651Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (74, 14, 1, '2026-07-11T01:37:38.364Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (75, 14, 2, '2026-07-11T02:34:52.701Z', 6);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (76, 14, 2, '2026-07-11T02:34:57.423Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (77, 14, 2, '2026-07-11T02:35:02.693Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (78, 14, 2, '2026-07-11T02:35:07.427Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (79, 14, 2, '2026-07-11T02:35:18.692Z', 1);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (80, 14, 1, '2026-07-11T02:35:32.774Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (81, 14, 1, '2026-07-11T02:35:37.426Z', 3);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (82, 14, 1, '2026-07-11T02:35:42.690Z', 5);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (83, 14, 1, '2026-07-11T02:35:47.424Z', 4);
INSERT INTO "watch_history" ("id", "user_id", "tutorial_id", "watched_at", "duration") VALUES (84, 14, 1, '2026-07-11T02:35:51.675Z', 4);

SELECT setval(pg_get_serial_sequence('"watch_history"', 'id'), COALESCE((SELECT MAX("id") FROM "watch_history"), 1), true);

-- Table: whatsapp_logs
CREATE TABLE IF NOT EXISTS "whatsapp_logs" (
  "id" INTEGER DEFAULT nextval('whatsapp_logs_id_seq'::regclass) NOT NULL,
  "recipient_number" CHARACTER VARYING,
  "message_content" TEXT,
  "status" CHARACTER VARYING,
  "reason" TEXT,
  "order_id" INTEGER,
  "user_id" INTEGER,
  "message_type" CHARACTER VARYING,
  "created_at" TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);
TRUNCATE TABLE "whatsapp_logs" CASCADE;

-- Inserting 44 rows into "whatsapp_logs"
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (1, '8903035099', 'Template: order_confirmation_admin', 'failed', '{"error":{"message":"(#100) Invalid parameter","code":100,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"Parameter ''text'' is mandatory for component parameter type ''text''"},"fbtrace_id":"A5qUC4yEoPOqL2LKyernAGS"}}', 7, NULL, 'order_confirmation_admin', '2026-04-26T05:12:30.672Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (2, '+919597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSNjgyOTI4MkNBRjZCNTk0NkZBAA==","message_status":"accepted"}]}', 8, 7, 'order_confirmation_client', '2026-04-26T05:22:32.288Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (3, '8903035099', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+918903035099","wa_id":"918903035099"}],"messages":[{"id":"wamid.HBgMOTE4OTAzMDM1MDk5FQIAERgSQkM4MEJEQ0JDNjQ0Mzk0NTU4AA==","message_status":"accepted"}]}', 8, NULL, 'order_confirmation_admin', '2026-04-26T05:22:35.047Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (4, '1234567890', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+911234567890","wa_id":"911234567890"}],"messages":[{"id":"wamid.HBgMOTExMjM0NTY3ODkwFQIAERgSNjFENEQxRDFGQjQ0RTRFRTExAA==","message_status":"accepted"}]}', 9, 8, 'order_confirmation_client', '2026-05-10T13:03:02.237Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (5, '8903035099', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+918903035099","wa_id":"918903035099"}],"messages":[{"id":"wamid.HBgMOTE4OTAzMDM1MDk5FQIAERgSQUU0QTQzQTVEQTcyMDNCRjhDAA==","message_status":"accepted"}]}', 9, NULL, 'order_confirmation_admin', '2026-05-10T13:03:04.343Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (6, 'Dnd', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#131009) Parameter value is not valid","code":131009,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"The phone number is malformed: Please use the format: +1234567890."},"fbtrace_id":"ABOwg__TeDWFiYaFpdKp23i"}}', 10, 8, 'order_confirmation_client', '2026-05-10T13:03:44.533Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (7, '8903035099', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+918903035099","wa_id":"918903035099"}],"messages":[{"id":"wamid.HBgMOTE4OTAzMDM1MDk5FQIAERgSMzNFMzZBMDY3MTEzRjYyRUU4AA==","message_status":"accepted"}]}', 10, NULL, 'order_confirmation_admin', '2026-05-10T13:03:47.841Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (8, '+919491201364', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"Unsupported post request. Object with ID ''1141890679005435'' does not exist, cannot be loaded due to missing permissions, or does not support this operation. Please read the Graph API documentation at https://developers.facebook.com/docs/graph-api","code":100,"type":"GraphMethodException","error_subcode":33,"fbtrace_id":"Aqms8lfgxqH0LhGEhh9NnEB"}}', 11, 3, 'order_confirmation_client', '2026-05-26T09:34:29.172Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (9, '+919491201364', 'Template: order_confirmation_admin', 'failed', '{"error":{"message":"Unsupported post request. Object with ID ''1141890679005435'' does not exist, cannot be loaded due to missing permissions, or does not support this operation. Please read the Graph API documentation at https://developers.facebook.com/docs/graph-api","code":100,"type":"GraphMethodException","error_subcode":33,"fbtrace_id":"A_i4h_8tI2la1Evup_o9szS"}}', 11, NULL, 'order_confirmation_admin', '2026-05-26T09:34:31.484Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (10, '+919491201364', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"Authentication Error","code":190,"type":"OAuthException","fbtrace_id":"AkolvGoTmBwR_YYS6pNVLSh"}}', 12, 3, 'order_confirmation_client', '2026-05-29T10:27:42.478Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (11, '+919989013142', 'Template: order_confirmation_admin', 'failed', '{"error":{"message":"Authentication Error","code":190,"type":"OAuthException","fbtrace_id":"AdsPlFjQ14e1WZ3dPOy4ZyU"}}', 12, NULL, 'order_confirmation_admin', '2026-05-29T10:27:42.944Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (12, '+919491201364', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#132000) Number of parameters does not match the expected number of params","code":132000,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"body: number of localizable_params (8) does not match the expected number of params (6)"},"fbtrace_id":"AoIoriClc1CGmC4d6F0q4xN"}}', 13, 9, 'order_confirmation_client', '2026-05-29T11:52:19.262Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (13, '+919491201364', 'Template: order_confirmation_admin', 'failed', '{"error":{"message":"(#132000) Number of parameters does not match the expected number of params","code":132000,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"body: number of localizable_params (8) does not match the expected number of params (7)"},"fbtrace_id":"AedeIEAF1IzJtUL7nuEAuGv"}}', 13, NULL, 'order_confirmation_admin', '2026-05-29T11:52:34.291Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (14, '+919491201364', 'Template: order_status_update', 'failed', '{"error":{"message":"(#132000) Number of parameters does not match the expected number of params","code":132000,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"body: number of localizable_params (10) does not match the expected number of params (8)"},"fbtrace_id":"AMtpk9-7hBAlx0vD3rS2qpK"}}', 13, 9, 'status_update_pending', '2026-05-31T03:03:53.761Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (15, '+919491201364', 'Template: order_status_update', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSNEU5OTU1MEQyMTVDQ0VENUM2AA==","message_status":"accepted"}]}', 13, 9, 'status_update_processing', '2026-05-31T03:15:13.023Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (16, '+919491201364', 'Template: order_status_update', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSQUQ0ODg4NzgxQ0Q1OEUzQUNEAA==","message_status":"accepted"}]}', 12, 3, 'status_update_pending', '2026-05-31T03:15:35.372Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (17, '+919597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSRjk3RTU0MUQ0REE3REIyNDVDAA==","message_status":"accepted"}]}', 14, 7, 'order_confirmation_client', '2026-05-31T04:33:59.202Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (18, '+919491201364', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSMzMxRDcxQjdEREJFNDI5RTEyAA==","message_status":"accepted"}]}', 14, NULL, 'order_confirmation_admin', '2026-05-31T04:34:00.724Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (19, '+919597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSNkM4RDlERDk5OEVDRDQzNkY1AA==","message_status":"accepted"}]}', 15, 7, 'order_confirmation_client', '2026-05-31T04:54:48.268Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (20, '+919491201364', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSQUNCREY5NENERDQ0NzhGNUMyAA==","message_status":"accepted"}]}', 15, NULL, 'order_confirmation_admin', '2026-05-31T04:54:49.987Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (21, '+919597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSOUM3N0YxMENEMUUyRjQwMTBGAA==","message_status":"accepted"}]}', 16, 7, 'order_confirmation_client', '2026-05-31T05:04:18.741Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (22, '+919491201364', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSMzM3MDJEQkQ2MzBFOUQzOUI2AA==","message_status":"accepted"}]}', 16, NULL, 'order_confirmation_admin', '2026-05-31T05:04:19.894Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (23, '+919597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSQzM4QzZGMTcxNkY0RENGQTg1AA==","message_status":"accepted"}]}', 17, 7, 'order_confirmation_client', '2026-05-31T11:58:59.026Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (24, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSMjZFOTlGN0U3QjJGREJCRjM3AA==","message_status":"accepted"}]}', 17, NULL, 'order_confirmation_admin', '2026-05-31T11:59:05.325Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (25, '+919597935647', 'Template: order_status_update', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSRTlCODZDOTYwMzZDMzIyNTQzAA==","message_status":"accepted"}]}', 17, 7, 'status_update_processing', '2026-05-31T12:00:03.696Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (26, '+919491201364', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919491201364","wa_id":"919491201364"}],"messages":[{"id":"wamid.HBgMOTE5NDkxMjAxMzY0FQIAERgSNEI5MzFGRDNFQTc2QzQ3NkE4AA==","message_status":"accepted"}]}', 18, 6, 'order_confirmation_client', '2026-07-08T10:35:06.191Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (27, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSNjQwRUU1MkYyMkMwOTNDQ0I3AA==","message_status":"accepted"}]}', 18, NULL, 'order_confirmation_admin', '2026-07-08T10:35:07.663Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (28, '9597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSN0NCOTMxNjIzRDcxQUUyNDNDAA==","message_status":"accepted"}]}', 19, NULL, 'order_confirmation_client', '2026-07-10T12:34:25.508Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (29, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSREU0RkQyNkZBQUU0MTRBRTA5AA==","message_status":"accepted"}]}', 19, NULL, 'order_confirmation_admin', '2026-07-10T12:34:27.240Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (30, '9597935647', 'Template: order_status_update', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSMUZDNTZEMDM4QjQ5NjUxMjQwAA==","message_status":"accepted"}]}', 19, NULL, 'status_update_pending', '2026-07-10T12:39:25.229Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (31, '9597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSMUE1ODY5NzVGNThDNkIzODA5AA==","message_status":"accepted"}]}', 20, NULL, 'order_confirmation_client', '2026-07-10T14:31:37.920Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (32, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSRDhEODcyMUQ4ODVFMzExRDNFAA==","message_status":"accepted"}]}', 20, NULL, 'order_confirmation_admin', '2026-07-10T14:31:39.285Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (33, '9597935647', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/<redacted-param-value>"},"fbtrace_id":"AH5QI2S7F-ZfxsyHCDR3uKP"}}', 21, NULL, 'order_confirmation_client', '2026-07-10T14:43:07.862Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (34, '+919989013142', 'Template: order_confirmation_admin ', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/admin<redacted-param-value>"},"fbtrace_id":"AfQESvRqxZRfGUb_56wcGik"}}', 21, NULL, 'order_confirmation_admin', '2026-07-10T14:43:08.589Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (35, '9597935647', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/<redacted-param-value>"},"fbtrace_id":"AqYuR7JgVn_-i8LboMXGpwL"}}', 22, NULL, 'order_confirmation_client', '2026-07-10T22:38:26.414Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (36, '+919989013142', 'Template: order_confirmation_admin ', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/admin<redacted-param-value>"},"fbtrace_id":"AB8xeoMr1jYxVnfcKRgqqjK"}}', 22, NULL, 'order_confirmation_admin', '2026-07-10T22:38:29.840Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (37, '+919597935647', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/<redacted-param-value>"},"fbtrace_id":"ALN6zXHRi9SKgU7I4pgHuqF"}}', 23, NULL, 'order_confirmation_client', '2026-07-10T23:06:11.175Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (38, '+919989013142', 'Template: order_confirmation_admin ', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/admin<redacted-param-value>"},"fbtrace_id":"AZcOVW5y_E7ObhcABS7j3eJ"}}', 23, NULL, 'order_confirmation_admin', '2026-07-10T23:06:11.920Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (39, '9597935647', 'Template: order_confirmation_client', 'failed', '{"error":{"message":"(#132018) There’s an issue with the parameters in your template","code":132018,"type":"OAuthException","error_data":{"messaging_product":"whatsapp","details":"buttons: URL parameter generates an invalid URL: https://ideazone3d.com/<redacted-param-value>"},"fbtrace_id":"Aynj5IuvpztDKmXDE2_ApB6"}}', 24, NULL, 'order_confirmation_client', '2026-07-10T23:09:58.232Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (40, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSMzM3OUFBMkM0QzhDNEEwQUE0AA==","message_status":"accepted"}]}', 24, NULL, 'order_confirmation_admin', '2026-07-10T23:10:00.147Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (41, '9597935647', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919597935647","wa_id":"919597935647"}],"messages":[{"id":"wamid.HBgMOTE5NTk3OTM1NjQ3FQIAERgSNjRDMEI3NkNDRjNGRjc1RjM5AA==","message_status":"accepted"}]}', 25, NULL, 'order_confirmation_client', '2026-07-10T23:19:06.063Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (42, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSRTA5MzVCOTk5MzlGMUM0OEQ3AA==","message_status":"accepted"}]}', 25, NULL, 'order_confirmation_admin', '2026-07-10T23:19:07.231Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (43, '8903035099', 'Template: order_confirmation_client', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+918903035099","wa_id":"918903035099"}],"messages":[{"id":"wamid.HBgMOTE4OTAzMDM1MDk5FQIAERgSRjVBQjgxMjYyMEI2RUM4QTBGAA==","message_status":"accepted"}]}', 26, NULL, 'order_confirmation_client', '2026-07-11T01:33:17.645Z');
INSERT INTO "whatsapp_logs" ("id", "recipient_number", "message_content", "status", "reason", "order_id", "user_id", "message_type", "created_at") VALUES (44, '+919989013142', 'Template: order_confirmation_admin', 'success', '{"messaging_product":"whatsapp","contacts":[{"input":"+919989013142","wa_id":"919989013142"}],"messages":[{"id":"wamid.HBgMOTE5OTg5MDEzMTQyFQIAERgSQkQzOTk2MDg4NEYyRkM5QzRCAA==","message_status":"accepted"}]}', 26, NULL, 'order_confirmation_admin', '2026-07-11T01:33:28.645Z');

SELECT setval(pg_get_serial_sequence('"whatsapp_logs"', 'id'), COALESCE((SELECT MAX("id") FROM "whatsapp_logs"), 1), true);

SET session_replication_role = 'origin';
