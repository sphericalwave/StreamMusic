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
    func update(tracks: Tracks)
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
        queryService.searchResults(searchTerm: searchText) { [weak self] tracks, errorMessage in
            guard let tracks = tracks else {
                print("Search error: " + errorMessage)
                return
            }
            var tracks2 = Tracks()  //FIXME: Constructor Please
            tracks2.tracks = tracks
            self?.searchEngineDelegate?.update(tracks: tracks2)
        }
    }
}
