function initImgChangeBtns (currentIndex, popUp, prevBtn, nextBtn) {
  currentIndex = parseInt(currentIndex);
  popUp.attr('data-index', currentIndex);
  var prevPhotoLinkTag = $('.photo-column [data-index=' + (currentIndex - 1) + ']'),
    nextPhotoLinkTag = $('.photo-column [data-index=' + (currentIndex + 1) + ']');

  if (prevPhotoLinkTag.get(0)) {
    prevBtn
      .removeClass('button-hide')
      .attr({
        'data-origin-url': prevPhotoLinkTag.attr('data-origin-url'),
        'data-index': currentIndex - 1
      });
  } else {
    prevBtn.addClass('button-hide');
  }
    
  if (nextPhotoLinkTag.get(0)) {
    nextBtn
      .removeClass('button-hide')
      .attr({
        'data-origin-url': nextPhotoLinkTag.attr('data-origin-url'),
        'data-index': currentIndex + 1
      });
  } else {
    nextBtn.addClass('button-hide');
  }
}

function pushOrDelete (array, element) {
  for (var i = 0, len = array.length ; i < len ; i ++) {
    if (array[i] == element) {
      array.splice(i ,1);
      return;
    }
  }
  array.push(element);
}

$(document).ready(function () {
  // add new upload photo field
  $('.add-field-btn').bind('click', function (e) {
    e.preventDefault();

    var newIndex = $('.photo-select-fields .photo-field').length + 1,
      newFieldHtml = [
        '<li class="photo-field">',
        '<label for="photo', newIndex, '">画像 ', newIndex, '</label>',
        '<input type="file" class="photo-file-input" accept="image/*" name="photos[photo', newIndex,
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

    var couldSubmit = false;
    $('.photo-file-input').each(function (index, elem) {
      couldSubmit = elem.value || couldSubmit;
    });

    if (! couldSubmit) return;

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
    originalPhotoPopup = $('.original-photo-popup'),
    prevBtn = $('.prev-img-btn'),
    nextBtn = $('.next-img-btn');
  $('body').delegate('.photo-wrapper a', 'click', function (e) {
    e.stopPropagation();
    var target = $(e.currentTarget);

    initImgChangeBtns(target.attr('data-index'), originalPhotoPopup, prevBtn, nextBtn);

    originalPhotoTag.attr('src', target.attr('data-origin-url'));
    originalPhotoPopup.css('top',
      (document.body.scrollTop + 80) + 'px').fadeIn(500);
  }).delegate('.photo-wrapper a textarea', 'click', function (e) {
    e.stopPropagation();
  });

  // click areas outside the pop-up, the pop-up disappears
  originalPhotoPopup.bind('click', function (e) {
    e.stopPropagation();
  });

  $('body').bind('click', function (e) {
    originalPhotoPopup.fadeOut(500);
  });

  // click next and prev buttons in the popup to change photo
  $('.img-change-btn').bind('click', function (e) {
    var target = $(e.currentTarget);
    originalPhotoTag.attr('src', target.attr('data-origin-url'));
    initImgChangeBtns(target.attr('data-index'), originalPhotoPopup, prevBtn, nextBtn);
  });

  // click 'もっと見る' button and load more pics of current user
  $('.load-more-btn').bind('click', function (e) {
    var target = $(e.currentTarget),
      outsideDivWrapper = target.parents('.photo-list'),
      userId = outsideDivWrapper.attr('data-user-id'),
      currentPage = parseInt(outsideDivWrapper.attr('data-current-page')),
      pageCount = parseInt(outsideDivWrapper.attr('data-page-count'));

    if (currentPage < pageCount) {
      $.get('/photos/list.json', {
        id: userId,
        page: currentPage + 1
      }, function (data) {
        console.log(data);

        if (data.currentPage == data.pageCount) {
          target.addClass('disabled-btn').attr('disabled', true);
        }
        outsideDivWrapper.attr({
          'data-current-page': data.currentPage,
          'data-page-count': data.pageCount
        });

        $('.photo-column').each(function (index, column) {
          var photoWrappers = [],
            photoInfoArr = data.photoColumns['column_' + (index + 1)];
          for (var i = 0, len = photoInfoArr.length ; i < len ; i ++) {
            var photoInfo = photoInfoArr[i];
            if (data.couldEdit) {
              photoWrappers.push([
                '<li class="photo-wrapper">',
                '<img class="delete-radio" data-db-index="', photoInfo.id,
                '" title="削除する" src="/assets/delete.png"/>',
                '<a href="javascript:void(0)" data-index="', photoInfo.index,
                '" data-origin-url="/photos/getoriginal',
                '?id=', photoInfo.id, '">',
                '<img src="/photos/getthumbnail?id=', photoInfo.id, '"/>',
                '<textarea data-db-index="', photoInfo.id, '">',
                photoInfo.intro, '</textarea>',
                '</a>', '</li>'
                ].join(''));
            } else {
              photoWrappers.push([
                '<li class="photo-wrapper">',
                '<a href="javascript:void(0)" data-index="', photoInfo.index,
                '" data-origin-url="/photos/getoriginal',
                '?id=', photoInfo.id, '">',
                '<img src="/photos/getthumbnail?id=', photoInfo.id, '"/>',
                '<p>', photoInfo.intro, '</p>',
                '</a>', '</li>'
                ].join(''));  
            }
          }
          $(column).append(photoWrappers.join(''));
        });

      });
    }
  });

  // after editting photo's introduction
  var edittedIntros = {},
    edittedIntroCount = 0,
    edittedIntroCountEm = $('.edit-intro em');
  $('body').delegate('.photo-wrapper a textarea', 'change', function (e) {
    var target = $(e.currentTarget);
    if (! target.hasClass('editted-intro')) {
      target.addClass('editted-intro');
      edittedIntroCount ++;
    }
    edittedIntros[target.attr('data-db-index')] = target.val();
    edittedIntroCountEm.text(edittedIntroCount);
  });

  // after selecting photos to be deleted
  var deletePhotos = [],
    deletePhotoCountEm = $('.delete-photo em');
  $('body').delegate('.delete-radio', 'click', function (e) {
    var target = $(e.currentTarget),
      title = target.attr('title');
    target.parent().toggleClass('delete-later');
    target.attr('title', title == '削除する' ? '削除しません' : '削除する');
    pushOrDelete(deletePhotos, target.attr('data-db-index'));
    deletePhotoCountEm.text(deletePhotos.length);
  });

  // click save edit button
  $('.save-edit').bind('click', function (e) {
    target = $(e.currentTarget);
    if (edittedIntroCount == 0 && deletePhotos.length == 0) return;
    $.ajax({
      url: '/photos/editanddelete',
      type: 'post',
      data: {
        'intro': JSON.stringify(edittedIntros),
        'delete': JSON.stringify(deletePhotos)
      },
      beforeSend: function () {
        target.attr('disabled', true).addClass('disabled-btn');
      },
      success: function (data) {
        edittedIntros = {};
        console.log('success');
        location.reload(true);
      }
    });
  });
});