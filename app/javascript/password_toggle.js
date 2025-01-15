window.togglePasswordVisibility = function(fieldId, checkboxId) {
  const passwordField = document.getElementById(fieldId);
  const checkbox = document.getElementById(checkboxId);
  if (checkbox.checked) {
    passwordField.type = "text";
  } else {
    passwordField.type = "password";
  }
};