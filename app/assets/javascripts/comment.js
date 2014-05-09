// Generate the code like <li><a ...>1</a></li>
function generateLiLinkCode (linkto, text) {
  return [
    '<li><a href="javascript:void(0)" data-page="',
    String(linkto),
    '">',
    String(text),
    '</a></li>'
  ].join('');
}

// Generate the code of <li> in the comment pagination
function generatePageLiSetCode (currentPage, pageCount) {
  var liSetArr = [];
  if (currentPage == 1) {
    liSetArr.push([
      '<li>前へ</li>',
      '<li class="current-page">1</li>'
      ].join(''));
  } else {
    liSetArr.push(generateLiLinkCode(parseInt(currentPage) - 1, '前へ'));
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
    commentArea = $('.blog-bottom-wrapper').get(0),
    loadingIcon = $('.loading-wrapper');

  var commentList = $('.comment-list'),
    commentPagination = $('.comment-pagination');

  if (! articleId) return;
  var commentTempl = [
      '{{#comments}}',
      '<li class="comment-item">',
      '<a class="user-small-logo" href="/blogs/listbyuser?id={{userid}}">',
      '<img src="/users/small_photo?id={{userid}}"></a>',
      '<div class="comment-info">',
      '<h4 class="comment-title">{{time}} ',
      '<a href="/blogs/listbyuser?id={{userid}}">{{username}}</a></h4>',
      '<p class="comment-content">{{content}}</p>',
      '</div></li>',
      '{{/comments}}'
    ].join('');

  // When page being loaded, get comment list
  // and initialize the pagination
  $.ajax({
    type: 'GET',
    url: '/comments/getcomments',
    data: {
      'id': articleId
    },
    success: function (data) {
      loadingIcon.hide();
      var comments = data.comments;
      if (comments.length > 0) {
        // Display the comment list
        commentList.append(Mustache.render(commentTempl, data));
        var pageCount = data.page_count;
        // Initialize the pagination
        commentPagination
        .append(generatePageLiSetCode(1, pageCount))
          // Pagination click event handler
        .delegate('li a', 'click', function (e) {  
          var nextPage = $(e.currentTarget).attr('data-page');
          $.ajax({
            type: 'GET',
            url: '/comments/getcomments',
            data: {
              'id': articleId,
              'page': nextPage
            },
            beforeSend: function () {
              commentList.empty()
              loadingIcon.show();
            },
            success: function (data) {
              loadingIcon.hide();
              commentList.append(Mustache.render(commentTempl, data));
              commentPagination
                .empty()
                .append(generatePageLiSetCode(nextPage, data.page_count));
              commentArea.scrollIntoView();
            }
          });
        });
      }
    }
  });

  // Add comment event handler
  $('.button-wrapper button').bind('click', function (e) {
    var target = $(e.currentTarget),
      textArea = $('.comment-textarea');
    if (! target.attr('data-login-id')) {
      $('.J_LogInBtn').trigger('click');
    } else {
      $.ajax({
        type: 'POST',
        url: '/comments/new',
        data: {
          'content': textArea.val(),
          'login_id': target.attr('data-login-id'),
          'article_id': articleId
        },
        beforeSend: function () {
          commentList.empty()
          loadingIcon.show();
        },
        success: function (data) {
          loadingIcon.hide();
          textArea.val('');
          commentList.append(Mustache.render(commentTempl, data));
          commentPagination
            .empty()
            .append(generatePageLiSetCode(data.page_count, data.page_count));
          commentArea.scrollIntoView();
        }
      });
    }
  });
});