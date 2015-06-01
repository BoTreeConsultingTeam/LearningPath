$(document).ready(function() {
    var res_arr = [];
    var group_res_arr = [];
  $('.my_modal').click(function () {
    $("#myModal").modal('show');
  });

  $('.contact_select').click(function(){
    $.ajax({
        type: "POST",
        url: "links/final_sender",
        data: {contact_ids: res_arr, group_ids: group_res_arr, links: $('#selected_links').val()}
        } ).done(function(){
        $("#myModal").modal('hide');
        })
    });

    $('.btn-group').unbind('click');
    $('.btn-group').click(function(){
            $('#'+this.id).toggleClass('open');
        }

    );
    $('.view_desc_more').click(function () {
        $('.truncate_desc'+this.id).toggleClass('hide_me');
        $('.truncate_desc_show'+this.id).toggleClass('show_me');
        var v = $( ".truncate_desc_show"+this.id).find("p");
        v.append($('.'+this.id));
    });
    $('.view_desc_less').click(function () {
        $('.truncate_desc'+this.id).toggleClass('hide_me');
        $('.truncate_desc_show'+this.id).toggleClass('show_me');
    });
    $('.cb_select:checkbox').click(function() {
        var $this = $(this);
        if ($this.is(':checked')) {
            res_arr.push($this.val());
        } else {
            res_arr.pop($this.val());
        }

        if(res_arr.length > 0){
            $('.sender').fadeIn( "slow");
        }else{
            $('.sender').fadeOut( "slow");
        }
        return res_arr;
    });

    $('.send_btn').click(function(){
        alert(res_arr);
        $.ajax({
            type: "POST",
            url: "links/list_selected",
            data: {link_ids: res_arr}
        } ).done(function(){
        })

    });

    $('.dlt_btn').click(function(){
        $.ajax({
            type: "POST",
            url: "links/remove_selected",
            data: {link_ids: res_arr}
        } ).done(function(){
        })
    });

    $('.contact_cb:checkbox').click(function() {
        var $this = $(this);
        if ($this.is(':checked')) {
            res_arr.push($this.val());
        } else {
            res_arr.pop($this.val());
        }
        if(res_arr.length > 0){
            $('.sender').fadeIn( "slow");
        }else{
            $('.sender').fadeOut( "slow");
        }
        return res_arr;
    });
    $('.group_cb:checkbox').click(function() {
        var $this = $(this);
        if ($this.is(':checked')) {
            group_res_arr.push($this.val());
        } else {
            group_res_arr.pop($this.val());
        }

        if (group_res_arr.length > 0) {
            $('.sender').fadeIn("slow");
        } else {
            $('.sender').fadeOut("slow");
        }
        return group_res_arr;
    });
});


