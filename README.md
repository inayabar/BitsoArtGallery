# Bitso iOS Coding Challenge

### Author : Iñaki Yabar Bilbao (inayabarb@gmail.com)

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Instructions](#instructions)
  - [Running the Project](#running-the-project)
  - [Running the Test Suite](#running-the-test-suite)

    
## Overview

This repo contains code related to Bitso's iOS coding challenge, consisting of an app with two views: Artwork list and Artwork detail, utilizing Chicago Art institute API. 

## Architecture

### UI Framework
I decided to build the app using **SwiftUI**, taking into account two major aspects: 
- SwiftUI's declarative syntax allows for quick prototyping, making development smoother. Since this is a basic app withouth extensive customization, we won't need some of the important features that haven't still been migrated to SwiftUI from UIKit. In a production environment, with an app as large as Bitso, it could become trickier to implement all of the functionality in pure SwiftUI.
- Bitso supports iOS 13 or later, which means it can and probably is utilizing SwiftUI via UIHostingControllers. As iOS advances, the percentage of apps built in SwiftUI will grow, as it once did when Swift was released.

### Design patterns
In terms of architectural design pattern, I decided to use **MVVM**, to promote a clear separation of concerns, centralizing business logic in the view model. MVVM is well-suited for use with SwiftUI because it aligns well with SwiftUI's data-driven and declarative programming model. ViewModels can publish ObservableObjects that SwiftUI views can observe and react to, enabling a reactive and responsive UI, while keeping the Views free of logic. I found that this patter also really helped with testing.

One popular variation is to use MVVM-C (Coordinator), which decouples the business logic from the UI navigation, because navigation in SwiftUI can still be complicated to work with. In this case, I decided not to utilize this pattern because the navigation stack is simple (We only navigate from List to Detail, and backwards). If there were new screens and navigation flows added, MVVM-C would be a good choice.

### Concurrency 
To handle asyncronous tasks this project utilizes async-await (Swift concurrency, presented in Swift 5.5), because it reduces the amount of boilerplate code required to manage asynchronous tasks. Instead of dealing with callbacks and nested closures, async-await code looks like a sequence of synchronous statements.

### Dependency Injection
The whole project utilizes constructor injection, where dependencies are injected through the class constructor. Whenever a class has a dependency, a Protocol is added to abstract this class from the actual implementation (Check FileManaging protocol, which abstracts the default FileManager). This allows for loosely coupled code and largely improves testability. Mock dependencies are used in the project's Unit Tests and also in SwiftUI previews. 

### Network Layer
The project implements a basic network layer, which allows for remote data fetching. NetworkService is the main component, which recieves a Resource to fetch, comprised of an URLRequest (the url we want to fetch) and a generic type we want to parse the response to. This network layer utilizes URLSession internally, and handles all errors (url creation, network issues, decoding errors, etc). 

### API Utilization
The Chicago Art Institute API utilized to fetch artworks data consists of two main endpoints: /artworks and /artworks/{id}. As stated in their [best practices](https://api.artic.edu/docs/#best-practices), specifying which fields to retrieve improves performance. Even though both endpoints return the same information for an artwork resource (such as title, artist, description, etc), I decided to fetch a reduced field set in the first endpoint, which serves the artwork list screen, and when accessing the detail view, fetch the complete field set to show all of the information using the second endpoint. 

This approach has the tradeoff that for offline navigation, the second api call is only triggered when entering the detail screen, which means the possibility exists that we saved the list response containing a specific artwork, but when we navigate to the detail the api call fails due to no internet connection, and we cannot show detailed information. In hindsight, it would be better to fetch all the data in the first api call.

## Instructions

### Running the Project

Requirements:
- iOS 13+
- Working Xcode 11+ installation

Steps:
1. **Clone the Repository:** ```git clone https://github.com/inayabar/BitsoArtGallery```
2. **Open the Project:**
- Navigate to the project directory.
- Open the `.xcworkspace` file in Xcode.
3. **Select a Simulator:**
- Choose a simulator or connect a physical device with iOS 13 or later.

4. **Build and Run:**
- Press the play button (▶️) in Xcode to build and run the app on the selected device.

### Running the Test Suite

1. **Select a Testing Scheme:**
- Make sure the testing scheme is set to the app's target and not a specific file or class.

2. **Run Tests:**
- Navigate to the Product menu.
- Select "Test" or use the shortcut (⌘U) to run the test suite.


## Screenshots
| Light Mode | Dark Mode |
|------------|-----------|
| <img src="https://github.com/inayabar/BitsoArtGallery/assets/21232834/4cc37462-2fc5-425b-adb9-0d9e6c144885" width="300" height="650"> | <img src="https://github.com/inayabar/BitsoArtGallery/assets/21232834/a5ce09e4-e571-4487-aeec-d7cccf67f2c2" width="300" height="650"> |
| <img src="https://github.com/inayabar/BitsoArtGallery/assets/21232834/7704ca59-e8fa-415b-9c4e-d8c699048e83" width="300" height="650"> | <img src="https://github.com/inayabar/BitsoArtGallery/assets/21232834/1258f111-139f-4cee-a68c-ffacca6f1f98" width="300" height="650"> |


