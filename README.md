# Swift Comment UI
A Comment UI for Swift

##
Built by Qiuhao Zhang, a Software Developer at Spontit. Check out the Spontit API for sending your own push notifications <a href="https://github.com/spontit/spontit-api-python-wrapper">here</a>.

## About
This repository is a pre-built comment section UI developed in Swift. You can comment in a thread with others. A "Like" and "Reply" button on each comment allows you to like or reply to a comment. When tagging a friend, simply press "Reply" on a comment or type "@" to select from a list of friends. Bold font indicates a tagged user. You can also delete one of your comments by simply swiping left.

<p align="center">
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1323.PNG" /> 
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1326.PNG" /> 
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1327.PNG" /> 
</p>

## Test it Out
You can build the UI and run on an iOS simulator as is to test it out. View the comment UI Swift files <a href="https://github.com/spontit/swift-comment-ui/tree/master/SwiftCommentUI">here</a>. 

## Integrate

To integrate the UI with your server, see the markers "MARK:- TODO", which is outlined below.

Command + F "MARK:- TODO" in the <a href="https://github.com/spontit/swift-comment-ui/blob/master/SwiftCommentUI/ViewController.swift">ViewController.swift</a> file to see where to customize the following parts.
- Get comments: load all the comments to the table
- View profile from comment: view the user profile by tapping the profile image
- View profile from tag: view the user profile by tapping the tagged user in the comment text.
- Like a comment: increment the like count of the comment
- Remove a like from a comment: decrement the like count of the comment
- Add a comment: add a new comment to the server
- Delete a comment: delete the comment from server