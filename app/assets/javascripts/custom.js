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

function sortMoviesDate(sortKey, method) {
	var elems = $('.movie-col');
	var test = $(elems[0]).find(sortKey);
	console.log(test);
	var map = elems.map(function(i, e) {
		var arr = $(e).find(sortKey).data("release").split("-");
		var date = new Date(parseInt(arr[0]),parseInt(arr[1]),parseInt(arr[2]));
  	return { index: i, value: date };
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
	sortMovies($("button#atoz").data("sortkey"),$("button#atoz").data("method"));
	linkHighlight("li#atoz");
}

function sortztoa(){
	sortMovies($("button#ztoa").data("sortkey"),$("button#ztoa").data("method"));
	linkHighlight("li#ztoa");
}

function sortoldest(){
	sortMovies($("button#yearup").data("sortkey"),$("button#yearup").data("method"));
	linkHighlight("li#yearup");
}

function sortnewest(){
	sortMovies($("button#yeardown").data("sortkey"),$("button#yeardown").data("method"));
	linkHighlight("li#yeardown");
}

function sortimdb(){
	sortMovies($("button#imdb").data("sortkey"),$("button#imdb").data("method"));
	linkHighlight("li#imdb");
}

function sortrt(){
	sortMoviesNum($("button#rotten").data("sortkey"),$("button#rotten").data("method"));
	linkHighlight("li#rotten");
}
