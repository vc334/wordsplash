document.querySelectorAll(".buzz").forEach((photo) => {
  photo.addEventListener("click", (event) => {
    console.log(event)
    event.currentTarget.classList.toggle("photo-highlight");
  });
});

const photosSubmit = document.querySelector("#photos-submit");
const photosForm = document.querySelector("#photos-form");


photosSubmit.addEventListener("click", () => {
  const selectedPhotos = document.querySelectorAll(".photo-highlight")
  const photosArray = []
  selectedPhotos.forEach((photo) => {
    photosArray.push(photo.getAttribute("src"))
  });

  photosForm.insertAdjacentHTML('beforeend', `<input type="hidden" name="photo_urls" value=${photosArray} >`)
});
