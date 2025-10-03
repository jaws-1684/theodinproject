export const DOM = (function () {
  const load = (tag) => {
  	const node = document.querySelector(tag);
  	return node
  };
  const create = (tag) => {
  	const node = document.createElement(tag);
  	return node
  };
  const clear = (tag) => {
  	load(tag).textContent = ""
  };
  const insert = (tag, content) => {
  	load(tag).textContent = content
  };
  const append = (tag, node) => {
  	load(tag).append(node)
  };
  const populate = (tag="#content", obj) => {
  	clear(tag)
    for (const [key, value] of Object.entries(obj)) {
      const node = create("div");
      node.setAttribute("class", key);

      for (let i of value) {
        const p = create("p")
        p.textContent = i;
        node.append(p)
      };
     
      append(tag, node);     
    }
	
  };
  return { clear, append, insert, populate, create, load };
})();