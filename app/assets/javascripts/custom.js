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
    $('html, body').animate({scrollTop: offsetTop}, 100, 'linear');
}

/* Button functions */
function insertButtonInfo(button, sortKey, method) {
	$(button).data("sortKey", sortKey);
	$(button).data("method", method);
}

function sortMovies(sortKey, method) {
	var elems = $('.movie-col');
	var map = elems.map(function(i, e) {
  	return { index: i, value: $(e).find(sortKey).text() };
	});
	var sorted = map.sort(function(a, b) {
		if(method == 'asc')
  			return +(a.value > b.value) || +(a.value === b.value) - 1;
  		else
  			return +(a.value < b.value) || +(a.value === b.value) - 1;
	});	
	elems = map.map(function(e){
  		return elems[sorted[e].index];
});
	var rows = $('.row');
	rows.append(elems);
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn",
    	failure_limit : 5
	});
}

function sortMoviesNum(sortKey, method) {
	var elems = $('.movie-col');
	var map = elems.map(function(i, e) {
		var value = ($(e).find(sortKey).text()).replace( /\D/g, '');
		if(value == "")
			value = -1;
  	return { index: i, value: value };
	});
	var sorted = map.sort(function(a, b) {
		if(method == 'asc')
  			return +(parseInt(a.value) > parseInt(b.value)) || +(parseInt(a.value) === parseInt(b.value)) - 1;
  		else
  			return +(parseInt(a.value) < parseInt(b.value)) || +(parseInt(a.value) === parseInt(b.value)) - 1;
	});	
	elems = map.map(function(e){
  		return elems[sorted[e].index];
});
	var rows = $('.row');
	rows.append(elems);
/* lazy load images */
    $("img.lazy").lazyload({
    	effect : "fadeIn",
    	failure_limit : 5
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
