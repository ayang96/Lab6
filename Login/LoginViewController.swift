//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
         static let buttonColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 1, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
        static let buttonTextColor = UIColor.white
        static let textInputColor = UIColor.gray
        static let buttonCornerRadius:CGFloat = 10
        static let screenwidth = UIScreen.main.bounds.size.width
        static let screenheight = UIScreen.main.bounds.size.height
        static let spacing = 50
    }
    
    var button: UIButton = {
        // first create a button to be returned by the closure
        let myButton = UIButton()
        
        // configure the text of the button
        myButton.setTitle("Login", for: .normal)
        myButton.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        myButton.titleLabel?.numberOfLines = 2
        myButton.titleLabel?.textAlignment = .center
        myButton.setTitleColor(Constants.buttonTextColor, for: .normal)
        
        // configure button itself
        myButton.backgroundColor = Constants.buttonColor
        // makes the corners of the cell rounded, instead of squared off
        myButton.layer.cornerRadius = Constants.buttonCornerRadius
        myButton.layer.masksToBounds = true
        
        // Since we specified that the button is equal
        // to the closure's return value (`button = { ... }())
        // `button` will now equal `myButton`
        return myButton
    }()
    let InputBox: UIView = {
        let sampleInputBox=UIView(frame: CGRect(x: 1000, y: 0, width: Constants.screenwidth*0.9, height: 175))
        sampleInputBox.backgroundColor=UIColor.white
        sampleInputBox.layer.cornerRadius=25
        return sampleInputBox

    }()
    let usernameinput: UITextField = {
        let sampleTextField = UITextField(frame: CGRect(x: 30, y: 20+Constants.spacing*0, width: 280, height: 20))
        sampleTextField.placeholder = "Username"
        sampleTextField.font = UIFont.systemFont(ofSize: 18)
        sampleTextField.autocapitalizationType = UITextAutocapitalizationType.none
        sampleTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        return sampleTextField
    }()
    
    let passwordinput: UITextField = {
        let sampleTextField = UITextField(frame: CGRect(x: 30, y: 20+Constants.spacing*1, width: 280, height: 20))
        sampleTextField.placeholder = "Password"
        sampleTextField.font = UIFont.systemFont(ofSize: 18)
        sampleTextField.autocapitalizationType = UITextAutocapitalizationType.none
        sampleTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        sampleTextField.isSecureTextEntry = true
        return sampleTextField
    }()
    let titleLabel: UILabel = {
        let sampleLabel = UILabel(frame:CGRect(x: (Constants.screenwidth - Constants.screenwidth*0.9)/2, y: 40, width: Constants.screenwidth*0.9, height: 120))
        sampleLabel.text = "Login View Controller"
        sampleLabel.textColor = UIColor.white
        sampleLabel.font = UIFont.systemFont(ofSize:40)
        
        sampleLabel.textAlignment = NSTextAlignment.center
        sampleLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        sampleLabel.numberOfLines = 0
        return sampleLabel
    }()
    // TODO: instantiate the views needed for your project
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        InputBox.center = view.center
        self.view.addSubview(InputBox)
        InputBox.addSubview(usernameinput)
        InputBox.addSubview(passwordinput)
        
        button.frame = CGRect(x: 25, y: 20+Constants.spacing*2, width: 280, height: 40)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        
        view.addSubview(titleLabel)
                        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        //button.center = view.center
        
        // This is how you link buttons to methods programmatically (if we
        // were using a storyboard we would control drag to our IBAction instead)
        // `addTarget` takes in 3 parameters
        //     1. target: this is where the action method is defined (in our case,
        //          this is our MainViewController, or self)
        //     2. action: the method we want to be called when the button (or other
        //          UI element) is interacted with
        //     3. for: (controlEvents) here we tell Xcode when we want the action
        //          to be called. In this case, I put ".touchDown" since I want
        //          "goToNextView" to be called every time the user touches down on the button
        button.addTarget(self, action: #selector(authenticate), for: .touchDown)
        
        // IMPORTANT: this adds our button to the view. If you do not call this,
        // the button will never show up on the screen
        InputBox.addSubview(button)

        // TODO: layout your views using frames or AutoLayout
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func authenticate(sender: UIButton) {
        authenticateUser(username:usernameinput.text, password: passwordinput.text)
    }

    
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
