//
//  EFMStateMachine.swift
//  EFMMenswear
//
//  Created by KEEVIN MITCHELL on 2/17/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import Foundation
@objc protocol EFMStateMachineDelegate{
   class func stateWillChange()
   class func stateDidChange()
}

@objc class EFMStateMachine: NSObject {
    
//    var currentState = String()
//    var validTransitions: [Dictionary<String, Int>]  = []
//    var shouldLogStateTransitions = true
    
    var currentState: String
    var validTransitions: [Dictionary<String, Int>]  = []
    var shouldLogStateTransitions: Bool?
    
    
    
    private var lock = OSSpinLock()
    
    
    func appyState (state: String) -> Bool{
        
        return true
    }
    
    /*
    func missingTransitionFromState(fromState:String?, toState: String?) -> String{
        if toState == nil {
            println(" cannot transition to <nil> state\(self)")
            toState =
            
        }
*/
        
        
        struct Scaling {
           
            static let AAPLStateNil: String = "Nil";
        
        
    }
    
     init(currentState: String) {
         lock = OS_SPINLOCK_INIT
        self.currentState = currentState
        super.init()
    }
    
    func target() -> AnyObject{
    // var EFMDelegate = EFMStateMachineDelegate()
        return self
        
    }


    
    
    }
    
    


