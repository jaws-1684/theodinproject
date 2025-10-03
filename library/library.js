const htmlLibrary = document.querySelector('.library-container');
const table = document.querySelector("table")

function Library() {
  if (!new.target) {
      throw Error("Must use new keyword when using Library()")
  }
  this.books = [];
  this.add = function (author, title, year, pages, status) {
              let book = new Book(author, title, year, pages, status)
              this.books.push(book);
            };
  this.showAll = function () {
              let count = 1;
              let res = [];
              this.books.forEach( book => {
                  res.push(`${count}[${book.id}]. ${book.info()}`)
                  count++
                })
              return res
              };
  this.find = function (bookID) {
                for (let i = 0; i < this.books.length; i++) {
                 if (this.books[i].id === bookID) {
                  return i
                  break
                 } else {
                   "not found"
                 };
                }
              };
  this.remove = function (bookPosition) {
    this.books.splice(bookPosition, 1);
  };                        
};
function Book(author, title, year, pages, status="not read", id=crypto.randomUUID()) {
   if (!new.target) {
        throw Error("Must use new keyword when using Book()")
    }
  this.id = id;
  this.author = author;
  this.title = title;
  this.year = year;
  this.pages = pages;
  this.status = status;
  this.info = function () {
    return `${this.title}, by ${this.author}, ${this.year}, ${this.pages} pages. Status: ${this.status}.`
  }
};

Object.defineProperty(Book.prototype, "setStatus", {
    set : function (status) {
        this.status = status;
    }
});
Object.setPrototypeOf(Library.prototype, Book.prototype)

const myLibrary = new Library;

function addDummyBooks () {
  const books = [
      {"author": "J.R.R. Tolkien", "title": "The Hobbit", "year": 2000, "pages": 700, "status": "not read"},
      {"author": "George Orwell", "title": "1984", "year": 1999, "pages": 328, "status": "read"},
      {"author": "J.K. Rowling", "title": "Harry Potter and the Sorcerer's Stone", "year": 2001, "pages": 309, "status": "read"},
      {"author": "Jane Austen", "title": "Pride and Prejudice", "year": 2005, "pages": 279, "status": "not read"},
      {"author": "F. Scott Fitzgerald", "title": "The Great Gatsby", "year": 2003, "pages": 180, "status": "read"},
      {"author": "Mary Shelley", "title": "Frankenstein", "year": 1998, "pages": 280, "status": "not read"},
      {"author": "Harper Lee", "title": "To Kill a Mockingbird", "year": 2006, "pages": 281, "status": "read"},
      {"author": "H.G. Wells", "title": "The War of the Worlds", "year": 2000, "pages": 240, "status": "not read"},
      {"author": "Mark Twain", "title": "Adventures of Huckleberry Finn", "year": 1995, "pages": 366, "status": "read"},
      {"author": "Ray Bradbury", "title": "Fahrenheit 451", "year": 2004, "pages": 194, "status": "not read"}
  ]
  for (book of books) {
    myLibrary.add(book.author, book.title, book.year, book.pages, book.status)
  };
};

// add dummy books
addDummyBooks ()

function buildRow(book) {
  const tbody = document.createElement("tbody")
  tbody.appendChild(buildHtmlBook(book));
  return tbody
};
function buildHtmlBook(book) {
  const tr = document.createElement("tr")
    tr.setAttribute("data-value", book.id)
    tr.setAttribute("class", "book")
  const tdToggle = document.createElement("td")
  const tdRemove = document.createElement("td")    
  const tags = ["author", "title", "year", "pages", "status"];
    tags.forEach(tag => {   
      const elem = document.createElement("td");
      elem.textContent = book[tag];
      tr.appendChild(elem);
    });
  const toggleButton = document.createElement("button");
  const removeButton = document.createElement("button");
  
  toggleButton.setAttribute("class", "status")
  removeButton.setAttribute("class", "remove")

  toggleButton.textContent = "change status";
  tdToggle.appendChild(toggleButton)
  removeButton.textContent = "delete";
  tdRemove.appendChild(removeButton)
  tr.appendChild(tdToggle)
  tr.appendChild(tdRemove)
  return tr;
}


myLibrary.books.forEach(book => {
  table.appendChild(buildRow(book))
});

function tooggleStatus(btn) {     
    const id = btn.parentElement.parentElement.getAttribute("data-value");
    console.log(id)
    const pos = myLibrary.find(id);
    const book = myLibrary.books[pos]
    book.setStatus = book.status === "read" ? "not read" : "read"
    btn.parentElement.previousElementSibling.textContent = book.status
}

function removeFromDOM(btn) {
  const container = btn.parentElement.parentElement
  const id = btn.parentElement.getAttribute("data-value");
  const bookPosition = myLibrary.find(id);
  myLibrary.remove(bookPosition)
  container.remove()

}

// btns.forEach(btn => tooggleStatus(btn))
htmlLibrary.addEventListener("click", (e) => {
  let target = event.target
  let className = target.classList[0]
    switch(className) {
        case 'status':
            tooggleStatus(target)
            break;
        case 'remove':
            removeFromDOM(target)
            break;  
    }
})

