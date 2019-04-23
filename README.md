# Storytel
# App Structure


* App structure I use **MVVM** with **Delegate** to notify about updates.

* I use the **Repository** design pattern to act as a Data source from API.

* Separate the data source of UITableView to other class **BooksTableViewDataSource**.

* I use **CellReusable** protocol and create 2 extensions for UITableView to reduce code when reusing the cell.

* Use DataLoader.swift to get data from local JSON.

* Create Extension for UIIMageView to download the image from the link.

* Create Extension for UITableViewCell to return Empty Cell with an error message.
* I use [SwiftLint](https://github.com/realm/SwiftLint) to enhance Swift style.

* I use [JSONExport](https://github.com/Ahmed-Ali/JSONExport) to generate model from JSON.

* I use [SnapKit](https://github.com/SnapKit/SnapKit) to create constraints of UI.

* I use [SkeletonView](https://github.com/Juanpe/SkeletonView) to create placeholder for UITableCell until data get back from API.


* I use  this answer to [check internet connection](https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10/52998897#52998897)



# UnitTest
* I apply  **Arrange, Act and Assert (AAA) Pattern** in Unit Testing.
* I use mocking to Test get data from  NetworkManager, I use the same JSON file to mock data.
* Test get data from API and From Local JSON.
* Test **ViewModel** (Get Data from API and JSON).
* Test **ViewController** (Get Data from API and JSON).
