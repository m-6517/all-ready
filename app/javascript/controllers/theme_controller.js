import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  connect() {
    // ローカルストレージから現在のテーマを取得（デフォルトは "mytheme"）
    const theme = localStorage.getItem("theme") || "mytheme";

    // HTMLのルート要素に現在のテーマを設定
    document.documentElement.setAttribute("data-theme", theme);

    // 現在のテーマが "dark" の場合、トグルスイッチをオンに設定
    if (theme === "dark") {
      this.toggleTarget.checked = true;
    }
  }

  toggle() {
    // 現在のテーマを取得
    const currentTheme = document.documentElement.getAttribute("data-theme");

    // 現在のテーマが "mytheme" なら "dark" に、"dark"なら "mytheme" に切り替え
    const newTheme = currentTheme === "mytheme" ? "dark" : "mytheme";

    // 新しいテーマをHTMLのルート要素に設定
    document.documentElement.setAttribute("data-theme", newTheme);

    // 新しいテーマをローカルストレージに保存
    localStorage.setItem("theme", newTheme);
  }
}
