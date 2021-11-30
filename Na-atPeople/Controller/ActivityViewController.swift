//
//  ActivityViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class ActivityViewController: CommonViewController {

	@IBOutlet weak var header: HeaderView!
	@IBOutlet weak var buttonRegisterHours: UIButton!
	@IBOutlet weak var tableActivities: UITableView!
	@IBOutlet weak var labelDate: UILabel!
	
	var listActivityRecords: [ActivityRecordsListResponse]!
	
	var day: String = Date().fullDate

	override func viewDidLoad() {
        super.viewDidLoad()
		header.delegate = self
		header.option = 1
		fetchActivitiesRecords()
		setupLabels()
		setupButtons()
		setupTable()
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
	
	func setupLabels() {
		day.removeLast(8)
		labelDate.text = day
		labelDate.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 15)
		labelDate.tintColor = UIColor(named: ColorsConstants.COLOR_GRAY_SOFTA6)
	}
    
	func setupButtons() {
		buttonRegisterHours.setTitle(StringsConstants.BUTTON_REGISTER_HOURS, for: .normal)
		buttonRegisterHours.titleLabel?.font = UIFont(name: FontsConstants.NUNITO_SANS_SEMIBOLD, size: 14)
		buttonRegisterHours.titleLabel?.tintColor = UIColor(named: ColorsConstants.COLOR_SALMON)
		buttonRegisterHours.layer.borderColor = UIColor(named: ColorsConstants.COLOR_SALMON)?.cgColor
		buttonRegisterHours.layer.borderWidth = 1
		buttonRegisterHours.layer.cornerRadius = 5.0
	}
	
	func setupTable() {
		tableActivities.register(UINib(nibName: "ActivityRecordsTableViewCell", bundle: nil), forCellReuseIdentifier: "ActivityRecordsTableViewCell")
		tableActivities.delegate = self
		tableActivities.dataSource = self
	}
	
	
	@IBAction func goToActivityRecord(_ sender: Any) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let customViewController = storyboard.instantiateViewController(withIdentifier: "ActivityRecordViewController") as! ActivityRecordViewController
		self.navigationController?.pushViewController(customViewController, animated: true)
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

extension Formatter {
	static let date = DateFormatter()
}
extension Date {
	func localizedDescription(dateStyle: DateFormatter.Style = .medium) -> String {
		Formatter.date.locale = Locale(identifier: "es_ES")
		Formatter.date.dateStyle = dateStyle
		return Formatter.date.string(from: self)
	}
	var fullDate: String   { localizedDescription(dateStyle: .full) }
}
