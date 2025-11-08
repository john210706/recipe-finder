import pkg from "pg";
import dotenv from "dotenv";
import path from "path";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

dotenv.config({ path: path.resolve(__dirname, "../.env") });

const { Pool } = pkg;
const pool = new Pool({
  user: process.env.PGUSER,
  host: process.env.PGHOST,
  database: process.env.PGDATABASE,
  password: process.env.PGPASSWORD,
  port: process.env.PGPORT,
});

async function setupDB() {
  try {
    console.log("🧱 Creating tables...");

    await pool.query(`
      CREATE TABLE IF NOT EXISTS categories (
        category_id SERIAL PRIMARY KEY,
        category_name VARCHAR(50) UNIQUE NOT NULL
      );

      CREATE TABLE IF NOT EXISTS ingredients (
        ingredient_id SERIAL PRIMARY KEY,
        ingredient_name VARCHAR(100) UNIQUE NOT NULL
      );

      CREATE TABLE IF NOT EXISTS recipes (
        recipe_id SERIAL PRIMARY KEY,
        recipe_name VARCHAR(100) UNIQUE NOT NULL,
        description TEXT,
        category_id INT REFERENCES categories(category_id),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );

      CREATE TABLE IF NOT EXISTS recipe_ingredients (
        recipe_id INT REFERENCES recipes(recipe_id),
        ingredient_id INT REFERENCES ingredients(ingredient_id),
        quantity VARCHAR(50),
        PRIMARY KEY (recipe_id, ingredient_id)
      );

      CREATE TABLE IF NOT EXISTS steps (
        step_id SERIAL PRIMARY KEY,
        recipe_id INT REFERENCES recipes(recipe_id),
        step_number INT,
        instruction TEXT,
        UNIQUE (recipe_id, step_number)
      );
    `);

    console.log("✅ Tables created successfully.");

  } catch (err) {
    console.error("❌ Error creating tables:", err);
  } finally {
    await pool.end();
  }
}

setupDB();
