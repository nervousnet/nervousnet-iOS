//
//  AuthController.swift
//  nervousnet-iOS
//
//  Created by Lewin Könemann on 04 Mar 2016.
//  Copyright (c) 2016 ETHZ . All rights reserved.
//



import Foundation
import CoreData
import UIKit

class AuthController : NSObject {
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var managedContext : NSManagedObjectContext
    
    
    
    override init(){
        managedContext = appDelegate.managedObjectContext
        
        
    }
    
    //Checks the Permissions of a given App and returns them as a [Bool] in alphabetical order. Authentication is done through a UInt64 Token
    //If the user is to be asked for missing permissions set askUser:Bool = true
    
    func checkAxonPermissions (token:Int, axonName:String, accaccess:Bool = false, bataccess:Bool = false, gyraccess:Bool = false, magaccess:Bool = false, proxaccess:Bool = false, askUser:Bool = false, createNewPermission:Bool = false) -> [Bool] {
        
        
        //Check whether permission has already been granted
        let fetchRequestExisting = NSFetchRequest(entityName: "AxonPermissionList")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequestExisting)
            let listof = results as! [NSManagedObject]
            for ress in listof {
                if (ress.valueForKey("axonName") as! String == axonName && ress.valueForKey("token") as! Int == token){
                    var resultStorage : [Bool] = []
                    
                    if accaccess   {
                        if ress.valueForKey("hasAccelerometerAccess") as! Bool{
                            resultStorage.append(ress.valueForKey("hasAccelerometerAccess") as! Bool)
                        }
                        else if (askUser && requestUserPermission(axonName, accaccess: true)[0]){
                            resultStorage.append(true)
                            changeAppPermissions(token, axonName: axonName, accaccess: true)
                        }
                        else {resultStorage.append(false)
                        }
                        
                    }
                    
                    
                    if bataccess   {
                        if ress.valueForKey("hasBatteryAccess") as! Bool{
                            resultStorage.append(ress.valueForKey("hasBatteryAccess") as! Bool)
                        }
                        else if (askUser && requestUserPermission(axonName, bataccess: true)[0]){
                            resultStorage.append(true)
                            changeAppPermissions(token, axonName: axonName, bataccess: true)
                        }
                        else {resultStorage.append(false)
                        }

                        
                    }
                    if gyraccess   {
                        if ress.valueForKey("hasGyroscopeAccess") as! Bool{
                            resultStorage.append(ress.valueForKey("hasGyroscopeAccess") as! Bool)
                        }
                        else if (askUser && requestUserPermission(axonName, gyraccess: true)[0]){
                            resultStorage.append(true)
                            changeAppPermissions(token, axonName: axonName, gyraccess: true)
                        }
                        else {resultStorage.append(false)
                        }

                        
                    }
                    if magaccess   {
                        if ress.valueForKey("hasMagnetometerAccess") as! Bool{
                            resultStorage.append(ress.valueForKey("hasMagnetometerAccess") as! Bool)
                        }
                        else if (askUser && requestUserPermission(axonName, magaccess:true)[0]){
                            resultStorage.append(true)
                            changeAppPermissions(token, axonName: axonName, magaccess: true)
                        }
                        else {resultStorage.append(false)
                        }

                    }
                    
                    if proxaccess   {
                        if ress.valueForKey("hasProximityAccess") as! Bool{
                            resultStorage.append(ress.valueForKey("hasProximityAccess") as! Bool)
                        }
                        else if (askUser && requestUserPermission(axonName, proxaccess: true)[0]){
                            resultStorage.append(true)
                            changeAppPermissions(token, axonName: axonName, proxaccess: true)
                        }
                        else {resultStorage.append(false)
                        }

                    }
                    
                    return resultStorage
                    //
                }
            }
            if (createNewPermission){
                let requestedPermissions = requestUserPermission(axonName, accaccess: accaccess, bataccess: bataccess, gyraccess: gyraccess, magaccess: magaccess, proxaccess: proxaccess)
                createNewEntry(token, axonName: axonName, accaccess: requestedPermissions[0], bataccess: requestedPermissions[1], gyraccess: requestedPermissions[2], magaccess: requestedPermissions[3], proxaccess: requestedPermissions[4])
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
     return [false]
    }
        
        
        
    
    
    
    /// Can be called by the UI settings.
    
    private func changeAppPermissions(token:Int, axonName:String, accaccess:Bool = false, bataccess:Bool = false, gyraccess:Bool = false, magaccess:Bool = false, proxaccess:Bool = false){
        //write
        let permission = getExistingPermissiondf(axonName, token: token)
        permission!.setValue( token as NSNumber , forKey: "token")
        permission!.setValue( axonName, forKey: "axonName")
        permission!.setValue( accaccess, forKey: "hasAcceleromterAccess")
        permission!.setValue( bataccess, forKey: "hasBatteryAccess")
        permission!.setValue( gyraccess, forKey: "hasGyroscopeAccess")
        permission!.setValue( magaccess, forKey: "hasMagnetometerAccess")
        permission!.setValue( proxaccess, forKey: "hasProximityAccess")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    private func getExistingPermissiondf (axonname : String, token : Int)  -> NSManagedObject? {
        
        var retObj : NSManagedObject?
        let fetchRequest = NSFetchRequest(entityName: "AxonPermissionList")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let listof = results as! [NSManagedObject]
            for ress in listof {
                if ( (ress.valueForKey("axonName") as! String) == axonname){ //&&  ress.valueForKey("token") as! UInt64 == token){
                    retObj = ress
                    break
                }
                
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return retObj
        
    }
    
    func requestUserPermission (appname:String, accaccess:Bool = false, bataccess:Bool = false, gyraccess:Bool = false, magaccess:Bool = false, proxaccess:Bool = false) -> [Bool]{
        
        var retList : [Bool] = []
        for _ in [accaccess,bataccess,gyraccess,magaccess,proxaccess]{
            retList.append(false)
        }
        return retList
    }
    
    
    private func createNewEntry(token:Int, axonName:String, accaccess:Bool = false, bataccess:Bool = false, gyraccess:Bool = false, magaccess:Bool = false, proxaccess:Bool = false){
        //write
        let entity = NSEntityDescription.entityForName("AxonPermissionList", inManagedObjectContext: managedContext)
        let permissionsList = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        permissionsList.setValue( token as NSNumber , forKey: "token")
        permissionsList.setValue( axonName, forKey: "axonName")
        permissionsList.setValue( accaccess, forKey: "hasAcceleromterAccess")
        permissionsList.setValue( bataccess, forKey: "hasBatteryAccess")
        permissionsList.setValue( gyraccess, forKey: "hasGyroscopeAccess")
        permissionsList.setValue( magaccess, forKey: "hasMagnetometerAccess")
        permissionsList.setValue( proxaccess, forKey: "hasProximityAccess")
        
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }

        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //sample
    func testStuff()-> [Bool]{
        //write
        let entity = NSEntityDescription.entityForName("AxonPermissionList", inManagedObjectContext: managedContext)
        let permissionsList = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        permissionsList.setValue( NSDate().timeIntervalSince1970.description, forKey: "axonName")
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        //readit
        let fetchRequest = NSFetchRequest(entityName: "AxonPermissionList")
        
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let listof = results as! [NSManagedObject]
            for ress in listof {
                NSLog(ress.valueForKey("axonName") as! String)
                
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        let retrieved = getExistingPermissiondf("1460030317.29031", token: Int.max)
        retrieved?.setValue("this changed and is no longer 1458853566.13866", forKey: "axonName")
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
        
        //just read it out agoin
        NSLog("_______________")
        do {
            let results =
                try managedContext.executeFetchRequest(fetchRequest)
            let listof = results as! [NSManagedObject]
            for ress in listof {
                NSLog(ress.valueForKey("axonName") as! String)
                
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        return [false]
        
    }
}

