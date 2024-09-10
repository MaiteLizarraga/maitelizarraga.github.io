window.addEventListener('load', function () {
    // Add the loaded class to the body to hide the loader
    document.body.classList.add('loaded');
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
