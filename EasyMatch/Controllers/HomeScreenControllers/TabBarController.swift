//
//  TabBarController.swift
//  EasyMatch
//
//  Created by Нуридин Сафаралиев on 11/6/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarAppearance()
        selectedIndex = 2
        navigationController?.navigationBar.tintColor = UIColor(red: 222/255, green: 243/255, blue: 88/255, alpha: 1)
    }
    

    private func generateTabBar(){
        
        let homeController = HomeController()
        let teamsViewController = TeamsViewController()
        teamsViewController.delegate = homeController
        
        viewControllers = [
        generateVC(viewController: MapViewController(), title: "Map", image: UIImage(systemName: "map")),
        generateVC(viewController: GamesViewController(), title: "Matches", image: UIImage(systemName: "sportscourt")),
        generateVC(viewController: teamsViewController, title: "Teams", image: UIImage(systemName: "heart")),
        generateVC(viewController: ChatViewController(), title: "HomChat", image: UIImage(systemName: "message.fill")),
        generateVC(viewController: homeController, title: "Home", image: UIImage(systemName: "person.crop.circle"))
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return navController
    }
    
    private func setTabBarAppearance(){
        let positionX:CGFloat = 10
        let positionY:CGFloat = 14
        let width = tabBar.bounds.width - positionX*2
        let height = tabBar.bounds.height + positionY*2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionX, y: tabBar.bounds.minY - positionY, width: width, height: height), cornerRadius: height/2)
        
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width/5
        tabBar.itemPositioning = .centered
        
        tabBar.tintColor = UIColor(red: 222/255, green: 243/255, blue: 88/255, alpha: 1)
        tabBar.unselectedItemTintColor = .lightGray
        roundLayer.fillColor = CGColor(red: 53/255, green: 61/255, blue: 54/255, alpha: 1)
    }
    
}
