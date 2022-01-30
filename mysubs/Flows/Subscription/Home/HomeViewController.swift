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

    let userNotificationCenter = UNUserNotificationCenter.current()

    var viewModel : HomeViewModel?
    weak var coordinator: AppCoordinator?
    
    // MARK: -UI Properties
    var subsView = UIView()
    var totalAmountView = UIView()
    var totalAmountLabel = UILabel()
    var amountLabel = UILabel()
    var subListStackView = UIStackView()
    var subCollectionView: UICollectionView! //= UICollectionView()
    var categoryButton = UIButton()//AdaptableSizeButton()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: -Properties
    var viewState: State<[Subscription]> = .showData {
        didSet {
            // resetState()
            switch viewState {
            case .loading:
                activityIndicator.startAnimating()
                print("loading...")
            case .empty:
                subCollectionView.isHidden = true
                displayEmptyView()
                print("empty!")
            case .error:
                showAlert("Erreur", "Il semble y avoir un problème, merci de réessayer")
                print("error")
            case .showData:
                print("thats datas")
                activityIndicator.stopAnimating()
                subCollectionView.reloadData()
                subCollectionView.isHidden = false

            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        self.userNotificationCenter.delegate = self
        //dans le save
        self.requestNotificationAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchSubscription()
        setUpUI()
        setUpTotalAmountView()
        viewModel?.computeTotal()
        refreshWith(subscriptions: viewModel?.subscriptions ?? [])
//        if viewModel?.subscriptions == [] {
//            viewState = .empty
//        } else {
//            viewState = .showData
//        }
    }
    
    //MARK: -OBJ C METHODS
    @objc func plusButtonAction() {
        viewModel?.showNewSub()
//        print("passage dans methode plusButtonAction (homeVC)")
    }
    
//    @objc func categoryNamefieldTextDidChange(textField: UITextField) {}
    
    @objc func deleteAll() {
        if let subscriptions = viewModel?.subscriptions {
            for sub in subscriptions {
                do {
                    try viewModel?.storageService.delete(sub)
                    viewModel?.fetchSubscription()
                    amountLabel.text = "- €"
                    viewState = .empty
                } catch { print(error) }
            }
        }
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            print("swipe left")
        }
    }

    
    //MARK: -PRIVATE METHODS
    private func displayEmptyView() {
        let emptyView = UITextView.init(frame: view.frame)
        emptyView.text = "\n\n\nAppuyez sur le + en haut pour commencer !"
        emptyView.isEditable = false
        emptyView.textAlignment = .center
        emptyView.font = MSFonts.title2
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        subListStackView.addArrangedSubview(emptyView)
        amountLabel.text = " - €"
    }
    
    private func setUpViewState() {}
    
    private func cellTapped(sub: Subscription) {
        viewModel?.showDetail(sub: sub)
        print("passage dans methode show details")
    }
    
    private func resetState() {
        activityIndicator.stopAnimating()
        viewState = .loading
        subCollectionView.isHidden = false
    }
    
    private func deleteSub(sub: Subscription) {
        do {
            try viewModel?.storageService.delete(sub)
        }
        catch { print (error); self.showAlert("Erreur", "Suppression impossible. Merci de réessayer plus tard") }
    }
  
}

//MARK: -SET UP COLLECTION VIEWS
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel?.subscriptions.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let subCell = subCollectionView.dequeueReusableCell(withReuseIdentifier: SubCell.identifier, for: indexPath) as! SubCell
        subCell.subscription = viewModel?.subscriptions[indexPath.row]
        subCell.addCornerRadius()
        return subCell
        
        // let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        // leftSwipe.direction = .left
        // subCell.addGestureRecognizer(leftSwipe)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSub = viewModel?.subscriptions[indexPath.row] else { return }
        cellTapped(sub: selectedSub)
        print("item \(indexPath.row+1) tapped")
    }
}



//MARK: -REFRESHING DATAS
extension HomeViewController {
    
    func refreshWith(subscriptions: [Subscription]) {
        if subscriptions.isEmpty {
            viewState = .empty
        } else {
            viewState = .showData
        }
    }
    
    func didComputetotalAmount() {
        amountLabel.text = viewModel?.totalAmount
    }
    
     func refreshWith2(categorys: [SubCategory]) {
         viewState = .showData
    }
    
    func didFinishLoadingSubscriptions2() {
//        if viewModel?.subscriptions.isEmpty == true {
//            viewState = .empty
//        } else {
//            viewState = .showData
//        }
    }
    
}
//MARK: -UI SET UP
extension HomeViewController {
    func setUpUI() {
        setUpNavBar()
        view.backgroundColor = MSColors.background

        subListStackView.translatesAutoresizingMaskIntoConstraints = false
        subListStackView.axis = .vertical
        
        //MARK: Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width - 16, height: 60)
        layout.scrollDirection = .vertical
        subCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        subCollectionView.register(SubCell.self, forCellWithReuseIdentifier: SubCell.identifier)
        subCollectionView.backgroundColor = MSColors.background
        subCollectionView.dataSource = self
        subCollectionView.delegate = self
        subCollectionView.translatesAutoresizingMaskIntoConstraints = false
        subCollectionView.isScrollEnabled = true
        subCollectionView.isUserInteractionEnabled = true
        subListStackView.addArrangedSubview(subCollectionView ?? UICollectionView())
        setUpTotalAmountView()
        view.addSubview(subListStackView)
        
        NSLayoutConstraint.activate([
            subListStackView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.leadingAnchor, multiplier: 0),
            subListStackView.trailingAnchor.constraint(equalToSystemSpacingAfter: view.safeAreaLayoutGuide.trailingAnchor, multiplier: 0),
            subListStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            totalAmountView.leadingAnchor.constraint(equalToSystemSpacingAfter: subListStackView.leadingAnchor, multiplier: 0),
            totalAmountView.trailingAnchor.constraint(equalToSystemSpacingAfter: subListStackView.trailingAnchor, multiplier: 0),
            totalAmountView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            totalAmountView.heightAnchor.constraint(equalToConstant: 50),
            totalAmountLabel.leadingAnchor.constraint(equalTo: totalAmountView.leadingAnchor, constant: 32),
            totalAmountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            
            amountLabel.trailingAnchor.constraint(equalTo: totalAmountView.trailingAnchor, constant: -32),
            amountLabel.centerYAnchor.constraint(equalTo: totalAmountView.centerYAnchor, constant: 0),
            amountLabel.widthAnchor.constraint(equalToConstant: 90),
            amountLabel.heightAnchor.constraint(equalToConstant: 30),
        ])
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
    
    
    func setUpTotalAmountView() {
        totalAmountView.translatesAutoresizingMaskIntoConstraints = false
        totalAmountView.backgroundColor = .systemBackground
        subListStackView.addArrangedSubview(totalAmountView)
        
        totalAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        totalAmountLabel.adjustsFontForContentSizeCategory = true
        totalAmountLabel.text = "Coût total"
        totalAmountLabel.textColor = UIColor(named: "yellowgrey")
        totalAmountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        totalAmountView.addSubview(totalAmountLabel)
        
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.adjustsFontForContentSizeCategory = true
        
        //MARK: calculating total amount for displayed subs
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.textColor = UIColor(named: "yellowgrey")
        amountLabel.backgroundColor = MSColors.background
        totalAmountView.addSubview(amountLabel)
        amountLabel.layer.cornerRadius = 5
        amountLabel.textAlignment = .center
        amountLabel.layer.masksToBounds = true
    }
}




//    @objc func addNewCategory() {
//        // Displaying the alert window
//        let alert = UIAlertController(title: "Nouvelle categorie", message: "Ajoutez votre nouvelle categorie", preferredStyle: .alert)
//        let saveAction = UIAlertAction(title: "Ajouter", style: .default) { [unowned self] action in
//            guard let textField = alert.textFields?.first,
//                  let categoryToSave = textField.text else { return }
//            // Saving the new category into the viewModel
//            viewModel?.addNewCategory(categoryToSave)
//            print("voici la cateory name ajoutée :\(categoryToSave)")
//            viewModel?.fetchCategories()
//            categoryCollectionView.reloadData()
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
//        alert.addTextField()
//        alert.addAction(saveAction)
//        alert.addAction(cancelAction)
//        present(alert, animated: true)
//    }

//    func configureCategoriesStackView() {
//        categoriesStackView.translatesAutoresizingMaskIntoConstraints = false
//        categoriesStackView.backgroundColor = MSColors.background
//        categoriesStackView.spacing = 5.5
//        view.addSubview(categoriesStackView)
//        configureAddCategoryButton()
//        configureCategoriesCollectionView()
//    }
    
//    func configureAddCategoryButton() {
//        addCategoryButton.translatesAutoresizingMaskIntoConstraints = false
//        addCategoryButton.setImage(UIImage(systemName: "plus.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 38, weight: .light, scale: .small)), for: .normal)
//        addCategoryButton.tintColor = MSColors.maintext
//        addCategoryButton.addTarget(self, action: #selector(addNewCategory), for: .touchUpInside)
//        categoriesStackView.addArrangedSubview(addCategoryButton)
//    }
    
//    func configureCategoriesCollectionView() {
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.itemSize = CGSize(width: view.frame.size.width/5, height: view.frame.size.width/13.5)
//        layout.scrollDirection = .horizontal
//        categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        categoryCollectionView.backgroundColor = MSColors.background
//
//        categoryCollectionView.register(CategoriesCell.self, forCellWithReuseIdentifier: CategoriesCell.identifier)
//        categoryCollectionView.dataSource = self
//        categoryCollectionView.delegate = self
//        categoryCollectionView.translatesAutoresizingMaskIntoConstraints = false
//        categoryCollectionView.isScrollEnabled = true
//        categoryCollectionView.isUserInteractionEnabled = true
//        categoryCollectionView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height/6.5)
//        categoriesStackView.addArrangedSubview(categoryCollectionView)
//    }
//MARK: -Setting up notification authorization
extension HomeViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }

    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
//        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { (success, error) in

        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }

}
