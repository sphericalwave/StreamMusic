//
//  SearchBar.swift
//  Gyphs
//
//  Created by Aaron Anthony on 2020-01-30.
//  Copyright © 2020 SphericalWaveSoftware. All rights reserved.
//

import UIKit

protocol SearchEngineDelegate: AnyObject
{
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
    self.obscuresBackgroundDuringPresentation = false
    self.hidesNavigationBarDuringPresentation = true
  }
  required init?(coder: NSCoder) { fatalError() }
}

extension SearchEngine: UISearchBarDelegate
{
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    guard let searchText = searchBar.text else { return }
    UIApplication.shared.isNetworkActivityIndicatorVisible = true //FIXME: These are deprecated
    queryService.searchResults(searchTerm: searchText) { [weak self] tracks, errorMessage in
      UIApplication.shared.isNetworkActivityIndicatorVisible = false  //FIXME: These are deprecated
      guard let tracks = tracks else {
        print("Search error: " + errorMessage)
        return
      }
      self?.searchEngineDelegate?.update(tracks: tracks)
    }
  }
}
