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
        loadStats()
        
    }
    
    func loadStats(){
      
        let db = Firestore.firestore()
        db.collection("Unistudent").addDocument(data: ["advisorID": "441111111", "major" :"SWE","sFirstN":"Amani","sLastN":"Aldahmash","studentID":"441204066"])
        {error in
            if let error = error {
                print("FAAAAAIIIIILLLL \(error)")
            }
            else{
                print("YESSSSSSSSSSS")
            }
        }}}


/*
    func post(){
        let db = Firestore.firestore()
        db.collection("Unistudent").document("jhkPjKIZ4mj9ZisvgjFb")
        //.getDocument()
        
    }*/

