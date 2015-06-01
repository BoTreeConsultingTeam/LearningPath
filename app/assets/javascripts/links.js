$(document).ready(function() {
  var res_arr = [];
  var group_res_arr = [];
  $('.selection_modal').click(function () {
    $("#list_modal").modal('show');
  });

  $('.contact_select').click(function(){
    $.ajax({
      type: "POST",
      url: "links/final_sender",
      data: { contact_ids: res_arr,
          group_ids: group_res_arr,
          links: $('#selected_links').val()
        }
      } )
      .done(function(){
        $("#list_modal").modal('hide');
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

    $('.send_btn').click(function(){
      $.ajax({ type: "POST",
             url: "links/list_selected",
             data: {link_ids: res_arr}
      })
    });

    $('.dlt_btn').click(function(){
      $.ajax({ type: "POST",
          url: "links/remove_selected",
          data: {link_ids: res_arr}
        })
    });

    function ids_list(arr, thisObj) {
      var $this = $(thisObj);
      if ($this.is(':checked')) {
        arr.push($this.val());
        } else {
            arr.pop($this.val());
        }
        if(arr.length > 0){
            $('.sender').fadeIn( "slow");
        }else{
            $('.sender').fadeOut( "slow");
        }
      return arr;
    }

    $('.cb_select:checkbox').click(function() {
        ids_list(res_arr, $(this));
    });

    $('.contact_cb:checkbox').click(function() {
        ids_list(res_arr, $(this));
    });

    $('.group_cb:checkbox').click(function() {
        ids_list(group_res_arr, $(this));
    });

    $("[name='by_contact']").bootstrapSwitch();

    $('#by_contact').bootstrapSwitch('onText', 'contact');
    $('#by_contact').bootstrapSwitch('labelText', 'ShareBy');
    $('#by_contact').bootstrapSwitch('offText', 'Group');
    $('#by_contact').bootstrapSwitch('onColor', 'info');
    $('#by_contact').bootstrapSwitch('offColor', 'success');
    $('#by_contact').on('switchChange.bootstrapSwitch', function(event, state) {
      if (state == true){
        $(".by_contacts").addClass('show_me');
        $(".by_groups").addClass('hide_me');
      }
      else {
        $(".by_contacts").removeClass('show_me');
        $(".by_groups").removeClass('hide_me');
      };
    });
});


