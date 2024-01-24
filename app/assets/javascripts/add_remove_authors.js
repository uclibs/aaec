function addAuthor(type) {
    const authorGroup = document.getElementById("author_group");
    if (!authorGroup) return;

    const newAuthor = createAuthorElement(type);
    authorGroup.appendChild(newAuthor);
    updateAuthorIds();
}

function createAuthorElement(type) {
    const newAuthor = createElementWithAttributes("div", { class: "form-row", 'data-type': type });
    newAuthor.appendChild(createInput(type, "author_first_name"));
    newAuthor.appendChild(createInput(type, "author_last_name"));
    newAuthor.appendChild(createDeleteButton()); // No index required initially
    return newAuthor;
}

function createElementWithAttributes(tag, attributes) {
    const element = document.createElement(tag);
    Object.entries(attributes).forEach(([key, value]) => element.setAttribute(key, value));
    return element;
}

function createInput(type, name) {
    // The "for" attribute of the label will be updated with the updateAuthorIds function.

    const wrapper = createElementWithAttributes("div", {
        class: "col-md-5",
        "data-type": type
    });

    const label = createElementWithAttributes("label", {
        class: "required",
        "data-type": type
    });

    label.textContent = name.includes('first_name') ? 'Author First Name' : 'Author Last Name';

    const input = createElementWithAttributes("input", {
        type: "text",
        name: `${type}[${name}][]`,
        required: "required",
        class: "form-control form-group",
        "data-type": type
    });

    wrapper.appendChild(label);
    wrapper.appendChild(input);

    return wrapper;
}

function createDeleteButton() {
    const wrapper = createElementWithAttributes("div", { class: "col-md-2" });
    const button = createElementWithAttributes("button", {
        type: "button",
        class: "form-control form-group bg-danger text-white"
    });
    button.textContent = "Remove Author";
    button.addEventListener('click', function() {
        wrapper.parentNode.removeChild(wrapper);
        updateAuthorIds();
    });
    wrapper.appendChild(button);
    return wrapper;
}


function removeAuthor(authorIndex) {
    const authorGroup = document.querySelector(`#author_group .form-row[data-index='${authorIndex}']`);
    if (authorGroup) {
        authorGroup.parentNode.removeChild(authorGroup);
        updateAuthorIds();
    }
}

function updateAuthorIds() {
    const authorGroups = document.querySelectorAll('#author_group .form-row');
    authorGroups.forEach((group, index) => {
        group.id = `author_${index}`;
        updateFieldAndLabel(group, 'first_name', index);
        updateFieldAndLabel(group, 'last_name', index);

        const deleteButton = group.querySelector("button[type='button']");
        if (deleteButton) deleteButton.setAttribute('data-index', index);
    });
}

function updateFieldAndLabel(group, fieldName, index) {
    const type = group.getAttribute('data-type');
    if (!type) return;

    const input = group.querySelector(`[name='${type}[author_${fieldName}][]']`);
    if (!input) return;

    input.id = `author_${fieldName}_${index}`;
    const label = input.previousElementSibling;
    if (label && label.tagName === 'LABEL') {
        label.setAttribute('for', input.id);
    }
}