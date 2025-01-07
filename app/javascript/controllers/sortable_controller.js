import { Controller } from "@hotwired/stimulus";
import Sortable from "sortablejs";

// Stimulus Controllerクラスを定義
export default class extends Controller {
  // listターゲットを設定
  static targets = ["list"]

  // コントローラが接続された際に呼ばれる
  connect() {
    // Sortableインスタンスを作成し、リストを並べ替え可能にする
    this.sortable = new Sortable(this.listTarget, {
      // 並べ替えが終了した時にonSortEndを呼び出す
      onEnd: (evt) => this.onSortEnd(evt)
    });
  }

  // 並べ替えが終了した際に呼ばれる
  onSortEnd(evt) {
    // 並べ替え後のリストの子要素を取得し、各要素のdata-item-id属性を配列に格納
    const itemIds = Array.from(this.listTarget.children)
      .map(item => item.getAttribute('data-item-id'));
  
    // サーバーに並べ替えた順番の情報を送信
    fetch(`${this.data.get("url")}/update_position`, {
      method: 'PATCH', // PATCHメソッドでデータを更新
      headers: {
        'Content-Type': 'application/json', // リクエストヘッダとしてJSONを指定
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute("content") // CSRFトークンを送信
      },
      body: JSON.stringify({ item_ids: itemIds }) // リスト順番の情報をJSON形式で送信
    })
  }
}
