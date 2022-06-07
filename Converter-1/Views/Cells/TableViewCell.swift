//
//  TableViewCell.swift
//  Converter-1
//
//  Created by Ap on 6.06.22.
//

import UIKit

class TableViewCell: UITableViewCell {

    var viewModel: TableViewCellViewModelType?
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var currencyNameToLabel: UILabel!
    @IBOutlet weak var currencyNameImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure() {
        resultLabel.text = viewModel?.result
        currencyNameToLabel.text = viewModel?.currencyNameTo
        currencyNameImage.image = viewModel?.image
    }
    
    override func prepareForReuse() {
        resultLabel.text = ""
        currencyNameToLabel.text = ""
        currencyNameImage.image = nil
    }

}
