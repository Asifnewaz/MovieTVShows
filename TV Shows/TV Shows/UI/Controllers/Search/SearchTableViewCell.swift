//
//  SearchTableViewCell.swift
//  TV Shows
//
//  Created by Asif Newaz on 27/2/21.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    
    var show: TVShow?
    var mvi : Movie?
    func setName(_ fullName: String) {
        name.text = fullName
    }

}
