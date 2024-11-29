// 持ち物リスト一覧のメニュー
export function openMenuModal(id) {
  document.getElementById(`menuModal_${id}`).showModal();
}
// リスト名変更
export function openRenameModal(id) {
  document.getElementById(`menuModal_${id}`).close();
  document.getElementById(`renameModal_${id}`).showModal();
}
// カバー画像をアップロード
export function openCoverImageModal(id) {
  document.getElementById(`menuModal_${id}`).close();
  document.getElementById(`coverImageModal_${id}`).showModal();
}
// リスト共有
export function openShareModal(id) {
  document.getElementById(`menuModal_${id}`).close();
  document.getElementById(`shareModal_${id}`).showModal();
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
// アイテム数を変更
export function openItemQuantityModal(id) {
  document.getElementById(`itemQuantityModal_${id}`).showModal();
}

// かばんの中身削除
export function openBagContentDeleteModal(uuid) {
  document.getElementById(`bagContentDeleteModal_${uuid}`).showModal();
}

window.openMenuModal = openMenuModal;
window.openRenameModal = openRenameModal;
window.openCoverImageModal = openCoverImageModal;
window.openShareModal = openShareModal;
window.openDeleteModal = openDeleteModal;
window.openItemModal = openItemModal;
window.openItemQuantityModal = openItemQuantityModal;
window.openBagContentDeleteModal = openBagContentDeleteModal;
