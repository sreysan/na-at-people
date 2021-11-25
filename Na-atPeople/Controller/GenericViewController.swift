//
//  GenericViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 25/11/21.
//

import UIKit

class GenericViewController: UIViewController , HeaderProtocol {
	
	func goToLoginViewController(option options: Int) {
		if options==0{
			goToRootViewController()
		}else{
			gotToLoginViewControllerFromSubFlow()
		}
	}
	
	public func goToRootViewController() {
		for vc in self.navigationController!.viewControllers {
			if vc.isKind(of: LoginViewController.self) {
				self.navigationController?.popToViewController(vc, animated: true)
			}
		}
	}
	
	func gotToLoginViewControllerFromSubFlow() {
		(self.tabBarController as! TabBarViewController).navigationController?.popToRootViewController(animated: true)
	}
	
	let child = SpinnerViewController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	public func closeSesion(option: Int){
		
	}
	
	public func goToBack() {
		self.navigationController?.popViewController(animated: true)
	}
	
	func createSpinnerView() {
		// add the spinner view controller
		addChild(child)
		child.view.frame = view.frame
		view.addSubview(child.view)
		child.didMove(toParent: self)

	}
	
	func hideActivity() {
		DispatchQueue.main.async {
			self.child.willMove(toParent: nil)
			self.child.view.removeFromSuperview()
			self.child.removeFromParent()
		}
	}
}
