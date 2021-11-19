//
//  TabBarViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		selectedIndex = 1
    }
    
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.setNavigationBarHidden(true, animated: animated)
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		navigationController?.setNavigationBarHidden(false, animated: animated)
	}
	
	public func hideTabBar() {
		navigationController?.setNavigationBarHidden(false, animated: false)
	}
	
}
