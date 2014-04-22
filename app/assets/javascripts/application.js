// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

function addOrRemoveErrorMsg (isAdd, target, errorClass, errorMsg, callback) {
    var inputField = target.parent();
    if (isAdd) {
        if (! inputField.children('.' + errorClass).get(0)) {
            inputField.append([
                '<p class="error-msg ',
                errorClass,
                '">',
                errorMsg,
                "</p>"
                ].join(''));
        }
        if (callback) {
            callback();
        }
    } else {
        if (inputField.children('.' + errorClass).get(0)) {
            inputField.children('.' + errorClass).remove();
        }
    }
}

function addServerSideErrorMsg (target, errorClass, errorMsg) {
    var inputField = target.parent();
    if (! inputField.children('.' + errorClass).get(0)) {
        inputField.append([
            '<p class="error-msg server-side-error ',
                errorClass,
                '">',
                errorMsg,
                "</p>"
            ].join(''));
    }
}

function removeServerSideErrorMsg (target) {
    var inputField = target.parent();
    inputField.children('.server-side-error').each(function () {
        $(this).remove();
    });
}

$(document).ready(function(){
    //Log-in Button
    $('.user-admin').delegate('.J_LogInBtn', 'click', function (e) {
        $('.J_LoginPopup').show().find('#username').focus();
    //Sign-up Button
    }).delegate('.J_SignUpBtn', 'click', function () {
        $('.J_SignupPopup').show().find('#su-username').focus();
    //Log-out Button
    }).delegate('.J_LogOutBtn', 'click', function () {
        $.get('/user/logout.html', function () {
            location.reload(true);
        });
    });

    //Blur Tips for text and password inputs
    // $('.pop-up input[type=text], .pop-up input[type=password]').bind('blur', function (e) {
    //     var target = $(e.currentTarget);
    //     addOrRemoveErrorMsg(! target.val(), target, 'must-enter', '入力必須項目です。');
    // });

    // //Blur Tips for password reenter
    // $('#su-password-re').bind('blur', function (e) {
    //     var target = $(e.currentTarget);
    //     //Pay attention to 'target.parents('form').find('#password').val()'
    //     addOrRemoveErrorMsg(target.val() != target.parents('form').find('#su-password').val(), target, 'diff-password', '二つのパースワードは一致していません。');
    // });

    // //Blur Tips for email
    // $('#email').bind('blur', function (e) {
    //     var target = $(e.currentTarget),
    //         emailVal = target.val();
    //     if (emailVal.length > 0) {
    //         addOrRemoveErrorMsg(! /^[a-z0-9_+.-]+\@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/i.test(emailVal),
    //             target, 'invalid-email', '有効なE-mailを入力してください。');
    //     }
    // });

    // //Blur Tips for select input
    // $('.pop-up select').bind('blur', function (e) {
    //     var target = $(e.currentTarget);
    //     addOrRemoveErrorMsg(target.val() == 'none', target, 'must-enter', '入力必須項目です。');
    // });

    //Close Popup Button
    $('.J_ClosePopup').bind('click', function (e) {
        $(e.currentTarget).parents('.pop-up').hide();
    });

    //Sign up form check
    $('.J_SignUpForm').bind('submit', function (e) {
        var form = $(e.currentTarget),
            willSubmit = true;
        //Check fill out all the text fields
        form.find('input').each(function () {
            var target = $(this);
            willSubmit = willSubmit && target.val();
            addOrRemoveErrorMsg(! target.val(), target, 'must-enter', '入力必須項目です。');
        });
        //Check passwords r the same
        if (form.find('#su-password').val() != form.find('#su-password-re').val()) {
            willSubmit = false;
            if (! form.find('.diff-password').get(0)) {
                form.find('#su-password-re').parent().append('<p class="error-msg diff-password">二つのパースワードは一致していません。</p>');
            }
        } else {
            if (form.find('.diff-password').get(0)) {
                form.find('.diff-password').remove();
            }
        }
        //Check invalid email address
        var emailInput = form.find('#email'),
            emailVal = emailInput.val();
        if (emailVal.length > 0) {
            addOrRemoveErrorMsg(! /^[a-z0-9_+.-]+\@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/i.test(emailVal),
                emailInput, 'invalid-email', '有効なE-mailを入力してください。', function () {
                    willSubmit = false;
                });
        }
        //Check fill out the select fields
        var genderSelect = form.find('#gender');
        addOrRemoveErrorMsg(genderSelect.val() == 'none', genderSelect, 'must-enter', '入力必須項目です。', function () {
            willSubmit = false;
        });

        //If all the fields r valid, submit the form
        if (willSubmit) {
            $.post('/user/new.html', {
                username: form.find('#su-username').val(),
                password: form.find('#su-password').val(),
                email: form.find('#email').val(),
                gender: form.find('#gender').val()
            }, function (data) {
                //Successfully sign-up, remove server side error messages
                //then, refresh current page - use reload(true)
                if (data.success) {
                    form.find('[type=text], [type=password], select').each(function () {
                        removeServerSideErrorMsg($(this));
                    });
                    location.reload(true);
                //Unseccessfully log-in, display server side error message
                } else {
                    addServerSideErrorMsg(form.find('#su-username'), 'already-have', '同じのIDが存在しています。');
                }
            });
        }
        e.preventDefault();
    });

    //Login form check
    $('.J_LogInForm').bind('submit', function (e) {
        var form = $(e.currentTarget),
            willSubmit = true;
        form.find('input').each(function () {
            var target = $(this);
            willSubmit = willSubmit && target.val();
            addOrRemoveErrorMsg(! target.val(), target, 'must-enter', '入力必須項目です。');
        });

        if (willSubmit) {
            var usernameInput = form.find('#username'),
                passwordInput = form.find('#password');
            $.get('/user/login.html', {
                username: usernameInput.val(),
                password: passwordInput.val()
            }, function (data) {
                //Successfully log-in, remove server side error messages
                //then, refresh current page - use reload(true)
                if (data.success) {
                    removeServerSideErrorMsg(passwordInput);
                    location.reload(true);
                //Unseccessfully log-in, display server side error message
                } else {
                    addServerSideErrorMsg(passwordInput, 'invalid-login', data.message);
                    
                }
            });
        }
        e.preventDefault();
    });
});
