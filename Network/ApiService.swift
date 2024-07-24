//
//  ApiService.swift
//  GetFlix
//
//  Created by Mac on 7/24/24.
//

import Foundation


class ApiService{
    
    var delegate : MainVC?
    
    func getMovies(){
        
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
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
            }
        })

        dataTask.resume()
    }
    
    func parseJson(){
        
    }
}
