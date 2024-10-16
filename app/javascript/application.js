// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

// ローディングアニメーションの表示
document.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form"); // 対象のフォームを選択
  const loading = document.getElementById("loading");

  form.addEventListener("submit", () => {
    loading.style.display = "flex"; // ローディングを表示
  });
});