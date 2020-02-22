//
//  ViewUtil.swift
//  filmes
//
//  Created by Ytallo on 19/02/20.
//  Copyright © 2020 gadelha. All rights reserved.

import Foundation
import UIKit

class ViewUtil {
    
    class func prepareWindow(window: UIWindow?){
        
        let window = window ?? UIWindow()
       
        let view = MoviesViewController()
        
        let navigationVC = MainNavigationController(rootViewController: view)
        
        view.view.backgroundColor = .white
        
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()        
    }    
    
    class func openMovieDetailsVC(from vc: UIViewController, movie: Movies) {
        
        let destiny = MoviesDetailsViewController()
        
        destiny.movie = movie
        destiny.modalPresentationStyle = .fullScreen
        vc.navigationController?.pushViewController(destiny, animated: true)
    }
}
