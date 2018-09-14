$( document ).on('turbolinks:load', function() {
  // Subject Form
  $('#subject_employee_ids').multiSelect();

  // Employee Form 
  $('#employee_subject_ids').multiSelect();

   // Department Form 
   $('#employee_department_ids').multiSelect();
});

// Employee Select Buttons 
$(document).on('click', '#employee_select_all', function(event) {
  event.preventDefault();
  $('#employee_subject_ids').multiSelect('select_all');
  return true;
});

$(document).on('click', '#employee_deselect_all', function(event) {
  event.preventDefault();
  $('#employee_subject_ids').multiSelect('deselect_all');
  return true;
});

// Employee Department Select Buttons 
$(document).on('click', '#department_select_all', function(event) {
  event.preventDefault();
  $('#employee_department_ids').multiSelect('select_all');
  return true;
});

$(document).on('click', '#department_deselect_all', function(event) {
  event.preventDefault();
  $('#employee_department_ids').multiSelect('deselect_all');
  return true;
});

// Subject Select Buttons 
$(document).on('click', '#subject_select_all', function(event) {
  event.preventDefault();
  $('#subject_employee_ids').multiSelect('select_all');
  return true;
});

$(document).on('click', '#subject_deselect_all', function(event) {
  event.preventDefault();
  $('#subject_employee_ids').multiSelect('deselect_all');
  return true;
});