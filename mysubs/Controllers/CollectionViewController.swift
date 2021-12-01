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

class CollectionViewController: UIViewController, UINavigationBarDelegate {
// TEST CODE DATA (mettre dans viewdidLoad à partir du do pour test
//    var subInfo = SubInfo(category: "ciné", commitment: "mensuel", extraInfo: "test", name: "NETFLIX", paymentRecurrency: "mensuel", price: 9.99, reminder: "2j avant", suggestedLogo: "rien")
//        do {
//            try storageService.saveSubs(subInfo)
//        }
//        catch { print(error)}
    
    var category = CategoryEntity(name: " Loisirs ")
    
    // MARK: UI Properties
    var navBar: UINavigationBar!
    var categoryButton = UIButton()
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
                //collectionView.reloadData() ou qqch du style ?
                
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavBar()
        setUpView()
        activateConstraints()
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
    
    func setUpNavBar() {
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        navBar.delegate = self
        navBar.translatesAutoresizingMaskIntoConstraints = false
        navBar.isHidden = false
        navBar.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1647058824, blue: 0.2, alpha: 1)
//        let imageTitleBar = UIImage(named: "subs_dark")
//        self.navigationItem.titleView = UIImageView(image: imageTitleBar)
        
        view.addSubview(navBar)
    }
    
    func setUpView() {
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle(category.name, for: UIControl.State.normal)
        categoryButton.backgroundColor = UIColor(named: "reverse_bg")
        categoryButton.setTitleColor(UIColor(named: "background"), for: UIControl.State.normal)
        categoryButton.addCornerRadius()
        categoryButton.isUserInteractionEnabled = true
        view.addSubview(categoryButton)
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            navBar.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            navBar.topAnchor.constraint(equalToSystemSpacingBelow: view.topAnchor, multiplier: 0),
            navBar.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            navBar.heightAnchor.constraint(equalToConstant: 100),
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 32),
            categoryButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 116)
        ])
    }

}
