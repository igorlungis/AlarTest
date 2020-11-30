//
//  PagesTableViewCell.swift
//  AlarTestApp
//
//  Created by Igor Lungis on 11/29/20.
//

import UIKit
import Kingfisher

class PagesTableViewCell: UITableViewCell {
  
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var cellView: UIView! {
    didSet {
      cellView.clipsToBounds = true
      cellView.layer.cornerRadius = 20
    }
  }
  
  var name: String? {
    didSet {
      if let name = name {
        nameLabel.text = name
      }
    }
  }
  var imageUrl: String?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    if let url = URL(string: imageUrl ?? "https://proprikol.ru/wp-content/uploads/2019/09/kartinki-krasivye-priroda-na-rabochij-stol-na-ves-ekran-1-1.jpg") {
      DispatchQueue.main.async {
        self.imgView.kf.setImage(with: url)
      }
    }
  }
  
}


