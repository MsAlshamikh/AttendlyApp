//
//  loginController.swift
//  AttendlyApp
//
//  Created by Sara Alsaleh on 13/02/1444 AH.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
//var useremailshare : String = ""

class loginController: UIViewController {
    
    
    @IBOutlet weak var emailTextfiled: UITextField!
    @IBOutlet weak var passwordTextfiled: UITextField!
    
    
    // @IBOutlet weak var emailError: UILabel!
    //@IBOutlet weak var passError: UILabel!
    
    @IBOutlet weak var buttonlogin: UIButton!
    
    
    
    // override func viewDidLoad() {
    //   super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    // resetForm()
    //  }
    /* func resetForm(){
     buttonlogin.isEnabled=false
     emailError.isHidden=false
     passError.isHidden=false
     
     emailError.text="Required"
     passError.text="Required"
     
     emailTextfiled.text=""
     passwordTextfiled.text=""
     }*/
    
    
    
    
    @IBAction func loginpressed(_ sender: Any) {
        //  resetForm()
        if let email=emailTextfiled.text,let password=passwordTextfiled.text{
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                //  guard let strongSelf = self else { return }
                if let e=error{   //if no connect with firebase
                    print(e)
                }else{   //user Auth in firebase
               //     self.performSegue(withIdentifier: "LaunchScreen", sender: self)
                    print("sucsses")
                    self.checkUserExist(emailckeck: email) { exist in
                        if  exist {
                            print("exist user in Appstudent")
                       self.performSegue(withIdentifier: "movetoo", sender: self)
                            Global.shared.useremailshare = email
                        }
                        else{
                            print("not exist in Appstudent")
                            self.storeUserInformation()
                        }
                    }
                }}
    }
    }
    
    
    //end
    
    func checkUserExist(emailckeck:String, callback:@escaping (Bool) -> () )  {
        let db = Firestore.firestore()
        db.collection("Appstudent").whereField("EmailStudent", isEqualTo:emailckeck).getDocuments { snapshot, error in
            if let error = error {
                print("failed connection")
            }
            if let snapshot=snapshot {
                if snapshot.count==0{
                    
                    callback(false) }
                else{
                    callback(true)
                }
            }
            
            
        }
        }
        
    
    
    
    
    func storeUserInformation(){
        //  var ref: DocumentReference? = nil
        // guard let uid=Auth.auth().currentUser?.uid else {return }
        
        Firestore.firestore().collection("Appstudent").addDocument(data: [
            "EmailStudent": emailTextfiled.text,
            "counter": "" ,
            "date": ""  ,
            "sectionID": "" ,
            "studentID": "" ,
            "time":""
            //  "uid":uid
        ]) { err in
            if let err = err {
                print("Error adding Appstudent : \(err)")
            } else {
                print("Appstudent added sucsseful ")
            }
        }
    }  //end func
    
    
    
    
    /*  if  let emstore=emailTextfiled.text,let passtore=passwordTextfiled.text{
     guard let uid=Auth.auth().currentUser?.uid else {return }
     let userData = ["Email":self.emstore ,"passw":passtore,"uid":uid]
     Firestore.firestore().collection("studentApp ")
     .document(uid).setData(userData){err in
     if let err = err {
     print(err)
     //  self.statusMessage = "\(err)"
     return
     }
     print("sucsee ")
     }
     }
     */
    
    /* func textFieldDidEndEditing(_ textField: UITextField) {
     if activeField == emailTextfiled.text{
     if textField.text?.isEmpty == false {
     textField.checkUsername(field: emailTextfiled.text!) { (success) in
     if success == true {
     print("Username is taken") // Perform some action
     } else {
     print("Username is not taken")// Perform some action
     }
     }
     }
     }
     
     }  //ende
     func checkUsername(field: String, completion: @escaping (Bool) -> Void) {
     let collectionRef = Firestore.firestore().collection("Appstudent")
     collectionRef.whereField("EmailStudent", isEqualTo: field).getDocuments { (snapshot, err) in
     if let err = err {
     print("Error getting document: \(err)")
     } else if (snapshot?.isEmpty)! {
     completion(false)
     } else {
     for document in (snapshot?.documents)! {
     if document.data()["EmailStudent"] != nil {
     completion(true)
     }
     }
     }
     }
     }  //end*/
    
    
    
    // @IBAction func emailChange(_ sender: Any) {
    // }
    
    
    
    // @IBAction func passChange(_ sender: Any) {
    //}
    
    
    
    
    
    
    
    
}
