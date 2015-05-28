//
//  UploadTask.swift
//  nervous
//
//  Created by Sam Sulaimanov on 27/09/14.
//  Modified by Siddhartha
//  Copyright (c) 2014 ethz. All rights reserved.
//

import Foundation

class UploadTask :NSObject, NSStreamDelegate {
    
    var pbSensorupload :SensorUpload? = nil
   
    //router settings
    //let serverAddress = "www.inn.ac"
    //let serverPort = 25600
    var inputStream: NSInputStream?
    var outputStream: NSOutputStream?

    
    init(pbSensorupload :SensorUpload){
        super.init()
        
        var VM = NervousVM.sharedInstance
        var serverAddress = VM.getServerAddress()
        var serverPort = VM.getServerPort()
        
        self.pbSensorupload = pbSensorupload
        
        println("connecting...")
        //NSLog("\(serverAddress)")
        //NSLog("\(serverPort)")
        
        NSStream.getStreamsToHostWithName(serverAddress, port: serverPort, inputStream: &self.inputStream, outputStream: &self.outputStream)
        
        if inputStream != nil && outputStream != nil {
            var inp:NSInputStream = self.inputStream!
            var out:NSOutputStream = self.outputStream!
            
            // set delegate
            inp.delegate = self
            out.delegate = self
            
            // schedule
            inp.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            out.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
            
            // open
            inp.open()
            out.open()
            
            //NSLog("Successfully opened!")
        }
    }
    
    
    func writeToRouter(){
            var sensorData :SensorUpload = self.pbSensorupload!
            var out :NSOutputStream = self.outputStream!
            var inp :NSInputStream = self.inputStream!
            let date = NSDate()
        
            let start = date.timeIntervalSince1970
            var timeD :Double
        
            //TODO: make this less hacky, add proper timers
            while (out.streamStatus == NSStreamStatus.Opening){
                timeD = date.timeIntervalSince1970 - start
                
                if(out.streamStatus == NSStreamStatus.Error){
                    NSLog("dies")
                    out.close()
                    inp.close()
                }else if (timeD > 2) {
                    NSLog("upload timeout")
                    out.close()
                    inp.close()
                }
                //else {
                    //NSLog("Connected")
                //}
                
            }
            
            sensorData.writeDelimitedToOutputStream(out)
            
            out.close()
            inp.close()
    }
    
    
    /*func stream(theStream: NSStream!, handleEvent streamEvent: NSStreamEvent){
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
    }*/

    
}