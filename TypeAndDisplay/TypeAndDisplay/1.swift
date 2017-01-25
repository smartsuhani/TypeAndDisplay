//
//  1.swift
//  TypeAndDisplay
//
//  Created by Devloper30 on 09/01/17.
//  Copyright © 2017 lanetteamLanet. All rights reserved.
//

import Foundation

public class nameit{
    var name:String
    public init(name:String){
        self.name = name
    }
    public func take(){
        self.name = readLine()!
    }
    public func put(){
        print(self.name)
    }
}
