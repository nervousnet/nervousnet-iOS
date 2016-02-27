# nervousnet iOS
__Important__: make sure you open this project with `open nervousnet.xcworkspace` and follow the [iOS good practices](https://github.com/futurice/ios-good-practices)

### Features
_nervousnet iOS_ enables the user to locally log and share their iPhone's sensor data in many interesting ways. Logging sensor data has been implemented by many other apps, some apps even sending all data to a central location out of control of the user. What makes _nervousnet iOS_ different is that the user decides where their data goes.

As it would be boring to just log cryptic sensor data, _nervousnet iOS_ provides special "JSApps" to visualise, process or share sensor data. These "JSApps" can use the many functions provided by the Global Analytics Engine, like machine learning algorithms. They also have access to third party libraries and if activated by the user P2P networking and internet access.`*`

"JSApps" can be found and installed from within the _nervousnet iOS_ app.

`*` functionality not yet implemented.

### Architecture

We adhere to Apple's recommended MVC architecture and separate code into the respective `Models`, `Views`, `Controllers`, `Stores` directories. The `assets` directory contains media, binaries and other non-swift code.

### Database
The current version of the app does not use Apple's Core Data as the persistent store. Instead it relies on sqlite3, which at the time of development was the preferred choice. It is envisaged to make a switch to Core Data as soon as possible.

### JSApps
"JSApps" are written in JavaScript and HTML. They follow strict view and code separation and must be contained within a single directory. Important external dependencies like jQuery and the Nervous JS API are provided by the nervousnet iOS app. All other libraries must be included by the developer.

The minimal JSApp must provide the following three files zipped within a folder baring the same name as the app in kebab-case:
```
my-first-app/
   package.json
   app.js
   app.html
```
An example app can be downloaded [here](http://n.cg).

JSApps must be installed from within the _nervousnet iOS_ app. This is done by downloading the ZIP file and unzipping it to the app's home directory. When a user selects to run a JSApp, it opens a modal window containing a WebView displaying the `app.html`. All JSApp resources are served by a local lightweight HTTP server as the WebKit engine does not allow file:/// XMLHTTPRequests.

JSApps specify requested privileges in `package.json`. On first JSApp execution, the user will be prompted to grant or deny access. Once granted, the JSApp can access all authorised [Nervous JS API methods](http://documented.here).


### VM

### Auth

### LAE


## External HW
(default HW webview for sensors)
