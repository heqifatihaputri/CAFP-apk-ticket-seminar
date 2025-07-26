import 'uppy/dist/uppy.min.css'

import {
  Core,
  FileInput,
  Informer,
  ProgressBar,
  ThumbnailGenerator,
  XHRUpload,
} from 'uppy'

function fileMultiUpload(fileInput) {
  const hiddenInput = document.querySelector('.upload-data'),
        imagePreview = document.querySelector('.upload-preview'),
        formGroup = fileInput.parentNode,
        csrfToken = document.querySelector('meta[name="csrf-token"]').content;

  // remove our file input in favour of Uppy's
  formGroup.removeChild(fileInput)

  const uppy = Core({
      autoProceed: true,
      onBeforeFileAdded: (currentFile, files) => {
        currentFile['name'] = (new Date().getTime()) + "-" +  currentFile['name'];
      }
    })
    .use(FileInput, {
      target: formGroup,
    })
    .use(Informer, {
      target: formGroup,
    })
    .use(ProgressBar, {
      target: imagePreview.parentNode,
    })
    .use(ThumbnailGenerator, {
      thumbnailWidth: 600,
    })
    .use(XHRUpload, {
      endpoint: '/images/upload', bundle: false, headers: { "X-CSRF-Token": csrfToken }
    })

  uppy.on('thumbnail:generated', (file, preview) => {
    // show preview of the image using URL from thumbnail generator
    var div = document.createElement("div");
        div.className = 'col-3 image-col mt-auto';
        $(div).attr('data-filename', file['name']);

    var img = document.createElement("img");
    $(div).append(img)

    var span  = document.createElement("span");
    var ahref = document.createElement("a");
        ahref.className = 'remove-cache-image';
        ahref.innerHTML = 'Click for Remove';
        ahref.href = 'javascript:void(0)';
    $(span).append(ahref);
    $(div).append(span);

    img.src = preview;
    img.className = 'w-100';
    $(imagePreview).append(div);
  })

  uppy.on('upload-success', (file, response) => {
    if (file.type.includes('video')) {
      var ul = $('.list-of-video');
      var ahref = document.createElement('a');
          ahref.innerHTML = file.name;
          ahref.href = `http://localhost:3000/uploads/cache/${response.body.id}`;
          ahref.target = '_blank';
      var ahref2 = document.createElement("a");
          ahref2.className = 'remove-cache-image';
          ahref2.innerHTML = 'Click for Remove';
          ahref2.href = 'javascript:void(0)';
      var li = document.createElement('li');
          li.setAttribute('data-cache-id', response.body.id);
      
      $(li).append($(ahref));
      $(li).append(' - ');
      $(li).append($(ahref2));
      ul.append(li);

      $('.video-blank').remove();
    }

    if (file.type.split('/')[0] == 'image') {
      var div = $("div[data-filename='"+ file['name'] +"']")
          div.attr('data-cache-id', response.body.id)

    }

    // construct uploaded file data in the format that Shrine expects
    const uploadedFileData = {
      id: response.body.id, // object key without prefix
      storage: 'cache',
      metadata: {
        size: response.body.metadata['size'],
        filename: response.body.metadata['filename'],
        mime_type: response.body.metadata['mime_type'],
      }
    }

    // set hidden field value to the uploaded file data so that it's submitted
    // with the form as the attachment
    var old_value = []
    if (hiddenInput.value != "") {
      old_value = JSON.parse(hiddenInput.value)
    }

    old_value.push(uploadedFileData)
    hiddenInput.value = JSON.stringify(old_value)
    setTimeout(() => {
    }, 1500)
  })

  uppy.on('upload-error', (file, error, response) => {
    console.log("error", response)
    // submitButton.removeAttribute("disabled")
    // submitButton.innerHTML = "Save"
  })
}

export default fileMultiUpload
