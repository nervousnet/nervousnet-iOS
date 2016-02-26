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
//class QueryNumVectorValue<G : SensorDescVectorValue> {
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
//        return List.count
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
//    func createSensorDescVectorValue(sensorData : SensorUploadSensorData) -> G{
//        fatalError("Must Override")
//    }
//    
//    func getSensorDescriptorList() -> Array<G>{
//        var descList = Array<G>()
//        for sensorData in List {
//            descList.append(createSensorDescVectorValue(sensorData))
//            
//        }
//        return descList
//    }
//    
//    func createDummyObject()-> G{
//        fatalError("Must Override")
//    }
//    
//    func getTimeRange(desc_list : Array<G>, s : Array<Float>, e : Array<Float>)-> Array<G>{
//        //array start s val1,2,3
//        //array end e
//        
//        var answer = Array<G>()
//        
//        for var i=0; i<desc_list.count ; ++i{
//            
//            let sensDesc = desc_list[i]
//            var temp = sensDesc.getValue()
//            var t = true
//            for var i = 0;i < temp.count ;++i{
//                if(temp[i]<=e[i] && temp[i]>=s[i]){
//                    t = true
//                }
//                else{
//                    t = false
//                    break
//                }
//                
//            }
//            if(t == true){
//                answer.append(sensDesc)
//            }
//        }
//        
//        return answer
//        
//    }
//    
//    func getMaxValue()-> G{
//        var maxSensDesc = createDummyObject()
//        var maxVal = FLT_MIN
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            var f :Float = 0
//            for var i = 0;i < temp.count;++i{
//                f += temp[i]
//            }
//            if(f > maxVal){
//                maxVal = f
//                maxSensDesc = sensDesc
//            }
//        }
//        
//        return maxSensDesc
//    }
//    
//    func getMinValue()-> G{
//        var minSensDesc = createDummyObject()
//        var minVal = FLT_MAX
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var f :Float = 0
//            var temp = sensDesc.getValue()
//            for var i = 0;i < temp.count;++i{
//                f += temp[i]
//            }
//            if(f < minVal){
//                minVal = f
//                minSensDesc = sensDesc
//            }
//        }
//        
//        return minSensDesc
//    }
//    
//    func getAverage()-> Array<Float>{
//        
//        var totalSum = Array<Float>()
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i < temp.count;++i{
//                totalSum[i] += temp[i]
//            }
//        }
//        for var i = 0;i < totalSum.count;++i{
//            totalSum[i] = totalSum[i]/Float(List.count)
//        }
//        
//        return totalSum
//    }
//    
//    func sd()-> Array<Float>{
//        
//        var temp = variance()
//        for var i=0;i<temp.count;++i{
//            temp[i] = sqrt(temp[i])
//        }
//        return temp
//    }
//    
//    
//    func variance()-> Array<Float>{
//        var sd = Array<Float>()
//        let av = getAverage() // array
//        var average = av
//        
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var t = sensDesc.getValue()
//            for var i = 0;i < t.count ; ++i{
//                sd[i] += powf(average[i]-t[i],2)
//            }
//            //temp += (average - sensDesc.getValue())*(average - sensDesc.getValue())
//        }
//        for var i = 0;i < sd.count ; ++i{
//            sd[i] = sd[i]/Float(List.count)
//        }
//        
//        return sd
//    }
//    
//    func getRms()->Array<Float>{
//        
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i<temp.count;++i{
//                totalSum[i] += powf(temp[i],2)
//            }
//            
//        }
//        for var i = 0;i<totalSum.count;++i{
//            totalSum[i] = sqrt(totalSum[i]/Float(List.count))
//        }
//        return totalSum
//        
//    }
//    
//    func getMeanSquare()->Array<Float>{
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i<temp.count;++i{
//                totalSum[i] += powf(temp[i],2)
//            }
//            
//        }
//        for var i = 0;i<totalSum.count;++i{
//            totalSum[i] = totalSum[i]/Float(List.count)
//        }
//        return totalSum
//    }
//    
//    func getSum()->Array<Float>{
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i<temp.count;++i{
//                totalSum[i] += temp[i]
//            }
//            
//        }
//        
//        return totalSum
//        
//    }
//    
//    func getSumSquare()->Array<Float>{
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i<temp.count;++i{
//                totalSum[i] += powf(temp[i],2)
//            }
//            
//        }
//        
//        return totalSum
//        
//    }
//    
//    func getRmsError(comp : Array<Float>)-> Array<Float>{
//        /*var answer = Array<Float>()
//        var temp : Float = 0
//        var data = comp[0] //only 1 value
//        for sensorData in List{
//        var sensDesc = createSensorDescSingleValue(sensorData)
//        temp += powf(sensDesc.getValue()-data, 2)
//        }
//        temp = sqrt(temp/Float(List.count))
//        answer.append(temp)
//        return answer*/
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i = 0;i<temp.count;++i{
//                totalSum[i] += powf(temp[i]-comp[i],2)
//            }
//            
//        }
//        for var i = 0;i<totalSum.count;++i{
//            totalSum[i] = totalSum[i]/Float(List.count)
//        }
//        return totalSum
//    }
//    
//    func getMedian()-> Array<Float>{
//        var temp = Array<Float>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescVectorValue(sensorData))
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
//        var middle = Array<Float>()
//        if(List.count%2 == 0){
//            middle = desc_list[List.count/2].getValue()
//        }
//        else
//        {let tt = desc_list[0].getValue()
//            var arr1 = desc_list[List.count/2].getValue()
//            var arr2 =  desc_list[List.count/2+1].getValue()
//            for var i=0;i<tt.count;++i{
//                middle[i] = arr1[i] + arr2[i]
//            }}
//        
//        
//        return middle
//    }
//    
//    func compare(obj1 : G, obj2 : G)->Bool{
//        //if return 0 first larger than second
//        //else 1
//        var arr1 = Array<Float>()
//        var arr2 = Array<Float>()
//        arr1 = obj1.getValue()
//        arr2 = obj2.getValue()
//        var sum1 : Float = 0
//        var sum2 : Float = 0
//        for var i=0;i<arr1.count;++i{
//            sum1 += arr1[i]
//            sum2 += arr2[i]
//        }
//        if(sum1 >= sum2){
//            return false
//        }
//        if(sum1 < sum2){
//            return true
//        }
//        return false
//    }
//    
//    
//    
//    
//    //largest 10 output
//    func getLargest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescVectorValue(sensorData))
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
//        }
//        return descList
//        
//    }
//    //smallest 10
//    func getSmallest(k : Int)->Array<G>{
//        var descList = Array<G>()
//        var desc_list = Array<G>()
//        for sensorData in List{
//            desc_list.append(createSensorDescVectorValue(sensorData))
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
//            desc_list.append(createSensorDescVectorValue(sensorData))
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
//            desc_list.append(createSensorDescVectorValue(sensorData))
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
//        //comp had 3 avriable
//        //comp 1 has 3 variables
//        var moo = Array<Float>()
//        var avg = Array<Float>()
//        var avg1 = Array<Float>()
//        
//        var a = [[Float]]()
//        var b = [[Float]]()
//        
//        for var i=0;i<comp.count;++i{
//            var temp = comp[i].getValue()
//            for var j = 0;j < temp.count;++j{
//                avg[j] +=  temp[j]
//            }
//        }
//        for var i=0;i<comp1.count;++i{
//            var temp = comp1[i].getValue()
//            for var j = 0;j < temp.count;++j{
//                avg1[j] +=  temp[j]
//            }
//        }
//        
//        for var i=0;i<avg.count;++i{
//            avg[i] = avg[i]/Float(comp1.count)
//            avg1[i] = avg1[i]/Float(comp1.count)
//        }
//        
//        for var i=0;i<comp.count;++i{
//            var temp = comp[i].getValue()
//            for var j = 0;j<comp.count;++j{
//                temp[j] = temp[j] - avg[j]
//            }
//            a.append(temp)
//        }
//        
//        for var i=0;i<comp1.count;++i{
//            var temp = comp1[i].getValue()
//            for var j = 0;j<comp1.count;++j{
//                temp[j] = temp[j] - avg[j]
//            }
//            b.append(temp)
//        }
//        
//        var top = Array<Float>()
//        var bota = Array<Float>()
//        var botb = Array<Float>()
//        
//        for var i=0;i<comp1.count;++i{
//            var temp = comp[i].getValue()
//            var temp1 = comp1[i].getValue()
//            for var j=0;j<comp1.count;++j{
//                top[j] += temp[j]*temp[j]
//                
//                bota[j] += powf(temp[j],2)
//                
//                botb[j] += powf(temp1[j],2)
//            }
//        }
//        
//        for var i=0;i<comp1.count;++i{
//            moo[i] = top[i]/(bota[i]*botb[i])
//        }
//        return moo
//        
//        
//        
//        
//        
//        
//    }
//    
//    func getEntropy()->Array<Float>{
//        var n = [[Float]]()
//        var ent = Array<Float>()
//        var totalSum = Array<Float>()
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            var temp = sensDesc.getValue()
//            for var i=0;i<temp.count;++i{
//                totalSum[i] += temp[i]//sum of each variable
//            }
//        }
//        var coun : Int = 0
//        var prob = Array<Float>()
//        var j :Int = 0 //
//        for sensorData in List{
//            let sensDesc = createSensorDescVectorValue(sensorData)
//            // var temp = sensDesc.getValue() / totalSum
//            var temp = sensDesc.getValue()
//            coun = temp.count
//            for var i=0;i<temp.count;++i{
//                n[j][i] = temp[i]/totalSum[i]
//            }
//            //prob.append(temp)
//            j++
//        }
//        for j=0;j<List.count;++j{
//            for var i = 0;i < coun;++i{
//                ent[i] += n[j][i] * log(1/n[j][i])
//                //ent += prob[i] * log(1/prob[i])
//            }
//        }
//        return ent
//        
//        
//    }
//}
//
//
//
