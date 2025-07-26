$(document).ready(function(){
  var timeout = null;

  updateTotalCart(timeout);
  // changeQuantity();

  document.addEventListener("turbo:load", function() {
    updateTotalCart(timeout);
    // changeQuantity();
  });

  const callUpdateTotalCart = () => updateTotalCart(timeout);
  window.callUpdateTotalCart = callUpdateTotalCart;

  // function changeQuantity(){
  //   $(".item-quantity").change(function(){
  //     clearTimeout(timeout);

  //     var quantity = $(this).val();
  //     var idx      = $(this).attr("data-id");
  //     timeout = setTimeout(() => {
  //     calculateTotalItem(quantity, idx);
  //     }, 1000);
  //   });

  //   $(".item-quantity").keyup(function(){
  //     clearTimeout(timeout);

  //     var quantity = $(this).val();
  //     var idx      = $(this).attr("data-id");
  //     timeout = setTimeout(() => {
  //     calculateTotalItem(quantity, idx);
  //     }, 1000);
  //   });
  // }


  // function calculateTotalItem(quantity, idx){
  //   $.ajax({
  //     type: "GET",
  //     dataType:"json",
  //     data: {'quantity' : quantity, 'idx' : idx},
  //     url: "/user/events/get_quantity_pricing",
  //     success: function(response){
  //       if (response['quantity'] == 0 || response['pricing'] == null) {
  //         $(`#total-${idx}`).addClass('d-none')
  //         $(`#price-${idx}`).removeAttr('style')
  //       } else {
  //         $(`#total-${idx}`).removeClass('d-none')
  //         $(`#price-${idx}`).attr('style', 'text-decoration: line-through')
  //         $(`#total-${idx}`).text(`RM ${response['price'].toString()}.00`)
  //       }
  //     }
  //   });
  // }

  function updateTotalCart(timeout) {
    $(".input-quantity").keyup(function(){
      clearTimeout(timeout);

      var quantity     = $(this).val();
      var idx          = $(this).attr("data-id");
      var cart_item_id = $(`input[name="cart_item[id][${idx}]"]`).val()

      timeout = setTimeout(() => {
        calculateCartItem(quantity, idx, cart_item_id)
      }, 1000);
    });

    $(".input-quantity").change(function(){
      clearTimeout(timeout);

      var quantity     = $(this).val();
      var idx          = $(this).attr("data-id");
      var cart_item_id = $(`input[name="cart_item[id][${idx}]"]`).val()

      timeout = setTimeout(() => {
        calculateCartItem(quantity, idx, cart_item_id)
      }, 1000);
    });

    function calculateCartItem(quantity, idx, cart_item_id){
      $.ajax({
        type: "GET",
        dataType: "script",
        data: {'quantity' : quantity, 'cart_item_id' : cart_item_id, 'idx': idx},
        url: "/user/carts/update_price_cart_item"
      });
    }
  }
});
