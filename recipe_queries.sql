    -- 1. Get all recipes:
    SELECT * FROM recipes;

    -- 2. Get only recipe names and categories:
    SELECT recipe_name, category FROM recipes;

    -- 3. List all unique categories:
    SELECT DISTINCT category FROM recipes;

    --4. Count total recipes:
    SELECT COUNT(*) AS total_recipes FROM recipes;

    -- 5. Count how many recipes per category:
    SELECT category, COUNT(*) AS total FROM recipes GROUP BY category;

    -- 6. Find recipes that belong to “Dessert”:
    SELECT recipe_name FROM recipes WHERE category = 'Dessert';

    -- 7. Find recipes containing “Egg” in the name:
    SELECT recipe_name FROM recipes WHERE recipe_name ILIKE '%egg%';

    -- 8. Find recipes whose ingredients include “milk”:
    SELECT recipe_name FROM recipes WHERE ingredients ILIKE '%milk%';

    -- 9. Recipes that are not beverages:
    SELECT recipe_name FROM recipes WHERE category != 'Beverage';

    -- 10. Recipes with instructions longer than 200 characters:
    SELECT recipe_name FROM recipes WHERE LENGTH(instructions) > 200;

    -- 11. List all recipes alphabetically:
    SELECT recipe_name FROM recipes ORDER BY recipe_name ASC;

    -- 12. List all categories alphabetically (descending):
    SELECT DISTINCT category FROM recipes ORDER BY category DESC;

    --13. Show top 10 recipes alphabetically:
    SELECT recipe_name FROM recipes ORDER BY recipe_name LIMIT 10;

    -- 14. Average length of recipe names:
    SELECT AVG(LENGTH(recipe_name)) AS avg_name_length FROM recipes;

    -- 15. Find the longest recipe name:
    SELECT recipe_name, LENGTH(recipe_name) AS name_length
    FROM recipes
    ORDER BY name_length DESC
    LIMIT 1;


    -- 16. Count how many recipes have images:
    SELECT COUNT(*) FROM recipes WHERE image_url IS NOT NULL AND image_url != '';

    -- 17. Recipes per category (sorted highest first):
    SELECT category, COUNT(*) AS count
    FROM recipes
    GROUP BY category
    ORDER BY count DESC;


    -- 18. Recipes whose name starts with “C”:
    SELECT recipe_name FROM recipes WHERE recipe_name ILIKE 'C%';

    -- 19. Recipes whose name ends with “Cake”:
    SELECT recipe_name FROM recipes WHERE recipe_name ILIKE '%cake';

    -- 20. Recipes having both “chocolate” and “milk” in ingredients:
    SELECT recipe_name FROM recipes
    WHERE ingredients ILIKE '%chocolate%' AND ingredients ILIKE '%milk%';

    -- 21. Get all recipes with their category name:
    SELECT r.recipe_name, c.category_name
    FROM recipes r
    LEFT JOIN categories c ON r.category_id = c.category_id;


    -- 22. Count how many recipes each category_id has:
    SELECT category_id, COUNT(*) AS total
    FROM recipes
    GROUP BY category_id;

    -- 23. Find categories that have more than 5 recipes:
    SELECT category, COUNT(*) AS total
    FROM recipes
    GROUP BY category
    HAVING COUNT(*) > 5;


    -- 24. Check if any duplicate recipe names exist:
    SELECT recipe_name, COUNT(*)
    FROM recipes
    GROUP BY recipe_name
    HAVING COUNT(*) > 1;

-- 25. Function to count total recipes 

   CREATE OR REPLACE FUNCTION total_recipe_count()
RETURNS INTEGER AS $$
DECLARE
    total INTEGER;
BEGIN
    SELECT COUNT(*) INTO total FROM recipes;
    RETURN total;
END;
$$ LANGUAGE plpgsql;

-- Call the function:
SELECT total_recipe_count();


--26. Trigger for preventing empty recipe names
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


INSERT INTO recipes (recipe_name, category, ingredients, instructions, image_url)
VALUES (
  'Garlic Butter Shrimp',
  'Seafood',
  'Shrimp, butter, garlic, parsley, lemon juice',
  'Melt butter in a pan, add garlic, cook shrimp until pink, add lemon juice and parsley.',
  'https://example.com/shrimp.jpg'
);





    -- cd C:\Users\victo\recipe-finder
    -- psql -U postgres
    -- \c recipe_db

