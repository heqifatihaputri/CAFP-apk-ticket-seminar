// import { Application } from "stimulus"
// import { definitionsFromContext } from "stimulus/webpack-helpers"
// import "@hotwired/turbo-rails"
// import "./controllers"
require("@rails/ujs").start()
require("@rails/activestorage").start()
// require("xendit-node")({ secretKey: 'xnd_development_CR8zuvQNsxtbWNV9fIEHfNWLt3S0alC5X27AZWYbIudvkPill0oIZzQDKPTbM4' });

import "bootstrap"
import "../stylesheets/application"

var jQuery = require('jquery')
global.$ = global.jQuery = jQuery;
window.$ = window.jQuery = jQuery;

import fileUpload from './fileUpload.js'
import fileMultiUpload from './fileMultiUpload.js'

import "pc-bootstrap4-datetimepicker"
import "jquery-ui"

import "./main.js"
import "./custom.js"
// import "./vendor/apexcharts/apexcharts.min.js"
// import "./vendor/bootstrap/js/bootstrap.bundle.min.js"
// import "./vendor/chart/chart.min.js"
// import "./vendor/echarts/echarts.min.js"
// import "./vendor/quill/quill.min.js"
import "./vendor/simple-datatables/simple-datatables.js"
// import "./vendor/tinymce/tinymce.min.js"
import "./vendor/php-email-form/validate.js"
import "./vendor/daterangepicker/daterangepicker.js"
// import "./vendor/bootstrap-datepicker/dist/js/bootstrap-datepicker.min.js"
// import "./vendor/jquery-ui-datepicker/jquery-ui-datepicker.js"

import "./general-image.js"
import "./user.js"
import "./event.js"
import "./cart.js"
import "./checkout.js"
import "./qr-code-generator.js"

document.addEventListener('DOMContentLoaded', () => {
  // FOR UPLOAD SINGLE IMAGE
  document.querySelectorAll('.upload-file').forEach(fileInput => {
    fileUpload(fileInput);
  })

  // FOR UPLOAD MULTIPLE IMAGES
  document.querySelectorAll('.upload-multi-file').forEach(fileInput => {
    fileMultiUpload(fileInput);
  })
})
