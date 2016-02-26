//
// Created by Ramapriya Sridharan on 19/05/15.
// Copyright (c) 2015 ethz. All rights reserved.
//

import Foundation
import Cocoa

class QueryNumSingleValue<G : SensorDescSingleValue> : QueryNum<G> {

    init(timestamp_from : Int64,timestamp_to : Int64, file : NSFileHandle){
        super.init();
    }

    func createSensorDescSingleValue(sensorData : SensorUploadSensorData){}//abstract


    // return desc list for sensor
    func getSensorDescriptorList() -> Array<G>{

        var descList = Array<G>()
        for sensorData in List{ //check the loop
            descList.append(createSensorDescSingleValue(sensorData));
        }
        return descList
    }

    func getTimeRange(desc_list : Array<G>, s : Array<Float>, e : Array<Float>)
    {
         var start = s[0]
         var end = e[0]
        var answer = Array<G>()
        for var i=0;i<desc_list.count;++i {
            var sensDesc = desc_list[i] //type G
            if (sensDesc.getValue() <= end && sensDesc.getValue() >= start) {
                answer.append(sensDesc)
            }

        }
        return answer
    }

    func sd() -> Array<Float>{
        var sd = Array<Float>()
        var totalSum = 0
        for sensorData  in List{
            var sensDesc = createSensorDescSingleValue(sensorData)
            totalSum += sensorData.getValue()
        }
        var average = totalSum / (List.count)
        var temp = 0
        for sensorData in List{
            var senDesc = createSensorDescSingleValue(sensorData)
            temp += (average - sensorDesc.getValue())*(average - sensDesc.getValue());
        }

        temp = temp / List.count
        temp = sqrt(temp);
        sd.append(temp)
    }


}
