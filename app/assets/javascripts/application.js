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
//= require add_remove_authors

$(document).on('turbolinks:load', function() {
    if (window.location.pathname.includes("/edit") || window.location.pathname.includes("/new")) {
        otherChkbox = document.querySelector('[id$="_college_ids_16"]');
        otherField = document.querySelector('[id$="_other_college"]');
        otherGroup = document.querySelector('[id$="other_college_group"]');
        tempStorage = '';

        if (otherField.value != "") {
            otherChkbox.checked = true;
        }
        else    {
            otherGroup.classList.toggle("d-none");
        }

        otherChkbox.onclick = function() {
            if (otherChkbox.checked) {
                otherGroup.classList.toggle("d-none");
                    if (tempStorage != '') {
                        otherField.value = tempStorage;
                    }
                }
            else    {
                otherGroup.classList.toggle("d-none");
                tempStorage = otherField.value;
                otherField.value = '';
            } 
        }
    }
})
