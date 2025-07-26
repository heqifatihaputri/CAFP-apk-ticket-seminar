$(document).ready(function(){
  $('.btn-close').click(function(){
    $(this).parent().remove();
  });

  $('.datepicker').datetimepicker({
    format: 'DD/MM/YYYY',
    // icons: {
    //   time:'zmdi zmdi-time',
    //   date:'zmdi zmdi-calendar-alt',
    //   up:'zmdi zmdi-chevron-up',
    //   down:'zmdi zmdi-chevron-down',
    //   previous:'zmdi zmdi-chevron-left',
    //   next:'zmdi zmdi-chevron-right',
    //   today:'zmdi zmdi-calendar-check',
    //   clear:'zmdi zmdi-tag-close',
    //   close:'zmdi zmdi-close'
    // }
  });
  // $('.datepicker').val("");

  $('.datetimepicker').datetimepicker({
    format: "DD/MM/YYYY hh:mm A",
    icons: {
      time:'zmdi zmdi-time',
      date:'zmdi zmdi-calendar-alt',
      up:'zmdi zmdi-chevron-up',
      down:'zmdi zmdi-chevron-down',
      previous:'zmdi zmdi-chevron-left',
      next:'zmdi zmdi-chevron-right',
      today:'zmdi zmdi-calendar-check',
      clear:'zmdi zmdi-tag-close',
      close:'zmdi zmdi-close'
    }
  });
  // $('.datetimepicker').val("");

  $('.daterange').daterangepicker({
    locale: {
      format: 'DD/MM/YYYY',
      defaultDate: null,
      useCurrent: false,
      // autoUpdateInput: false,
      // autoApply: true,
      // startDate: "",
      // endDate: "",
      // cancelLabel: 'Clear'
      }
  });
  $('.daterange').val("");

  $("input.field_number").keypress(function(event) {
    return /\d/.test(String.fromCharCode(event.keyCode));
  });

  $("input.field-number").keypress(function(event) {
    return /\d/.test(String.fromCharCode(event.keyCode));
  });

  var search_date_range = $('#hidden-search-daterange').attr('data-value');
  $('#input-search-date-range').val(search_date_range);

  // initPreviewUpload();
});

// function initPreviewUpload() {
//   var preview     = $('.upload-preview img');
//   var image_value = $('#inputGroupFile01').attr('value');

//   if (!image_value == "") {
//     $('#upload-multi-file').removeClass('required')
//   }

//   $(".file").change(function(event){
//      var input  = $(event.currentTarget);
//      refreshPreviewUpload(input, preview);
//   });
// }

// function refreshPreviewUpload(input, preview) {
//   var file   = input[0].files[0];
//   var reader = new FileReader();
//   reader.onload = function(e){
//       image_base64 = e.target.result;
//       preview.attr("src", image_base64);
//   };
//   reader.readAsDataURL(file);
// }

