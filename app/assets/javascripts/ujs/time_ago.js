(function(Rails) {
  'use strict';

  document.addEventListener('DOMContentLoaded', function() {
    Rails.$('[data-time-ago]').forEach(function(element) {
      var dateTime = moment(element.dataset.timeAgo);
      element.title = dateTime.format('LLL');
      element.innerText = dateTime.fromNow();
    });
  });
}).call(this, window.Rails)
