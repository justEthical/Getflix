//
//  CollectionViewCell.swift
//  GetFlix
//
//  Created by Mac on 7/25/24.
//

import UIKit
import SwipeCellKit

class CollectionViewCell: SwipeCollectionViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    var movieList : [MovieModel]?

    static let cellIdentifier = "CollectionViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    static func registerNib(movieList: UICollectionView){
        movieList.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}
