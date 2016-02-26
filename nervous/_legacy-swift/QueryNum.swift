////
////  QueryNum.swift
////  nervousnet
////
////  Created by Ramapriya Sridharan on 20/05/2015.
////  Copyright (c) 2015 ethz. All rights reserved.
////
//
//import UIKit
//
//
//protocol QueryNum : Query{
//    
//    typealias G : SensorDesc
//    
//    init(from : UInt64, to : UInt64)
//    
//    
//    func createDummyObject() -> G
//    
//    func getSensorDescriptorList() -> Array<G>
//    
//    func getTimeRange(desc_list : Array<G>, start : Array<Float>,end : Array<Float>) -> Array<G>
//    
//    func getMaxValue() -> G
//    
//    func sd()-> Array<Float>
//    
//    func variance() -> Array<Float>
//    
//    func getMinValue() -> G
//    
//    func getSum() -> Array<Float>
//    
//    func getLargest(k : Int) -> Array<G>
//    
//    func getSmallest(k : Int) -> Array<G>
//    
//    func getMedian() -> Array<Float>
//    
//    func getRms() -> Array<Float>
//    
//    func getMeanSquare() -> Array<Float>
//    
//    func getSumSquare() -> Array<Float>
//    
//    func getRankLargest(n : Int) -> G
//    
//    func getRankSmallest(n:Int) -> G
//    
//    func getRmsError(comp : Array<Float>) -> Array<Float>
//    
//    func getCorrelation(comp : Array<G>,comp1 : Array<G>) -> Array<Float>
//    
//    func getEntropy() -> Array<Float>
//    
//    func getAverage() -> Array<Float>
//    
//    func getKmeans(n : Int,initialize : Array<Float>) -> Array<Float>
//    
//}
//
