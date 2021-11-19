//
//  ActivityRecordsTableViewCell.swift
//  Na-atPeople
//
//  Created by sreyes on 12/11/21.
//

import UIKit

class ActivityRecordsTableViewCell: UITableViewCell {

	@IBOutlet weak var labelProjectTitle: UILabel!
	@IBOutlet weak var labelActivityTitle: UILabel!
	@IBOutlet weak var labelHours: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        
		setupLabels()
    }
	
	func setupLabels() {
		labelProjectTitle.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 15)
		labelProjectTitle.textColor = UIColor(named: ColorsConstants.COLOR_BLACK)
		labelActivityTitle.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelActivityTitle.textColor = UIColor(named: ColorsConstants.COLOR_GRAY)
		labelHours.font = UIFont(name: FontsConstants.NUNITO_SANS_REGULAR, size: 12)
		labelHours.textColor = UIColor(named: ColorsConstants.COLOR_GRAY)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
		
    }
    
}
