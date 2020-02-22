//
//  MainNavigationController.swift
//  filmes
//
//  Created by Ytallo on 19/02/20.
//  Copyright © 2020 gadelha. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            self.overrideUserInterfaceStyle = .light
        } else {
        }
        self.setup()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        
        if let topVC = viewControllers.last {
            return topVC.preferredStatusBarStyle
        }
        
        return .default
    }
    
    func setup() {
        let constants = Constants()
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = constants.MAIN_COLOR
        self.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 22) ]
    }
}
