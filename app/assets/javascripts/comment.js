$('document').ready(function () {
  var articleId = $('.comment-area-wrapper').attr('data-article-id'),
    commentTempl = [
      '{{#comments}}',
      '<li class="comment-item">',
      '<a class="user-small-logo" href="/blog/listbyuser?id={{arid}}">',
      '<img src="/assets/cliff_small.jpg"></a>',
      '<div class="comment-info">',
      '<h4 class="comment-title">{{time}} ',
      '<a href="/blog/listbyuser?id={{arid}}">{{username}}</a></h4>',
      '<p class="comment-content">{{content}}</p>',
      '</div></li>',
      '{{/comments}}'
    ].join('');

  $.get('/comment/getcomments',{
    'id': articleId
  }, function (data) {
    var comments = data.comments;
    if (comments.length > 0) {
      $('.comment-list').append(Mustache.render(commentTempl, data));
    }
  });
});