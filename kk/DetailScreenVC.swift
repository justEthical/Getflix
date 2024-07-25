//
//  DetailScreen.swift
//  GetFlix
//
//  Created by Mac on 7/25/24.
//

import UIKit
import SDWebImage

class DetailScreenVC: UIViewController{
    var movie : MovieModel?
    
    @IBOutlet weak var imagePosterBG: UIImageView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var movieDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePosterBG.sd_setImage(with: URL(string: (movie?.posterPath)!))
        movieTitle.text = movie?.title
        releaseDate.text = movie?.releaseDate
        movieDescription.text = movie?.overview
    }
}
