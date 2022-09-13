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
    
    @IBOutlet weak var validationMassege: UILabel!
    
    // @IBOutlet weak var emailError: UILabel!
    //@IBOutlet weak var passError: UILabel!
    
    @IBOutlet weak var validationMessegepass: UILabel!
    @IBOutlet weak var buttonlogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        validationMassege.isHidden = true
        validationMessegepass.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func isValid() -> (Bool, String, String) {
        validationMassege.isHidden = true   // not show
        validationMessegepass.isHidden = true
        
        guard let email = emailTextfiled.text?.trimmingCharacters(in: .whitespaces)
        else {
            validationMassege.isHidden = false
            validationMassege.text = "please Enter your Email"
            return (false, "", "")
        }
        guard let password = passwordTextfiled.text, !password.isEmpty else {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "please Enter your password"
            return (false, "", "")
        }
        if !isValidEmail(emailID: email) {
            validationMassege.isHidden = false
            validationMassege.text = "Please enter valid email address"
            return (false, "", "")
        }
        if password.count != 8 {
            validationMessegepass.isHidden = false
            validationMessegepass.text = "Please enter password with 8 number is"
            return (false, "", "")
        }
        
        
        return (true, email, password)
    }
        
        
        
        
        @IBAction func loginpressed(_ sender: Any) {
            //  resetForm()
            
            let validationResult = isValid()
            if validationResult.0 == false {
                return
            }
            
            let email = validationResult.1
            let password = validationResult.2
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e=error{   //if no connect with firebase
                    print("failed")
                    print(e)
                }else{   //user Auth in firebase
                    print("sucsses")
                    
                    Task {
                        if await self.checkEmailExist(email: email, collection: "Unistudent", field: "EmailStudent") {
                            // if self.isValidEmailSttudent (emailID: email) == true  {
                            //   self.storeUserInformation()
                            // }
                            if await !self.checkEmailExist(email: email, collection: "Appstudent", field: "EmailStudent") {
                                await self.storeUserInformation(collection: "Appstudent", data: ["EmailStudent": email])
                            }
                            
                            print("student exists")
                            self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            Global.shared.useremailshare = email
                            // students view
                        }
                        else if await self.checkEmailExist(email: email, collection: "Lectures", field: "EmailLectures") {
                        
                            if await !self.checkEmailExist(email: email, collection: "Lecturer", field: "EmailLecture") {
                                await self.storeUserInformation(collection: "Lecturer", data: ["EmailLecture": email])
                            }
                            
                            print("lectures exists")
                          //  if self.isValidEmailLectures(emailID: email) == true  {
                              //  self.storeLecturesInformation() }
                            
                            self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            Global.shared.useremailshare = email
                            // lectures view
                        }
                        else {
                            print("not exists")
                            let alert = UIAlertController(title: "Error", message: "No Exist User ,try agin", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            //  self.storeUserInformation()
                            // self.performSegue(withIdentifier: "gotoStudents", sender: self)
                            // Global.shared.useremailshare = email
                            
                        }
                    }
                }}
        }   //end if
    
    //
    
    
    func isValidEmail(emailID:String) -> Bool {
        //      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        //   let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailSttudent(emailID:String) -> Bool {
        //      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        //   let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    func isValidEmailLectures(emailID:String) -> Bool {
        //      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        //   let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"
        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
    
    //end
    
    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {
       // print("what??")
        let db = Firestore.firestore()
        do {
            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()
            print("COUNT ", snapshot.count)
            print("not added")
            return snapshot.count != 0
        } catch {
            print(error.localizedDescription)
            print("added")
            return false
        }
        
        //return false
    }
    
    func storeUserInformation(collection: String, data: [String: Any]) async {
        //  var ref: DocumentReference? = nil
        // guard let uid=Auth.auth().currentUser?.uid else {return }
        let db = Firestore.firestore()
        do {
            try await db.collection(collection).document().setData(data)
        } catch {
            print(error.localizedDescription)
        }
    }  //end func
    
    
    
    
//    func storeLecturesInformation(){
//        //  var ref: DocumentReference? = nil
//        // guard let uid=Auth.auth().currentUser?.uid else {return }
//
//        Firestore.firestore().collection("Lecturer").addDocument(data: [
//            "EmailStudent": emailTextfiled.text,
//            "counter": "" ,
//            "date": ""  ,
//            "sectionID": "" ,
//            "studentID": "" ,
//            "time":""
//
//        ]) { err in
//            if let err = err {
//                print("Error adding Lecturer  : \(err)")
//            } else {
//                print("Lecturer added sucsseful ")
//            }
//        }
//    }
    
    
    
    
    
    
}
