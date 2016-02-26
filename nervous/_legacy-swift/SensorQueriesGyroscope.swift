//
//
//import UIKit
//
//class SensorQueriesGyroscope<T : SensorDescGyroscope> : QueryNumVectorValue<SensorDescGyroscope>{
//    
//    var T : SensorDescGyroscope
//    init(f :UInt64,t :UInt64){
//        let m = SensorDescGyroscope(timestamp: 0,gyrX: 0,gyrY: 0,gyrZ: 0)
//        T = m
//        super.init(from: f, to: t)
//        
//    }
//    
//    override func getSensorID() -> UInt64 {
//        return T.getSensorId()
//    }
//    
//    override func createDummyObject()->SensorDescGyroscope{
//        let m = SensorDescGyroscope(timestamp: 0,gyrX: 0,gyrY: 0,gyrZ: 0)
//        return m
//    }
//    
//    override func createSensorDescVectorValue(sensorData: SensorUploadSensorData) -> SensorDescGyroscope{
//        let m = SensorDescGyroscope( sensorData : sensorData )
//        return m
//    }
//    
//    
//    
//    
//    
//    
//}