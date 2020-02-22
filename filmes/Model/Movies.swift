//
//  Movies.swift
//  filmes
//
//  Created by Ytallo on 18/02/20.
//  Copyright © 2020 gadelha. All rights reserved.
//

import Foundation

class DataAPI: Codable{
    
    var page: Int
    var total_results: Int
    var total_pages: Int
    var results: [Movies]
}

class Movies: Codable {
    
    var id: Int
    var poster_path: String
    var title: String
    var overview: String    
}
