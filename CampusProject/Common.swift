//
//  Common.swift
//  CampusProject
//
//  Created by Yadikaer on 7/8/15.
//  Copyright (c) 2015 Yadikaer. All rights reserved.
//

import Foundation

public class Common {
    
    public static func errorCodeToStr(code : Int) -> String{
        
        switch(code){
         
        default:
            break
        }
        
        return "str"
    }


    public static func getUser(id:String) -> AVUser{
        
        let query : AVQuery = AVQuery(className: "_User")
        var obj : AVObject = query.getObjectWithId(id)
        
        return obj as! AVUser
    }
    
    public static func getFileObj(id:String) -> AVObject{
        
        let query : AVQuery = AVQuery(className: "_File")
        var obj  = query.getObjectWithId(id)

        return obj
    }

}

    