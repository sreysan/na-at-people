//
//  HomeViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit


class HomeViewController: CommonViewController, UISearchBarDelegate {

	@IBOutlet weak var header: HeaderView!
	@IBOutlet weak var searchNews: UISearchBar!
	@IBOutlet weak var tableNews: UITableView!
	
	var listNews = [NewsListResponse]()

	var filterDataSearch = [NewsListResponse]()
	
	override func viewDidLoad() {
        super.viewDidLoad()
		header.delegate = self
		header.option = 1
		fetchNews()
		setupTable()
		setupSearch()
    }
	
	func setupTable() {
		tableNews.register(UINib(nibName: "NewsCellTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCellTableViewCell")
		tableNews.delegate = self
		tableNews.dataSource = self
		searchNews.delegate = self
	}
	
	func setupSearch() {
		searchNews.layer.borderWidth = 1
		searchNews.layer.borderColor = UIColor(named: ColorsConstants.COLOR_GRAY_SOFTF2)?.cgColor
	}
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		listNews = []
		if searchText == ""{
			listNews = filterDataSearch
		}else{
			for new in filterDataSearch{
				if new.headline.lowercased().contains(searchText.lowercased()){
					listNews.append(new)
				}
			}
		}
		tableNews.reloadData()
	}
	
	func fetchNews() {
		Service.shared.newsListResponse(completion: { [self]
			res in
			
			switch res {
			case .success(let decodedData):
				self.filterDataSearch = decodedData
				DispatchQueue.main.async {
					self.filterDataSearch = decodedData
					self.listNews = self.filterDataSearch
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
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
			return 137
		}
}

extension HomeViewController: UITableViewDataSource{
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return listNews.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableNews.dequeueReusableCell(withIdentifier: "NewsCellTableViewCell", for: indexPath) as! NewsCellTableViewCell
	
		cell.labelTitleNew.text = listNews[indexPath.row].headline
		cell.labelDateNew.text = DateNews.shared.setDateNew(date: listNews[indexPath.row].creationDate)
		cell.labelResumeNew.text = listNews[indexPath.row].summary
		cell.imagePhotoNews.downloaded(from: listNews[indexPath.row].image)
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
		newDetailViewController.idNew = listNews[index].id
		
		self.navigationController?.pushViewController(newDetailViewController, animated: true)
	}
}
