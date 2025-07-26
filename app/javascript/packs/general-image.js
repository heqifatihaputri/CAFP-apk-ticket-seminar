$(document).ready(function() {
  document.querySelectorAll('.remove-image').forEach( function(elm, id) {
    elm.addEventListener('click', function(){
      var data_confirm = confirm('Are you sure?');
      if (data_confirm) {
        var data_pic = document.querySelector(elm.getAttribute('data-pic-id'));

        var preview = data_pic;
        preview.className += ' hide'

        var id = $(elm).attr('data-id');
        var destroyField = data_pic.querySelector(`.destroy-field-${id}`);
        destroyField.value = true
        destroyField.setAttribute('value', true)
        return true;
      } else {
        return false;
      }

    })
  })

  $('body').on('click', '.remove-cache-image', function(){
    var data_confirm = confirm('Are you sure?');
    if (data_confirm) {
      var elm = this;
      var imageCol = elm.closest('.image-col')
      if (imageCol == null) { imageCol = elm.closest('li') }

      var imageField = document.querySelector('.upload-data')
      var jsonData   = JSON.parse(imageField.value)
      var newJson    = jsonData.filter(function(elm){
        return elm.id != imageCol.getAttribute('data-cache-id')
      })

      imageField.value = JSON.stringify(newJson)
      imageCol.remove()
      return true;
    } else {
      return false;
    }

  })

  $('img.show-image').on('click', function(){
    var currentUrl = this.getAttribute('src')
    var changedPic = document.querySelector('.current-image')
    var changedUrl = changedPic.getAttribute('src')
    changedPic.setAttribute('src', currentUrl)
    this.setAttribute('src', changedUrl)
  })
})
