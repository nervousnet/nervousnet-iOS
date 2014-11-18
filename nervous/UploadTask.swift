//
//  UploadTask.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class UploadTask :NSObject, NSStreamDelegate {
    
    var pbSensorupload :SensorUpload? = nil
   
    //router settings
    let serverAddress = "www.inn.ac"
    let serverPort = 25600
    
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?

    
    
    init(pbSensorupload :SensorUpload){
        super.init()
        
        self.pbSensorupload = pbSensorupload
        
        println("connecting...")
        
        NSStream.getStreamsToHostWithName(serverAddress, port: serverPort, inputStream: &self.inputStream, outputStream: &self.outputStream)
        
        
        var inp:NSInputStream = self.inputStream!
        var out:NSOutputStream = self.outputStream!
        
        inp.delegate = self
        out.delegate = self
        
        inp.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        out.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        inp.open()
        out.open()
        
    }
    
    
    func writeToRouter(){
            var sensorData :SensorUpload = self.pbSensorupload!
            var out :NSOutputStream = self.outputStream!
            var inp :NSInputStream = self.inputStream!
            var i = 0
            
            //TODO: make this less hacky, add proper timers
            while (out.streamStatus == NSStreamStatus.Opening){
                i++
                if(out.streamStatus == NSStreamStatus.Error){
                    NSLog("dies")
                    out.close()
                    inp.close()
                }else if (i > 40000) {
                    NSLog("upload timeout")
                    out.close()
                    inp.close()
                }
                
            }
            
            sensorData.writeDelimitedToOutputStream(out)
            
            out.close()
            inp.close()
    }
    
    
    func stream(theStream: NSStream!, handleEvent streamEvent: NSStreamEvent){
        NSLog("receive")
        
        
        switch streamEvent {
        
            case NSStreamEvent.None:
                NSLog("NSStreamEvent.None")
            
            case NSStreamEvent.OpenCompleted:
                NSLog("opened")
            
            case NSStreamEvent.HasSpaceAvailable:
                NSLog("NSStreamEvent.HasSpaceAvailable")
            
            case NSStreamEvent.ErrorOccurred:
                NSLog("NSStreamEvent.ErrorOccurred")
            
            
            case NSStreamEvent.EndEncountered:
                NSLog("NSStreamEvent.EndEncountered")
            
            default:
                NSLog("default")
        }
    }

    
}