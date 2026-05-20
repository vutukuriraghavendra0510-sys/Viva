-- Create tables
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  email VARCHAR(255) NOT NULL UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  title VARCHAR(200) NOT NULL,
  body TEXT NOT NULL,
  published BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Sample data
INSERT INTO users (username, email) VALUES
  ('alice', 'alice@example.com'),
  ('bob', 'bob@example.com');

INSERT INTO posts (user_id, title, body, published) VALUES
  (1, 'Hello World', 'This is the first post.', TRUE),
  (1, 'Draft Post', 'Work in progress', FALSE),
  (2, 'Bob''s Post', 'Bob says hi', TRUE);

-- Common queries
-- 1) List published posts with author
SELECT p.id, p.title, u.username AS author, p.created_at
FROM posts p
JOIN users u ON u.id = p.user_id
WHERE p.published = TRUE
ORDER BY p.created_at DESC;

-- 2) Count posts per user
SELECT u.username, COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p ON p.user_id = u.id
GROUP BY u.username
ORDER BY post_count DESC;

-- 3) Transaction example (update + audit)
BEGIN;
UPDATE posts SET published = TRUE WHERE id = 2;
-- (optional) insert into audit table here
COMMIT;

-- 4) Simple view for active content
CREATE VIEW published_posts AS
SELECT p.id, p.title, u.username AS author, p.created_at
FROM posts p
JOIN users u ON u.id = p.user_id
WHERE p.published = TRUE;