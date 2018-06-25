# macOS Keylogger

[![Backers on Open Collective](https://opencollective.com/Swift-Keylogger/backers/badge.svg)](#backers) [![Sponsors on Open Collective](https://opencollective.com/Swift-Keylogger/sponsors/badge.svg)](#sponsors) [![Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg)]()

It is a simple and easy to use keylogger for macOS. It is not meant to be malicious. There are only few keyloggers available for Mac and none of them are in Swift.

Another problem is with Apple high-level APIs. I don't know the reason but Apple suddenly deprecates and removes the documentation of APIs from its website.

So, I don't want to keep checking about the availability of their APIs and changing my code frequently. That is the reason I went for low-level API which is using HID API.

Most of the keyloggers available only log keystrokes into a file without much information about on which app the keystrokes are generated.

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

To quit the Keylogger, first, find its PID using `ps` and use `kill` to stop the keylogger.

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

By default, it creates a folder where the executable is present. 
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


## Contributors

This project exists thanks to all the people who contribute. 
<a href="graphs/contributors"><img src="https://opencollective.com/Swift-Keylogger/contributors.svg?width=890&button=false" /></a>


## Backers

Thank you to all our backers! 🙏 [[Become a backer](https://opencollective.com/Swift-Keylogger#backer)]

<a href="https://opencollective.com/Swift-Keylogger#backers" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/backers.svg?width=890"></a>


## Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website. [[Become a sponsor](https://opencollective.com/Swift-Keylogger#sponsor)]

<a href="https://opencollective.com/Swift-Keylogger/sponsor/0/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/1/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/2/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/3/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/4/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/5/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/6/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/7/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/8/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/Swift-Keylogger/sponsor/9/website" target="_blank"><img src="https://opencollective.com/Swift-Keylogger/sponsor/9/avatar.svg"></a>


