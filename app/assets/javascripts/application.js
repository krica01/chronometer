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

setInterval(function(){ changeDate() }, 1000);

Number.prototype.pad = function (len) {
    return (new Array(len+1).join("0") + this).slice(-len);
}



function changeDate2() {
	var date = new Date();

    var options = {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
		minute: "2-digit",
		hour: "2-digit",
		second: "2-digit"
    };

	$('.timer').text(date.toLocaleDateString("en", options))
}

function changeDateTime() {
	var date = new Date();

    var options = {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
		minute: "2-digit",
		hour: "2-digit",
		second: "2-digit"
    };

	$('.timer-finish').text(date.toLocaleDateString("en", options))
}

function changeDate() {
	var timestamp = Date.now();

    var options = {
        year: "numeric",
        month: "2-digit",
        day: "2-digit",
		minute: "2-digit",
		hour: "2-digit",
		second: "2-digit"
    };



	//$('.timer').text(date.toLocaleDateString("en", options))
	var times = new Date(timestamp);
	var time =
	times.getDate().pad(2) + '/' + (times.getMonth()+1).pad(2) + '/' + times.getFullYear() + ' ' +
	times.getHours().pad(2) + ':' + times.getMinutes().pad(2) + ':' + times.getSeconds().pad(2) + ':' + times.getMilliseconds().pad(3);
	$('.timer').text(time);

}

function sendFinishTime(timeLi, raceId, rzId) {
	var userId = timeLi.children('select').val();
	var finishTime = timeLi.children('span.startTimeLi').text();

	var url = '/race/' + raceId + '/finish/' + rzId + '/racer/' + userId;

  localStorage.setItem('finish-time' + userId, finishTime);

	$.ajax({
		type: 'GET',
		url: url,
		data: {startTime:  finishTime},
	});

	timeLi.hide();

}

function resendTimes(raceId, rzId) {
  var success = 0;
  var count = 0;
  $('#users').children().each(function() {
    var racerId = $(this).attr('value');
    var time = localStorage.getItem('finish-time' + racerId);
    if (time != null) {
        count ++;
        var url = '/race/' + raceId + '/finish/' + rzId + '/racer/' + racerId;
        $.ajax({
      		type: 'GET',
      		url: url,
          success: function (jqxhr, txt_status) {
             ++success;
          },
      		data: {startTime:  time},
          async: false,
      	});
    }


  });

  alert("uploaded times: " + success );


}
