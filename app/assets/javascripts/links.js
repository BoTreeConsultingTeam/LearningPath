$(document).ready(function() {
    if ($('.pagination').length > 0 && $('#links-list').length > 0 ) {
        $(window).scroll(function() {
            var url = $('.pagination .next_page').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $('.pagination').html('<img src="load.gif"  style="margin-bottom: 10px; margin-left: 400px"/>')
                return $.getScript(url);
            }
        });
        return $(window).scroll();
    }
});