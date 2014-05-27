$('document').ready(function () {
  //click reply button
  var commentTextarea = $('.add-message-textarea'),
    replyToHiddenField = $('.reply-to-hidden-field'),
    replyBox = $('.reply-box'),
    contentReplyTo = $('.content-reply-to'),
    replyIntro = $('.reply-intro');
  $('body').delegate('.reply-btn', 'click', function (e) {
    var target = $(e.currentTarget),
      messageInfoWrapper = target.siblings('.message-info');
    replyBox.addClass('visible-reply-box');
    contentReplyTo.html(
      messageInfoWrapper.children('.message-content').html());
    replyIntro.text(
      messageInfoWrapper.children('.message-author-time').text());
    replyToHiddenField.val(target.attr('data-reply-to-id'));
    commentTextarea.get(0).focus();
    document.body.scrollTop = 0;
  });

  //click reply cancel button
  $('.reply-cancel-btn').bind('click', function (e) {
    replyToHiddenField.val('');
    replyBox.removeClass('visible-reply-box');
  });

  //click load more message button
  var messageListWrapper = $('.message-list');
  $('.load-more-message-btn').bind('click', function (e) {
    var target = $(e.currentTarget);
    if (target.hasClass('disabled-load-message-btn')) return;

    var currentPage = parseInt(messageListWrapper.attr('data-current-page')),
      pageCount = parseInt(messageListWrapper.attr('data-page-count')),
      receiverId = messageListWrapper.attr('data-receiver-id');
    currentPage ++;
    messageListWrapper.attr('data-current-page', currentPage);
    if (currentPage >= pageCount) {
      target.addClass('disabled-load-message-btn');
    }

    $.ajax({
      method: 'get',
      url: '/messages/list',
      data: {
        id: receiverId,
        onlymessage: 'true',
        page: currentPage
      },
      success: function (data) {
        var messageWrapperFromServer = $(data);
        messageListWrapper.append(messageWrapperFromServer.html());
      }
    });
  });
});