//
//  SearchController.swift
//  CarRentalApp
//
//  Created by Zahra Alizada on 18.05.24.
//

import UIKit
import RealmSwift

class SearchController: UIViewController {
    
    @IBOutlet weak var carCollectionView: UICollectionView!
    
    @IBOutlet weak var searchField: UITextField!
    
    let manager = CarManagerHelper()
    var cars: Results<Car>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        
        carCollectionView.register(UINib(nibName: "CarCell", bundle: nil), forCellWithReuseIdentifier: "CarCell")
        
        cars = manager.getCars()
    }
    
    func filterCarsBySearchText(_ searchText: String) {
        if searchText.isEmpty {
            cars = manager.getCars()
        } else {
            cars = manager.getCars().filter("title CONTAINS[c] %@", searchText)
        }
        carCollectionView.reloadData()
    }
    
    
    @IBAction func searchFieldTapped(_ sender: Any) {
        print(searchField.text ?? "")
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


extension SearchController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cars?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CarCell.self)", for: indexPath) as! CarCell
        let car = cars?[indexPath.item]
        cell.configure(title: car?.title ?? "",
                       subtitle: car?.subtitle ?? "",
                       price: "$\(car?.price ?? "")",
                       engine: car?.engine ?? "",
                       image: car?.image ?? "")
        return cell
    }
}

extension SearchController: UICollectionViewDelegate {
    
}

extension SearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 20, height: 350)
    }
}
