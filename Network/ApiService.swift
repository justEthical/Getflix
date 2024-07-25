//
//  ApiService.swift
//  GetFlix
//
//  Created by Mac on 7/24/24.
//

import Foundation

protocol ApiServiceDelegate{
    func onError(_ apiService : ApiService, error: Error)
}

class ApiService{
    
    var delegate : MainVC?
    
    func getMovies(currentTabIndex: Int){
        
        let headers = [
            "x-rapidapi-key": "900246bf9emsh543d782a2b6ff0ap1a8216jsn5d968dd22a1a",
            "x-rapidapi-host": "movies-api14.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://movies-api14.p.rapidapi.com/home")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                self.delegate?.onError(self, error: error!)
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                self.parseJson(movieData: data!, currentTabIndex: currentTabIndex)
            }
        })

        dataTask.resume()
    }
    
    func parseJson(movieData: Data, currentTabIndex: Int){
        do {
                    // Decode the JSON data into an array of Category instances
                    let categories = try JSONDecoder().decode([MovieCategory].self, from: movieData)
                    
                    // Process the categories array
                    for category in categories {
                        print("Category: \(category.title)")
                        for movie in category.movies {
                            if(category.title == "Trending Movies"){
                                self.delegate?.nowPlaying.append(movie)
                            }else if(category.title == "New Movies"){
                                self.delegate?.topRated.append(movie)
                            }
                        }
                        
                        DispatchQueue.main.async{
                            self.delegate?.moviesList = []
                            if(currentTabIndex == 0){
                                
                                self.delegate?.moviesList.append(contentsOf: self.delegate!.nowPlaying)
                            }else{
                                self.delegate?.moviesList.append(contentsOf: self.delegate!.topRated)
                            }
                            self.delegate?.movieList.reloadData()
                        }
                    }
                } catch {
                    print("Failed to decode movie data: \(error)")
                    delegate?.onError(self, error: error)
                }
    }
}
