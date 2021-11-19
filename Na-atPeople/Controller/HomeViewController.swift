//
//  HomeViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit


class HomeViewController: UIViewController {

	@IBOutlet weak var header: HeaderView!
	@IBOutlet weak var searchNews: UISearchBar!
	@IBOutlet weak var tableNews: UITableView!
	
	var listNews: [NewsListResponse]!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		fetchNews()
		tableNews.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellTableViewCell")
		tableNews.delegate = self
		tableNews.dataSource = self
    }
	
	func fetchNews() {
		Service.shared.newsListResponse(completion: { [self]
			res in
			
			switch res {
			case .success(let decodedData):
				DispatchQueue.main.async {
					listNews = decodedData
					tableNews.reloadData()
					}
	
			case .failure(let err):
				print("ERROR AL OBTENER DATOS: ", err)
			}
		})
	}

}

extension HomeViewController: UITableViewDelegate{
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}

extension HomeViewController: UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listNews?.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableNews.dequeueReusableCell(withIdentifier: "NewsCellTableViewCell", for: indexPath) as! NewsCellTableViewCell
		
		cell.layer.cornerRadius = 4
		cell.layer.borderWidth = 1
		cell.layer.borderColor = CGColor(gray: 0.5, alpha: 0.5)
		
		cell.labelTitleNew.text = listNews?[indexPath.row].headline
		cell.labelDateNew.text = DateNews.shared.setDateNew(date: listNews?[indexPath.row].creationDate ?? "")
		cell.labelResumeNew.text = listNews?[indexPath.row].summary
		cell.imagePhotoNews.downloaded(from: listNews?[indexPath.row].image ?? "")
		cell.buttonDetail.addTarget(cell.self, action: #selector(cell.buttonPressed(myButton:)), for: .touchUpInside)
		cell.delegate = self
		cell.index = indexPath.row
		return cell
	}
	
}

extension HomeViewController: Detail{
	func sendData(index: Int) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let newDetailViewController = storyboard.instantiateViewController(withIdentifier: "NewDetailViewController") as! NewDetailViewController
		newDetailViewController.idNew = listNews?[index].id ?? ""
		
		self.navigationController?.pushViewController(newDetailViewController, animated: true)
	}
}
