//
//  NotificationViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class NotificationViewController: CommonViewController {

	@IBOutlet weak var header: HeaderView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		header.delegate = self
		header.option = 1
    }
    

}
