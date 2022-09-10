//
//  ViewController.swift
//  AttendlyApp
//
//  Created by SHAMMA  on 12/02/1444 AH.
//

import UIKit
import FirebaseFirestore
import CoreNFC

//import Firebase
//import FirebaseDatabse
// just a comment


class ViewController: UIViewController, NFCNDEFReaderSessionDelegate {


    @IBOutlet weak var NFCText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadStats()
        
    }
    
    func loadStats(){
      
        let db = Firestore.firestore()
        db.collection("Unistudent").getDocuments{ querySnapshot,error in
            if let er = error {
            print("FAAAAAIIIIILLLL \(er)")}
            else{
                if let snapshot = querySnapshot?.documents {
                    for doc in snapshot{
                            print(doc.data())
                }
                
            }
            }}}
      
    
    
    
    

    
    var nfcSession: NFCNDEFReaderSession?
    var type="None"
    
    @IBAction func ScanBtn(_ sender: Any) {
        nfcSession = NFCNDEFReaderSession.init(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold your iPhone near the Lecturer device  ."
        nfcSession?.begin()
    }
    
    
  
    
   
  
   
    
    override func  didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        print("The session was invalidated: \(error.localizedDescription)")
    }
    
    
    
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        var result = ""
        for payload in messages[0].records{ //,message saved in nfc tag
            result += String.init(data: payload.payload.advanced(by: 3), encoding: .utf8) ?? "Formate not supported"
        }
        DispatchQueue.main.async {
            self.NFCText.text = result
        }
    }
    
    
    
    
}
     
    
    
    
    
