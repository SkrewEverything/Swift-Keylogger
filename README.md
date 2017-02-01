# macOS Keylogger

[![Swift 3.0](https://img.shields.io/badge/Swift-3.0-orange.svg)]()

It is a simple and easy to use keylogger for macOS. It is not meant to be malicious. There are only few keyloggers available for mac and none of them are in swift.

Most of the keyloggers available only logs keystrokes into a file without much information about on which app the keystrokes are generated.

>Note: This keylogger doesn't capture secure input fields like passwords due to [`EnableSecureEventInput`](https://developer.apple.com/library/content/technotes/tn2150/_index.html)

## Usage

Clone the repository and open the project in Xcode and build the project and run the executable.

When it's run, it creates folder Data
```
|--Keylogger
|--Data
    |--App
    |--Devices
    |--Key
```
Key folder stores all the keystrokes according to application.
App folder stores all the timestamps of applications being active.
Devices folder stores the information about the connected keyboards.

By default it creates folder where the executable is present. 
To change the path edit `bundlePathURL` in `Keylogger.swift`
##### All the data is grouped according to day in each folder.


## Contributing

Feel free to fork the project and submit a pull request with your changes!

License
---

MIT


**Free Software, Hell Yeah!**

