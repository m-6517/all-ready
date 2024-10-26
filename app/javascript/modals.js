// 持ち物リスト一覧のメニュー
export function openMenuModal(id) {
  document.getElementById(`menuModal_${id}`).showModal();
}
// リスト名変更
export function openRenameModal(id) {
  document.getElementById(`menuModal_${id}`).close();
  document.getElementById(`renameModal_${id}`).showModal();
}
// リスト削除
export function openDeleteModal(id) {
  document.getElementById(`menuModal_${id}`).close();
  document.getElementById(`deleteModal_${id}`).showModal();
}

// 持ち物リスト詳細のメニュー
export function openItemModal() {
  document.getElementById('itemModal').showModal();
}
// アイテム追加
export function openAddItemModal() {
  document.getElementById('itemModal').close();
  document.getElementById('addItemModal').showModal();
}
// アイテム数変更
export function openItemQuantityModal() {
  document.getElementById('itemModal').close();
  document.getElementById('itemQuantityModal').showModal();
}

window.openMenuModal = openMenuModal;
window.openRenameModal = openRenameModal;
window.openDeleteModal = openDeleteModal;
window.openItemModal = openItemModal;
window.addItemModal = addItemModal;
window.openItemQuantityModal = openItemQuantityModal;