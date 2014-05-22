## Introduction

Blog Excercise

## Week 1

### Sign up
<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/signup.png"/>

Click sign up button, enter personal information and sign up. After signing up, return to the current page with logged-in state.

### Log in
<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/login.png"/>

Click log in button, enter username and password, then log in. After logging in, return to the current page with logged-in state.

### Log out
<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/logout.png"/>
In logged-in state, click log out button, return to the current page with logged-out state

### Blog list page front end development

After clone, please execute <tt>rake db:migrate</tt> and <tt>rake db:seed</tt>

Please check these function by browse <tt>http://0.0.0.0:3000/blog/listbyuser</tt>

## Week 2

### User List Page
To browse this page's sample: <tt>http://0.0.0.0:3000/user/index</tt>

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/index.png"/>

Finish client side and server side development, including pagination.

User could select one user and enter his blog list page.

TODO: in the sign-up part, did not add upload user image function, will do this part later.

### Blog List Page
To browse this page's sample: <tt>http://0.0.0.0:3000/blog/listbyuser?id=1</tt>

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/bloglist.png"/>

Finish client side and server side development, including pagination.
User could select one article and enter the article detail page.

TODO: considering change the pagination part into AJAX...

### Article Detail Page
To browse this page's sample: <tt>http://0.0.0.0:3000/blog/articledetail?id=1</tt>

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/articledetail.png"/>

Finish part of the client side and part of the server side development.

TODO: ajax pagination of the comments / add comment

## Week 3

### Comment Pagination / Add Comment
The GIF may take a little while to load.... Sorry.

In the GIF, at first, browse <tt>http://0.0.0:3000</tt>, then select one blog user to enter his article list, and then enter the detail page of one article. In this page, user can get comment list by page and post comment.

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/comment.gif"/>

Use AJAX to get comment list of the certain article, do pagination, and add new comment to that page.

User needs to log-in before post new comment.

### Post New Blog
The GIF may take a little while to load.... Sorry.

In the GIF, at first, browse any page, then click "ログイン" button, log-in, and after log-in, click "新規ブログ"　button, add new blog article. In this page, user can add tag, select a certain tag, and edit new blog.

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/addblog.gif"/>

Use AJAX to load tags of the user, and add new tags.

The editor part use [Cleditor](http://premiumsoftware.net/CLEditor) javascript plugin.

### Upload User Image
GIF may take a little while to load.... Sorry.

In the GIF, at first, browse <tt>http://0.0.0:3000</tt>, then click "登録" button, fill in all the fields, select photo to upload, and press "無料登録" button. As a result, new user with image is created.

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/uploadphoto.gif"/>

To check this function, you may need to pull the branch of <tt>photoupload</tt>, and you'd better execute these  after pulling this branch.

```
rake db:migrate VERSION=0
rake db:migrate
rake db:seed
```

Also, u need to install [ImageMagick](http://www.imagemagick.org/script/binary-releases.php) in your system.

In the upload part, user's photo is resized into 2 sizes. One is used as the photo in index, blog list, and article detail page. While, the other one is used as the smaller photo in the comment posted by this user.


## Week 4

To check the functions realized this week, you need to pull the branch called <tt>photoalbum</tt>.

Also, you need to install [ImageMagick](http://www.imagemagick.org/script/binary-releases.php) in your system.

### Edit and Delete Blog Article

In the GIF, at first, the user logs in. And then, click "ブログ一覧" link to go to blog list page of currently logged-in user. At this page, the "編集" and "削除" button will appear when the user's mouse enters the area of one article. Also, at the article detail page, user will see those two buttons. By clicking those buttons, user can edit and delete corresponding blog articles.

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/articleeditdelete.gif"/>

After edit, user will be redirected to the detail page of current article.

After delete, user will be redirected to the article list page.

### Photo Album Page

In the GIF, at first, browse <tt>http://0.0.0:3000</tt>. And then, user selects one user. In the blog list page, by clicking "画像アルバム" link, user enters the photo album of the blog user. 

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/photolist.gif"/>

Click thumbnails in album page, the corresponding original photo will pop-up.

Click area outside the pop-up, the pop-up will be closed.

### Upload Pictures to Photo Album

In the GIF, at first, the user logs in. And then, click "画像アプロード" link to go to the album upload page. And then, the user selects photos to be uploaded. After selecting, he clicks "アプロード開始" button. Wait a minute, user can edit the introduction of each photo. After editing, he click the "画像紹介を更新する" button to save his edit.

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/uploadphotoalbum.gif"/>

After saving the edit of photo introduction, user will be redirected to his photo album page.

TODO: add validations

## Week 5

To check the functions realized this week, you need to pull the branch called <tt>photoalbum</tt>.

### Article List of Tags

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/taglist.gif"/>

User can browse article list of a certain tag by click the tag link in the left part of the web page or the tag link under one article title.

### Photo Album Page Improvement

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/improvephotoalbum.gif"/>

User can browse more photos by click the button called "もっと見る" at the bottom of photo album page.

User can move to the previous or next photo by click the buttons besides the pop-up of original photo.

### Photo Album Management

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/photomanagement.gif"/>

When the user browse his own photo album page, after log-in, he can delete photos and change introduction of photos.

By click the icon at the top left corner of the photo, user can mark this photo for deleting it later. Click for the second time, user can cancel this mark.

By change the content in textareas under the photo, user can later change the introduction of photos.

After marking photos and change content in textareas, user could click "編集を保存する" button to save his changes.

### Upload Photos in Blog Article

<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/uploadphotoinblog.gif"/>

When user editting blog article, he can click the link of adding photo, and then select one local photo and update it to the server. After being updated, the photo is appended into the current article.