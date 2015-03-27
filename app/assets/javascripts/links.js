$(document).ready(function() {
    if ($('.pagination').length) {
        $(window).scroll(function() {
            var url = $('.pagination .next_page').attr('href');
            if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
                $('.pagination').html('<img src="assets/load.gif"  style="margin-bottom: 10px; margin-left: 400px"/>')
                return $.getScript(url);
            }
        });
        return $(window).scroll();
    }
});