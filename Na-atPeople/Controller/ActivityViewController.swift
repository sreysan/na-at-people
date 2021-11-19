//
//  ActivityViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class ActivityViewController: UIViewController {

	@IBOutlet weak var header: HeaderView!
	@IBOutlet weak var buttonRegisterHours: UIButton!
	@IBOutlet weak var tableActivities: UITableView!
	
	var listActivityRecords: [ActivityRecordsListResponse]!
	
	
	override func viewDidLoad() {
        super.viewDidLoad()

		fetchActivitiesRecords()
		setupButtons()
		tableActivities.register(UINib(nibName: "ActivityRecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityRecordsTableViewCell")
		tableActivities.delegate = self
		tableActivities.dataSource = self
		
		
    }
	
	func fetchActivitiesRecords() {
		Service.shared.activityRecordsListResponse(completion: { [self]
			res in
			
			switch res {
			case .success(let decodedData):
				DispatchQueue.main.async {
					listActivityRecords = decodedData
					tableActivities.reloadData()
					}
	
			case .failure(let err):
				print("ERROR AL OBTENER DATOS: ", err)
			}
		})
	}
    
	func setupButtons() {
		buttonRegisterHours.setTitle(StringsConstants.BUTTON_REGISTER_HOURS, for: .normal)
		buttonRegisterHours.titleLabel?.font = UIFont(name: FontsConstants.NUNITO_SANS_SEMIBOLD, size: 14)
		buttonRegisterHours.titleLabel?.tintColor = UIColor(named: ColorsConstants.COLOR_SALMON)
		buttonRegisterHours.layer.borderColor = UIColor(named: ColorsConstants.COLOR_SALMON)?.cgColor
		buttonRegisterHours.layer.borderWidth = 1
		buttonRegisterHours.layer.cornerRadius = 5.0
	}
}

extension ActivityViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}

extension ActivityViewController: UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listActivityRecords?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableActivities.dequeueReusableCell(withIdentifier: "ActivityRecordsTableViewCell", for: indexPath) as! ActivityRecordsTableViewCell
		
		
		cell.layer.cornerRadius = 4
		cell.layer.borderWidth = 1
		cell.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
		
		return cell
	}
	/*{"project":{"name":"Project F","client":{"name":"NAAT Technologies"}},"activityRecords":[{"activity":{"name":"Activity F name"},"duration":1,"date":"2021-09-04","id":"f9eed43a-df51-4790-b7de-d338a57c18a2"},{"activity":{"name":"Activity G name"},"duration":1,"date":"2021-09-04","id":"bbf45338-e0e2-4de1-864a-4deae6ff99ec"}]},
	
	{"project":{"name":"Project F","client":{"name":"NAAT Technologies"}},"activityRecords":[{"activity":{"name":"Activity F name"},"duration":1,"date":"2021-09-03","id":"3327e25d-aadb-492c-b55b-13606404cf11"},{"activity":{"name":"Activity G name"},"duration":1,"date":"2021-09-03","id":"383cfc10-8a3c-44d0-8d9f-f5945751b8f6"}]},
	
	{"project":{"name":"Project F","client":{"name":"NAAT Technologies"}},"activityRecords":[{"activity":{"name":"Activity F name"},"duration":1,"date":"2021-09-02","id":"40aec05b-a1d3-4025-9d49-802c8a6e5cee"},{"activity":{"name":"Activity G name"},"duration":1,"date":"2021-09-02","id":"5ae1ce4a-2c73-45ab-b9e4-3e26187d26fb"}]},
	
	{"project":{"name":"Project F","client":{"name":"NAAT Technologies"}},"activityRecords":[{"activity":{"name":"Activity F name"},"duration":1,"date":"2021-09-01","id":"fdf5954e-e0e8-4935-a953-690d26215953"},{"activity":{"name":"Activity G name"},"duration":1,"date":"2021-09-01","id":"d1181a48-77c9-479d-aa0c-af7ac630d73e"}]}*/
}
