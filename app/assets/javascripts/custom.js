/**
 * @author Brian
 */
function goTo(location) {
		console.log($(location).offset().top);
        $('html, body').animate({
            scrollTo: $(location).offset().top + 'px'
        }, 'fast');
}

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
	var elems = $('.movie-col');
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
	var curr  = 0;
	for(var i = 0; i < rows.length; i++)
	{
    	for(; curr < elems.length; curr++)
    	{
        	$('.row').eq(i).append(elems[curr]);
    	}
	}
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn",
    	threshold : 400
	});
}

function sortMoviesNum(sortKey, method) {
	var elems = $('.movie-col');
	var comparator = function (a, b) {
    	var result = 0;
    	var left = ($(a).find(sortKey).text()).replace( /\D/g, '');
    	if (left == "")
    		left = 0;
    	var right = ($(b).find(sortKey).text()).replace( /\D/g, '');
    	if (right == "")
    		right = 0;
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
	var curr  = 0;
	for(var i = 0; i < rows.length; i++)
	{
    	for(; curr < elems.length; curr++)
    	{
        	$('.row').eq(i).append(elems[curr]);
    	}
	}
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn",
    	threshold : 400
	});
}

function buttonHighlight(buttonName) {
	var buttons = ["button#atoz", "button#ztoa", "button#yearup", "button#yeardown", "button#imdb", "button#rotten"];
	$.each(buttons, function( index, value ){
		if (buttonName == value)
			$(this).addClass("pure-button-active");
		else
			$(value).removeClass("pure-button-active");
	});
}

function linkHighlight(linkName) {
	var links = ["li#atoz", "li#ztoa", "li#yearup", "li#yeardown", "li#imdb", "li#rotten"];
	$.each(links, function( index, value ){
		if (linkName == value)
			$(linkName).addClass("active");
		else
			$(value).removeClass("active");
	});
}

function sortatoz(){
	sortMovies($("button#atoz").data("sortKey"),$("button#atoz").data("method"));
	linkHighlight("li#atoz");
}

function sortztoa(){
	sortMovies($("button#ztoa").data("sortKey"),$("button#ztoa").data("method"));
	linkHighlight("li#ztoa");
}

function sortoldest(){
	sortMovies($("button#yearup").data("sortKey"),$("button#yearup").data("method"));
	linkHighlight("li#yearup");
}

function sortnewest(){
	sortMovies($("button#yeardown").data("sortKey"),$("button#yeardown").data("method"));
	linkHighlight("li#yeardown");
}

function sortimdb(){
	sortMovies($("button#imdb").data("sortKey"),$("button#imdb").data("method"));
	linkHighlight("li#imdb");
}

function sortrt(){
	sortMoviesNum($("button#rotten").data("sortKey"),$("button#rotten").data("method"));
	linkHighlight("li#rotten");
}
