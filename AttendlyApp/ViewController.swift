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
        db.collection("Unistudent").getDocuments{ (querySnapshot,error) in
            if let er = error {
            print("FAAAAAIIIIILLLL \(er)")}
            else{
                if let snapshot = querySnapshot?.documents {
                    for doc in snapshot{
                            print(doc.data())
                }
                
            }
            }}}
      /*  db.collection("Unistudent").addDocument(data: ["advisorID": "441111111", "major" :"SWE","sFirstN":"Amani","sLastN":"Aldahmash","studentID":"441204066"])
        {error in
            if let error = error {
                print("FAAAAAIIIIILLLL \(error)")
            }
            else{
                print("YESSSSSSSSSSS")
            }
        }
       */
  
}
