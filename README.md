# Todolah
A To-do list app from a beginner ios developer developing from scratch 😄

This app follows the [requirements](https://www.codementor.io/projects/mobile/to-do-list-mobile-app-bdi10y26rf) from DevProjects' To-do list mobile app project 📱

---
## App Demonstration

https://user-images.githubusercontent.com/18641991/124798431-e88aff80-df85-11eb-8c5d-b826ea6315e4.mp4

### App Features
| ![homepage](https://user-images.githubusercontent.com/18641991/124799788-7f0bf080-df87-11eb-8a53-0322420815ac.png)| ![multiple selection demo](https://user-images.githubusercontent.com/18641991/124799855-9519b100-df87-11eb-9136-d8dac2e7bdfe.png)| ![push notification demo](https://user-images.githubusercontent.com/18641991/124799872-9945ce80-df87-11eb-80ca-e8a930e0268c.png)  |
| :-------------: |:-------------:| :-----:| 
| Homepage | Multiple Selection using Pan-gesture | Push notification before deadline | 

### Different function pages
| ![add item page](https://user-images.githubusercontent.com/18641991/124800245-035e7380-df88-11eb-93f1-3acce2221b83.png)|![edit item page](https://user-images.githubusercontent.com/18641991/124800285-0d807200-df88-11eb-895b-bc9bdd5d068f.png)| ![show item page](https://user-images.githubusercontent.com/18641991/124800315-15d8ad00-df88-11eb-8721-71a6f2885db6.png)|
| :-------------: |:-------------:| :-----:| 
| Add New item | Edit Existing item | Show to-do item | 

---
## Features and Concepts used in this project
1. Model View Controller (MVC) are used in the development
2. Use segue to direct between different views
3. Realm database is used to save to-do items' data persistently
4. Auto layout to set constraints for views and make it responsive to all devices
5. Use UITableView to display the list of to-do items
6. Create and manipulate toolbar using UIToolbar
7. Create and manipulate segmented control using UISegmentedControl
8. Setting up and retrieve data from UIDatePicker
9. Using UITextView for long text input, mimic the appearance of UITextField
10. Exit the input field when user tap outside the input field by overriding ```touchesBegan``` function
11. UserNotifications framework to set and remove push notifications for each to-do item
12. Enable multiple selection using pan gesture in iOS
13. Passing data between different views
14. Rounding Date type to the nearest unit (e.g: minute)
15. Detect when app move to background and reappear to foreground

---
## Framework used in this project
- UIKit
- RealmSwift
- UserNotifications
