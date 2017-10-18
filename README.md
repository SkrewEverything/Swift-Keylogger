# macOS Keylogger

[![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)]()

It is a simple and easy to use keylogger for macOS. It is not meant to be malicious. There are only few keyloggers available for mac and none of them are in swift.

Another problem is with Apple high-level API's. I don't know the reason but Apple suddenly deprecates and removes the documentation of API's from it's website.

So, I don't want to keep checking about the availability of their API's and changing my code frequently. That is the reason I went for low-level API which is using HID API.

Most of the keyloggers available only logs keystrokes into a file without much information about on which app the keystrokes are generated.

>Note: This keylogger doesn't capture secure input fields like passwords due to [`EnableSecureEventInput`](https://developer.apple.com/library/content/technotes/tn2150/_index.html)

## Usage

Clone the repository and open the project in Xcode and build the project and run the executable.

### To run it in the background

To be able to close the Terminal when Keylogger is running, use this command while running the executable.

```shell
$ nohup ./Keylogger &
```
And you can quit the Terminal.

### To quit/stop the Keylogger

To quit the Keylogger, first find it's pid using `ps` and use `kill` to stop the keylogger.

```shell
$ ps -e | grep "Keylogger"
$ kill -9 pid_of_keylogger_from_above_command
```

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

## Disclaimer
If the use of this product causes the death of your firstborn or anyone, I'm not responsible ( no warranty, no liability, etc.)

For technical people: It is only for educational purpose.


## Contributing

Feel free to fork the project and submit a pull request with your changes!

License
---

MIT


**Free Software, Hell Yeah!**

