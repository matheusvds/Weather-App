//
//  FirebaseManager.swift
//  Weather
//
//  Created by Matheus Vasconcelos on 28/09/18.
//  Copyright © 2018 Matheus Sousa. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    
    fileprivate static let user = Auth.auth().currentUser
    fileprivate static let userReference = Database.database().reference().child("users")
    
    static func saveUser(data: [String : Any]) {
        guard let userID = user?.uid else {
            print("user is not logged in")
            return
        }
        userReference.child(userID).setValue(data)
    }
        
}
