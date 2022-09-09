//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore

//import Firebase
//import FirebaseDatabse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStats()}
    
    func loadStats(){
      
        let db = Firestore.firestore()
        db.collection("Unistudent").addDocument(data: ["name": "Amani", "major" :"SWE"])
        {(error) in
            if error != nil{
                
            }
            else{
                
            }
        }}}


/*
    func post(){
        let db = Firestore.firestore()
        db.collection("Unistudent").document("jhkPjKIZ4mj9ZisvgjFb")
        //.getDocument()
        
    }*/

