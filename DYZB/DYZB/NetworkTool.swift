//
//  NetworkTool.swift
//  DYZB
//
//  Created by Aden Lee on 2018/11/20.
//  Copyright © 2018 Aden Lee. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethodType:String{
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

class NetworkTool {
    
}

extension NetworkTool{
    class func requestJSON(URLString:String, parameters:[String:Any]? = nil, finishedCallBack: @escaping (_ result:Any?)->()){
        
        Alamofire.request(URLString,parameters: parameters).responseJSON { (response) in
            if let json = response.result.value{
                finishedCallBack(json)
            }
        }
    }
    
    
    
    
}
