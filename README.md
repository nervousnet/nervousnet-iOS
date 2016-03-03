# nervousnet iOS
__Important__: make sure you open this project with `open nervousnet.xcworkspace` and follow the [iOS good practices](https://github.com/futurice/ios-good-practices)

### Features
_nervousnet iOS_ enables the user to locally log and share their iPhone's sensor data in many interesting ways. Logging sensor data is nothing new in itself but what makes _nervousnet iOS_ different is that the user has full control over where their data is stored.

_nervousnet iOS_ provides special "JSApps" to visualise, process or share sensor data. These "JSApps" can use the many functions provided by the [Global and Local Analytics Engine](http://documentation.needed!), like machine learning algorithms. They also have access to third party libraries and if activated by the user P2P networking and internet access.`*`

"JSApps" can be found and installed from within the _nervousnet iOS_ app.

`*` functionality not yet implemented.

### Architecture
In this iOS app we adhere to Apple's recommended MVC architecture and separate code into the respective `Models`, `Views`, `Controllers`, `Stores` directories. The `Assets` directory contains media, binaries and other non-swift code.

### Database
The current version of the app uses [Apple's Core Data persistence framework](https://developer.apple.com/library/watchos/documentation/Cocoa/Conceptual/CoreData/index.html).

### JSApps
"JSApps" are written in JavaScript and HTML. They follow strict view and code separation and must be contained within a single directory. Important external dependencies like jQuery and the Nervous JS API are provided by the nervousnet iOS app. All other libraries must be included by the developer.

The minimal JSApp must provide the following three files zipped within a folder baring the same name as the app in kebab-case:
```
my-first-app/
   package.json
   app.js
   app.html
```
An example app can be downloaded [here](http://nervousnet.ethz.ch/nervous-developers/uploaded_apps/hello-world.zip).

JSApps must be installed from within the _nervousnet iOS_ app. This is done by downloading the ZIP file and unzipping it to the app's home directory. When a user selects to run a JSApp, it opens a modal window containing a WebView displaying the `app.html`. All JSApp resources are served by a local lightweight HTTP server called __JSApp Provider__ (the WebKit engine does not allow file:/// XMLHTTPRequests).

JSApps specify requested privileges in `package.json`. On first JSApp execution, the user will be prompted to grant or deny access. Once granted, the JSApp can access all authorised [Nervous JS API methods](http://documented.here).


### JSApp Provider
The JSApp Provider is the __HTTP server__ running locally on the phone that serves JSApp assets to the webview as well as handles requests sent via  the Nervous JS API. With every JS API method call, the JSApp must send an authentication token known only to the JSApp and the Auth. This token effectively authenticates the JSApp to the Local Analytics Engine and thus authorises the JSApp to access sensor data that it has been given access to (by the user prompt).


### VM
The VM (short for Virtual Machine) will be a separate entity in the backend of the system. LAE interacts with the VM. It is a singleton class and the system cannot create two distinct instances of this class.
The responsibilities of the VM are to work at the sensor and database level so that a developer does not have to deal with hardware level at all by him-/her-self. The VM collects the sensor data at the sensor level. 
	* This sensor data collection can be controlled by the user via UI. This privacy control is handled by the VM directly.
	* The VM pushed the data into a local database on the phone - the current architecture will use CoreData (an in-built iOS application, see ‘### Database’ above).
	* The VM also pushes the collected data not a remote server. The server address can be chosen by the user via UI.
The earlier version of the VM used protobuf as the protocol for pushing the data. The current version will remove this due to the complex nature of the protocol and replace it with JSON based format. The format will make development easier at the cost of performance (there is a balance between the two that must be maintained).


### Auth
Auth (short for Authentication Class) provides the facility to authenticate an application before it is allowed to use other modules of the system - e.g. LAE. This authentication is performed by the Web Server in the system which forms the central module that all other modules interacts with (see ‘### JSApp Provider’).
Other functionalities to come……


### LAE
The LAE (short for Local Analytics Engine) is an engine that interfaces the VM with any other application in the system architecture. 
	* The LAE provides a high level abstraction of the physical sensors in the database.
	* It also allows all the application to fetch and receive the data from the database (with multiple criteria as given by the user).
	* It also has the capability to not only give out sensor data in the raw format but also provide analytics on it. For example, the LAE will allow an application to fetch
	  mean or standard deviation on the the data. It can be designed to provide even more capabilities like clustering etc.

### External HW
A default JSApp will be provided which gives easy access to external hardware sensors like weather stations, seismographs, geiger couunters, etc.

A user could select an external sensor to be "installed". After "installation", the external sensor is available to any JSApp requiring it. Thus one could imagine independant JSApps building upon external sensors provided by the community.
