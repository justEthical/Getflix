//
//  MainVC.swift
//  GetFlix
//
//  Created by Mac on 7/24/24.
//

import UIKit
import SDWebImage
import SwipeCellKit

class MainVC: UIViewController, ApiServiceDelegate{
    
        @IBOutlet weak var movieList: UICollectionView!
        @IBOutlet weak var nowPlayingIcon: UIImageView!
        @IBOutlet weak var nowPlayingLabel: UILabel!
        @IBOutlet weak var topRatedIcon: UIImageView!
        @IBOutlet weak var topRatedLabel: UILabel!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    var searchBar: UISearchBar!
    var apiService = ApiService()
        var moviesList: [MovieModel] = []
        var nowPlaying: [MovieModel] = []
        var topRated: [MovieModel] = []
        var selectedTabIndex: Int = 0
    
    var tappedTile : MovieModel?
    var filteredItems = [MovieModel]()

//    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
//    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupCollectionView()
            setupTapGestures()
            fetchMovies()
            setupSearchBar()
            setupRefreshControl()
            
        }
    
    private func setupSearchBar(){
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        searchBar.placeholder = "Search"
                searchBar.delegate = self
        searchBar.showsCancelButton = true
        if let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton {
                    cancelButton.setTitleColor(UIColor.black, for: .normal) // Text color
                }
        searchBar.searchTextField.backgroundColor = .white
    }
    
    private func setupRefreshControl() {
        movieList.refreshControl = UIRefreshControl()
            // Add the refresh control to the collection view
        movieList.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
//            movieList.refreshControl = refreshControl
        }

        private func setupUI() {
            topRatedIcon.tintColor = .systemGray
            topRatedLabel.textColor = .systemGray
            nowPlayingIcon.isUserInteractionEnabled = true
            topRatedIcon.isUserInteractionEnabled = true
        }

        private func setupCollectionView() {
            CollectionViewCell.registerNib(movieList: movieList)
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
            movieList.collectionViewLayout = layout
            movieList.delegate = self
            movieList.dataSource = self
        }

        private func setupTapGestures() {
            let nowPlayingTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeBottomBarColor))
            nowPlayingIcon.addGestureRecognizer(nowPlayingTapGesture)

            let topRatedTapGesture = UITapGestureRecognizer(target: self, action: #selector(changeBottomBarColor))
            topRatedIcon.addGestureRecognizer(topRatedTapGesture)
        }

        private func fetchMovies() {
            apiService.delegate = self
            apiService.getMovies(currentTabIndex: selectedTabIndex)
        }

        @objc private func changeBottomBarColor() {
            selectedTabIndex = (selectedTabIndex == 0) ? 1 : 0
            moviesList = (selectedTabIndex == 0) ? nowPlaying : topRated
            movieList.reloadData()
            updateBottomBarColor()
        }
    
    @objc private func didPullToRefresh(_ sender: Any){
        self.movieList!.refreshControl?.beginRefreshing()
        self.movieList!.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
         apiService.getMovies(currentTabIndex: selectedTabIndex)
    }
    
    func stopRefresher() {
        self.movieList!.refreshControl?.endRefreshing()
     }

        private func updateBottomBarColor() {
            if selectedTabIndex == 0 {
                topRatedIcon.tintColor = .systemGray
                topRatedLabel.textColor = .systemGray
                nowPlayingIcon.tintColor = .black
                nowPlayingLabel.textColor = .black
            } else {
                nowPlayingIcon.tintColor = .systemGray
                nowPlayingLabel.textColor = .systemGray
                topRatedIcon.tintColor = .black
                topRatedLabel.textColor = .black
            }
        }

        func onError(_ apiService: ApiService, error: Error) {
            print("Error: \(error.localizedDescription)")
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "getToDetailScreen"){
            let detailScreenController = segue.destination as! DetailScreenVC
            detailScreenController.movie = tappedTile
            
        }
    }
    
}


extension MainVC : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        tappedTile = moviesList[indexPath.row]
        performSegue(withIdentifier: "getToDetailScreen", sender: self)
    }
}

extension MainVC : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mov = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.cellIdentifier, for: indexPath) as! CollectionViewCell
        cell.movieList = moviesList
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


extension MainVC : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            // Called when the user changes the text in the search bar
            filterContentForSearchText(searchText)
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            // Called when the search button is clicked
            searchBar.resignFirstResponder() // Dismiss the keyboard
            filterContentForSearchText(searchBar.text ?? "")
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            // Called when the cancel button is clicked
            searchBar.text = ""
            searchBar.resignFirstResponder()
            moviesList = (selectedTabIndex == 0 ? nowPlaying : topRated )
            movieList.reloadData()
        }
    
    func filterContentForSearchText(_ searchText: String) {
        if(searchText == ""){
            moviesList = (selectedTabIndex == 0 ? nowPlaying : topRated )
        }else{
            moviesList = (selectedTabIndex == 0 ? nowPlaying : topRated ).filter { item in
                
                return item.title!.lowercased().contains(searchText.lowercased())
            }
        }
        
        // Reload your table view or collection view
        movieList.reloadData()
    }
}


