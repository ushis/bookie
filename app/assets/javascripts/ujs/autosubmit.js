(function(Rails) {
  'use strict';

  Rails.delegate(document, 'input[data-autosubmit]', 'change', function(e) {
    var element = e.target;
    var selector = element.dataset.autosubmit;

    while (element instanceof Element && !Rails.matches(element, selector)) {
      element = element.parentNode;
    }

    if (element instanceof Element) {
      element.submit();
    }
  });
}).call(this, window.Rails);
