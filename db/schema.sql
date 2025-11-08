
DROP TABLE IF EXISTS recipes CASCADE;
DROP TABLE IF EXISTS categories CASCADE;


CREATE TABLE categories (
  category_id SERIAL PRIMARY KEY,
  category_name VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE recipes (
  recipe_id SERIAL PRIMARY KEY,
  recipe_name TEXT UNIQUE NOT NULL,
  category TEXT,
  ingredients TEXT,
  instructions TEXT,
  image_url TEXT,
  category_id INT REFERENCES categories(category_id) ON DELETE SET NULL
);




INSERT INTO categories (category_name)
VALUES
  ('Dessert'),
  ('Main Course'),
  ('Snack'),
  ('Beverage'),
  ('Salad'),
  ('Breakfast'),
  ('Lunch'),
  ('Dinner'),
  ('Appetizer'),
  ('Side Dish'),
  ('Filipino'),
  ('American'),
  ('Spanish'),
  ('Japanese'),
  ('Indian'),
  ('French'),
  ('Eastern European'),
  ('Hungarian'),
  ('Thai'),
  ('Asian'),
  ('Middle Eastern'),
  ('British'),
  ('Korean'),
  ('Russian'),
  ('Italian'),
  ('Chinese'),
  ('Peruvian'),
  ('Seafood'),
  ('Vegetarian'),
  ('Soup'),
  ('Mexican'),
  ('Greek')
ON CONFLICT DO NOTHING;