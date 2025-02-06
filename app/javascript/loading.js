document.addEventListener('turbo:load', handleSpinner);
document.addEventListener('turbo:render', handleSpinner);

function handleSpinner() {
  const spinner = document.getElementById("loading");
  if (spinner) {
    spinner.classList.add("loaded");
  }
}
