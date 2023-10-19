// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

$(document).on('turbolinks:load', function() {
    $('[data-toggle="tooltip"]').tooltip();
})

function addAuthor(type, count) {
    var count = count || 1;
    var newAuthor = document.createElement("div");
    var nameGroupDiv = document.createElement("div");
    var deleteBDiv = document.createElement("div");
    var lineDivider = document.createElement('hr');


    // Create line divider styling
    lineDivider.style.width = '100%';
    lineDivider.style.borderTop = '3px solid #999999';
    lineDivider.style.margin = '15px 0';
  
    // Create labels
    var firstNameLabel = document.createElement('label');
    firstNameLabel.innerText = 'First Name';
    firstNameLabel.className = 'form-label mt-3 mb-0';
    firstNameLabel.setAttribute('for', `${type}_author_first_name_${count}`);
  
    var lastNameLabel = document.createElement('label');
    lastNameLabel.innerText = 'Last Name';
    lastNameLabel.className = 'form-label mt-2 mb-0';
    lastNameLabel.setAttribute('for', `${type}_author_last_name_${count}`);
  
    // Create inputs
    var firstNameInput = document.createElement('input');
    firstNameInput.setAttribute("type", "text");
    firstNameInput.setAttribute("name", `${type}[author_first_name][]`);
    firstNameInput.setAttribute("id", `${type}_author_first_name_${count}`);
    firstNameInput.setAttribute("required", "required");
    firstNameInput.setAttribute("class", "form-control form-group");
    firstNameInput.setAttribute("autocomplete", "off");
  
    var lastNameInput = document.createElement('input');
    lastNameInput.setAttribute("type", "text");
    lastNameInput.setAttribute("name", `${type}[author_last_name][]`);
    lastNameInput.setAttribute("id", `${type}_author_last_name_${count}`);
    lastNameInput.setAttribute("required", "required");
    lastNameInput.setAttribute("class", "form-control form-group");
    lastNameInput.setAttribute("autocomplete", "off");
  
    // Append elements to name group
    nameGroupDiv.appendChild(lineDivider);
    nameGroupDiv.appendChild(firstNameLabel);
    nameGroupDiv.appendChild(firstNameInput);
    nameGroupDiv.appendChild(lastNameLabel);
    nameGroupDiv.appendChild(lastNameInput);
  
    // Set class for name group
    nameGroupDiv.setAttribute("class", "col-md-6 name-group");
  
    // Create and set delete button
    deleteBDiv.innerHTML = `<button name="button" type="button" onclick="removeAuthor('added_${count}');" class="form-control form-group bg-danger text-white" aria-label="Remove Author">Remove Author</button>`;
    deleteBDiv.setAttribute("class", "col-md-2 mt-2");
  
    // Create and set new author row
    newAuthor.setAttribute("class", "form-row");
    newAuthor.setAttribute("id", "added_" + count);
  
    // Append name group and delete button to new author row
    newAuthor.appendChild(nameGroupDiv);
    newAuthor.appendChild(deleteBDiv);
  
    // Append new author row to author group
    document.getElementById("author_group").appendChild(newAuthor);
    
    // Update count and set onClick for the next author
    count++;
    document.getElementById("add_author_btn").setAttribute("onClick", `addAuthor('${type}', ${count})`);
  }
  


function removeAuthor(idToDelete)     {
    document.getElementById(idToDelete).outerHTML = '';
}

// This function searches for the "Other" checkbox among college options.
// If the checkbox is found, it shows or hides the field for Other College
// based on the checkbox state.
$(document).on('turbolinks:load', function() {
    if (window.location.pathname.includes('/edit') || window.location.pathname.includes('/new')) {
        const checkboxes = Array.from(document.querySelectorAll('.form-check-input'));
        let otherChkbox;
    
        checkboxes.forEach(chkbox => {
          const label = document.querySelector(`label[for="${chkbox.id}"]`);
          if (label && label.textContent.trim() === 'Other') {
            otherChkbox = chkbox;
          }
        });
    
        if (!otherChkbox) return; 

        otherField = document.querySelector('[id$="_other_college"]');
        otherGroup = document.querySelector('[id$="other_college_group"]');
        tempStorage = '';

        if (otherField.value !== '') {
            otherChkbox.checked = true;
        } else {
            otherGroup.classList.toggle('d-none');
        }

        otherChkbox.onclick = function() {
            if (otherChkbox.checked) {
                otherGroup.classList.toggle('d-none');
                if (tempStorage !== '') {
                    otherField.value = tempStorage;
                }
            } else {
                otherGroup.classList.toggle('d-none');
                tempStorage = otherField.value;
                otherField.value = '';
            }
        };
    }
});
