//
//  mainTabBar.swift
//  FlowerApp
//
//  Created by Eslam Moemen on 9/13/19.
//  Copyright © 2019 CreativeShare. All rights reserved.
//

import UIKit


class mainTabBar: UITabBarController,UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        noti.addObserver(self, selector: #selector(Sectr), name: Notification.Name("selctr"), object: nil)
        noti.addObserver(self, selector: #selector(cartType), name: Notification.Name("cartTye"), object: nil)

        self.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "cairo", size: 10)!], for: .normal)
        self.selectedIndex = 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cartType()
    }
    @objc func Sectr(){
        self.selectedIndex = 2
    }
    @objc func cartType(){
        if retrieveSavedUsers()?.count != 0 {
           self.tabBar.items![0].badgeValue = "\(retrieveSavedUsers()!.count)"
        }else {
         self.tabBar.items![0].badgeValue = nil

         }
    }
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if support.checkUserId == false && (viewController == tabBarController.viewControllers?[3]){
            alert.registerAlert(v: self)
            return false
        } else {
            return true
        }

    }


}


