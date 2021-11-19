//
//  ViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 09/11/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {

	var gidConfiguration: GIDConfiguration?
	
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var labelTextLogo: UILabel!
    @IBOutlet weak var imagePhotoLogin: UIImageView!
    @IBOutlet weak var labelTextLogin: UILabel!
    @IBOutlet weak var labelTextPolicy: UILabel!
    @IBOutlet weak var buttonLoginGoogle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		gidConfiguration = GIDConfiguration.init(clientID: "252458349142-l96autpekba2afouf8fr30lq4e57m1lg.apps.googleusercontent.com")
		
        self.setupLabels()
        self.setupImages()
        self.setupButtons()
    }
    
    func setupLabels() {
        labelTextLogo.text = StringsConstants.LABEL_LOGIN_LOGO
        labelTextLogo.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 13)
        labelTextLogin.text = StringsConstants.LABEL_LOGIN
        labelTextLogin.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 13)
        labelTextPolicy.text = StringsConstants.LABEL_LOGIN_POLICY
        labelTextPolicy.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 13)
        labelTextPolicy.textColor = UIColor(named: ColorsConstants.COLOR_SALMON)
    }
    
    func setupImages() {
        imageLogo.image = UIImage(named: "naat")
        imagePhotoLogin.image = UIImage(named: "login-main")
    }
    
    func setupButtons() {
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.buttonLoginGoogle.frame.size)
        gradient.colors = [UIColor(named: ColorsConstants.COLOR_GRADIENT_START)?.cgColor as Any, UIColor(named: ColorsConstants.COLOR_GRADIENT_END)?.cgColor as Any]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerRadius = 22.5

        buttonLoginGoogle.layer.addSublayer(gradient)
        buttonLoginGoogle.setTitle(StringsConstants.BUTTON_GOOGLE_LOGIN, for: .normal)
        buttonLoginGoogle.titleLabel?.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 16)
        buttonLoginGoogle.titleLabel?.tintColor = .white
        //buttonLoginGoogle.setImage(UIImage(named: "google"), for: .normal)
    }
	@IBAction func goToTabBar(_ sender: Any) {
		GIDSignIn.sharedInstance.signIn(with: gidConfiguration!, presenting: self, callback: {
			user, err in
			guard let user = user else {return}
			let email = user.profile?.email ?? ""
			if email.contains("@na-at.com.mx"){
				let storyboard = UIStoryboard(name: "Main", bundle: nil)
				let customViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController") as! UITabBarController
				self.navigationController?.pushViewController(customViewController, animated: true)
			}else{
				self.showAlert()
			}
		})
	}
	
	func showAlert() {

		let alert = UIAlertController(title: "Únete con tu cuenta NA-AT", message: "El acceso a la aplicación, solo esta disponible para talento NAAT Ingresa con tu correo @na-at.com.mx", preferredStyle: .alert)

				
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

				// show the alert
		self.present(alert, animated: true, completion: nil)
		
	}
}

