$(document).ready(function(){
  CopyTicketLink();

  document.addEventListener("turbo:load", function() {
    CopyTicketLink();
  });

  const callCopyTicketLink = () => CopyTicketLink();
  window.callCopyTicketLink = callCopyTicketLink;

  function CopyTicketLink() {
    console.log("masuk")
    $(".copy-link-ticket").click(function() {
      $('.copy-section-ticket').attr('style', 'display: none;');
      var id_link = $(this).attr('data-id');
      var section = $(`.copy-link-section-ticket-${id_link}`);
      var input   = $(`#link-stream-${id_link}`);

      section.css('display', 'none')
      input.removeAttr('style')
      section.toggle(200);

      input.select();
      document.execCommand("copy");
      input.css('display', 'none')
      alert("Link copied!");
    });
  }

  $("#btn-plus-qty").click(function(){
    $("#input-minus-qty").val('');
    $("#plus-form").attr('style', '');
    $("#minus-form").attr('style', 'display: none;');
  });

  $("#btn-minus-qty").click(function(){
    $("#input-plus-qty").val('');
    $("#minus-form").attr('style', '');
    $("#plus-form").attr('style', 'display: none;');
  });

});