//
//  MainVC.swift
//  GetFlix
//
//  Created by Mac on 7/24/24.
//

import UIKit
import SDWebImage

class MainVC: UIViewController, ApiServiceDelegate{
    func onError(_ apiService: ApiService, error: Error) {
        print(error.localizedDescription)
    }
    
    @IBOutlet weak var movieList: UICollectionView!
    
    var apiService = ApiService()
    
    var moviesList : [MovieModel] = []
    var nowPlaying : [MovieModel] = []
    var topRated : [MovieModel] = []
    
    var selectedTabIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiService.delegate = self
        apiService.getMovies(currentTabIndex: selectedTabIndex)
        CollectionViewCell.registerNib(movieList: movieList)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        movieList.collectionViewLayout = layout
        movieList.delegate = self
        movieList.dataSource = self
    }
}

extension MainVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            // handle tap events
            print("You selected cell #\(indexPath.item)!")
        }
}

extension MainVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mov = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.moviePoster.sd_setImage(with: URL(string: mov.posterPath!))
        cell.movieTitle.text = mov.title
        cell.movieDescription.text = mov.overview
        
        return cell
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 120)
    }
}


