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
    let appleMusic: AppleMusic
    weak var searchEngineDelegate: SearchEngineDelegate? //is MusicSearchScreen
    
    init(appleMusic: AppleMusic) {
        self.appleMusic = appleMusic
        super.init(searchResultsController: nil)
        searchBar.placeholder = "Song name or artist"
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        obscuresBackgroundDuringPresentation = false
        hidesNavigationBarDuringPresentation = true
    }
    required init?(coder: NSCoder) { fatalError() }
}

extension SearchEngine: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let string = searchBar.text else { return }
        appleMusic.tracksMatching(searchTerm: string) { [weak self] tracks in
            self?.searchEngineDelegate?.update(tracks: tracks)
        }
    }
}
