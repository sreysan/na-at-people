//
//  HeaderView.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class HeaderView: UIView {


	@IBOutlet var contentView: UIView!
	@IBOutlet weak var labelUser: UILabel!
	@IBOutlet weak var signOutView: UIView!
	@IBOutlet weak var imageProfile: UIImageView!
	@IBOutlet weak var imageButtonSignOut: UIImageView!
	@IBOutlet weak var labelButtonSignOut: UILabel!
	@IBOutlet weak var buttonSignOut: UIButton!
	
	var delegate: HeaderProtocol?
	
	var option: Int?
	
	let userName: String? = UserDefaults.standard.string(forKey: "userName")
	let userImage: String? = UserDefaults.standard.string(forKey: "userImage")
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initSubviews()
		setupImageView()
		setupLabels()
		setupButtons()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initSubviews()
		setupImageView()
		setupLabels()
		setupButtons()
	}
	
	private func setupLabels() {
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let components = userName?.components(separatedBy: chararacterSet)
		//labelUser.text = StringsConstants.LABEL_HELLO_HOME
		labelUser.text = "Hola, \(components?[0] ?? "") \(components?[1] ?? "")"
		labelUser.font = UIFont(name: FontsConstants.EUROPA_BOLD, size: 22)
		labelUser.textColor = UIColor(named: ColorsConstants.COLOR_WHITE)
		labelButtonSignOut.text = StringsConstants.BUTTON_SIGN_OUT
		labelButtonSignOut.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelButtonSignOut.textColor = UIColor(named: ColorsConstants.COLOR_WHITE)
	}
	
	private func setupButtons() {
		buttonSignOut.backgroundColor = .clear
		buttonSignOut.setTitle("", for: .normal)
	}
	
	private func setupImageView() {
		imageProfile.downloaded(from: userImage ?? "")
		imageProfile.layer.cornerRadius = imageProfile.bounds.height / 2
		imageButtonSignOut.image = UIImage(named: "cerrar-sesion (1)")
		labelButtonSignOut.sizeToFit()
		
	}
	
	func initSubviews() {
		let nib = UINib(nibName: "HeaderView", bundle: nil)
		nib.instantiate(withOwner: self, options: nil)
				
		backgroundColor = .clear
		
		contentView.frame = bounds
		addSubview(contentView)
		
		
		let layer = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.size.width, height: 100))
		let gradient = CAGradientLayer()
		gradient.frame = contentView.frame
		gradient.colors = [
		  UIColor(red:1, green:0.51, blue:0.33, alpha:1).cgColor,
		  UIColor(red:1, green:0.27, blue:0.52, alpha:1).cgColor
		]
		gradient.locations = [0, 1]
		gradient.startPoint = CGPoint(x: 0, y: -0.11)
		gradient.endPoint = CGPoint(x: 0.99, y: 1.11)
		layer.layer.addSublayer(gradient)
		
		let rectShape = CAShapeLayer()
		rectShape.bounds = contentView.frame
		rectShape.position = contentView.center
		rectShape.path = UIBezierPath(roundedRect: contentView.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

		layer.layer.mask = rectShape
		
		
		self.contentView.addSubview(layer)
		self.contentView.sendSubviewToBack(layer)
		signOutView.backgroundColor = .clear
	}
	
	@IBAction func pressSignOut(_ sender: Any) {
		delegate?.goToLoginViewController(option: 0)
	}
	
}

protocol HeaderProtocol {
	func goToLoginViewController(option: Int)
}

extension UIImageView {
	func download(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}.resume()
	}
	func download(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}


