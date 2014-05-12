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
      if(tagIdHiddenField.val()) {
        $('[data-tag-id=\'' + tagIdHiddenField.val() + '\']').addClass('selected')
      }
    };
   
    $.ajax({
      type: 'GET',
      url: '/tags/get',
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
        url: '/tags/add',
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
  }).delegate('.add-tag-field', 'keydown', function (e) {
    if (e.keyCode == 13) {
      $('.add-tag').trigger('click')
    }
  });

  articleTextarea.cleditor({
    'height': 500
  });

  $('.new-article-form').bind('submit', function (e) {
    var couldSubmit = true;
    $('.must-have').each(function (index, currentField) {
      currentField = $(currentField);
      var fieldVal = currentField.val();
      if (fieldVal == '' || /^\s+$/.test(fieldVal)) {
        var currentLabel = currentField.parents('.article-field').find('label');
        if (! currentLabel.find('em').get(0)) {
          currentLabel.append('<em>空いたらだめなんですが...</em>');          
        }
        couldSubmit = false;
      }
    });
    if (! couldSubmit) {
      e.preventDefault();
    }
  });
});