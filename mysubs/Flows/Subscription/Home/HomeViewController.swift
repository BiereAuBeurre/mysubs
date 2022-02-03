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

final class HomeViewController: UIViewController, UINavigationBarDelegate {
    
    // Private Properties
    private let totalAmountView = UIView()
    private var totalAmountLabel = UILabel()
    private var subListStackView = UIStackView()
    private  var subCollectionView: UICollectionView!
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    // Properties
    var viewModel: HomeViewModel?
    weak var coordinator: AppCoordinator?
    var amountLabel = UILabel()
    var viewState: State<[Subscription]> = .showData {
        didSet {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchSubscription()
//        setUpUI()
        setUpTotalAmountView()
        viewModel?.computeTotal()
    }
    
    //OBJ C METHODS
    @objc func plusButtonAction() {
        viewModel?.showNewSub()
    }

    //Privates methods
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
        
    private func cellTapped(sub: Subscription) {
        viewModel?.showDetail(sub: sub)
    }
    
    private func deleteSub(sub: Subscription) {
        do {
            try viewModel?.storageService.delete(sub)
        } catch {
            print(error); self.showAlert("Erreur", "Suppression impossible. Merci de réessayer plus tard")
        }
    }
  
}

// MARK: Collection view set up
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel?.subscriptions.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let subCell = collectionView.dequeueReusableCell(withReuseIdentifier: SubCell.identifier, for: indexPath) as? SubCell else {
            assertionFailure("The dequeue collection view cell was of the wrong type")
            return UICollectionViewCell()
        }
        subCell.subscription = viewModel?.subscriptions[indexPath.row]
        subCell.addCornerRadius()
        return subCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedSub = viewModel?.subscriptions[indexPath.row] else { return }
        cellTapped(sub: selectedSub)
    }
}

// MARK: Refreshing datas
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
    
}
// MARK: UI set up
extension HomeViewController {
    
    func setUpUI() {
        setUpNavBar()
        view.backgroundColor = MSColors.background

        subListStackView.translatesAutoresizingMaskIntoConstraints = false
        subListStackView.axis = .vertical
        
        //Collection View
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
            amountLabel.heightAnchor.constraint(equalToConstant: 30)
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
        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: plusButton)
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
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: menuButton)
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
        
        //calculating total amount for displayed subs
        amountLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        amountLabel.textColor = UIColor(named: "yellowgrey")
        amountLabel.backgroundColor = MSColors.background
        totalAmountView.addSubview(amountLabel)
        amountLabel.layer.cornerRadius = 5
        amountLabel.textAlignment = .center
        amountLabel.layer.masksToBounds = true
    }
}
