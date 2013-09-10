$(document).ready(function() {
	$('#cat').hide();
	$('#done').hide();
	$('#twitter').submit(function(e) {
		e.preventDefault();
		$('#cat').show();
		var data = $('textarea').serialize();
		$('textarea').prop('disabled', true);
		$.post('/newtweet',data,function(){
			$('textarea').prop('disabled', false);
			$('#cat').hide();
			$('#done').show();
		});
	});
});