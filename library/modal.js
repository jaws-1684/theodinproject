const dropdownContainer = document.querySelector(".dropdown-container");
const backDrop = document.querySelector(".back-drop")
const btn = document.querySelector(".new");
const clsBtn = document.querySelector(".cls-btn");
const dropdownMenu = document.querySelector(".dropdown-menu");
const form = document.querySelector("#newBook")
const author = document.querySelector("input[id='author']")
const title = document.querySelector("input[id='title']")
const year = document.querySelector("input[id='year']")
const status = document.querySelector("input[id='status']")
const pages = document.querySelector("input[id='pages']")
btn.addEventListener("click", (e) => {
	e.preventDefault()
	closeModal()
})

function closeModal () {
	dropdownMenu.classList.toggle("visible")
	backDrop.classList.toggle("visible")
}

clsBtn.addEventListener("click", (e) => {
	e.preventDefault()
	closeModal()
})


form.addEventListener("submit", (event) => {
	myLibrary.add(author.value, title.value, year.value, pages.value, status.value)
	let book = myLibrary.books[myLibrary.books.length - 1]
	let row = buildRow(book)
	table.appendChild(row)
	form.reset()
	closeModal()
})