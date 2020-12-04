//
//  Helper.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import Foundation

class Helper{
    
    //MARK: Handle Nil  values
    class func checkNullAndPassValue(stringPassed:Any?) -> String
    {
        var valueString = String()
        if stringPassed == nil {
            valueString = ""
        }
        else {
            if (stringPassed! is NSNull == true)
            {
                valueString = ""
            }
            else
            {
                if (stringPassed! is NSNumber) {
                    valueString = (stringPassed as! NSNumber).stringValue
                }
                else {
                    valueString = stringPassed as! String
                }
            }
            
        }
        return valueString
    }
}
