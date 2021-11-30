//
//  ViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 09/11/21.
//

import UIKit
import GoogleSignIn

class LoginViewController: CommonViewController {

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
		self.setUpModal()
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
				let userImage = (user.profile?.imageURL(withDimension: 30))?.absoluteString
				let userName = user.profile?.name
				UserDefaults.standard.setValue(userImage, forKey: "userImage")
				UserDefaults.standard.setValue(userName, forKey: "userName")
			}else{
				self.setUpModal()
			}
		})
	}
	
	func setUpModal(){
		
		let baner = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
		baner.backgroundColor = UIColor(white: 0, alpha: 0.4)
		
		let card = UIView(frame: CGRect(x: 0, y: 0, width: 286, height: 300))
		card.layer.cornerRadius = 10
		
		let imClose = UIImage(named: "cerrar (1)")
		let button = UIButton(frame: CGRect(x: 255, y: 10, width: 20, height: 20))
		button.setImage(imClose, for: .normal)
		  button.backgroundColor = .none
		button.imageView?.image = UIImage(named: "cerrar (1)")
		
		button.addTarget(self, action: #selector(closeDialog(_:)), for: .touchUpInside)
		
		let ivLogo = UIImageView(image: UIImage(named: "Nsquare (1)"))
		ivLogo.frame = CGRect(x: 113, y: 65, width: 60, height: 60)
		
		let lbtitle = UILabel(frame: CGRect(x: 53, y: 136, width: 286-53, height: 18))
		lbtitle.text = "Únete con tu cuenta NA-AT"
		lbtitle.font = UIFont.init(name: FontsConstants.EUROPA_REGULAR, size: 15)
		
		
		
		let lbContent = UILabel(frame: CGRect(x: 25, y: 183, width: 236, height: 54))
		lbContent.lineBreakMode = .byWordWrapping
		lbContent.textAlignment = .center
		lbContent.numberOfLines = 0
		lbContent.text = "El acceso a la aplicación, solo esta disponible para talento NAAT Ingresa con tu correo @na-at.com.mx"
		lbContent.font = UIFont.init(name: FontsConstants.NUNITO_SANS_REGULAR, size: 13)
		
		
		//ivClose.translatesAutoresizingMaskIntoConstraints = false
		card.addSubview(lbContent)
		card.addSubview(lbtitle)
		card.addSubview(ivLogo)
		//card.addSubview(ivClose)
		card.addSubview(button)
		
		card.translatesAutoresizingMaskIntoConstraints = false
		card.backgroundColor = .white
		baner.tag = 100
		baner.addSubview(card)
		view.addSubview(baner)
		
		
		card.center = baner.convert(baner.center, from:baner.superview)
	}
	
	@objc func closeDialog(_ sender: UITapGestureRecognizer){
		if let viewWithTag = self.view.viewWithTag(100) {
				viewWithTag.removeFromSuperview()
			}else{
				print("No!")
			}
		
	}
	
}

