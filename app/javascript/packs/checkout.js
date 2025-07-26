$(document).ready(function(){
  $('#use-e-wallet').change(function() {
    console.log("test")
    var dataGrandTotalBef   = parseFloat($('.order_use-balance').attr('data-grand-total-bef')).toFixed(2);
    var dataCurrentMutation = parseFloat($('.order_use-balance').attr('data-current-mutation')).toFixed(2);
    if ($(this).prop('checked')) {
      $('.grand_total_amount strong').text('Rp '+ (dataGrandTotalBef - dataCurrentMutation));
      $('.order_use-balance').removeClass('d-none');
      $(this).val(true);
    } else {
      $('.grand_total_amount strong').text('Rp '+ (dataGrandTotalBef));
      $('.order_use-balance').addClass('d-none');
      $(this).val(false);
    }
  })
});