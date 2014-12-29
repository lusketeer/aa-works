CREATE TABLE users (
  id    INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id    INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body  TEXT  NOT NULL,
  author_id INTEGER NOT NULL,
  FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_followers (
  question_id INTEGER NOT NULL,
  follower_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (follower_id) REFERENCES users(id),
  CONSTRAINT question_and_follow_index UNIQUE (question_id, follower_id)
);

CREATE TABLE replies (
  id    INTEGER PRIMARY KEY,
  body  TEXT NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply_id INTEGER,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes(
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT question_and_like_index UNIQUE (question_id, user_id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Luke', 'Lu'),
  ('Amit', 'Amin'),
  ('Eddard', 'Stark'),
  ('Sansa', 'Stark'),
  ('Daenerys', 'Targaryen'),
  ('Jon', 'Snow');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('How to kill my brother without getting caught?', 'What title says.', (SELECT id FROM users WHERE fname = 'Daenerys' AND lname = 'Targaryen')),
  ('How to kill the ice trolls.', 'They are devestating my country. Help me!.', (SELECT id FROM users WHERE fname = 'Jon' AND lname = 'Snow')),
  ('How to be a badass.', 'Im weak. I want muscles like you crazy fantasy characters.', (SELECT id FROM users WHERE fname = 'Amit' AND lname = 'Amin')),
  ('How to conquer Westros', 'What title says.', (SELECT id FROM users WHERE fname = 'Daenerys' AND lname = 'Targaryen'));

INSERT INTO
  question_followers (question_id, follower_id)
VALUES
  (1, 2),
  (1, 3),
  (1, 1),
  (2, 2),
  (3, 5);

INSERT INTO
  replies (body, question_id, parent_reply_id, user_id)
VALUES
  ('Get some dragons boy.', 3, null, 5);

INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1, 1),
  (1, 4),
  (1, 5),
  (2, 2),
  (4, 1),
  (4, 2),
  (4, 3),
  (4, 4),
  (3, 5);
