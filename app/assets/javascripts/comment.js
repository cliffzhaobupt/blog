function generateLiLinkCode (linkto, text) {
  return [
    '<li><a href="javascript:void(0)" data-page="',
    String(linkto),
    '">',
    String(text),
    '</a></li>'
  ].join('');
}

function generatePageLiSetCode (currentPage, pageCount) {
  var liSetArr = [];
  if (currentPage == 1) {
    liSetArr.push([
      '<li>前へ</li>',
      '<li class="current-page">1</li>'
      ].join(''));
  } else {
    liSetArr.push(generateLiLinkCode(currentPage - 1, '前へ'));
    liSetArr.push(generateLiLinkCode(1, 1));
  }
  for (var i = 2 ; i <= pageCount ; i ++) {
    if (i == currentPage) {
      liSetArr.push('<li class="current-page">' + i + '</li>');
    } else {
      liSetArr.push(generateLiLinkCode(i, i));
    }
  }
  if (currentPage == pageCount) {
    liSetArr.push([
      '<li>次へ</li>',
      '<li>合計' + pageCount + 'ページ</li>'
      ].join(''));
  } else {
    liSetArr.push(generateLiLinkCode(parseInt(currentPage) + 1, '次へ'));
    liSetArr.push('<li>合計' + pageCount + 'ページ</li>');
  }
  return liSetArr.join('');
}

$('document').ready(function () {
  var articleId = $('.comment-area-wrapper').attr('data-article-id'),
    commentArea = $('.blog-bottom-wrapper').get(0);
  if (! articleId) return;
  var commentTempl = [
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
      var commentList = $('.comment-list'),
        commentPagination = $('.comment-pagination');
      commentList.append(Mustache.render(commentTempl, data));
      var pageCount = data.page_count;
      commentPagination
        .append(generatePageLiSetCode(1, pageCount))
        .delegate('li a', 'click', function (e) {
          var nextPage = $(e.currentTarget).attr('data-page');
          $.get('/comment/getcomments', {
            'id': articleId,
            'page': nextPage
          }, function (data) {
            commentList
              .empty()
              .append(Mustache.render(commentTempl, data));
            commentPagination
              .empty()
              .append(generatePageLiSetCode(nextPage, data.page_count));
            commentArea.scrollIntoView();
          });
        });
    }
  });
});