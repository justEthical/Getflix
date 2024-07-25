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
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePosterBG.sd_setImage(with: URL(string: (movie?.posterPath)!))
    }
}
