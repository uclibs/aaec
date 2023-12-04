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
//= require bootstrap-tooltip-initialization
//= require toggle_college_other_field

function addAuthor(type, count)    {
    var count = count || 1;
    var newAuthor = document.createElement("div");
    var firstI = document.createElement("div");
    var lastI = document.createElement("div");
    var deleteB = document.createElement("div");
    newAuthor.setAttribute("class", "form-row");
    firstI.setAttribute("class", "col-md-5");
    lastI.setAttribute("class", "col-md-5");
    deleteB.setAttribute("class", "col-md-2");
    firstI.innerHTML = `<input type="text" name="${type}[author_first_name][]" id="${type}_author_first_name_" required="required" class="form-control form-group">`;
    lastI.innerHTML = `<input type="text" name="${type}[author_last_name][]" id="${type}_author_last_name_" required="required" class="form-control form-group">`;
    deleteB.innerHTML = `<button name="button" type="button" onclick="removeAuthor('added_${count}');" class="form-control form-group bg-danger text-white">Remove Author</button>`;
    newAuthor.setAttribute("id", "added_" + count);
    newAuthor.appendChild(firstI);
    newAuthor.appendChild(lastI);
    newAuthor.appendChild(deleteB);
    document.getElementById("author_group").appendChild(newAuthor);
    count++;
    document.getElementById("add_author_btn").setAttribute("onClick", `addAuthor('${type}', ${count})`);
}

function removeAuthor(idToDelete)     {
    document.getElementById(idToDelete).outerHTML = '';
}
