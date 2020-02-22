//
//  FilmesViewController.swift
//  filmes
//
//  Created by Ytallo on 18/02/20.
//  Copyright © 2020 gadelha. All rights reserved.
//

import UIKit

class MoviesViewController: DefaultViewController {
    
    var favotitesMoviesID: [Int] = []
    var currentPage = 0
    var totalPages = 0
    var movies: [Movies] = []
    
    var dataAPI: DataAPI?{        
        didSet{
            DispatchQueue.main.async {
                self.labelPage.text = "\(self.currentPage)"
                self.tableView.reloadData()
            }
        }
    }
    
    lazy var tableView: UITableView = {
        
        let obj = UITableView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.separatorStyle = .singleLine
        obj.backgroundColor = .white
        
        return obj
    }()
    
    lazy var viewDown: UIView = {
        
        let constants = Constants()
        let obj = UIView()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.backgroundColor = constants.MAIN_COLOR
        
        return obj
    }()
    
    lazy var labelPage: UILabel = {
        
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        obj.numberOfLines = 0
        obj.textAlignment = .center
        obj.textColor = .white
        obj.font = .boldSystemFont(ofSize: 22)
        
        return obj
    }()
    
    lazy var buttonBack: UIButton = { [weak self] in
        
        let obj = UIButton()
        obj.setImage(UIImage(named: "ic_voltar")?.withRenderingMode(.alwaysTemplate), for: .normal)
        obj.tintColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        if let me = self {
            obj.addTarget(me, action: #selector(backAction), for: .touchUpInside)
        }
        
        return obj
        }()
    
    lazy var buttonNext: UIButton = { [weak self] in
        
        let obj = UIButton()
        obj.setImage(UIImage(named: "ic_avancar")?.withRenderingMode(.alwaysTemplate), for: .normal)
        obj.tintColor = .white
        obj.translatesAutoresizingMaskIntoConstraints = false
        
        if let me = self {
            obj.addTarget(me, action: #selector(nextAction), for: .touchUpInside)
        }
        
        return obj
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showActivity()
        self.favotitesMoviesID = UserDefaults.standard.array(forKey: "saveFavorites") as? [Int] ?? [Int]()
        self.view.backgroundColor = .white
        self.setupNavigation("Filmes")
        self.setupConstraints()
        self.updateData(page: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    func updateData(page: Int){
        
        REST.loadMovies(page: page ,onComplete: { (data) in
            
            self.dataAPI = data
            self.currentPage = data.page
            self.totalPages = data.total_pages
            self.movies = data.results
            
            DispatchQueue.main.async {
                self.hideActivity()
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
            }
            
        }) { (error) in
            
            print(error)
            DispatchQueue.main.async {
                self.showAlert(message: "Erro ao tentar acessar a página: \(self.currentPage).")
                self.hideActivity()
            }
        }
    }
    
    @objc func backAction(){
        
        self.buttonBack.isEnabled = false
        
        if currentPage == 1{
            return
        }
            
        else{
            self.showActivity()
            currentPage = currentPage - 1
            self.updateData(page: currentPage)
        }
        
        self.buttonBack.isEnabled = true
        self.buttonNext.isEnabled = true
    }
    
    @objc func nextAction(){
        
        self.buttonNext.isEnabled = false
        
        if currentPage == self.totalPages{
            return
        }
            
        else{
            self.showActivity()
            currentPage = currentPage + 1
            self.updateData(page: currentPage)
        }
        
        self.buttonBack.isEnabled = true
        self.buttonNext.isEnabled = true
    }
    
    func setupConstraints(){
        
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.viewDown)
        
        self.viewDown.addSubview(self.buttonBack)
        self.viewDown.addSubview(self.labelPage)
        self.viewDown.addSubview(self.buttonNext)
        
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.viewDown.topAnchor, constant: 0).isActive = true
        self.tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.90).isActive = true
        
        self.viewDown.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.viewDown.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.viewDown.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        self.buttonBack.centerYAnchor.constraint(equalTo: self.viewDown.centerYAnchor).isActive = true
        self.buttonBack.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonBack.widthAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonBack.trailingAnchor.constraint(equalTo: self.labelPage.leadingAnchor, constant: -40).isActive = true
        
        self.labelPage.centerYAnchor.constraint(equalTo: self.viewDown.centerYAnchor).isActive = true
        self.labelPage.centerXAnchor.constraint(equalTo: self.viewDown.centerXAnchor).isActive = true
        
        self.buttonNext.centerYAnchor.constraint(equalTo: self.viewDown.centerYAnchor).isActive = true
        self.buttonNext.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonNext.widthAnchor.constraint(equalToConstant: 35).isActive = true
        self.buttonNext.leadingAnchor.constraint(equalTo: self.labelPage.trailingAnchor, constant: 40).isActive = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: "moviesCell")
        
    }
}

//MARK:- Extension TableView
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "moviesCell") as? MoviesTableViewCell {
            
            let nameMovie = self.movies[indexPath.row].title
            let posterMovie = self.movies[indexPath.row].poster_path
            let idMovie = self.movies[indexPath.row].id
            
            cell.accessoryType = .disclosureIndicator
            cell.delegate = self
            cell.movie = self.movies[indexPath.row]
            
            cell.setupCell(name: nameMovie, poster: posterMovie, id: idMovie, favoritesID: favotitesMoviesID)
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height * 0.20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        ViewUtil.openMovieDetailsVC(from: self, movie: movies[indexPath.row])
    }    
}

//MARK:- Extension Protocol
extension MoviesViewController: MoviesViewCellDelegate{
    
    func favorite(movie: Movies?) {
        
        if let movie = movie{
            
            if !self.favotitesMoviesID.contains(movie.id){
                
                self.favotitesMoviesID.append(movie.id)
                UserDefaults.standard.set(favotitesMoviesID, forKey: "saveFavorites")
            }
            else{
                
                let ind = self.favotitesMoviesID.firstIndex(of: movie.id)
                
                if let index = ind{
                    self.favotitesMoviesID.remove(at: index)
                    UserDefaults.standard.set(favotitesMoviesID, forKey: "saveFavorites")
                }
            }
            self.tableView.reloadData()
        }
    }
}
