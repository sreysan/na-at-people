//
//  ActivityRecordViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 30/11/21.
//

import UIKit

class ActivityRecordViewController: CommonViewController {

	@IBOutlet weak var header: HeaderView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		header.delegate = self
		header.option = 1

    }

}
