window.addEventListener("DOMContentLoaded", () => {
  const searchBtn = document.getElementById("searchBtn");
  const searchInput = document.getElementById("searchInput");
  const resultDiv = document.getElementById("result");

  function getFoodImage(recipeName, fallbackUrl) {
    return fallbackUrl || `https://source.unsplash.com/600x400/?${encodeURIComponent(recipeName)},food`;
  }

  searchBtn.addEventListener("click", async () => {
    const name = searchInput.value.trim();
    if (!name) {
      resultDiv.innerHTML = `<p class="error">⚠️ Please enter a recipe name!</p>`;
      return;
    }

    resultDiv.innerHTML = `<p class="loading">🔍 Searching for "${name}"...</p>`;

    try {
      const response = await fetch(`/api/recipe?name=${encodeURIComponent(name)}`);
      const data = await response.json();

      if (data.error) {
        resultDiv.innerHTML = `<p class="error">❌ ${data.error}</p>`;
        return;
      }

      const imageURL = getFoodImage(data.recipe_name, data.image_url);

      resultDiv.innerHTML = `
        <div class="recipe-card">
          <img src="${imageURL}" alt="${data.recipe_name}">
          <div class="recipe-content">
            <h2>${data.recipe_name}</h2>
            <p><strong>Category:</strong> ${data.category}</p>
            <h3>🥕 Ingredients</h3>
            <ul>${data.ingredients.map(i => `<li>${i}</li>`).join("")}</ul>
            <h3>👩‍🍳 Instructions</h3>
            <ol>${data.instructions.map(s => `<li>${s}</li>`).join("")}</ol>
          </div>
        </div>
      `;
    } catch (err) {
      console.error("⚠️ Fetch error:", err);
      resultDiv.innerHTML = `<p class="error">⚠️ Error fetching recipe data.</p>`;
    }
  });
});
