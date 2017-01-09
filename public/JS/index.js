window.onload= function() {
  console.log("Works");

var editbttn = document.getElementById('editbttn');
var deletebttn = document.getElementById('deletebttn');
var formedit = document.getElementById('editvisibility');
var editpost = document.querySelector('.editbttn');
console.log(editpost);
var postform = document.getElementById('editvisibility1');

editbttn.addEventListener('click', function(e){
  e.preventDefault();
  formedit.style.visibility = 'visible';
});

deletebttn.addEventListener('click', function(e){
  e.preventDefault();

});
editpost.addEventListener('click', function(e){
  e.preventDefault();
  postform.style.visibility = 'visible';
});





} //end of onload
