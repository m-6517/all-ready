document.addEventListener("DOMContentLoaded", () => {
  const setupImagePreview = (inputId, previewId) => {
    const fileInput = document.getElementById(inputId);
    const preview = document.getElementById(previewId);

    if (fileInput && preview) {
      fileInput.addEventListener("change", (event) => {
        const file = event.target.files[0];
      
        if (file) {
          if (preview.src && preview.src.startsWith("blob:")) {
            URL.revokeObjectURL(preview.src); // 以前のオブジェクトURLを解放しメモリリークを防ぐ
          }
          preview.src = URL.createObjectURL(file);
          preview.style.display = "block";
        } else {
          preview.src = "#";
          preview.style.display = "none";
        }
      });
    }
  };

  setupImagePreview("recommend_item_image", "recommend_image_preview");
  setupImagePreview("user_avatar", "avatar_preview");
});
