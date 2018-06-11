var fieldId = 0;

function onClickAdd(sectionName) {
  var parentDiv = document.getElementById(sectionName);
  var cloneDiv = parentDiv.cloneNode(true);
  ++fieldId;
  cloneDiv.id += fieldId;
  cloneDiv.childNodes[1].name = cloneDiv.childNodes[1].name.replace("0", fieldId);
  //console.log(cloneDiv.childNodes[1]);
  parentDiv.parentNode.insertBefore(cloneDiv, parentDiv.nextSibling);
}

function onClickRemove(currentItem) {
  var recordId = currentItem.parentNode.childNodes[1].value;
  var divId = currentItem.parentNode.id;
  if (recordId == '') {
    document.getElementById(divId).remove();
  }
  else {
    // clear field of values
    currentItem.parentNode.childNodes[3].value = '';
    currentItem.parentNode.style.display = "none";
  }
}

function addWebsiteField(currentItem) {
  //console.log(document.getElementById('button'));

  //create Date object
  var date = new Date();

  //get number of milliseconds since midnight Jan 1, 1970
  //and use it for address key
  var mSec = date.getTime();

  var parentDiv = currentItem.parentNode;
  var cloneDiv = parentDiv.cloneNode(true);
  cloneDiv.id += mSec;

  //Replace 0 with milliseconds
  cloneDiv.childNodes[1].name = cloneDiv.childNodes[1].name.replace("0", mSec);
  cloneDiv.childNodes[1].value = '';

  cloneDiv.childNodes[3].name = cloneDiv.childNodes[3].name.replace("0", mSec);
  // cloneDiv.childNodes[5].value = '';
  cloneDiv.childNodes[5].name = cloneDiv.childNodes[5].name.replace("0", mSec);

  cloneDiv.childNodes[5].value = '-';
  cloneDiv.childNodes[5].setAttribute('onclick', "onClickRemove(this)");

  // cloneDiv.childNodes[5].value = '+';
  // cloneDiv.childNodes[5].setAttribute('onclick', "addWebsiteField(this)");

  //console.log(cloneDiv.childNodes);

  // var button = document.getElementById('button');
  // button.value = '-';
  // button.setAttribute('onclick', "onClickRemove(this)");

  parentDiv.parentNode.insertBefore(cloneDiv, parentDiv);
}
