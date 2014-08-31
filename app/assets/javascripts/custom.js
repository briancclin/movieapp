/**
 * @author Brian
 */
function scrollToTop() {
    verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
    element = $('body');
    offset = element.offset();
    offsetTop = offset.top;
    $('html, body').animate({scrollTop: offsetTop}, 300, 'linear');
}

/* Button functions */
function insertButtonInfo(button, sortKey, method) {
	$(button).data("sortKey", sortKey);
	$(button).data("method", method);
}

function sortMovies(sortKey, method) {
	var elems = $('.col-md-4');
	var comparator = function (a, b) {
    	var result = 0;
    
    	if ($(a).find(sortKey).text() > $(b).find(sortKey).text()) {
        	result = -1;
    	} else {
        	result = 1;
    	}
    
    	if (method === 'asc') {
        	result *= -1;
    	}
    
    	return result;
	};

	elems.sort(comparator);
	var rows = $('.row');
	var count = 0;
	var curr  = 0;
	for(var i = 0; i < rows.length; i++)
	{
    	for(; curr < elems.length; curr++, count++)
    	{
       		if(count > 4)
        	{
            	count = 0;
            	break;
        	}
        	$('.row').eq(i).append(elems[curr]);
    	}
	}
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn"
	});
}

function sortMoviesNum(sortKey, method) {
	var elems = $('.col-md-4');
	var comparator = function (a, b) {
    	var result = 0;
    	var left = $(a).find(sortKey).text().replace( /^\D+/g, '');
    	var right = $(b).find(sortKey).text().replace( /^\D+/g, '');
    	if (parseInt(left) > parseInt(right)) {
        	result = -1;
    	} else {
        	result = 1;
    	}
    
    	if (method === 'asc') {
        	result *= -1;
    	}
    
    	return result;
	};

	elems.sort(comparator);
	var rows = $('.row');
	var count = 0;
	var curr  = 0;
	for(var i = 0; i < rows.length; i++)
	{
    	for(; curr < elems.length; curr++, count++)
    	{
       		if(count > 4)
        	{
            	count = 0;
            	break;
        	}
        	$('.row').eq(i).append(elems[curr]);
    	}
	}
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn"
	});
}

function buttonHighlight(buttonName) {
	var buttons = ["button#atoz", "button#ztoa", "button#yearup", "button#yeardown"];
	$.each(buttons, function( index, value ){
		if (buttonName == value)
			$(this).addClass("pure-button-active");
		else
			$(value).removeClass("pure-button-active");
	});
}
