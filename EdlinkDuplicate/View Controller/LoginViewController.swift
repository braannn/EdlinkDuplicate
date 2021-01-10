//
//  LoginViewController.swift
//  EdlinkDuplicate
//
//  Created by Muhammad Syabran on 07/01/21.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var selamatDatangText: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sandiTextField: UITextField!
    @IBOutlet weak var masukButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selamatDatangText.text = "Selamat datang, masukkan email dan kata sandi untuk masuk ke akun anda"
        selamatDatangText.preferredMaxLayoutWidth = 322
        
        styleTextField(emailTextField)
        styleTextField(sandiTextField)
        
        masukButton.layer.cornerRadius = 5.0
    }
    

    @IBAction func masukButtonTapped(_ sender: Any) {
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let sandi = sandiTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        Auth.auth().signIn(withEmail: email, password: sandi) { (result, error) in
            if error != nil {
                // jika tidak bisa masuk atau sign in
                let alert = UIAlertController(title: "Error", message: "\(error!.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else {
                // to beranda screen
                self.transitionBeranda()
            }
            
        }
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
