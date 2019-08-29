//
//  AddressSearchViewController.swift
//  AddressSearch
//
//  Created by Ty Schenk on 8/27/19.
//  Copyright © 2019 Sparkir, Inc. All rights reserved.
//

import UIKit
import MapKit

final public class ASViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKLocalSearchCompleterDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var noResultsLabel: UILabel!

	fileprivate var searchCompleter = MKLocalSearchCompleter()
	fileprivate var searchResults = [MKLocalSearchCompletion]()
	public var delegate: ASDelegate?
	
	override public func viewDidLoad() {
		super.viewDidLoad()
		searchCompleter.delegate = self
		self.tableView.delegate = self
		self.tableView.dataSource = self
	}
	
	public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		self.noResultsLabel.isHidden = true
		searchCompleter.queryFragment = searchText
		
		if searchText == "" {
			self.noResultsLabel.isHidden = false
			
			// remove all search results from array
			searchResults.removeAll()
			
			// reload table view with empty results
			self.tableView.reloadData()
		}
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return searchResults.count
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let searchResult = searchResults[indexPath.row]
		let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
		cell.textLabel?.text = searchResult.title
		cell.detailTextLabel?.text = searchResult.subtitle
		return cell
	}
	
	public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		let completion = searchResults[indexPath.row]
		
		let searchRequest = MKLocalSearch.Request(completion: completion)
		let search = MKLocalSearch(request: searchRequest)
		search.start { (response, error) in
			let placeMark = response!.mapItems[0].placemark
			guard let address = placeMark.title else { return }
			self.getAddressData(from: address)
		}
	}
	
	public func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
		searchResults = completer.results
		self.tableView.reloadData()
	}
	
	public func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
		// handle error
	}
	
	/// Returns array of address dictionaries from a String
	fileprivate func getAddressData(from string: String) {
		var addressData: Dictionary<NSTextCheckingKey, String> = [:]
		
		let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.address.rawValue)
		let matches = detector.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
		
		// put matches into String array
		for match in matches {
			if match.resultType == .address {
				guard let components = match.components else { return }
				addressData = components
			}
		}
		
		// send data to delegate
		self.delegate?.addressSelected(data: addressData)
		self.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func closeSearch(_ sender: UIButton) {
		self.dismiss(animated: true, completion: nil)
	}
	
	public static func launch() -> ASViewController {
		// Pull framework bundle
		let kitBundle = Bundle(for: ASViewController.self)
		let bundleURL = kitBundle.url(forResource: "AddressSearch", withExtension: "bundle")
		let bundle = Bundle(url: bundleURL!)
		
		let storyboard = UIStoryboard(name: "Map", bundle: bundle)
		
		let controller = storyboard.instantiateViewController(withIdentifier: "asMain") as! ASViewController
		
		return controller
	}
}
