//
//  WebManager.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
class WebManager: NSObject {
    let BASE_API_URL = "https://api.github.com"
    private override init(){}
    static let sharedInstance: WebManager = WebManager()
    //    let PULL_REQUEST_BASE_URL = "https://api.github.com/repos/%@/pulls"
    
    func starsRequest(language: String, page: Int, callback:@escaping (_ error: Bool, _ message: String, _ stadimus: [Repository]?) -> Void) {
        let url = "\(BASE_API_URL)/search/repositories?q=language:Java&sort=stars&page=\(page)"
        Alamofire.request(url).responseArray(keyPath: "items") { (response: DataResponse<[Repository]>)  in
            if let repositories = response.result.value {
                callback(false, "Success!", repositories)
            } else {
                callback(true, "Error!", nil)
            }
        }
    }
}