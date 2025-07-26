$(document).ready(function() {
  const callCreateQrCode = (ticketId, VisitorId) => CreateQrCode(ticketId, VisitorId);
  window.callCreateQrCode = callCreateQrCode;

  const callTicketAlert  = (ticketId, VisitorId, refresh) => TicketAlert(ticketId, VisitorId, refresh);
  window.callTicketAlert = callTicketAlert;

  function CreateQrCode(ticketId, VisitorId){
    var qrcode = new QRCode(document.getElementById("qrcode"), {
    text: `host=${document.location.host}&ticket_id=${ticketId}&visitor_id=${VisitorId}`,
    width: 300,
    height: 300,
    colorDark : "#000000",
    colorLight : "#ffffff",
    correctLevel : QRCode.CorrectLevel.H
    });
  }

  function TicketAlert(ticketId, VisitorId, refresh){
    $.ajax({
      type: "GET",
      dataType:"json",
      data: {'ticket_id' : ticketId, 'visitor_id' : VisitorId, 'refresh' : refresh },
      url: "/api/ticket_sessions/get_ticket_alert",
      success: function(response){
        var isEmpty = Object.keys(response).length === 0;

        if (!isEmpty) {
          var alert_label   = response.alert_label;
          var alert_msg     = response.alert_msg;
          var failed_reason = `Reason : ${response.failed_reason}`;

          $('.alert-wrapper').removeClass('hide');
          $('.ticket-alert-label').addClass(`alert alert-${alert_label}`);
          $('.ticket-alert-text').addClass(`text-${alert_label}`);
          $('.ticket-alert-text').text(`${alert_msg}`);

          if (!(response.failed_reason == "")) {
            $('.failed-reason').text(`${failed_reason}`);
          }
        } else {
          $('.alert-wrapper').addClass('hide');
        }
      }
    });
  }

  $('.btn-close').click(function(){
    $(".failed-reason").remove();
  });

});