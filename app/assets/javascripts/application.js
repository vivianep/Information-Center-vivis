//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(".path-link").on("click", function(){
	var numb_id = $(this).attr("id").slice(2);
	var form_id = "#form-".concat(numb_id);
	$(form_id).submit();
});
