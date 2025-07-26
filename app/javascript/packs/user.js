$(document).ready(function(){
  $("#top-up-amount").keyup(function(){
    var amount = $(this).val();
    $("#btn-submit-top-up").attr("data-confirm", `Are you sure want to Top Up Rp ${amount}?`)
  });
});