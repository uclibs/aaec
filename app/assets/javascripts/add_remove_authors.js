function addAuthor(type, authorCount) {
  authorCount = authorCount || document.getElementById("author_group").childElementCount;
  const newAuthorId = `author_${authorCount}`;
  const newAuthor = createAuthorElement(type, newAuthorId);
  document.getElementById("author_group").appendChild(newAuthor);
  updateAddAuthorButton(type, authorCount);
}

// find the addAuthor button on the screen and change it to send both the type and the authorCount
function updateAddAuthorButton(type, authorCount) {
  const addAuthorButton = document.getElementById("add_author_btn");
  addAuthorButton.outerHTML = createAddAuthorButton(type, authorCount);
}

// create a new addAuthor button with the type and authorCount
function createAddAuthorButton(type, authorCount) {
  const button = createElementWithAttributes("button", {
      name: "button",
      type: "button",
      class:  "btn btn-primary",
      id: "add_author_btn",
      onclick: `addAuthor("${type}", ${authorCount + 1})`
  });
  button.textContent = "Add Author";
  return button.outerHTML;
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

function removeAuthor(idToDelete)     {
  document.getElementById(idToDelete).outerHTML = '';
}
