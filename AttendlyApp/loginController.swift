//
//  loginController.swift
//  AttendlyApp
//
//  Created by Amani Aldahmash on 11/09/2022.
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

    

    

    

    

    @IBAction func loginpressed(_ sender: Any) {
    

        //  resetForm()

        validationMassege.isHidden = true

        validationMessegepass.isHidden = true

        

        if let email=emailTextfiled.text,let password=passwordTextfiled.text{

            

            guard let emailis =  self.emailTextfiled.text, !email.isEmpty else {

                validationMassege.isHidden = false

                validationMassege.text = "please Enter your Email"

                return

            }

            if isValidEmail(emailID: emailis) == false {

                validationMassege.isHidden = false

                validationMassege.text = "Please enter valid email address"

            }

            guard let passw =  self.passwordTextfiled.text, !passw.isEmpty else {

                validationMessegepass.isHidden = false

                validationMessegepass.text = "please Enter your password"

                return

            }

            if password.count != 8{

                validationMessegepass.isHidden = false

                validationMessegepass.text = "Please enter password with 8  number"

            }

            

            //validationMassege.isHidden = true

            //  validationMessegepass.isHidden = true

            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in

                //  guard let strongSelf = self else { return }

                if let e=error{   //if no connect with firebase

                    //error creating account

                    let alert = UIAlertController(title: "Error", message: "No Exist User ,try agin", preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

                    self.present(alert, animated: true, completion: nil)

                    

                    print(e)

                }else{   //user Auth in firebase

                    //     self.performSegue(withIdentifier: "LaunchScreen", sender: self)

                    print("sucsses")

                    

                    Task {

                        if await self.checkEmailExist(email: email, collection: "Unistudent", field: "Emailstudent") {

                            print("student exists")

                           self.performSegue(withIdentifier: "gotoStudents", sender: self)

                            Global.shared.useremailshare = email

                            // students view

                        }

                        else if await self.checkEmailExist(email: email, collection: "Lectures", field: "EmailLectures") {

                            print("lectures exists")

                        self.performSegue(withIdentifier: "gotoStudents", sender: self)

                            Global.shared.useremailshare = email

                            // lectures view

                        }

                        else {

                            print("not exists")

                            

                            self.storeUserInformation()

                          self.performSegue(withIdentifier: "gotoStudents", sender: self)

                            Global.shared.useremailshare = email

                            

                        }

                    }
                }}

        }   //end if

    }

                    

                    ///

//                    self.checkUserExist(emailckeck: email) { exist in

//                        if  exist {

//                            print("exist student in Unistudent")

//

//                            self.checklectureExist(emailckeck: email) { exs in

//                                if  exs {

//                                    self.performSegue(withIdentifier: "movetoo", sender: self)

//                                    print("exist lecture in Lectures")

//                                    // self.performSegue(withIdentifier: "movetoo", sender: self)

//                                    Global.shared.useremailshare = email

//                                }

//                                else{

//                                    print(" lecture not exist in Lectures")

//                                  //  self.storeUserInformation()

//                                }

//                            }   //end checklectureExist

//

//                            Global.shared.useremailshare = email

//                        }

//                        else{

//                            print("student not exist in Unistudent")

//                            self.storeUserInformation()

//                        }

//                    }   //end checkuserExist(student)

   
    

    //

    

    

    func isValidEmail(emailID:String) -> Bool {

        //      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

     //   let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"

        let emailRegEx = "[0-9]+@[A-Za-z]+\\.[A-Za-z]{2,}+\\.[A-Za-z]{3,}+\\.[A-Za-z]{2,}"



        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)

        return emailTest.evaluate(with: emailID)

    }

    

    

    

    

    //end

    

    func checkEmailExist(email: String, collection: String, field: String) async -> Bool {

        let db = Firestore.firestore()

        do {

            let snapshot = try await db.collection(collection).whereField(field, isEqualTo: email).getDocuments()

            return snapshot.count != 0

        } catch {

            print(error.localizedDescription)

        }

        return false

    }

    

//    func checkUserExist(emailckeck:String, callback:@escaping (Bool) -> () )  {

//        let db = Firestore.firestore()

//        db.collection("Unistudent").whereField("Emailstudent", isEqualTo:emailckeck).getDocuments { snapshot, error in

//            if let error = error {

//                print("failed connection")

//            }

//            if let snapshot=snapshot {

//                if snapshot.count==0{

//                    //no student

//                    callback(false) }

//                else{

//              //      there student

//                    callback(true)

//                }

//            }

//        }

//    }

//    func checklectureExist(emailckeck:String, callback:@escaping (Bool) -> () )  {

//        let db = Firestore.firestore()

//        db.collection("Lectures").whereField("EmailLectures", isEqualTo:emailckeck).getDocuments { snapshot, error in

//            if let error = error {

//                print("failed connection")

//            }

//            if let snapshot=snapshot {

//                if snapshot.count==0{

//                    //no lecture in Lectures

//                    callback(false) }

//                else{

//                    //   there lecture in Lectures

//                    callback(true)

//                }

//            }

//        }

//    }

    

    

    

    

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

    
}
