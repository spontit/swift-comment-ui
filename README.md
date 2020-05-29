# Swift Comment UI
A Comment UI for Swift

## About
The swift comment UI is a simple program that can display users' comments in a table view. With the "like" and "reply" button you can like or reply to a comment. When typing a reply, the followers table will show up after "@" is typed to help you select friends or followers you want to tag. The tagged users will automatically set to bold in the text view. You can also delete the comment sent by yourself by simply swiping left.

<p align="center">
    <img src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1323.PNG" /> 
    <img src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1326.PNG" /> 
    <img src="https://github.com/spontit/swift-comment-ui/raw/master/ScreenShots/IMG_1327.PNG" /> 
</p>

## How to use
To use this, you need to integrate with your own comment and like server. I have marked at where the servers need to be integrated. The servers you can integrate are:

- Get-comments server: load all the comments to the table
- Add-comment-like server: increment the like count of the comment
- Remove-comment-like server: decrement the like count of the comment
- Add-comment server: add a new comment to the server
- Remove-comment server: delete the comment from server
- View profile from comment: view the user profile by tapping the profile image
- View profile from tag: view the user profile by tapping the tagged user in the comment text.
