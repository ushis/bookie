(function(Rails) {
  'use strict';

  Rails.delegate(document, '[data-toggle]', 'click', function(e) {
    var element = e.target;
    var toggleClass = element.dataset.toggle;
    var targetSelector = element.dataset.target;

    Rails.$(targetSelector).forEach(function(target) {
      target.classList.toggle(toggleClass);
    });
  });
}).call(this, window.Rails);
