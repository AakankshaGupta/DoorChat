
//  HTTPManager.swift
//  DoorChat
//
//  Created by Aseem14 on 23/02/16.
//  Copyright © 2016 Aseem14. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON
import AFNetworking


class HTTPManager: NSObject
{
    
    static func mainapi(path: String , withParameters parameters : [String : String], success : (AnyObject?) -> () , failure : (NSError) -> ())
    {
        let url1 = path
        
        Alamofire.request(.POST, url1,parameters: parameters,encoding : ParameterEncoding.URL,headers: nil).responseJSON {response in
            switch response.result
            {
            case.Success(let data):
                success(data)
                
            case.Failure(let error):
                failure(error)
            }
        }
    }
    
    static func postPath(path : String , withParameters  paramerters : [String : String] , success : (AnyObject?) -> () , failure : (NSError) -> () )
    {
        
        let url = path
        Alamofire.request(.GET, url).responseJSON { response in
            switch response.result {
            case .Success(let data):
                success(data)
            case .Failure(let error):
                failure(error)
            }
        }
    }
    
    static func postFileWithParameters (path : String , paramerters : [String : String] , profilePic : UIImage? , success : (AnyObject?) -> () , failure : (NSError) -> ()){
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.POST(path, parameters: paramerters , constructingBodyWithBlock: { (formData) -> Void in
            
            if let ppic = profilePic,data = UIImageJPEGRepresentation(ppic, 0.5){
                
                formData.appendPartWithFileData(data, name:"image" ,fileName:"temp.png" , mimeType: "image/png")
            }
            
            }, success: { (operation, response) -> Void in
                
                do{
                    success( try NSJSONSerialization.JSONObjectWithData(response as! NSData, options: .MutableLeaves))
                }catch{
                    
                }
                
                
            }) { (operation, error) -> Void in
                failure(error)
                
        }
    }
}