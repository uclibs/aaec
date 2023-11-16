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
