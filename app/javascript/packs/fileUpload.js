import 'uppy/dist/uppy.min.css'

import {
  Core,
  FileInput,
  Informer,
  ProgressBar,
  ThumbnailGenerator,
  XHRUpload,
} from 'uppy'

const csrfToken = document.querySelector('meta[name="csrf-token"]').content
const callSingleFileUploadLocal = (fileInput) => fileUploadLocal(fileInput);
window.callSingleFileUploadLocal = callSingleFileUploadLocal;

function fileUploadLocal(fileInput) {
  var hiddenInput = document.querySelector('.upload-data');

  const formGroup = fileInput.parentNode;

  if ($(fileInput).data('previewId')) {
    var imagePreview = document.querySelector('#' + $(fileInput).data('previewId'));
  } else{
    var imagePreview = document.querySelector('.upload-preview img');
  }

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
    .use(XHRUpload, { endpoint: '/images/upload', bundle: false, headers: { "X-CSRF-Token": csrfToken } })

  uppy.on('thumbnail:generated', (file, preview) => {
    // show preview of the image using URL from thumbnail generator
    imagePreview.src = preview;
  })

  uppy.on('upload-success', (file, response) => {
    const uploadedFileData = {
      id: response.body.id, // object key without prefix
      storage: 'cache',
      metadata: {
        size: response.body.metadata['size'],
        filename: response.body.metadata['filename'],
        mime_type: response.body.metadata['mime_type'],
      }
    }
    
    hiddenInput.value = JSON.stringify(uploadedFileData);
  })

  uppy.on('upload-error', (file, error, response) => {
    console.log("error", response)
  })
}

export default fileUploadLocal