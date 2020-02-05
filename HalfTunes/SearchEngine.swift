//
//  SearchBar.swift
//  Gyphs
//
//  Created by Aaron Anthony on 2020-01-30.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import UIKit

class SearchEngine: UISearchController
{
    init(searchResultsScreen: UIViewController) {
        super.init(searchResultsController: searchResultsScreen)
        let searchBar = self.searchBar
        searchBar.placeholder = "Song name or artist"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchResultsUpdater = self
        delegate = self
        
        self.obscuresBackgroundDuringPresentation = false
        self.hidesNavigationBarDuringPresentation = true
    }
    
    required init?(coder: NSCoder) { fatalError() }
}

extension SearchEngine: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController) {
        print("What do i do here")
    }
}

extension SearchEngine: UISearchControllerDelegate { }

//extension SearchEngine: UISearchBarDelegate
//{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("Submit a Request to Using Search URL")
//        //pass results to data object
//    }
//}

extension SearchEngine: UISearchBarDelegate
{
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//    dismissKeyboard()
//    guard let searchText = searchBar.text, !searchText.isEmpty else { return }
//    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    queryService.getSearchResults(searchTerm: searchText) { [weak self] results, errorMessage in
//      UIApplication.shared.isNetworkActivityIndicatorVisible = false
//
//      if let results = results {
//        self?.searchResults = results
//        self?.tableView.reloadData()
//        self?.tableView.setContentOffset(CGPoint.zero, animated: false)
//      }
//
//      if !errorMessage.isEmpty { print("Search error: " + errorMessage) }
//    }
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    //view.addGestureRecognizer(tapRecognizer)
  }
  
  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    //view.removeGestureRecognizer(tapRecognizer)
  }
  
  //FIXME: remove if unneeded
  //  lazy var tapRecognizer: UITapGestureRecognizer = {
  //    var recognizer = UITapGestureRecognizer(target:self, action: #selector(dismissKeyboard))
  //    return recognizer
  //  }()
}
