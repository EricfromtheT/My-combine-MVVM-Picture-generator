//
//  BossNavViewController.swift
//  My combine AI picture
//
//  Created by 孔令傑 on 2023/2/10.
//

import UIKit

class BossNavViewController: UINavigationController {
    
    override func viewDidLoad() {
        setUpAppearance()
    }
    
    private func setUpAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.blue
        appearance.shadowColor = nil
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.cyan as Any]
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
