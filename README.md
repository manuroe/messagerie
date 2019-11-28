# Messagerie
Messagerie is a chat app written for fun to evaluate SwiftUI for:
- performance: rendering a timeline of messages smoothly is often tricky. This required a significant amount of iterations with old good UITableViews to get it right. What about SwiftUI performance where a lot of things seems to happen magically?
- patterns to use. How to write a full SwiftUI app? SwiftUI is young. There are a lot of tutorials for small screens but less for an entire app.
- testing multi-OS development with Catalyst

# MessagerieUI
This subfolder in the codebase can become a library that offers UI components to render
By its seperation of concerns design, it is communication protocol agnostic. 
This may change in the future and may be more matrix-oriented but data models implementations will stay away from the UI.

# TODO
+ Matrix Login screen / Store account
+ Multi account
+ True image cache
- avatar: enum: letter + 2 urls preview
+ scroll to bottom
- scroll more
+ abstract message more for date, preview, etc
+ WTF text
+ text composer

# Bugs:
- Clamp image width in timeline

Later
- View injection (for messages to render them differently)
- image send
