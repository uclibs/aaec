function addAuthor(type, count) {
  const newAuthorId = `added_${count}`;
  const newAuthor = createAuthorElement(type, newAuthorId);
  document.getElementById("author_group").appendChild(newAuthor);
  updateAddAuthorButton(type, count + 1);
}

function createAuthorElement(type, id) {
  const newAuthor = createElementWithAttributes("div", { class: "form-row", id });
  const firstNameInput = createInput(type, "author_first_name");
  const lastNameInput = createInput(type, "author_last_name");
  const deleteButton = createDeleteButton(id);

  newAuthor.appendChild(firstNameInput);
  newAuthor.appendChild(lastNameInput);
  newAuthor.appendChild(deleteButton);
  return newAuthor;
}

function createInput(type, name) {
  const wrapper = createElementWithAttributes("div", { class: "col-md-5" });
  const input = createElementWithAttributes("input", {
      type: "text",
      name: `${type}[${name}][]`,
      id: `${type}_${name}_`,
      required: "required",
      class: "form-control form-group"
  });
  wrapper.appendChild(input);
  return wrapper;
}

function createDeleteButton(id) {
  const wrapper = createElementWithAttributes("div", { class: "col-md-2" });
  const button = createElementWithAttributes("button", {
      name: "button",
      type: "button",
      class: "form-control form-group bg-danger text-white"
  });
  button.textContent = "Remove Author";
  button.addEventListener("click", () => removeAuthor(id));
  wrapper.appendChild(button);
  return wrapper;
}

function createElementWithAttributes(tag, attributes) {
  const element = document.createElement(tag);
  Object.entries(attributes).forEach(([key, value]) => element.setAttribute(key, value));
  return element;
}

function updateAddAuthorButton(type, count) {
  const addButton = document.getElementById("add_author_btn");
  addButton.setAttribute("onClick", `addAuthor('${type}', ${count})`);
}

function removeAuthor(idToDelete)     {
  document.getElementById(idToDelete).outerHTML = '';
}
