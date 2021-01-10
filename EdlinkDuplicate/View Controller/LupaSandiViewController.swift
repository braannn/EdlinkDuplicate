//
//  LupaSandiViewController.swift
//  EdlinkDuplicate
//
//  Created by Muhammad Syabran on 10/01/21.
//

import UIKit
import Firebase

class LupaSandiViewController: UIViewController {

    @IBOutlet weak var perintahLupaSandiLabel: UILabel!
    @IBOutlet weak var emailTextFields: UITextField!
    @IBOutlet weak var kirimEmailButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        perintahLupaSandiLabel.text = "Masukkan alamat email anda untuk verifikasi perubahan sandi"
        perintahLupaSandiLabel.preferredMaxLayoutWidth = 322

        kirimEmailButton.layer.cornerRadius = 5.0
        
        styleTextField(emailTextFields)
    }
    
    @IBAction func kirimEmailTapped(_ sender: Any) {
        let email = emailTextFields.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)

                return
            }
            let alert = UIAlertController(title: "Sudah Terkirim", message: "Permintaan perubahan kata sandi sudah dikirim ke email anda!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
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
