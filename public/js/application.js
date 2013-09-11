
var polling = function(jid, status, jqXHR, complete) {
  if (complete) {
    return // stop polling
  }
  else {
		$.get('/status/'+ jid, function(response){
		 	if (response === "true") {
		 		complete = true
 	  	}
 	  	setTimeout(polling, 10000, jid, status, jqXHR, complete)
	  });
	}
}
 



$(document).ready(function() {
	$('#cat').hide();
	$('#done').hide();
	$('#twitter').submit(function(e) {
		e.preventDefault();
		var data = $('textarea').serialize();
		$('textarea').prop('disabled', true);
		$.post('/newtweet',data, polling);
	});
});

