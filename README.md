# NYT Stories
- App gets stories from New York Time API and display in tab bar with Home, Health, Sports and Offline tabs. Each tab contains list of stories title with thumbnail. Each row displays detail screen.


## Notes
- Offline.json file is included in the project which contains the same data as top stories home page from NYT. This file is used in loading offline data in Offline tab.
- I have not included thumbnail in the detail page of the application as all the images in the multimedia are same with different dimensions. So it doesn't make any sense to include thumbnail image in the detail screen when there is already a full image. I have also included caption in the detail page which shows caption of the photo. It was not required in the requirement document but i have added it just to make UI a bit better. Caption is not available for every multimedia object so application will only show the caption for the image which is available.

# Technical Details
## App Architecture
- MVVM is used as application architecure.
- Protocol orientated network layer is used to handle network calls.

## Code Structure
Project structure is divided into certain groups to make the code structure better and easy to use.

- AppDelegate, sceneDelegate, assets and info.plist files are placed at the root folder of the nyt module.
- Helpers group contains files with generic code which helps the application. 
- Storyboards group contains storyboards files. 
- Network layer group contains further groups i.e. EndPoint, Manager, Service, Encoding, OfflineData. These group contains files which implements network layer.
- Models group contains model used in application
- ViewModels group contains view models for hanlding model and view. Each view has its corresponding view model file in this group.
- Views group contains viewControllers of the application.
- Extensions group contains extensions of built-in objects. 

## Unit Tests
- View Model group in this module contains viewModel test classes which tests the view models used in the application.

## Unit UI Test
- This module has single file which tests the tab bar buttons on main screen.

# Development Environment
- This is built with Xcode 11.6. Tested with iPhone 11 on iOS 13.6. It supports all orientations.

# Author
-  *Umer Saleem*
- *GitHub Link* -  This is the public repository with url link "https://github.com/mumersaleem/NYT-Stories"

