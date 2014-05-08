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
