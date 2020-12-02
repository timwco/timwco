// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// Favicon JS
const favicon_images = [
  'favicons/fav1.png',
  'favicons/fav2.png',
  'favicons/fav3.png',
  'favicons/fav4.png',
];
    
let image_counter = 0; // To keep track of the current image

setInterval(function() {
  // remove current favicon
  if(document.querySelector("link[rel='icon']") !== null)
      document.querySelector("link[rel='icon']").remove();
  if(document.querySelector("link[rel='shortcut icon']") !== null)
      document.querySelector("link[rel='shortcut icon']").remove();
      
  // add new favicon image
  document.querySelector("head").insertAdjacentHTML('beforeend', '<link rel="icon" href="' + favicon_images[image_counter] + '" type="image/png">');
  
  // If last image then goto first image
  // Else go to next image    
  if(image_counter == favicon_images.length -1)
      image_counter = 0;
  else
      image_counter++;
}, 1000);

