//
//  StatistikViewController.swift
//  Assistant-manager v1.0
//
//  Created by Anton Khlomov on 18/01/2022.
//
import UIKit
import WebKit

class StatistikViewController: UIViewController {
    
    var presenter: StatistikViewPresenterProtocol!
    
    private lazy var webView: WKWebView = {
        let config = WKWebViewConfiguration()
        let wv = WKWebView(frame: .zero, configuration: config)
        
        wv.backgroundColor = UIColor.appColor(.blueAssistantFon)
        wv.isOpaque = false
        wv.scrollView.backgroundColor = .clear
        wv.translatesAutoresizingMaskIntoConstraints = false
        
        return wv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.appColor(.blueAssistantFon)
        setupWebView()
        presenter.viewDidLoad()
    }
    
    private func setupWebView() {
        view.addSubview(webView)
        let bottomOffset = UIScreen.main.bounds.height * 0.1 //* 0.1 10% от высоты экрана
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -bottomOffset)
        ])
    }
}

extension StatistikViewController: StatistikViewProtocol {
    func loadDashboardPage(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}







/*
import UIKit
import Firebase


private let reuseIdentifier = "Cell"
private let searchBarCalendarIdentifier = "searchBarCalendarIdentifier"

class StatistikViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
    var presenter: StatistikViewPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.register(SearchBarCalendarModuleCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: searchBarCalendarIdentifier)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    //update on change of view orientation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return    CGSize (width: view.frame.width - 30, height: view.frame.width/1.5 + 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 60)
    }
    // убераем разрыв между вью по горизонтали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    // убераем разрыв между вью по вертикали
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
  

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        cell.backgroundColor =  UIColor.appColor(.blueAssistantFon)
        // Configure the cell
    
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: searchBarCalendarIdentifier, for: indexPath) as! SearchBarCalendarModuleCell
        header.backgroundColor =  UIColor.appColor(.pinkAssistant)
            return header        
    }
}
extension StatistikViewController{
    func alertRegistrationControllerMassage(title: String, message: String){
        let alertControler = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default)
        alertControler.addAction(alertOk)
        present(alertControler, animated: true, completion: nil)
    }
}
extension StatistikViewController: StatistikViewProtocol {
    func success() {
    }
   func failure(error: Error) {
       let error = "\(error.localizedDescription)"
       alertRegistrationControllerMassage(title: "Error", message: error)
   }
}

*/
