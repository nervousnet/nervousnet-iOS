//
//  UploadTask.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class UploadTask :NSObject, NSStreamDelegate {
    
    var pbSensorupload :SensorUpload
    
    init(pbSensorupload :SensorUpload){
        self.pbSensorupload = pbSensorupload
    }
    
    
    func writeToRouter(){
        
        let addr = "inn.ac"
        let port = 25600
        
        var inp :NSInputStream?
        var out :NSOutputStream?
        var pbSizeB :UInt8
        
        
        NSStream.getStreamsToHostWithName(addr, port: port, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        
        inputStream.delegate = self
        outputStream.delegate = self
        
        inputStream.open()
        outputStream.open()
        
        
        self.pbSensorupload.writeDelimitedToOutputStream(outputStream)
        
        outputStream.close()

    
    }
    
    
    func stream(theStream: NSStream!, handleEvent streamEvent: NSStreamEvent){
        println("receive")
        switch streamEvent {
        case NSStreamEvent.None:
            println("NSStreamEvent.None")
        case NSStreamEvent.OpenCompleted:
            NSLog("NSStreamEvent.OpenCompleted")
        case NSStreamEvent.HasBytesAvailable:
            println("NSStreamEvent.HasBytesAvailable")
            if let inputStream = theStream as? NSInputStream {
                println("is NSInputStream")
                if inputStream.hasBytesAvailable {
                    NSLog("hasBytesAvailable")
                    let bufferSize = 1024
                    var buffer = Array<UInt8>(count: bufferSize, repeatedValue: 0)
                    var bytesRead: Int = inputStream.read(&buffer, maxLength: bufferSize)
                    println(bytesRead)
                    if bytesRead >= 0 {
                        var output: String = NSString(bytes: &buffer, length: bytesRead, encoding: NSUTF8StringEncoding)
                        println(output)
                    } else {
                        // Handle error
                    }
                }
            }
        case NSStreamEvent.HasSpaceAvailable:
            println("NSStreamEvent.HasSpaceAvailable")
        case NSStreamEvent.ErrorOccurred:
            NSLog("NSStreamEvent.ErrorOccurred")
        case NSStreamEvent.EndEncountered:
            NSLog("NSStreamEvent.EndEncountered")
        default:
            NSLog("default")
        }
    }

    
}