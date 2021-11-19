//
//  SecondHeaderView.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class SecondHeaderView: UIView {

	@IBOutlet var contentView: UIView!
	@IBOutlet weak var viewDown: UIView!
	@IBOutlet weak var viewUp: UIView!
	
	@IBOutlet weak var labelDateViewUp: UILabel!
	@IBOutlet weak var labelProjectViewDown: UILabel!
	@IBOutlet weak var labelProjectNameViewDown: UILabel!
	@IBOutlet weak var buttonChange: UIButton!
	
	
	var delegate: SecondHeaderProtocol?
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		initSubviews()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		initSubviews()
	}
	
	func initSubviews() {
		let nib = UINib(nibName: "SecondHeaderView", bundle: nil)
		nib.instantiate(withOwner: self, options: nil)
				
		backgroundColor = .clear
		
		contentView.frame = bounds
		addSubview(contentView)
		
		setRoundCornersBottomView(view: viewUp)
		setRoundCornersBottomView(view: viewDown)
		viewUp.backgroundColor = UIColor(named: ColorsConstants.COLOR_GRAY)
		viewDown.backgroundColor = UIColor(named: ColorsConstants.COLOR_GRAY_SOFTF2)
		setupLabels()
		setupButtons()
	}
	
	private func setRoundCornersBottomView(view: UIView) {
		let rectShape = CAShapeLayer()
		rectShape.bounds = view.frame
		rectShape.position = view.center
		rectShape.path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 15, height: 15)).cgPath

		view.layer.mask = rectShape
	}
	
	func setupLabels() {
		labelDateViewUp.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 15)
		labelDateViewUp.textColor = UIColor(named: ColorsConstants.COLOR_WHITE)
		labelProjectViewDown.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 15)
		labelProjectViewDown.textColor = UIColor(named: ColorsConstants.COLOR_GRAY_SOFTA6)
		labelProjectNameViewDown.font = UIFont(name: FontsConstants.NUNITO_SANS_SEMIBOLD, size: 15)
		labelProjectNameViewDown.textColor = UIColor(named: ColorsConstants.COLOR_BLACK)
	}
	
	func setupButtons() {
		buttonChange.setTitle(StringsConstants.BUTTON_CHANGE, for: .normal)
		buttonChange.titleLabel?.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		buttonChange.titleLabel?.tintColor = UIColor(named: ColorsConstants.COLOR_SALMON)
	}

	@IBAction func pressChange(_ sender: Any) {
		print("Ir hacia atrás..")
		delegate?.goToBackViewController()
	}
}

protocol SecondHeaderProtocol {
	func goToBackViewController()
}

