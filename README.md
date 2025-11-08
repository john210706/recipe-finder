
# 🍽️ Recipe Finder Project

## 📘 Overview
The **Recipe Finder** is a full-stack web application that allows users to browse and search for recipes by name or category.  
It uses **PostgreSQL** for storing recipe data, **Express.js** for the backend API, and a simple **HTML/CSS/JS** frontend for user interaction.

---

## ⚙️ Technologies Used
- **Frontend:** HTML, CSS, JavaScript  
- **Backend:** Node.js, Express.js  
- **Database:** PostgreSQL  
- **Environment Variables:** dotenv  
- **Version Control:** Git & GitHub  

---

## 🗂️ Project Structure
```

recipe-finder/
│
├── server.js               # Backend server file (Express + PostgreSQL API)
├── setup.js                # Script to initialize or test the database connection
├── db/
│   ├── schema.sql          # Database structure (tables, constraints)
│   └── seed_recipes.js     # Inserts 100 sample recipes into the database
│
├── public/
│   ├── index.html          # Homepage displaying all recipes
│   ├── recipe.html         # Displays searched recipe details
│   ├── style.css           # All frontend styling
│   └── script.js           # Handles fetching and displaying data using API calls
│
├── .env                    # Environment variables (DB connection settings)
├── package.json            # Project dependencies and scripts
├── package-lock.json       # Exact dependency tree
└── README.md               # Project documentation

````

---

## 🧠 Features
✅ Displays all 100 recipes categorized beautifully on the homepage  
✅ Search bar to find recipes by name (case-insensitive)  
✅ Each recipe includes image, ingredients, and step-by-step instructions  
✅ Responsive design with interactive UI  
✅ PostgreSQL database with 25 executed SQL queries  
✅ Includes sample **function** and **trigger** for validation and learning  

---

## 🧩 PostgreSQL Function & Trigger Example

```sql
CREATE OR REPLACE FUNCTION prevent_empty_name()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.recipe_name IS NULL OR TRIM(NEW.recipe_name) = '' THEN
        RAISE EXCEPTION 'Recipe name cannot be empty!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_recipe_name
BEFORE INSERT ON recipes
FOR EACH ROW
EXECUTE FUNCTION prevent_empty_name();
````

**Explanation:**
This trigger ensures that no recipe can be inserted into the database without a valid name.
It helps maintain clean and consistent data inside the `recipes` table.

---

## 🧮 Sample SQL Queries

Here are some examples of the 25 PostgreSQL queries used in this project:

```sql
-- 1. Get all recipes
SELECT * FROM recipes;

-- 2. Count total recipes
SELECT COUNT(*) AS total_recipes FROM recipes;

-- 3. Recipes that belong to 'Dessert'
SELECT recipe_name FROM recipes WHERE category = 'Dessert';

-- 4. Recipes that include 'Egg' in their name
SELECT recipe_name FROM recipes WHERE recipe_name ILIKE '%egg%';

-- 5. Recipes per category
SELECT category, COUNT(*) FROM recipes GROUP BY category;
```

---

## 🚀 How to Run the Project

### Step 1: Clone the repository

```bash
git clone https://github.com/john210706/recipe-finder.git
cd recipe-finder
```

### Step 2: Install dependencies

```bash
npm install
```

### Step 3: Set up PostgreSQL

* Create a database named `recipe_db`
* Run the SQL schema file:

  ```bash
  psql -U postgres -d recipe_db -f db/schema.sql
  ```
* Run the seed script:

  ```bash
  node db/seed_recipes.js
  ```

### Step 4: Configure environment variables

Create a `.env` file:

```bash
PGUSER=postgres
PGHOST=localhost
PGDATABASE=recipe_db
PGPASSWORD=yourpassword
PGPORT=5432
```

### Step 5: Start the server

```bash
node server.js
```

Then open **[http://localhost:3000](http://localhost:3000)** in your browser 🚀

---

## 💡 Example API Endpoints

| Endpoint                     | Method | Description           |
| ---------------------------- | ------ | --------------------- |
| `/api/recipes`               | GET    | Fetch all recipes     |
| `/api/recipe?name=Egg Curry` | GET    | Search recipe by name |

---

## 📄 Author

👤 **John Abraham**
👤 **Sanjay Rangasamy**
👤 **Aswanth AS**

Project: *Recipe Finder using Node.js, Express & PostgreSQL*
GitHub: [https://github.com/john210706/recipe-finder](https://github.com/john210706/recipe-finder)

---

````

---



