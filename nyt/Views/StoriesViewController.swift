//
//  StoriesViewController.swift
//  nyt
//
//  Created by Umer Saleem on 28/07/2020.
//  Copyright © 2020 Umer Saleem. All rights reserved.
//

import UIKit

class StoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private lazy var viewModel = StoriesViewModel()
    private let  activityIndicator = UIActivityIndicatorView(style: .large)
    var storyType: TabBarController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /// Adding activity indicator until data is populated
        activityIndicator.center = view.center
        activityIndicator.color = .black
        view.addSubview(activityIndicator)
        bindViewModel()
        tabBarController?.navigationItem.title = storyType?.viewHeaderTitle
    }
    
}

// MARK: - Table view data source

extension StoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.storyCellIdentifier, for: indexPath) as! StoryTableViewCell

        /// Configure the cell
        let story = viewModel.stories.value[indexPath.row]
        cell.viewModel.story = story
        cell.configureCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = UIStoryboard(name: SegueIdentifiers.main, bundle: nil).instantiateViewController(withIdentifier: SegueIdentifiers.detailViewController) as! DetailViewController
        detailVC.viewModel.story = viewModel.stories.value[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        self.show(detailVC, sender: nil)
    }
}

//MARK:- Initilize ViewModel and bind it with View
extension StoriesViewController: AlertPresentable {
    
    func bindViewModel() {
        viewModel.storyType = storyType
        viewModel.isLoading.bind { [weak self] _ in
            DispatchQueue.main.async {
                (self?.viewModel.isLoading.value)! ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.stories.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        viewModel.errorStr.bind { [weak self] _ in
            if let errorStr = self?.viewModel.errorStr.value, !errorStr.isEmpty {
                DispatchQueue.main.async {
                    self?.presentAlert(title: "Error", message: errorStr, completion: nil)
                }
            }
        }
    }
}
