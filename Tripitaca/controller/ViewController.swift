//
//  ViewController.swift
//  Tripitaca
//
//  Created by Ernest Mwangi on 25/01/2023.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate{

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var googleLogin: UIView!
    @IBOutlet weak var googleLogo: UIImageView!
    @IBOutlet weak var btnGoogleLogin: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
//        loginWithGoogle()
//        GIDSignIn.sharedInstance().signInSilently()
         setupViews()

    }

    func setupViews(){
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = Colors.darkerWhite?.cgColor
        emailField.layer.cornerRadius = 8

        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = Colors.darkerWhite?.cgColor
        passwordField.layer.cornerRadius = 8

        btnLogin.layer.cornerRadius = 8

        googleLogin.layer.borderWidth = 1
        googleLogin.layer.borderColor = Colors.darkerWhite?.cgColor
        googleLogin.layer.cornerRadius = 8
    }

    func loginWithGoogle(){
        let currentUser = GIDSignIn.sharedInstance().currentUser

        print("Current User: \(currentUser?.profile.name)")

        if currentUser != nil{
            performSegue(withIdentifier: "goToHome", sender: nil)
            print("Welcome Back \(currentUser)")
        }
        else {
            print("Logging You in")
            GIDSignIn.sharedInstance().signIn()
            let currentUser = GIDSignIn.sharedInstance().currentUser
            print("New Current User: \(currentUser?.profile.name)")

        }

    }

    func validateForm(){

        let email: String = emailField.text!
        let password: String = passwordField.text!

        if email.isEmpty {
            let alertController = UIAlertController(title: "Alert", message: "Please enter your Email!", preferredStyle: .alert)

            let actionCancel = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
            }

            alertController.addAction(actionCancel)
            self.present(alertController, animated: true, completion: nil)
        } else if password.isEmpty{
            let alertController = UIAlertController(title: "Alert", message: "Please enter your Password!", preferredStyle: .alert)

            let actionCancel = UIAlertAction(title: "Okay", style: .cancel) { (action:UIAlertAction) in
            }

            alertController.addAction(actionCancel)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            performSegue(withIdentifier: "goToHome", sender: nil)
        }

    }

    @IBAction func loginTapped(_ sender: Any) {
        validateForm()
    }

    @IBAction func googleLoginTapped(_ sender: Any) {
        GIDSignIn.sharedInstance().uiDelegate = self

        (UIApplication.shared.delegate as! AppDelegate).signInCallBack = loginWithGoogle
//        loginWithGoogle()

        performSegue(withIdentifier: "goToHome", sender: nil)

    }
}

