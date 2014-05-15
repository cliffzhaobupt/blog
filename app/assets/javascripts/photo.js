$(document).ready(function () {
  // add new upload photo field
  $('.add-field-btn').bind('click', function (e) {
    e.preventDefault();

    var newIndex = $('.photo-select-fields .photo-field').length + 1,
      newFieldHtml = [
        '<li class="photo-field">',
        '<label for="photo', newIndex, '">画像 ', newIndex, '</label>',
        '<input type="file" name="photos[photo', newIndex,
        ']" id="photo', newIndex, '"/>',
        '</li>'
      ].join('');

    $('.photo-select-fields').append(newFieldHtml);
  });

  // ajax upload
  var introFieldsTempl = [
    '{{#just_add}}',
    '<li class="intro-field">',
    '<img src="/photos/getthumbnail?id={{id}}"/>',
    '<textarea data-photo-id="{{id}}" name="intros[{{id}}]">{{intro}}</textarea>',
    '</li>',
    '{{/just_add}}'
  ].join(''),
    loadingWrapper = $('.loading-wrapper')
  $('.photo-form').bind('submit', function (e) {
    e.preventDefault();

    $(this).ajaxSubmit({
      beforeSend: function () {
        $('.upload-btn').attr('disabled', true).addClass('disabled-btn');
        loadingWrapper.removeClass('loading-hide');
      },
      success: function (data) {
        $('.intro-update-btn').removeClass('button-hide');
        loadingWrapper.addClass('loading-hide');
        $('.intro-fields-wrapper').append(Mustache.render(introFieldsTempl, data));
        $('.intro-field').bind('mouseenter', function (e) {
          var target = $(e.currentTarget),
            textarea = target.find('textarea').get(0);
          textarea.select();
        });
      }
    });
  });

  // click photo and show pop-up
  var originalPhotoTag = $('.original-photo-wrapper img'),
    originalPhotoPopup = $('.original-photo-popup');
  $('.photo-wrapper a').bind('click', function (e) {
    e.stopPropagation();
    var target = $(e.currentTarget);
    originalPhotoTag.attr('src', target.attr('data-origin-url'));
    originalPhotoPopup.fadeIn(500);
  });

  originalPhotoPopup.bind('click', function (e) {
    e.stopPropagation();
  });

  $('body').bind('click', function (e) {
    originalPhotoPopup.fadeOut(500);
  });
});