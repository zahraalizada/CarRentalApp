//
//  HomeController.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 18.05.24.
//

import UIKit
import RealmSwift

class HomeController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    let manager = CarManagerHelper()
    var cars: Results<Car>?
    var categories: Results<Category>?
    var selectedCategoryId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
        if let url = manager.realm.configuration.fileURL {
            print(url)
        }
        
        mainCollectionView.register(UINib(nibName: "MainCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
        carCollectionView.register(UINib(nibName: "CarCell", bundle: nil), forCellWithReuseIdentifier: "CarCell")
        
        cars = manager.getCars()
        categories = manager.getCategories()
        
        if let firstCategory = categories?.first {
            selectedCategoryId = firstCategory.id
        }
        
        filterCarsByCategory()
        
    }
    
    func filterCarsByCategory() {
        if let categoryId = selectedCategoryId {
            cars = manager.getCars().filter("categoryId == %@", categoryId)
        } else {
            cars = manager.getCars()
        }
        carCollectionView.reloadData()
    }
    
    func filterCarsBySearchText(_ searchText: String) {
           if searchText.isEmpty {
               filterCarsByCategory()
           } else {
               cars = manager.getCars().filter("title CONTAINS[c] %@", searchText)
               carCollectionView.reloadData()
               mainCollectionView.reloadData()
           }
       }
    
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        if let searchText = searchField.text {
            filterCarsBySearchText(searchText)
        }
    }
    
    @IBAction func searchTappedButton(_ sender: Any) {
        if let searchText = searchField.text {
            filterCarsBySearchText(searchText)
        }
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case mainCollectionView:
            return categories?.count ?? 0
        case carCollectionView:
            return cars?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(MainCell.self)", for: indexPath) as! MainCell
            let category = categories?[indexPath.item]
            let isSelected = selectedCategoryId == category?.id
            let carCount = manager.getCarsCount(for: category?.id ?? 0)
            
            let backgroundColor: UIColor = {
                if let searchText = searchField.text, !searchText.isEmpty {
                    return .white
                } else {
                    return isSelected ? .blue : .white
                }
            }()
            
            cell.configure(image: category?.image ?? "",
                           count: "\(carCount)",
                           title: category?.name ?? "",
                           backgroundColor: backgroundColor)
            return cell
        case carCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CarCell.self)", for: indexPath) as! CarCell
            let car = cars?[indexPath.item]
            cell.configure(title: car?.title ?? "",
                           subtitle: car?.subtitle ?? "",
                           price: "$\(car?.price ?? "")",
                           engine: car?.engine ?? "",
                           image: car?.image ?? "")
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == mainCollectionView {
            selectedCategoryId = categories?[indexPath.item].id
            filterCarsByCategory()
            mainCollectionView.reloadData()
        }
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == mainCollectionView {
            return CGSize(width: 200, height: 230)
        } else if collectionView == carCollectionView {
            return CGSize(width: collectionView.frame.width - 20, height: 350)
        }
        return CGSize.zero
    }
}
