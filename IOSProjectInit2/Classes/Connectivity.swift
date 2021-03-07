//
//  Connectivity.swift
//  IOSProjectInit2
//
//  Created by MacOSSierra on 3/4/21.
//  Copyright © 2021 asmaa. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
        
    }
}
