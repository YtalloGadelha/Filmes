//
//  MoviesTableViewCell.swift
//  filmes
//
//  Created by Ytallo on 22/02/20.
//  Copyright © 2020 gadelha. All rights reserved.

import UIKit

//MARK:- Protocol
protocol MoviesViewCellDelegate: class {
    func favorite(movie: Movies?)
}

class MoviesTableViewCell: UITableViewCell{
    
    var movie: Movies?
    weak var delegate: MoviesViewCellDelegate?
    
    lazy var poster: UIImageView = { [weak self] in
        
        guard let me = self else { return UIImageView() }
        let obj = UIImageView()
        obj.contentMode = .scaleAspectFit
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        return obj
        }()
    
    lazy var name: UILabel = {
        
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.numberOfLines = 4
        obj.adjustsFontSizeToFitWidth = true
        obj.minimumScaleFactor = 0.5
        obj.textAlignment = .left
        obj.textColor = .darkGray
        obj.font = .boldSystemFont(ofSize: 18)
        
        return obj
    }()
    
    lazy var buttonFavorite: UIButton = { [weak self] in
        
        let constants = Constants()
        let obj = UIButton()
        obj.tintColor = constants.MAIN_COLOR
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        if let me = self {
            obj.addTarget(me, action: #selector(favoriteAction), for: .touchUpInside)
        }
        
        return obj
        }()
    
    override func didMoveToSuperview() {
        self.setupCell()
    }
    
    @objc func favoriteAction(){
        
        self.delegate?.favorite(movie: movie)
    }
    
    private func setupCell(){
        
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(self.poster)
        self.contentView.addSubview(self.name)
        self.contentView.addSubview(self.buttonFavorite)
        
        self.poster.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        self.poster.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.poster.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.poster.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.poster.trailingAnchor.constraint(equalTo: self.name.leadingAnchor, constant: 0).isActive = true
        
        self.name.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.name.trailingAnchor.constraint(equalTo: self.buttonFavorite.leadingAnchor, constant: -20).isActive = true
        
        self.buttonFavorite.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.buttonFavorite.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20).isActive = true
        self.buttonFavorite.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.buttonFavorite.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.layoutIfNeeded()
        self.updateConstraints()
    }
    
    func setupCell(name: String, poster: String, id: Int, favoritesID: [Int]){
        
        self.poster.downloaded(from: imagePath + poster)
        self.name.text = name
        
        if favoritesID.contains(id){
            self.buttonFavorite.setImage(UIImage(named: "ic_favoritado")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.buttonFavorite.tintColor = Constants().MAIN_COLOR
        }else{
            self.buttonFavorite.setImage(UIImage(named: "ic_favoritos")?.withRenderingMode(.alwaysTemplate), for: .normal)
            self.buttonFavorite.tintColor = Constants().MAIN_COLOR
        }
    }
}
