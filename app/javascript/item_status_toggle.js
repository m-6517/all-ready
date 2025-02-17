// ページ読み込み時とTurboのナビゲーション後に実行
function setupItemStatusToggle() {

  // アイテムの状態を切り替えるボタンを取得
  const toggleButtons = document.querySelectorAll("[data-toggle='item-status']");
  
  // ボタン、アイコン、テキストの要素を取得
  const filterButtons = document.querySelectorAll(".filter-checked-button");
  const filterIcons = document.querySelectorAll(".filter-icon");
  const filterTexts = document.querySelectorAll(".filter-text");

  // ローカルストレージから「準備済みのアイテムを非表示」の状態を取得（デフォルトはfalse）
  let hideCheckedItems = JSON.parse(localStorage.getItem("hideCheckedItems")) || false;

  // アイテムの表示/非表示を更新
  function updateItemVisibility() {
    toggleButtons.forEach((button) => {
      const listItem = button.closest("li"); // ボタンの親要素であるli要素を取得

      const isActive = button.classList.contains("btn-active"); // ボタンが「btn-active」かどうか判定

      if (hideCheckedItems && isActive) {
        listItem.classList.add("hidden"); // 非表示にするクラスを追加
      } else {
        listItem.classList.remove("hidden"); // 非表示にするクラスを削除
      }
    });
  }

  // UIの状態を更新（すべてのボタンを同時に更新）
  function updateUI() {
    const newText = hideCheckedItems ? "準備済みのアイテムを表示" : "準備済みのアイテムを非表示";
    const newIcon = hideCheckedItems ? "visibility" : "visibility_off";
    
    filterTexts.forEach(text => text.textContent = newText);
    filterIcons.forEach(icon => icon.textContent = newIcon);
  }

  // フィルターの切り替え
  function toggleFilter() {
    // 状態を反転させ、表示/非表示を切り替え
    hideCheckedItems = !hideCheckedItems;
    // 新しい状態をローカルストレージに保存
    localStorage.setItem("hideCheckedItems", JSON.stringify(hideCheckedItems));
    updateUI();
    updateItemVisibility();
  }

  // 初期状態の設定
  updateUI();
  updateItemVisibility();

  // すべてのフィルターボタンにイベントリスナーを設定
  filterButtons.forEach(button => {
    button.removeEventListener("click", toggleFilter);
    button.addEventListener("click", toggleFilter);
  });
}

// Turboのナビゲーション後にセットアップを実行
document.addEventListener("turbo:render", setupItemStatusToggle);
document.addEventListener("turbo:load", setupItemStatusToggle);
