// Turboのページ読み込み完了時に実行
document.addEventListener("turbo:load", () => {
  // アイテムの状態を切り替えるボタンを取得
  const toggleButtons = document.querySelectorAll("[data-toggle='item-status']");
  
  // ボタン、アイコン、テキストの要素を取得
  const filterButton = document.getElementById("filterChecked");
  const filterIcon = document.getElementById("filterIcon");
  const filterText = document.getElementById("filterText");

  // ローカルストレージから「準備済みのアイテムを非表示」の状態を取得（デフォルトはfalse）
  let hideCheckedItems = JSON.parse(localStorage.getItem("hideCheckedItems")) || false;

  // アイテムの表示/非表示を更新
  function updateItemVisibility() {
    toggleButtons.forEach((button) => {
      // 各ボタンがチェックされているかどうかを判定
      const isChecked = button.dataset.checked === "true"; // ボタンに設定されたチェック状態を取得
      const listItem = button.closest("li"); // ボタンの親要素であるli要素を取得

      if (listItem) {
        // hideCheckedItemsがtrueで、アイテムがチェック済みならば非表示にする
        if (hideCheckedItems && isChecked) {
          listItem.classList.add("hidden"); // 非表示にするクラスを追加
        } else {
          listItem.classList.remove("hidden"); // 非表示にするクラスを削除
        }
      }
    });
  }

  // ページが最初に読み込まれた時に初期化
  function initialize() {
    // 初期状態でアイテムの表示/非表示を更新
    updateItemVisibility();

    // ボタンのテキストとアイコンを更新
    if (filterButton) {
      filterText.textContent = hideCheckedItems
        ? "準備済みのアイテムを表示"
        : "準備済みのアイテムを非表示";
      filterIcon.textContent = hideCheckedItems ? "visibility" : "visibility_off";
    }
  }

  // ボタンがクリックされた時
  function toggleFilter() {
    // 状態を反転させ、表示/非表示を切り替え
    hideCheckedItems = !hideCheckedItems;
    
    // 新しい状態をローカルストレージに保存
    localStorage.setItem("hideCheckedItems", JSON.stringify(hideCheckedItems));

    // アイコンとテキストを更新
    filterIcon.textContent = hideCheckedItems ? "visibility" : "visibility_off";
    filterText.textContent = hideCheckedItems ? "準備済みのアイテムを表示" : "準備済みのアイテムを非表示";

    // アイテムの表示/非表示を再更新
    updateItemVisibility();
  }

  // ページが読み込まれた時に初期化処理を実行
  initialize();
});
