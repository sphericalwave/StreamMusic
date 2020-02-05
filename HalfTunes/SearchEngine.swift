//
//  SearchBar.swift
//  Gyphs
//
//  Created by Aaron Anthony on 2020-01-30.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import UIKit

protocol SearchEngineDelegate: AnyObject {
  func update(tracks: [Track])
}

class SearchEngine: UISearchController
{
  let queryService: QueryService
  weak var searchEngineDelegate: SearchEngineDelegate?
  
  init(searchResultsScreen: UIViewController?, queryService: QueryService) {
    self.queryService = queryService
    super.init(searchResultsController: searchResultsScreen)
    let searchBar = self.searchBar
    searchBar.placeholder = "Song name or artist"
    searchBar.showsCancelButton = true
    searchBar.delegate = self
    //searchResultsUpdater = self //FIXME: Make MusicSearchScreen the searchResultsUpdater
    delegate = self
    
    self.obscuresBackgroundDuringPresentation = false
    self.hidesNavigationBarDuringPresentation = true
  }
  
  required init?(coder: NSCoder) { fatalError() }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    guard searchBar.delegate != nil, searchResultsUpdater != nil, searchEngineDelegate != nil else { fatalError() }
  }
}

//extension SearchEngine: UISearchResultsUpdating
//{
//  func updateSearchResults(for searchController: UISearchController) {
//    print("What do i do here")
//    //searchController.
//  }
//}

extension SearchEngine: UISearchControllerDelegate { }

extension SearchEngine: UISearchBarDelegate
{
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let searchText = searchBar.text, !searchText.isEmpty else { return }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    queryService.searchResults(searchTerm: searchText) { [weak self] tracks, errorMessage in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      guard let tracks = tracks else {
        print("Search error: " + errorMessage)
        return
      }
      self?.searchEngineDelegate?.update(tracks: tracks)
      
      
      //searchResultsUpdater?.updateSearchResults(for: self) //Not Sure About this
      //          if let results = results {
      //            self?.searchResults = results
      //            self?.tableView.reloadData()
      //            self?.tableView.setContentOffset(CGPoint.zero, animated: false)
      //          }
    }
  }
}
