// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

// Begin Victor's code...

const answer = document.querySelector("#answer");

const showWordButton = document.querySelector("#show_word_button");

// showWordButton.addEventListener("click", event => {
//   answer.classList.toggle("hidden_answer");
// });

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


// setTimeout(() => {
//   showWord.insertAdjacentHTML('afterend', "Hi Victor!!!")
// }, 3000 );








