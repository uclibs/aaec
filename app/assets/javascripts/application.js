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

function addAuthor(type, count)    {
    var count = count || 1;
    var firstI = document.createElement("input");
    var lastI = document.createElement("input");
    var deleteB = document.createElement("button");
    firstI.setAttribute("type", "text");
    lastI.setAttribute("type", "text");
    deleteB.setAttribute("type", "button");
    firstI.setAttribute("name", type + "[author_first_name][]");
    lastI.setAttribute("name", type + "[author_last_name][]");
    deleteB.setAttribute("onclick", "removeAuthor('added_" + count +"');")
    firstI.setAttribute("id", "first_added_" + count);
    lastI.setAttribute("id", "last_added_" + count);
    deleteB.setAttribute("id", "delete_added_" + count);
    firstI.setAttribute("class", "form-control form-group");
    lastI.setAttribute("class", "form-control form-group");
    firstI.setAttribute("required", "required");
    lastI.setAttribute("required", "required");
    deleteB.setAttribute("class", "form-control form-group bg-danger text-white");
    deleteB.textContent = "Remove Author";

    document.getElementById("author_first_div").appendChild(firstI);
    document.getElementById("author_last_div").appendChild(lastI);
    document.getElementById("author_delete_div").appendChild(deleteB);
    count++;
    document.getElementById("add_author_btn").setAttribute("onClick", "addAuthor('other_publication', " + count + ")");
}

function removeAuthor(idToDelete)     {
    document.getElementById('first_' + idToDelete).outerHTML = '';
    document.getElementById('last_' + idToDelete).outerHTML = '';
    document.getElementById('delete_' + idToDelete).outerHTML = '';
}