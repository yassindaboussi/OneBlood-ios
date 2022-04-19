//
//  Created by Apple Esprit on 8/4/2022.
//

import UIKit

class Signup1ViewController: UIViewController {

  @IBOutlet weak var NameTxt: UITextField!
  @IBOutlet weak var EmailTxt: UITextField!
  @IBOutlet weak var PhoneTxt: UITextField!
  @IBOutlet weak var LocationTxt: UITextField!
  @IBOutlet weak var gifimage: UIImageView!

  @IBOutlet weak var PasswordTxt: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
    let setGif = UIImage.gifImageWithName("userlogin")
    gifimage.image = setGif
    ///
    NameTxt.addTarget(
      self, action: #selector(Signup1ViewController.textFieldDidChangeName(_:)),
      for: UIControl.Event.editingChanged)
    EmailTxt.addTarget(
      self, action: #selector(Signup1ViewController.textFieldDidChangeEmail(_:)),
      for: UIControl.Event.editingChanged)

    PasswordTxt.addTarget(
      self, action: #selector(Signup1ViewController.textFieldDidChangePassword(_:)),
      for: UIControl.Event.editingChanged)
    PhoneTxt.addTarget(
      self, action: #selector(Signup1ViewController.textFieldDidChangePhone(_:)),
      for: UIControl.Event.editingChanged)
    LocationTxt.addTarget(
      self, action: #selector(Signup1ViewController.textFieldDidChangeLocation(_:)),
      for: UIControl.Event.editingChanged)

  }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "SignUp2" {
      let des = segue.destination as! SignUp2ViewController
      des.name = NameTxt.text
      des.Email = EmailTxt.text
      des.Password = PasswordTxt.text
      des.Phone = PhoneTxt.text
      des.location = LocationTxt.text

    }
  }

  @IBAction func GoToSignUp2(_ sender: Any) {

   if !validatedName() || !validatedEmail() || !validatedPassword() || !validatedPhone() || !validatedLocation()
    {
      print("Error")
    } else {
   
      performSegue(withIdentifier: "SignUp2", sender: sender)

    }

  }

  @objc func textFieldDidChangeName(_ textField: UITextField) {

    if validatedName() {
      print("Typed ===>>> Name")
      let mycolor = UIColor.white
      NameTxt.layer.borderColor = mycolor.cgColor
      NameTxt.layer.borderWidth = 1.0
    }
  }
  @objc func textFieldDidChangeEmail(_ textField: UITextField) {
    if validatedEmail() {
      print("Typed ===>>> Email")
      let mycolor = UIColor.white
      EmailTxt.layer.borderColor = mycolor.cgColor
      EmailTxt.layer.borderWidth = 1.0
    }
  }
  @objc func textFieldDidChangePassword(_ textField: UITextField) {
    if validatedPassword() {
      print("Typed ===>>> password")
      let mycolor = UIColor.white
      PasswordTxt.layer.borderColor = mycolor.cgColor
      PasswordTxt.layer.borderWidth = 1.0

    }
  }
  @objc func textFieldDidChangePhone(_ textField: UITextField) {
    if validatedPhone() {
      print("Typed ===>>> Phone")
      let mycolor = UIColor.white
      PhoneTxt.layer.borderColor = mycolor.cgColor
      PhoneTxt.layer.borderWidth = 1.0
    }
  }

  @objc func textFieldDidChangeLocation(_ textField: UITextField) {
    if validatedLocation() {
      print("Typed ===>>> location")
      let mycolor = UIColor.white
      LocationTxt.layer.borderColor = mycolor.cgColor
      LocationTxt.layer.borderWidth = 1.0
    }
  }

  func validatedName() -> Bool {
    var valid: Bool = true
    if NameTxt.text == "" {
      /*            NameTxt.attributedPlaceholder = NSAttributedString(string: "Empty" , attributes: [NSAttributedString.Key.foregroundColor:  UIColor(red: 25, green: 0, blue: 0, alpha: 1.0)])*/
      valid = false
      NameTxt.shake()
      let mycolor = UIColor.red
      NameTxt.layer.borderColor = mycolor.cgColor
      NameTxt.layer.borderWidth = 1.0
      NameTxt.layer.cornerRadius = 10

    }

    return valid
  }

  func validatedEmail() -> Bool {  //   yassin@gmail.com

    var valid: Bool = true

    if EmailTxt.text == "" {
      // change placeholder color to red for textfield username
      //EmailTxt.attributedPlaceholder = NSAttributedString(string:"Please enter User Name")
      valid = false
      EmailTxt.shake()
      let mycolor = UIColor.red
      EmailTxt.layer.borderColor = mycolor.cgColor
      EmailTxt.layer.borderWidth = 1.0
      EmailTxt.layer.cornerRadius = 10
    } else if !checkEmailFormat() {
      valid = false
      EmailTxt.shake()
      let mycolor = UIColor.red
      EmailTxt.layer.borderColor = mycolor.cgColor
      EmailTxt.layer.borderWidth = 1.0
      EmailTxt.layer.cornerRadius = 10
    }

    return valid
  }

  func validatedPassword() -> Bool {
    var valid: Bool = true

    if PasswordTxt.text == "" {
      // change placeholder color to red color for textfield email-id
      // NameTxt.attributedPlaceholder = NSAttributedString(string: "Please enter Your Email ID")
      valid = false
      PasswordTxt.shake()
      let mycolor = UIColor.red
      PasswordTxt.layer.borderColor = mycolor.cgColor
      PasswordTxt.layer.borderWidth = 1.0
      PasswordTxt.layer.cornerRadius = 10
    }

    return valid
  }

  func validatedPhone() -> Bool {
    var valid: Bool = true

    if PhoneTxt.text == "" {
      // change placeholder color to red for textfield username
      //EmailTxt.attributedPlaceholder = NSAttributedString(string:"Please enter User Name")
      valid = false
      PhoneTxt.shake()
      let mycolor = UIColor.red
      PhoneTxt.layer.borderColor = mycolor.cgColor
      PhoneTxt.layer.borderWidth = 1.0
      PhoneTxt.layer.cornerRadius = 10
    }

    return valid
  }

  func validatedLocation() -> Bool {
    var valid: Bool = true
    if LocationTxt.text == "" {
      // change placeholder color to red for textfield username
      //EmailTxt.attributedPlaceholder = NSAttributedString(string:"Please enter User Name")
      valid = false
      LocationTxt.shake()
      let mycolor = UIColor.red
      LocationTxt.layer.borderColor = mycolor.cgColor
      LocationTxt.layer.borderWidth = 1.0
      LocationTxt.layer.cornerRadius = 10
    }

    return valid
  }

  func checkEmailFormat() -> Bool {
    let validate = "[a-z1-9.]+@[a-z1-9]+.[a-z]{1,3}"
    let isValidate = NSPredicate(format: "SELF MATCHES %@", validate)
    let validateEmail = isValidate.evaluate(with: EmailTxt.text)
    return validateEmail
  }

}

