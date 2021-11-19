//
//  NewsCellTableViewCell.swift
//  Na-atPeople
//
//  Created by sreyes on 10/11/21.
//

import UIKit

class NewsCellTableViewCell: UITableViewCell {

	
	@IBOutlet weak var imagePhotoNews: UIImageView!
	@IBOutlet weak var labelTitleNew: UILabel!
	@IBOutlet weak var labelDateNew: UILabel!
	@IBOutlet weak var labelResumeNew: UILabel!
	@IBOutlet weak var buttonDetail: UIButton!
	
	var stateButton = false
	var delegate: Detail?
	var index: Int!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		setupLabels()
		setupButtons()
    }
	
	private func setupLabels() {
		labelTitleNew.font = UIFont(name: FontsConstants.EUROPA_REGULAR, size: 15)
		labelTitleNew.textColor = UIColor(named: ColorsConstants.COLOR_BLACK)
		labelDateNew.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 10)
		labelDateNew.textColor = UIColor(named: ColorsConstants.COLOR_GRAY)
		labelResumeNew.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelResumeNew.textColor = UIColor(named: ColorsConstants.COLOR_GRAY)
		labelResumeNew.numberOfLines = 2
	}
	
	private func setupButtons() {
		buttonDetail.setTitle(StringsConstants.BUTTON_NEW_DETAIL, for: .normal)
		buttonDetail.titleLabel?.font = UIFont(name: FontsConstants.NUNITO_SANS_SEMIBOLD, size: 14)
		buttonDetail.titleLabel?.tintColor = UIColor(named: ColorsConstants.COLOR_SALMON)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	@objc func buttonPressed(myButton: UIButton) {
		delegate?.sendData(index: index)
	}
    
}

protocol Detail {
	func sendData(index: Int)
}

extension UIImageView {
	func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() { [weak self] in
				self?.image = image
			}
		}.resume()
	}
	func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}
