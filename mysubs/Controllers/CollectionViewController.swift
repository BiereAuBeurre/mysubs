//
//  CollectionViewController.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//

import UIKit

// MARK: Enums
enum State<Data> {
    case loading
    case empty
    case error
    case showData(Data)
}

class AdaptableSizeButton: UIButton {
    override var intrinsicContentSize: CGSize {
        let labelSize = titleLabel?.sizeThatFits(CGSize(width: frame.size.width, height: CGFloat.greatestFiniteMagnitude)) ?? .zero
        let desiredButtonSize = CGSize(width: labelSize.width, height: labelSize.height)
        return desiredButtonSize
    }
}

class CollectionViewController: UIViewController, UINavigationBarDelegate {
// TEST CODE DATA (mettre dans viewdidLoad à partir du do pour test
//    var subInfo = SubInfo(category: "ciné", commitment: "mensuel", extraInfo: "test", name: "NETFLIX", paymentRecurrency: "mensuel", price: 9.99, reminder: "2j avant", suggestedLogo: "rien")
//    do {
//        try storageService.saveSubs(subInfo)
//    }
//    catch { print(error)}
//
//    do {
//        try storageService.deleteSubs(subInfo)
//    }
//    catch { print(error)}
    
    var category = CategoryInfo(name: " Ajouter une catégorie ")
    
    // MARK: UI Properties
    var navBar: UINavigationBar!
    var subsView = UIView()
    var totalAmountView = UIView()
    var totalAmountLabel = UILabel()
    var amountLabel = UILabel()
    var myCollectionView: UICollectionView?
//    var subcell = SubCell()
    var categoryButton = AdaptableSizeButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: Properties
    var storageService = StorageService()
    var subscriptions: [SubInfo] = []
    
    
    var viewState: State<[SubInfo]> = .empty {
        didSet {
            resetState()
            switch viewState {
            case .loading:
                activityIndicator.startAnimating()
                print("loading...")
            case .empty:
                //diplsayEmptyView()
                print("empty!")
            case .error:
                showAlert("Erreur", "Il semble y avoir un problème, merci de réessayer")
                print("error")
            case .showData(let subscriptions):
                print("thats datas")
                self.subscriptions = subscriptions
                //collectionView.reloadData() (equivalent)?
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        subcell.setup()
        title = "hhf"
    }
    
    
    //MARK: Private methods
    private func resetState() {
        activityIndicator.stopAnimating()
        //collectionView.isHidden = true
    }
    
    private func deleteSub(sub: SubInfo) {
        do {
            try storageService.deleteSubs(sub)
            //fetchSubs()
        }
        catch { print (error); self.showAlert("Erreur", "Suppression impossible. Merci de réessayer plus tard") }
    }
    
    func setUpUI() {
        setUpNavBar()
        setUpView()
        setUpSubsView()
        setUpTotalAmountView()
        activateConstraints()
    }
    
    func setUpNavBar() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        navBar.delegate = self
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.isHidden = false
        navBar.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1647058824, blue: 0.2, alpha: 1)
        let imageTitleBar = UIImage(named: "subs_dark")
        self.navigationItem.titleView = UIImageView(image: imageTitleBar)
        view.addSubview(navBar)
    }
    
    func setUpView() {
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle(category.name, for: UIControl.State.normal)
        //       categoryButton.setTitle(" Ajouter une category ", for: UIControl.State.normal)
        categoryButton.titleLabel?.adjustsFontForContentSizeCategory = true
        categoryButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        categoryButton.backgroundColor = UIColor(named: "reverse_bg")
        categoryButton.setTitleColor(UIColor(named: "background"), for: UIControl.State.normal)
        categoryButton.addCornerRadius()
        categoryButton.isUserInteractionEnabled = true
        view.addSubview(categoryButton)
    }
    
    func setUpSubsView() {
        subsView.translatesAutoresizingMaskIntoConstraints = false
        subsView.backgroundColor = UIColor(named: "background")
        view.addSubview(subsView)
        
        //MARK: Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.view.frame.width - 16, height: 60)
        layout.collectionView?.backgroundColor = UIColor(named: "reverse_bg")
        layout.scrollDirection = .vertical
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "SubCell")
        myCollectionView?.backgroundColor = UIColor(named: "background")
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.isScrollEnabled = true
        myCollectionView?.isUserInteractionEnabled = true
        subsView.addSubview(myCollectionView ?? UICollectionView())
    }
    
    func setUpTotalAmountView() {
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        totalAmountView.backgroundColor = .systemBackground
        subsView.addSubview(totalAmountView)
        
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountLabel.adjustsFontForContentSizeCategory = true
        totalAmountLabel.text = "Coût total"
        totalAmountLabel.textColor = UIColor(named: "yellowgrey")
        totalAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        totalAmountView.addSubview(totalAmountLabel)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.adjustsFontForContentSizeCategory = true
        amountLabel.text = " 22 € "
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.textColor = UIColor(named: "yellowgrey")
        amountLabel.backgroundColor = UIColor(named: "background")
        totalAmountView.addSubview(amountLabel)
        amountLabel.layer.cornerRadius = 5
        amountLabel.textAlignment = .center
        amountLabel.layer.masksToBounds = true
//        amountLabel.layer.shadowColor = UIColor.black.cgColor
//        amountLabel.layer.shadowRadius = 3.0
//        amountLabel.layer.shadowOpacity = 1.0
//        amountLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            navBar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            navBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            navBar.heightAnchor.constraint(equalToConstant: 100),
            
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 50),
            categoryButton.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            subsView.bottomAnchor.constraint(equalToSystemSpacingBelow: view.bottomAnchor, multiplier: 0),
            subsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            subsView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            subsView.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 16),
            
            totalAmountView.leadingAnchor.constraint(equalToSystemSpacingAfter: subsView.leadingAnchor, multiplier: 0),
            totalAmountView.trailingAnchor.constraint(equalToSystemSpacingAfter: subsView.trailingAnchor, multiplier: 0),
            totalAmountView.bottomAnchor.constraint(equalTo: subsView.bottomAnchor, constant: -24),
            totalAmountView.heightAnchor.constraint(equalToConstant: 50),
            
            totalAmountLabel.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 32),
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            
            amountLabel.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -32),
            amountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            amountLabel.widthAnchor.constraint(equalToConstant: 90),
            amountLabel.heightAnchor.constraint(equalToConstant: 30),
//            myCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

}

extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCell", for: indexPath)
        myCell.backgroundColor = UIColor(named: "reverse_bg")
        return myCell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       print("User tapped on item \(indexPath.row+1)")
    }
}
