window.addEventListener('load', function () {
    // Hide the loader after the page fully loads
    const loaderElement = document.getElementById('gen_loader');
    if (loaderElement) {
      loaderElement.style.display = 'none';  // Hides the loader
    }
  });
  

// $('.grid').masonry({
// // options
// itemSelector: '.grid-item',
// columnWidth: 200
// });

var grid = document.querySelector('.grid');
var msnry;

// Initialize Masonry after all images have loaded
imagesLoaded(grid, function () {
  msnry = new Masonry(grid, {
    itemSelector: '.grid-item',
    percentPosition: true,
    columnWidth: 80
  });
});
