# Swift Comment UI
A Comment UI for Swift

##
Built by Qiuhao Zhang, a Software Developer at Spontit. Check out the Spontit API for sending your own push notifications <a href="https://github.com/spontit/spontit-api-python-wrapper">here</a>.

## About
The swift comment UI is a simple program that can display users' comments in a table view. With the "like" and "reply" button you can like or reply to a comment. When typing a reply, the followers table will show up after "@" is typed to help you select friends or followers you want to tag. The tagged users will automatically set to bold in the text view. You can also delete the comment sent by yourself by simply swiping left.

<p align="center">
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1323.PNG" /> 
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1326.PNG" /> 
    <img width=200 src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1327.PNG" /> 
</p>

## Test it Out and Integrate
You can build the UI and run on an iOS simulator as is to test it out. View the comment UI Swift files <a href="https://github.com/spontit/swift-comment-ui/tree/master/SwiftCommentUI">here</a>. 

To integrate the UI with your server, see the markers "MARK:- TODO", which is outlined below.

Command + F "MARK:- TODO" in the <a href="https://github.com/spontit/swift-comment-ui/blob/master/SwiftCommentUI/ViewController.swift">ViewController.swift</a> file to see where to customize the following parts.
- Get-comments server: load all the comments to the table
- View profile from comment: view the user profile by tapping the profile image
- View profile from tag: view the user profile by tapping the tagged user in the comment text.
- Add-comment-like server: increment the like count of the comment
- Remove-comment-like server: decrement the like count of the comment
- Add-comment server: add a new comment to the server
- Remove-comment server: delete the comment from server