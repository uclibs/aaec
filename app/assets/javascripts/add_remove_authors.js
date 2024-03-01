
// Add an event listener to the author group element that will allow the "Remove Author" button to work
// even if the author group element is dynamically added to the page.
document.addEventListener("turbolinks:load", function() {
    const authorGroupElement = document.getElementById('author_group');

    if (authorGroupElement) {
        authorGroupElement.addEventListener('click', function(event) {
            if (event.target &&
                event.target.matches("button[type='button']") &&
                ['Remove Author', 'Remove Artist'].includes(event.target.textContent)
                ) {
                // Navigate up two levels to get the grandparent element, which is the author element.
                const authorElement = event.target.parentNode.parentNode;
                const authorElements = Array.from(authorGroupElement.children);
                const authorIndex = authorElements.indexOf(authorElement);

                if (authorIndex !== -1) {
                    removeAuthor(authorIndex);
                    updateAuthorIds()
                }
            }
        });
    }
});

// We have both authors and artists.  This function looks at the text in the
// "Add Author" button to determine if we are dealing with artist or an author.
// The "Add Author" button has its text determined by publications_helper's
// "author_or_artist_label" method.
function getRoleFromButton() {
    const button = document.getElementById('add_author_btn');
    if (!button) return null; // Return null if the button doesn't exist

    return button.textContent.includes('Artist') ? 'Artist' : 'Author';
}

function removeAuthor(authorIndex) {
    const authorGroupElement = document.getElementById('author_group');
    if (authorGroupElement && authorGroupElement.children[authorIndex]) {
        authorGroupElement.children[authorIndex].remove();
        updateAuthorIds();
    }
}


function addAuthor(type) {
    const authorGroup = document.getElementById("author_group");
    if (!authorGroup) return;

    const newAuthor = createAuthorElement(type);
    authorGroup.appendChild(newAuthor);
    updateAuthorIds();
}

function createAuthorElement(type) {
    const newDataIndex = document.querySelectorAll(`[data-type='${type}']`).length;
    const newAuthor = createElementWithAttributes("div", { class: "form-row", 'data-type': type, 'data-index': newDataIndex });
    newAuthor.appendChild(createInput(type, "author_first_name"));
    newAuthor.appendChild(createInput(type, "author_last_name"));
    newAuthor.appendChild(createDeleteButton());
    return newAuthor;
}

function createElementWithAttributes(tag, attributes) {
    const element = document.createElement(tag);
    Object.entries(attributes).forEach(([key, value]) => element.setAttribute(key, value));
    return element;
}

function createInput(type, name) {
    // The "for" attribute of the label will be updated with the updateAuthorIds function.

    const role = getRoleFromButton();
    if (!role) return;

    const wrapper = createElementWithAttributes("div", {
        class: "col-md-5",
        "data-type": type
    });

    const label = createElementWithAttributes("label", {
        class: "required",
        "data-type": type
    });

    label.textContent = name.includes('first_name') ? role + ' First Name' : role + ' Last Name';

    const input = createElementWithAttributes("input", {
        type: "text",
        name: `${type}[${name}][]`,
        required: "required",
        class: "form-control form-group",
        autocomplete: "off",
        "data-type": type
    });

    wrapper.appendChild(label);
    wrapper.appendChild(input);

    return wrapper;
}

function createDeleteButton() {
    const role = getRoleFromButton();
    if (!role) return;

    const wrapper = createElementWithAttributes("div", { class: "col-md-2" });
    const button = createElementWithAttributes("button", {
        type: "button",
        class: "form-control form-group bg-danger text-white"
    });
    button.textContent = "Remove " + role;
    wrapper.appendChild(button);
    return wrapper;
}

function updateAuthorIds() {
    const authorGroups = document.querySelectorAll('#author_group .form-row');
    authorGroups.forEach((group, index) => {
        group.id = `author_${index}`;
        updateFieldAndLabel(group, 'first_name', index);
        updateFieldAndLabel(group, 'last_name', index);
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