//
//  MovieCell.swift
//  TV Shows
//
//  Created by Asif Newaz on 26/2/21.
//

import UIKit

class MovieCell: UICollectionViewCell {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    func setName(_ fullName: String) {
        name.text = fullName
    }

    func setDescription(_ img: UIImage) {
        image.image = img
    }
}
