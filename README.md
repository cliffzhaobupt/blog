== Introduction

Blog Excercise

== Week 1

* Sign up
<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/signup.png"/>

Click sign up button, enter personal information and sign up. After signing up, return to the current page with logged-in state.

* Log in
<img src="https://github.com/cliffzhaobupt/blog/raw/master/sampleimg/login.png"/>

Click log in button, enter username and password, then log in. After logging in, return to the current page with logged-in state.

* Log out
In logged-in state, click log out button, return to the current page with logged-out state

* Blog list page front end development

After clone, please execute <tt>rake db:migrate</tt> and <tt>rake db:seed</tt>

Please check these function by browse <tt>http://0.0.0.0:3000/blog/listbyuser</tt>

== Week 2

* User List Page
<tt>http://0.0.0.0:3000/user/index</tt>

Finish client side and server side development, including pagination.

User could select one user and enter his blog list page.

Todo: in the sign-up part, did not add upload user image function, will do this part later.

* Blog List Page
<tt>http://0.0.0.0:3000/blog/listbyuser?id=1</tt>

Finish client side and server side development, including pagination.
User could select one article and enter the article detail page.

Todo: considering change the pagination part into AJAX...

* Article Detail Page
<tt>http://0.0.0.0:3000/blog/articledetail?id=1</tt>

Finish part of the client side and part of the server side development.

Todo: ajax pagination of the comments / add comment
