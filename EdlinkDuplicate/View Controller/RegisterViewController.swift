//
//  RegisterViewController.swift
//  EdlinkDuplicate
//
//  Created by Muhammad Syabran on 07/01/21.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var perintahDaftarText: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var namaTextField: UITextField!
    @IBOutlet weak var sandiTextField: UITextField!
    @IBOutlet weak var ulangSandiTextField: UITextField!
    @IBOutlet weak var daftarButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
        perintahDaftarText.text = "Silahkan lengkapi data dibawah untuk daftar akun Edlink"
        perintahDaftarText.preferredMaxLayoutWidth = 322
        
        styleTextField(emailTextField)
        styleTextField(namaTextField)
        styleTextField(sandiTextField)
        styleTextField(ulangSandiTextField)
        
        daftarButton.layer.cornerRadius = 5.0
    }
    // untuk validasi data yang di isi dalam field benar atau salah
    func validateFields() -> String? {
        
        // memastikan field tidak kosong
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            namaTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            sandiTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        ulangSandiTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Tolong isi semua kolom."
        }
        
        
        return nil
    }
    
    @IBAction func daftarButtonTapped(_ sender: Any) {
        
        // validasi data
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        } else {
            
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let nama = namaTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let sandi = sandiTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // create user
            Auth.auth().createUser(withEmail: email, password: sandi) { (result, err) in
                //check for error
                if err != nil {
                    self.showError("Error creating user")
                    
                } else {
                    // untuk store nama user
                    let db = Firestore.firestore()
                    
                    db.collection("users").addDocument(data: ["namaLengkap":nama, "uid": result!.user.uid]) { (error) in
                        
                        if error != nil {
                            
                            //show error
                            self.showError("Error saving data")
                        }
                    }
                    // to beranda screen
                    self.transitionBeranda()
                }
            }
        }
        
        // create user
        
        
    }
    
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionBeranda() {
        
        let mainTabController = storyboard?.instantiateViewController(withIdentifier: "MainTabController") as! MainTabController
        
        present(mainTabController, animated: true, completion: nil)
    }
    
    func styleTextField(_ textfield:UITextField) {
        
        // warna garis bawah text field
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        textfield.layer.addSublayer(bottomLine)
        
        // Remove border
        textfield.borderStyle = .none
        
    }
    // for hide keyboard by touch view
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // for hide keyboard by return
    private func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return (true)
    }
}
