//
//  ProcutController.swift
//  Shopify
//
//  Created by Jitendra Rajput on 04/12/20.
//

import UIKit

class ProcutController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var trendingLabel: UILabel!
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var brandCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var backgroundLoadingView: UIView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    //MARK: Varibales
    var alertController: UIAlertController!
    var productsList: [ProductsModel] = []
    var brandsList: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isLoading(load: true)
        _initalizeXIB()
        createDropDown()
        getProductsList()
    }
    
    func isLoading(load: Bool){
        loadingLabel.isHidden = !load
        backgroundLoadingView.isHidden = !load
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.productCountLabel.text = "0 Products"
        searchBar.moveSearchIconToRightSide()
        searchBar.backgroundColor = .white
        searchBar.returnKeyType = .search
    }
    
    
    //MARK: Initalize Cells
    func _initalizeXIB(){
        brandCollectionView.register(UINib(nibName: Identifiers.shared.brandXib, bundle: nil),forCellWithReuseIdentifier: Identifiers.shared.brandXib)
        productCollectionView.register(UINib(nibName: Identifiers.shared.productXib, bundle: nil), forCellWithReuseIdentifier: Identifiers.shared.productXib)
        
        brandCollectionView.dataSource      = self
        brandCollectionView.delegate        = self
        productCollectionView.dataSource    = self
        productCollectionView.delegate      = self
        
        
    }
    
    //MARK: Create AlertController
    func createDropDown(){
        alertController = UIAlertController(title: "", message: "Please select filters", preferredStyle: .actionSheet)
        let alert = UIAlertAction(title: "Most Popular", style: .default) { (action) in
            
        }
        
        let dismiss = UIAlertAction(title: "Dismiss", style: .destructive,handler: nil)
        alertController.addAction(alert)
        alertController.addAction(dismiss)
        
    }
    
    //MARK: Alert Controller Action
    @IBAction func didTapDropDownButton(_ sender: Any) {
        self.present(alertController, animated: true, completion: nil)
    }
    
}


//MARK: Collection View Functionality
extension ProcutController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == brandCollectionView{
            return brandsList.count
        }else{
            return productsList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == productCollectionView{
            let cell = productCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.shared.productXib, for: indexPath) as! ProductCollectionViewCell
            cell.populateData(data:productsList[indexPath.row])
            return cell
        }else{
            let cell = brandCollectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.shared.brandXib, for: indexPath) as! BrandsCollectionViewCell
            cell.populateBrands(data: brandsList[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == brandCollectionView{
            return CGSize(width: 100, height: 80)
        }else{
            let noOfCellsInRow = 2
            
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
            
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
            
            return CGSize(width: size, height: 200)
        }
        
    }
    
    func reloadCells(){
        DispatchQueue.main.async {
            self.isLoading(load: false)
            self.productCountLabel.text = "\(self.productsList.count) Products"
            self.brandCollectionView.reloadData()
            self.productCollectionView.reloadData()
        }
    }
    
}

//MARK: API Calls
extension ProcutController{
    
    func getProductsList(){
        ProductsAPI().getProuctsList { [weak self] (productsList,brandsList) in
            self?.productsList = productsList
            self?.brandsList = brandsList
            self?.reloadCells()
        }
    }
}
