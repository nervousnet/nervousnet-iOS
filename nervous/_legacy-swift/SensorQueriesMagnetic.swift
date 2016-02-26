//
//import UIKit
//
//class SensorQueriesMagnetic<T : SensorDescMagnetic> : QueryNumVectorValue<SensorDescMagnetic>{
//    
//    var T : SensorDescMagnetic
//    init(f :UInt64,t :UInt64){
//        let m = SensorDescMagnetic(timestamp: 0,magX: 0,magY: 0,magZ: 0)
//        T = m
//        super.init(from: f, to: t)
//        
//    }
//    
//    override func getSensorID() -> UInt64 {
//        return T.getSensorId()
//    }
//    
//    override func createDummyObject()->SensorDescMagnetic{
//        let m = SensorDescMagnetic(timestamp: 0,magX: 0,magY: 0,magZ: 0)
//        return m
//    }
//    
//    override func createSensorDescVectorValue(sensorData: SensorUploadSensorData) -> SensorDescMagnetic{
//        let m = SensorDescMagnetic( sensorData : sensorData )
//        return m
//    }
//    
//    
//    
//    
//    
//    
//}