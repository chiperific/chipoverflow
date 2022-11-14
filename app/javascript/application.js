// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"

// global blank link click event preventer
document.querySelectorAll("a[href='#']").forEach((link) => {
  link.addEventListener('click', function() {
    event.preventDefault();
  });
});
