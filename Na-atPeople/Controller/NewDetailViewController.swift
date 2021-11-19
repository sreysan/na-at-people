//
//  NewDetailViewController.swift
//  Na-atPeople
//
//  Created by sreyes on 11/11/21.
//

import UIKit

class NewDetailViewController: UIViewController {

	@IBOutlet weak var header: HeaderView!
	@IBOutlet weak var imageNewDetail: UIImageView!
	@IBOutlet weak var labelTitleNewDetail: UILabel!
	@IBOutlet weak var labelDateNewDetail: UILabel!
	@IBOutlet weak var labelBodyNewDetail: UILabel!
	
	var idNew = ""
	var listNewDetail: NewsDetailResponse!
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setupLabels()
		fetchNews()
    }
    
	func setupLabels() {
		labelTitleNewDetail.font = UIFont(name: FontsConstants.EUROPA_BOLD, size: 20)
		labelTitleNewDetail.textColor = UIColor(named: ColorsConstants.COLOR_BLACK)
		labelTitleNewDetail.numberOfLines = 0
		labelDateNewDetail.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelDateNewDetail.textColor = UIColor(named: ColorsConstants.COLOR_GRAY)
		labelBodyNewDetail.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelBodyNewDetail.textColor = UIColor(named: ColorsConstants.COLOR_BLACK)
		labelBodyNewDetail.numberOfLines = 0
	}
	
	func fetchNews() {
		Service.shared.newsDetailsResponse(id: idNew, completion: { [self]
			res in
			
			switch res {
			case .success(let decodedData):
				DispatchQueue.main.async {
					listNewDetail = decodedData
					imageNewDetail.downloaded(from: listNewDetail.image)
					labelTitleNewDetail.text = listNewDetail.headline
					labelDateNewDetail.text = DateNews.shared.setDateNewDetail(date: listNewDetail.creationDate)
					labelBodyNewDetail.text = listNewDetail.body
					}
	
			case .failure(let err):
				print("ERROR AL OBTENER DATOS: ", err)
			}
		})
	}
}
