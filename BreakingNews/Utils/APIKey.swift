//
//  APIKey.swift
//  BreakingNews
//
//  Created by Robert P on 17.03.2021.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "Key", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    
    return value
}
