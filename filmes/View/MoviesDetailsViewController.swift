//
//  MoviesDetailsViewController.swift
//  filmes
//
//  Created by Ytallo on 21/02/20.
//  Copyright © 2020 gadelha. All rights reserved.

import UIKit

class MoviesDetailsViewController: DefaultViewController {
    
    var movie: Movies?
    
    lazy var imagePoster: UIImageView = {
        
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFill
        obj.backgroundColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    lazy var labelTitle: UILabel = {
        
        let constants = Constants()
        let obj = UILabel()
        
        obj.numberOfLines = 0
        obj.textColor = constants.MAIN_COLOR
        obj.textAlignment = .left
        obj.backgroundColor = .white
        obj.font = UIFont.boldSystemFont(ofSize: 18)
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        return obj
    }()
    
    lazy var labelOverview: UILabel = {
        
        let constants = Constants()
        let obj = UILabel()
        
        obj.numberOfLines = 12
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.textColor = constants.MAIN_COLOR
        obj.textAlignment = .left
        obj.backgroundColor = .white
        obj.font = UIFont.boldSystemFont(ofSize: 16)
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        return obj
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupNavigation("Detalhes")
        self.navigationController?.navigationBar.tintColor = .white
        self.setupConstraints()
        self.loadMovie()
    }
    
    func setupConstraints(){
        
        self.view.addSubview(self.imagePoster)
        self.view.addSubview(self.labelTitle)
        self.view.addSubview(self.labelOverview)
        
        self.imagePoster.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        self.imagePoster.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imagePoster.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35).isActive = true
        self.imagePoster.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85).isActive = true
        self.imagePoster.bottomAnchor.constraint(equalTo: self.labelTitle.topAnchor, constant: -10).isActive = true
        
        self.labelTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.labelTitle.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.10).isActive = true
        self.labelTitle.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85).isActive = true
        self.labelTitle.bottomAnchor.constraint(equalTo: self.labelOverview.topAnchor, constant: -10).isActive = true
        
        self.labelOverview.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.labelOverview.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.35).isActive = true
        self.labelOverview.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.85).isActive = true
        
    }
    
    func loadMovie(){
        if let movie = movie{

            self.imagePoster.downloaded(from: imagePath + movie.poster_path)            
            self.labelTitle.text = "Filme: \(movie.title)"
            
            if movie.overview.isEmpty{
                self.labelOverview.text = "Informações em breve..."
            }
            else{
                self.labelOverview.text = "Sinopse: \(movie.overview)"
            }
        }
    }    
}
