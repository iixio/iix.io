if (/windows/i.test(navigator.userAgent)) {
  document.getElementsByTagName('html')[0].className = 'windows';
}

var fastlink = require('fastlink');
var social = require('social');
var query = require('query');
require('ganalystics');

fastlink.on('page:visit', function() {
  document.body.className = 'page-loading';
});
fastlink.on('page:change', function() {
  document.body.className = '';

  // lazy load image
  lazyimg(query.all('.entry-content img'));

  // enable social widget
  var el = query('.social-button');
  if (el) social(el);
  // enable github cards
  gitcards();
  disqus();

  if (location.port) return;
  weixin();
  ga('send', 'pageview', {
    page: location.pathname,
    location: location.href,
    title: pureTitle() || document.title
  });
});


function pureTitle() {
  var el = document.querySelector('meta[property="og:title"]');
  if (el) {
    return el.content;
  }
}

function weixin() {
  // change title for weixin
  if (/MicroMessenger/i.test(navigator.userAgent) && document.querySelector) {
    var title = pureTitle();
    if (title) {
      document.title = title;
    }
  }
}

function use(link, name) {
  var tag;
  if (/\.js$/.test(link)) {
    tag = 'script';
  } else {
    tag = 'link';
  }

  var d=document, s=d.createElement(tag), f=d.getElementsByTagName(tag)[0];
  if (tag==='link') {
    s.href=link;
    s.rel='stylesheet';
  } else {
    s.src=link;
    s.async=true;
  }
  f.parentNode.insertBefore(s,f);
  return s;
}

function lazyimg(images) {
  if (images.length) {
    for (var i = 0; i < images.length; i++) {
      var src = images[i].getAttribute('data-src');
      if (src) images[i].src = src;
    }
  }
}
