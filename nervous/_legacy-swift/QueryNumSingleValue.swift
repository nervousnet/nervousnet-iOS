////
////  QueryNumSingleValue.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 21/05/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//import Foundation
//import Darwin
//
////query,querynum and querynumsinglevalue together
//
// class QueryNumSingleValue<G : SensorDescSingleValue> {
//    
//    
//    var List : Array<SensorUploadSensorData>
//    
//    func getSensorID() -> UInt64{
//        fatalError("Must Override")
//    }
//    init(from timestamp_from :UInt64,to timestamp_to : UInt64){
//        let vm = NervousVM()
//        
//        self.List = vm.retrieve(0, fromTimeStamp: 0, toTimeStamp: 0)
//        self.List = vm.retrieve(getSensorID(), fromTimeStamp: timestamp_from, toTimeStamp: timestamp_to)
//        if(containsReading()){
//            print("retreived list of size /(getCount())")
//        }
//    }
//    
//    
//    func getCount() -> Int
//    {
//    return List.count
//    }
//    
//    func containsReading() -> Bool{
//        
//        if(List.count == 0)  //check for null equivalent
//        {return false}
//        else
//        {return true}
//    }
//    
//    func createSensorDescSingleValue(sensorData : SensorUploadSensorData) -> G{
//        fatalError("Must Override")
//    }
//    
//    func getSensorDescriptorList() -> Array<G>{
//        var descList = Array<G>()
//        for sensorData in List {
//            descList.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        return descList
//    }
//    
//    func createDummyObject()-> G{
//        fatalError("Must Override")
//    }
//    
//  
//    
//    func getMaxValue()-> G{
//        var maxSensDesc = createDummyObject()
//        var maxVal = FLT_MIN
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            if(sensDesc.getValue() > maxVal){
//                maxVal = sensDesc.getValue()
//                maxSensDesc = sensDesc
//            }
//        }
//        
//       return maxSensDesc
//    }
//    
//    func getTimeRange(desc_list : Array<G>, s : Array<Float>, e : Array<Float>)-> Array<G>{
//        let start = s[0]
//        let end = e[0]
//        
//        var answer = Array<G>()
//        
//        for var i=0; i<desc_list.count ; ++i{
//            
//            let sensDesc = desc_list[i]
//            if(sensDesc.getValue() <= end && sensDesc.getValue() >= start)
//            {
//                answer.append(sensDesc)
//            }
//        }
//        
//        return answer
//        
//    }
//    
//    func getMinValue()-> G{
//        var minSensDesc = createDummyObject()
//        var minVal = FLT_MAX
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            if(sensDesc.getValue() < minVal){
//                minVal = sensDesc.getValue()
//                minSensDesc = sensDesc
//            }
//        }
//        
//        return minSensDesc
//    }
//    
//    func getAverage()-> Array<Float>{
//        var temp = Array<Float>()
//        var totalSum : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()
//            
//        }
//        let average = totalSum/Float(List.count)
//        temp.append(average)
//        return temp
//    }
//    
//    func sd()-> Array<Float>{
//        var sd = Array<Float>()
//        var temp = variance()
//        var t = temp[0]
//        t = sqrt(t)
//        sd.append(t)
//        return sd
//    }
//    
//    
//    func variance()-> Array<Float>{
//        var sd = Array<Float>()
//        var av = getAverage()
//        let average = av[0]
//        var temp : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            temp += (average - sensDesc.getValue())*(average - sensDesc.getValue())
//        }
//        temp = temp/Float(List.count)
//        sd.append(temp)
//        return sd
//    }
//    
//    func getRms()->Array<Float>{
//        var temp = Array<Float>()
//        var totalSum :Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()*sensDesc.getValue()
//            
//        }
//        var average = totalSum/Float(List.count)
//        average = sqrt(average)
//        temp.append(average)
//        return temp
//        
//    }
//    
//    func getMeanSquare()->Array<Float>{
//        var temp = Array<Float>()
//        var totalSum : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()*sensDesc.getValue()
//            
//        }
//        let average = totalSum/Float(List.count)
//        temp.append(average)
//        return temp
//    }
//    
//    func getSum()->Array<Float>{
//        var temp = Array<Float>()
//        var totalSum : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()
//            
//        }
//        
//        temp.append(totalSum)
//        return temp
//        
//    }
//    
//    func getSumSquare()->Array<Float>{
//        var temp = Array<Float>()
//        var totalSum : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()*sensDesc.getValue()
//            
//        }
//        
//        temp.append(totalSum)
//        return temp
//        
//    }
//    
//    func getRmsError(comp : Array<Float>)-> Array<Float>{
//        var answer = Array<Float>()
//        var temp : Float = 0
//        let data = comp[0] //only 1 value
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            temp += powf(sensDesc.getValue()-data, 2)
//        }
//        temp = sqrt(temp/Float(List.count))
//        answer.append(temp)
//        return answer
//    }
//    
//    func getMedian()-> Array<Float>{
//        var temp = Array<Float>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        //SORT
//        for var i=0;i<desc_list.count;++i{
//            for var j=i+1;j<desc_list.count;++j{
//                let ans = compare(desc_list[i]  ,obj2: desc_list[j])
//                if(ans == false){
//                    let temp = desc_list[i]
//                    desc_list[i] = desc_list[j]
//                    desc_list[j] = temp
//                }
//    
//            }
//        }
//        var middle : Float
//        if(List.count%2 == 0){
//            middle = desc_list[List.count/2].getValue()
//        }
//        else
//        {middle = desc_list[List.count/2].getValue() + desc_list[List.count/2+1].getValue()}
//        
//        
//        temp.append(middle)
//        return temp
//    }
//    
//    func compare(obj1 : G, obj2 : G)->Bool{
//        //if return 0 first larger than second
//        //else 1
//        if(obj1.getValue() >= obj2.getValue()){
//            return false
//        }
//        if(obj1.getValue() < obj2.getValue()){
//            return true
//        }
//        return false
//    }
//    //largest 10 output
//    func getLargest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        //SORT
//        for var i=0;i<desc_list.count;++i{
//            for var j=i+1;j<desc_list.count;++j{
//                let ans = compare(desc_list[i]  ,obj2: desc_list[j])
//                if(ans == false){
//                    let temp = desc_list[i]
//                    desc_list[i] = desc_list[j]
//                    desc_list[j] = temp
//                }
//                
//            }
//        }
//        for var i=0;i<k;++i{
//            descList.append(desc_list[desc_list.count-1-i])
//            }
//        return descList
//        
//    }
//    //smallest 10
//    func getSmallest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        //SORT
//        for var i=0;i<desc_list.count;++i{
//            for var j=i+1;j<desc_list.count;++j{
//                let ans = compare(desc_list[i]  ,obj2: desc_list[j])
//                if(ans == false){
//                    let temp = desc_list[i]
//                    desc_list[i] = desc_list[j]
//                    desc_list[j] = temp
//                }
//                
//            }
//        }
//        for var i=0;i<k;++i{
//            descList.append(desc_list[i])
//        }
//        return descList
//        
//    }
//    
//    func getRankSmallest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        //SORT
//        for var i=0;i<desc_list.count;++i{
//            for var j=i+1;j<desc_list.count;++j{
//                let ans = compare(desc_list[i]  ,obj2: desc_list[j])
//                if(ans == false){
//                    let temp = desc_list[i]
//                    desc_list[i] = desc_list[j]
//                    desc_list[j] = temp
//                }
//                
//            }
//        }
//        descList.append(desc_list[k])
//        return descList
//        
//    }
//    
//    func getRankLargest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescSingleValue(sensorData))
//            
//        }
//        //SORT
//        for var i=0;i<desc_list.count;++i{
//            for var j=i+1;j<desc_list.count;++j{
//                let ans = compare(desc_list[i]  ,obj2: desc_list[j])
//                if(ans == false){
//                    let temp = desc_list[i]
//                    desc_list[i] = desc_list[j]
//                    desc_list[j] = temp
//                }
//                
//            }
//        }
//        descList.append(desc_list[desc_list.count-1-k])
//        return descList
//        
//    }
//    
//    func getCorrelation(comp : Array<G>,comp1:Array<G>)->Array<Float>{
//        var c3 = Array<Float>()
//        var totalSum : Float = 0
//        for var i = 0;i<comp.count;++i{
//            totalSum += comp[i].getValue()
//        }
//        var totalSum1 : Float = 0
//        for var i = 0;i<comp1.count;++i{
//            totalSum1 += comp1[i].getValue()
//        }
//        let average = totalSum/Float(comp.count)
//        var average1 = totalSum1/Float(comp1.count)
//        
//         var c = Array<Float>()
//         var c1 = Array<Float>()
//        
//        for var i = 0;i<comp.count;++i{
//            var temp = comp[i].getValue()
//            temp -= average
//            c.append(temp)
//        }
//        for var i = 0;i<comp1.count;++i{
//            var temp = comp1[i].getValue()
//            temp -= average
//            c1.append(temp)
//        }
//        
//        var top : Float = 0
//        for var i = 0;i<comp.count;++i{
//            top += c[i]*c1[i]
//        }
//        
//        var a2 : Float = 0
//        var b2 : Float = 0
//        
//        for var i = 0;i<comp.count;++i{
//            a2 += powf(c[i], 2)
//            b2 += powf(c1[i], 2)
//        }
//        
//        let bottom = sqrt(a2*b2)
//        let coef = top/bottom
//        
//        c3.append(coef)
//        return c3
//        
//        }
//    
//    func getEntropy()->Array<Float>{
//        var n = Array<Float>()
//        var ent : Float = 0
//        var totalSum : Float = 0
//        for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            totalSum += sensDesc.getValue()
//        }
//        var prob = Array<Float>()
//         for sensorData in List{
//            let sensDesc = createSensorDescSingleValue(sensorData)
//            let temp = sensDesc.getValue() / totalSum
//            prob.append(temp)
//        }
//        for var i = 0;i<prob.count;++i{
//            ent += prob[i] * log(1/prob[i])
//        }
//        n.append(ent)
//        return n
//    
//    }
//}
//
//
