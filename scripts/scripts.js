window.addEventListener('load', function () {
    // Add the loaded class to the body to hide the loader
    document.body.classList.add('loaded');
});

$('.grid').masonry({
// options
itemSelector: '.grid-item',
columnWidth: 200
});