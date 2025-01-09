import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  connect() {
    // ローカルストレージから現在のテーマを取得（デフォルトは "mytheme"）
    const theme = localStorage.getItem("theme") || "mytheme";

    // HTMLのルート要素に現在のテーマを設定
    document.documentElement.setAttribute("data-theme", theme);

    // 現在のテーマが "dark" の場合、ルート要素に "dark" クラスを追加
    if (theme === "dark") {
      document.documentElement.classList.add("dark");
      this.toggleTarget.checked = true;
    } else {
      document.documentElement.classList.remove("dark");
    }
  }

  toggle() {
    // 現在のテーマを取得
    const currentTheme = document.documentElement.getAttribute("data-theme");

    // 新しいテーマを決定
    const newTheme = currentTheme === "mytheme" ? "dark" : "mytheme";

    // 新しいテーマをHTMLのルート要素に設定
    document.documentElement.setAttribute("data-theme", newTheme);

    // HTMLのルート要素のクラスを更新
    if (newTheme === "dark") {
      document.documentElement.classList.add("dark");
    } else {
      document.documentElement.classList.remove("dark");
    }

    // 新しいテーマをローカルストレージに保存
    localStorage.setItem("theme", newTheme);
  }
}
