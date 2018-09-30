# Weather
An application that fetchs data from OpenWeatherMap to give weather status for today and the next five days!

## App Overview

Some nice-looking empty states.

| Super cute loading | Unkown Error | Location Error | Connection Error |
|-|-|-|-|
| <img src="https://media.giphy.com/media/1kTOoUKWu3Dczwv0CD/giphy.gif" width="290" height="370"> | <img src="https://i.imgur.com/zSY4irV.png" width="290" height="370"> | <img src="https://i.imgur.com/Sn6uS6d.png" width="290" height="370"> | <img src="https://i.imgur.com/FFDGlQz.png" width="290" height="370"> |


And the app's flow

| Forecast for Today | Forecast for the next 5 days |
|-------|----------|
|   <img src="https://media.giphy.com/media/2w5MMArB7TkSRlXBXL/giphy.gif" width="290" height="500">    |     <img src="https://media.giphy.com/media/bEUYqxaIitZL9uF5Ss/giphy.gif" width="290" height="500">     |

## Requirements

In order to run this project you must have:
- Xcode 10.x
- Swift 4.2 support
- Cocoapods 1.5.x

## Getting Started

To run this project, run the following commands on terminal:
```
git clone https://github.com/matheusvds/Weather-App.git
pod install
```

## Comments

- In an effort to show my skills, I developed the whole app using View Code, so all the views were created programmatically. (I won't say if this is better or worse, but it has its advantages when working in big projects and give you more knowledge of whats is going on behind the scenes. Anyways, just wanted to show a nice skill here :D) There's a nice post from a colleague [here](https://medium.com/cocoaacademymag/storyboard-no-more-crafting-coding-a-custom-uiview-de166b0cac5).

- Also, I usually don't use pod for networking, I write my own code as you can see [here](https://github.com/matheusvds/iOS-Photos/tree/master/BlendleiOSAssignment/Shared/Networking) and the tests [here](https://github.com/matheusvds/iOS-Photos/tree/master/BlendleiOSAssignmentTests/Network), because it's easier to tweak, test, debug and mantain. But seeing  STRV's stack for iOS, I decided to use [Moya](https://github.com/Moya/Moya) which is built on top of **Alamofire**. I have never used Moya before, but even so I decided to use it because some friends used in their projects and I noticed it makes the network abstraction layer to become super clean and I loved it. 



### Enviroments

- Development
- QA
- UAT
- Production

### Dependencies

- Moya
- Snapkit
- Firebase/Core
- Firebase/Auth
- Firebase/Database
- Quick/Nimble
