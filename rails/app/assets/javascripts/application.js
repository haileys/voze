// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {

    // placeholder polyfill
    $('[placeholder]').focus(function() {
    	var input = $(this);
    	if (input.val() == input.attr('placeholder')) {
    		input.val('');
    		input.removeClass('placeholder');
    	}
    }).blur(function() {
    	var input = $(this);
    	if (input.val() == '' || input.val() == input.attr('placeholder')) {
    		input.addClass('placeholder');
    		input.val(input.attr('placeholder'));
    	}
    }).blur();

    // dropdown
    $('body > nav .icon').click(function(ev) {
        ev.preventDefault();
    	$('body > nav ul li.active').removeClass('active');
    	$('body > nav ul li .container').hide();
    	$(this).parent().addClass('active');
    	$(this).parent().children('.container').show();
    	//$('#overlay').show();
    	return false;
    });

    $('body').click(function() {
    	$('body > nav ul li.active').removeClass('active');
    	$('body > nav ul li .container').hide();
    	//$(this).hide();
    });

    // dud links
    $('a[href=#]').click(function(){ return false; });

});