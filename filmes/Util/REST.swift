//
//  REST.swift
//  filmes
//
//  Created by Ytallo on 18/02/20.
//  Copyright © 2020 gadelha. All rights reserved.
//

import Foundation
import UIKit

//url cartaz
let basePath = "https://api.themoviedb.org/3/movie/now_playing"
let apiKey = "c2e78b4a8c14e65dd6e27504e6df95ad"

//url poster
let imagePath = "https://image.tmdb.org/t/p/w500"

enum APIError{
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJSON
}

class REST {
    
    static private let configuration: URLSessionConfiguration = {
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 30.0
        return config
    }()
    
    static private let session = URLSession(configuration: configuration)
    
    class func loadMovies(page: Int ,onComplete: @escaping (DataAPI) -> Void, onError: @escaping (APIError) -> Void)  {
        
        guard let url = URL(string: "\(basePath)?api_key=\(apiKey)&language=pt-BR&page=\(page)") else {
            
            onError(.url)
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil{
                
                guard let response = response as? HTTPURLResponse else {
                    
                    onError(.noResponse)
                    return
                }
                
                if response.statusCode == 200{
                    
                    guard let data = data else { return }
                    
                    do{
                        let dataJson = try JSONDecoder().decode(DataAPI.self, from: data)
                        
                        onComplete(dataJson)
                        
                    }catch{
                        onError(.invalidJSON)
                    }
                    
                }else{
                    onError(.responseStatusCode(code: response.statusCode))
                }
                
            }else{
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }        
}
