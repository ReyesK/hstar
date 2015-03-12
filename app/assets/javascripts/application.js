// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){

  $(".generate_button").click(function(e){
    console.log("generate hurr");
  });//end generate

  var buttonCount = 0;
  var margLeft = 0;
  var margTop = 0;

  /*$( ".generate_button" ).mouseover(function() {
    if(buttonCount <3)
    {
      $('.generate_button').css({ 'margin-left': margLeft+'px','width': margTop+'px', 'width':'125px' });

      margLeft= randomNumber(0,90);
      margTop= randomNumber(0,50);

      buttonCount++;
    }
  });*/

  /*var $win = $(window),
    w = 0,h = 0,
    rgb = [],
    getWidth = function() {
        w = $win.width();
        h = $win.height();
    };

$win.resize(getWidth).mousemove(function(e) {

    rgb = [
        //Math.round(e.pageX/w * 255),
        //Math.round(e.pageY/h * 255),
        //Math.round(e.pageX/h * 255)
        scaleRed(e.pageX),
        scaleGreen(e.pageY),
        scaleBlue(e.pageX)
    ];

    $(document.body).css('background','rgb('+rgb.join(',')+')');

}).resize(); //end resize/color bg*/

//helper functions
function randomNumber(min,max)
{
    var randomNumber = Math.floor(Math.random()*(max-min+1)+min);

    return randomNumber;
}

  function scaleRed(mouse)
{
	var a=120;
	var b=125;
	var min=0;
	var max=255;
	var scaleVal = ((b-a)*(mouse-min)/255)+a;
	return scaleVal | 0;
}

 function scaleGreen(mouse)
{
	<!--var scaleVal = (mouse*255)/$('body').height();-->
	var a=20;
	var b=125;
	var min=0;
	var max=255;
	var scaleVal = ((b-a)*(mouse-min)/255)+a;
	return scaleVal | 0;
	return scaleVal | 0;
}


 function scaleBlue(mouse)
{
	<!--var scaleVal = (mouse*255)/$('body').width();-->
	var a=135;
	var b=240;
	var min=0;
	var max=255;
	var scaleVal = ((b-a)*(mouse-min)/255)+a;
	return scaleVal | 0;
}


});//end doc ready
