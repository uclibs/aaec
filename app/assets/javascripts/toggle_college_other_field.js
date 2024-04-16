// Show or hide the other college text field based on the checkbox
// The field is hidden by default, and the checkbox is checked if the field has a value
// If the checkbox is unchecked, the field's value is stored in tempStorage and the field is cleared
$(document).on('turbolinks:load', function() {
    if (window.location.pathname.includes("/edit") || window.location.pathname.includes("/new")) {
        setupOtherCollegeCheckbox();
    }
});

function setupOtherCollegeCheckbox() {
    const otherChkbox = document.querySelector('[id$="_college_ids_16"]');
    const otherField = document.querySelector('[id$="_other_college"]');
    const otherGroup = document.querySelector('[id$="other_college_group"]');

    // Initialize or use existing tempStorage
    otherField.tempStorage = otherField.tempStorage || '';

    // Set initial state based on otherField's value
    otherChkbox.checked = otherField.value !== "";
    otherGroup.classList.toggle("d-none", !otherChkbox.checked);

    // Event listener for the checkbox
    otherChkbox.addEventListener('click', () => {
        otherGroup.classList.toggle("d-none");
        if (otherChkbox.checked) {
            if (otherField.tempStorage !== '') {
                otherField.value = otherField.tempStorage;
            }
        } else {
            otherField.tempStorage = otherField.value;
            otherField.value = '';
        }
    });
}
