# Messagerie

Messagerie is a chat app written to test SwiftUI and Combine into a real and, hopefully, useful app.

A smooth chat timeline is often tricky to implement on iOS or MacOS. How well does it work with these new things? 
Apple still camps on its MVC model but SwifUI seems to fit very well with MVVM pattern. How to implement it? Can we even have MVVM-C easily?



# Functionalites

[screenshots]
Any resemblance to a future RiotX-iOS is unexpected :)

Messagerie misses a lot of things but it has:
- Support of Matrix using [SwiftMatrixSDK]()
- E2EE
- Multi-account (swipe the navigation bar to switch accounts)
- Dark mode and auto-sizing fonts (well, they come for free)
- 4 screens:
    - a Matrix login screen
    - a room list
    - a room screen
    - a very early beginning of a SwiftUI text composer to post text message
    

# Installation
For now, you need an Apple build environment to install Messagerie:

```
$ git clone https://github.com/manuroe/messagerie.git
$ cd messagerie
$ pod install
$ xed .
```


# MessagerieUI
This subfolder in the codebase could become a library that offers UI components for a chat app independent from the communication protocol. Messagerie is multi-account and multi-protocol.

UI, data and services are isolated with protocols (the term for interfaces in Swift). There is a dumb dependency injection mechanism so that you inject an implementation of data and services into the UI. The will fetch and trigger things independent from the protocol. 

UI are implemented in the way we implement MVVM in Riot. We have:
- the View
- a view state with @Published things. These new SwiftUI things automatically update the view on changes
- some view actions sent by the view to the model
- the model that listens to view actions and updates the view state. It uses data and services provided by injection.


# SwiftUI 
Well done Apple! SwiftUI makes me happy to code UI again. Once you understood the 3 levels of data binding, writting UI is most of the time flawless and quick and fun.
They way it allows (and advices) you to cut views into small and independant ones is powerful. You can move a view to another container view with no drawbacks. 
You remember Interface Build? When you needed to click on tons of buttons to create lost contraints? This time is gone :)

## Performance
There is no doubt that SwiftUI performs very well. I hit no performance issues on the timeline. I even tried to display webviews into the timeline without any issues. You can see Matrix widgets webviews displayed within the timeline [here](cdcd)


## Gripes
SwiftUI 2 will be probably perfect :)

### ScrollView
No access to the scroll view offset. This is boring for 2 reasons: 
- how do you scroll to the bottom?
    To respect its chronology, messages of a timeline is displayed in a reversed order. When you open a room, you want to see the last message, which is at the bottom of this view. 
- how do you know the scroll position to implement an infite scrolling (that triggers pagination beyond the shell)?

I solved the first issue by applying a double vertical flip. I flipped the scroll view. Then, I flipped every cells.
In the code, the flip is implemented by a 180 degrees rotation.
In the UI, this is visible because the scroll indicator is on the left :/

### Text
How to render NSAttributedString?

### TextField
No multiline support :/

### Navigation / View coordination
I have not deeply explored this area yet. View still need to know each other.



# Next
- avatar: enum: letter + 2 urls preview
- Room screen: infinite scrolling
- Minimal settings: 
    - Sign out
    - Clear cache :/
- Do a full mock implementation
- View injection
- iPad root view
- MacOs root view

# Known issues
- Swipe kills room content
- Messages glitch when opening the room
- Sometimes fails to load (on device) ? 
- No user data in nav bar (on device)?
