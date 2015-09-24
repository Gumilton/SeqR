shinyjs.enrichr = function (options) {
    var defaultOptions = {
    description: "",
    popup: true
  };

  if (typeof options.description == 'undefined')
    options.description = defaultOptions.description;
  
  if (typeof options.list == 'undefined')
    alert('No genes defined.');

  options.popup = defaultOptions.popup;

  var form = document.createElement('form');
  form.setAttribute('method', 'post');
  form.setAttribute('action', 'http://amp.pharm.mssm.edu/Enrichr/enrich');
  if (options.popup)
    form.setAttribute('target', '_blank');
  form.setAttribute('enctype', 'multipart/form-data');

  var listField = document.createElement('input');
  listField.setAttribute('type', 'hidden');
  listField.setAttribute('name', 'list');
  listField.setAttribute('value', options.list);
  form.appendChild(listField);

  var descField = document.createElement('input');
  descField.setAttribute('type', 'hidden');
  descField.setAttribute('name', 'description');
  descField.setAttribute('value', options.description);
  form.appendChild(descField);

  document.body.appendChild(form);
  form.submit();
  document.body.removeChild(form);
}
