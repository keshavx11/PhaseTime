//
//  WebClient.swift
//  PhaseTime
//
//  Created by Keshav Bansal on 10/07/18.
//  Copyright © 2018 Keshav Bansal. All rights reserved.
//

import UIKit
import ObjectMapper

//typealias getDutyCallback = (_ response: [PinnedLocation]?,_ error: NSError?) -> Void
//
//class WebClient: NSObject {
//    
//    class func getRosterData(callback: @escaping getDutyCallback) {
//        let urlString = "https://get.rosterbuster.com/wp-content/uploads/dummy-response.json"
//        if let url = URL(string: urlString) {
//            URLSession.shared.dataTask(with:url) { (data, response, error) in
//                if let data = data, error == nil {
//                    do {
//                        let parsedData = try JSONSerialization.jsonObject(with: data, options: [])
//                        if let duties = Mapper<PinnedLocation>().mapArray(JSONObject: parsedData) {
//                            callback(duties, nil)
//                        }
//                    } catch let error as NSError {
//                        print(error)
//                        callback(nil, error)
//                    }
//                } else if let error = error as NSError? {
//                    print(error)
//                    callback(nil, error)
//                } else {
//                    callback(nil, nil)
//                }
//                }.resume()
//        }
//    }
//    
//}
