$(document).ready(function () {
  var articleTextarea = $('.article-field textarea');

  if (! articleTextarea.get(0)) return;

  var tagField = $('.tag-field'),
    tagLoading = $('.J_TagLoading'),
    userId = tagField.attr('data-user-id'),
    tagIdHiddenField = $('.J_TagId'),
    spanListTempl = [
      '{{#tags}}',
      '<span class="tag" data-tag-id="{{id}}">',
      '{{name}}',
      '</span>',
      '{{/tags}}'
    ].join(''),
    clearTagsAndShowLoading = function () {
      tagLoading.show();
      tagField.empty();
    },
    updateTags = function (data) {
      if (! data.success) return;
      tagLoading.hide();
      tagField.append(Mustache.render(spanListTempl, data)
        + '<input class="add-tag-field" type="text"/>'
        + '<span class="tag add-tag">+</span>');
    };
   
    $.ajax({
      type: 'GET',
      url: '/tag/get',
      data: {
        'id': userId
      },
      beforeSend: clearTagsAndShowLoading,
      success: updateTags
    });

  tagField.delegate('.tag', 'click', function (e) {
    var target = $(e.currentTarget);
    if (target.hasClass('add-tag')) {
      $.ajax({
        type: 'POST',
        url: '/tag/add',
        data: {
          'id': userId,
          'name': $('.add-tag-field').val()
        },
        beforeSend: clearTagsAndShowLoading,
        success: updateTags
      });
    } else {
      $('.tag').each(function (index, oneTag) {
        $(oneTag).removeClass('selected');
      });
      target.addClass('selected');
      tagIdHiddenField.val(target.attr('data-tag-id'));
    }
  });

  articleTextarea.cleditor();
});