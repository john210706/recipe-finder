  // server.js
  import express from "express";
  import pkg from "pg";
  import dotenv from "dotenv";
  import path from "path";
  import { fileURLToPath } from "url";

  dotenv.config();
  const { Pool } = pkg;

  // ✅ PostgreSQL connection
  const pool = new Pool({
    user: process.env.PGUSER,
    host: process.env.PGHOST,
    database: process.env.PGDATABASE,
    password: process.env.PGPASSWORD,
    port: process.env.PGPORT,
  });

  const app = express();

  // ✅ Serve frontend (public folder)
  const __filename = fileURLToPath(import.meta.url);
  const __dirname = path.dirname(__filename);
  app.use(express.static(path.join(__dirname, "public")));

  // ✅ API: Search for a recipe (case-insensitive + partial match)
  app.get("/api/recipe", async (req, res) => {
    const name = req.query.name;
    if (!name) {
      return res.status(400).json({ error: "Please provide ?name=RECIPE_NAME" });
    }

    try {
      const result = await pool.query(
        `SELECT recipe_name, category, ingredients, instructions, image_url
        FROM recipes
        WHERE recipe_name ILIKE $1`,
        [`%${name}%`]
      );

      if (result.rows.length === 0) {
        return res.json({ error: `Recipe not found for "${name}"` });
      }

      const recipe = result.rows[0];
      res.json({
        recipe_name: recipe.recipe_name,
        category: recipe.category,
        ingredients: recipe.ingredients.split(",").map(i => i.trim()),
        instructions: recipe.instructions.split(".").map(s => s.trim()).filter(Boolean),
        image_url: recipe.image_url,
      });

    } catch (err) {
      console.error("❌ DB error:", err);
      res.status(500).json({ error: "Server error" });
    }
  });

  // ✅ Start server
  const port = process.env.PORT || 3000;
  app.listen(port, () => {
    console.log(`✅ Server running on http://localhost:${port}`);
  });
