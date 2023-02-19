# Precise Volume

## Usage
This is a SwiftUI app that gives the user the correct volume percentage. Change the system volume inside or outside of the app with the volume buttons or the pull-down slider and see the percentage change. To adjust the volume within the app, tap the left or right sides of the screen to increase or decrease the volume respectively. 

## Bugs?
I'm not sure if this is a bug but the volume always rounds to the nearest 5 percent. I was trying to get the volume to only increase by one percent instead of 5 as my ears have always been sensitive to the iPhone volume intervals, or lack thereof. This might also be because I am running an iPhone 12 mini (iOS 16.3) and haven't tested on other devices. Regardless, when adjusting the volume through the buttons, sliders, or in-app programmatically, the result is that the system volume will always round to the nearest 5 percent. 

Another questionable bug I found is that when adjusting the volume from the side buttons, sometimes the percentage will increase by 10 percent rather than 5. This happens 3 times from 0 - 100 percent and I hypothesize that apple has calculated an optimal amount of times a user has to press the volume buttons before they get to the desired level; this could be the reason for non-linear steps.

## Result 
That's where I am going to leave this app. I am probably not going to put it on the app store as showing the volume percentage and having a more linear step progression aren't enough to justify opening a completely separate app for volume. I might look into it again, as it does bother me that I can't get down to 1 percent, but I haven't found a good way of making that happen.
