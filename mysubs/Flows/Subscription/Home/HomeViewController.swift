//
//  CollectionViewController.swift
//  mysubs
//
//  Created by Manon Russo on 30/11/2021.
//

import UIKit
import CoreData

// MARK: Enums
enum State<Data> {
    case loading
    case empty
    case error
    case showData
}

class HomeViewController: UIViewController, UINavigationBarDelegate {
    var viewModel : HomeViewModel?
    weak var coordinator: AppCoordinator?
    var categorys: [SubCategory] = []
    
    // MARK: UI Properties
    var subsView = UIView()
    var totalAmountView = UIView()
    var totalAmountLabel = UILabel()
    var amountLabel = UILabel()
    var myCollectionView: UICollectionView!
    var stackView = UIStackView()
    var categoryButton = UIButton()//AdaptableSizeButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    // MARK: Properties
    var viewState: State<[Subscription]> = .empty {
        didSet {
            // resetState()
            switch viewState {
            case .loading:
                activityIndicator.startAnimating()
                print("loading...")
            case .empty:
                myCollectionView.isHidden = true
                displayEmptyView()
//                myCollectionView.reloadData()
                print("empty!")
            case .error:
                showAlert("Erreur", "Il semble y avoir un problème, merci de réessayer")
                print("error")
            case .showData:
                print("thats datas")
                activityIndicator.stopAnimating()
                myCollectionView.isHidden = false
                //                self.viewModel?.subscriptions = subscriptions
                myCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("voici les categories \(categorys)")
        self.viewModel?.categorys = categorys
        viewModel?.fetchSubscription()
        if viewModel?.subscriptions.isEmpty == true {
            viewState = .empty
        } else {
        viewState = .showData
        }
        setUpUI()
        setUpTotalAmountView()
    }
    
    //MARK: OBJ C METHODS
    @objc func plusButtonAction() {
        viewModel?.showNewSub()
        print("passage dans methode plusButtonAction (homeVC)")
    }
    
    @objc func deleteAll() {
        for sub in viewModel!.subscriptions {
            do {
                try viewModel?.storageService.deleteSubs(sub)
                viewModel?.fetchSubscription()
                amountLabel.text = "- €"
                viewState = .empty
            } catch { print(error) }
        }
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("swipe left")
        }
    }
    
    @objc func addNewCategory() {
        //        let alert = UIAlertController(title: "Nouvelle category", message: "Ajoutez votre nouvelle category", preferredStyle: .alert)
        //        let saveAction = UIAlertAction(title: "Ajouter", style: .default) { [unowned self] action in
        //            guard let textField = alert.textFields?.first,
        //                  let categoryToSave = textField.text else { return }
        //
        //            do {
        //                try storageService.saveCategory(name: categoryToSave)
        //            } catch { print(error) }
        //        }
        //        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        //        alert.addTextField()
        //        alert.addAction(saveAction)
        //        alert.addAction(cancelAction)
        //
        //        present(alert, animated: true)
    }
    
    //MARK: PRIVATE METHODS
    private func displayEmptyView() {
        let emptyView = UITextView.init(frame: view.frame)
        emptyView.text = "\n\n\nAppuyez sur le + en haut pour commencer !"
        emptyView.isEditable = false
        emptyView.textAlignment = .center
        emptyView.font = MSFonts.title2
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(emptyView)
        amountLabel.text = " - €"
    }
    
    private func setUpViewState() {

    }
    
    private func cellTapped(sub: Subscription) {
        viewModel?.showDetail(sub: sub)
        print("passage dans methode show details")
    }
    
    private func resetState() {
        activityIndicator.stopAnimating()
        viewState = .loading
        myCollectionView.isHidden = true
    }
    
    private func deleteSub(sub: Subscription) {
        do {
            try viewModel?.storageService.deleteSubs(sub)
            
        }
        catch { print (error); self.showAlert("Erreur", "Suppression impossible. Merci de réessayer plus tard") }
    }
    
    private func refreshWith2(categorys: [SubCategory]) {
        //        var catname = viewModel?.categorys.first?.name
        //        categoryButton.setTitle(catname, for: .normal)
    }
}

//MARK: SET UP COLLECTION VIEW
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.subscriptions.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = myCollectionView.dequeueReusableCell(withReuseIdentifier: SubCell.identifier, for: indexPath) as! SubCell
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        collectionViewCell.addGestureRecognizer(leftSwipe)
        collectionViewCell.subscription = viewModel?.subscriptions[indexPath.row]
        return collectionViewCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSub = viewModel?.subscriptions[indexPath.row] else { return }
        cellTapped(sub: selectedSub)
        print("item \(indexPath.row+1) tapped")
    }
}

extension HomeViewController {
    
    func refreshWith(subscriptions: [Subscription]) {
        myCollectionView.reloadData()
    }
    
    func didFinishLoadingSubscriptions() {
        myCollectionView.reloadData()
    }
    
    func didFinishLoadingSubscriptions2() {
        if viewModel?.subscriptions.isEmpty == true {
            viewState = .empty
        } else {
            viewState = .showData
        }
    }
    
}
//MARK: UI SET UP
extension HomeViewController {
    func setUpUI() {
        setUpNavBar()
        setUpView()
        setUpStackView()
        activateConstraints()
    }
    
    func setUpNavBar() {
        // DISPLAYING LOGO
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 38, height: 38))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "subs_dark")
        imageView.image = image
        navigationItem.titleView = imageView
        
        //DISPLAYING PLUS BUTTON
        let plusButton: UIButton = UIButton(type: .custom)
        plusButton.setImage(UIImage(named: "plus_button"), for: .normal)
        plusButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        let rightBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: plusButton)
        let plusWidth = rightBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        plusWidth?.isActive = true
        let plusHeight = rightBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        plusHeight?.isActive = true
        rightBarButtonItem.customView = plusButton
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        
        //DISPLAYING MENU BUTTON
        let menuButton: UIButton = UIButton(type: .custom)
        menuButton.setImage(UIImage(named: "menu_button"), for: .normal)
        menuButton.addTarget(self, action: #selector(plusButtonAction), for: .touchUpInside)
        let leftBarButtonItem:UIBarButtonItem = UIBarButtonItem(customView: menuButton)
        let menuWidth = leftBarButtonItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        menuWidth?.isActive = true
        let menuHeight = leftBarButtonItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        menuHeight?.isActive = true
        leftBarButtonItem.customView = menuButton
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    func setUpView() {
        view.backgroundColor = MSColors.background
        categoryButton.translatesAutoresizingMaskIntoConstraints = false
        categoryButton.setTitle("test", for: UIControl.State.normal)
        categoryButton.titleLabel?.adjustsFontForContentSizeCategory = true
        categoryButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        categoryButton.backgroundColor = UIColor(named: "reverse_bg")
        categoryButton.setTitleColor(MSColors.background, for: UIControl.State.normal)
        categoryButton.addCornerRadius()
        categoryButton.isUserInteractionEnabled = true
        view.addSubview(categoryButton)
        categoryButton.addTarget(self, action: #selector(deleteAll), for: .touchUpInside)
        //        categoryButton.addTarget(self, action: #selector(addNewCategory), for: .touchUpInside)
    }
    
    func setUpStackView() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        //MARK: Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 16, height: 60)
        layout.scrollDirection = .vertical
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView?.register(SubCell.self, forCellWithReuseIdentifier: SubCell.identifier)
        myCollectionView?.backgroundColor = MSColors.background
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        myCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        myCollectionView?.isScrollEnabled = true
        myCollectionView?.isUserInteractionEnabled = true
        stackView.addArrangedSubview(myCollectionView ?? UICollectionView())
        setUpTotalAmountView()
        view.addSubview(stackView)
    }
    
    func setUpTotalAmountView() {
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        totalAmountView.backgroundColor = .systemBackground
        stackView.addArrangedSubview(totalAmountView)
        
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountLabel.adjustsFontForContentSizeCategory = true
        totalAmountLabel.text = "Coût total"
        totalAmountLabel.textColor = UIColor(named: "yellowgrey")
        totalAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        totalAmountView.addSubview(totalAmountLabel)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.adjustsFontForContentSizeCategory = true
        if viewModel?.subscriptions.isEmpty == true {
            amountLabel.text = "- €"
        } else {
            var totalPrice: Float = 0
            for sub in viewModel!.subscriptions {
                totalPrice += sub.price
                print("voici les prix \(sub.price)")
                amountLabel.text = "\(totalPrice) €"
            }
        }
        
        //MARK: calculating total amount for displayed subs
        
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.textColor = UIColor(named: "yellowgrey")
        amountLabel.backgroundColor = MSColors.background
        totalAmountView.addSubview(amountLabel)
        amountLabel.layer.cornerRadius = 5
        amountLabel.textAlignment = .center
        amountLabel.layer.masksToBounds = true
    }
    
    func activateConstraints() {
        NSLayoutConstraint.activate([
            categoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoryButton.heightAnchor.constraint(equalToConstant: 50),
            categoryButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            categoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 0),
            stackView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.trailingAnchor, multiplier: 0),
            stackView.topAnchor.constraint(equalTo: categoryButton.bottomAnchor, constant: 16),
            
            totalAmountView.leadingAnchor.constraint(equalToSystemSpacingAfter: stackView.leadingAnchor, multiplier: 0),
            totalAmountView.trailingAnchor.constraint(equalToSystemSpacingAfter: stackView.trailingAnchor, multiplier: 0),
            totalAmountView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 0),
            totalAmountView.heightAnchor.constraint(equalToConstant: 50),
            totalAmountLabel.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 32),
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            
            amountLabel.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -32),
            amountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            amountLabel.widthAnchor.constraint(equalToConstant: 90),
            amountLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
