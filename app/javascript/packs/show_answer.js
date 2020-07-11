// Begin Victor's code...

const answer = document.querySelector("#answer");
const showWordButton = document.querySelector("#show_word_button");

showWordButton.addEventListener("click", event => {
  answer.classList.toggle("hidden_answer");
});




// setTimeout(() => {
//   showWord.insertAdjacentHTML('afterend', "Hi Victor!!!")
// }, 3000 );
