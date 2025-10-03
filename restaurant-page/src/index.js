// src/index.js
import "./styles.css";
import { Home } from "./home.js";
import { Menu } from "./menu.js";
import { Contact } from "./contact.js";
import { DOM } from "./dom.js"

// import someimage from "./someimage.extension";
   
// const image = document.createElement("img");
// image.src = odinImage;
   
// document.body.appendChild(image);
DOM.populate("#content", Home.data)

DOM.load("nav").addEventListener("click", (e) => {
  let target = event.target
  let id = target.id
    switch(id) {
        case 'home':
            DOM.populate("#content", Home.data)
            break;
        case 'menu':
            DOM.populate("#content", Menu.data)
            break;
        default:
        	DOM.populate("#content", Contact.data)
    }
})
