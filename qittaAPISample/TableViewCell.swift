//
//  TableViewCell.swift
//  qittaAPISample
//
//  Created by 松島悠人 on 2021/02/02.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet var lable: UILabel!
//    @IBOutlet var view:UIView!


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func bindData(text :String){
        lable.text = text

    }
    
}
