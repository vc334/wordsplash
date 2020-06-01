// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

// Begin Victor's code...

const answer = document.querySelector("#answer");

const showWordButton = document.querySelector("#show_word_button");

showWordButton.addEventListener("click", event => {
  answer.classList.toggle("hidden_answer");
});

// setTimeout(() => {
//   showWord.insertAdjacentHTML('afterend', "Hi Victor!!!")
// }, 3000 );








