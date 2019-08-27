//
//  AddressSearchViewController.swift
//  AddressSearch
//
//  Created by Ty Schenk on 8/27/19.
//  Copyright © 2019 Sparkir, Inc. All rights reserved.
//

import UIKit

class AddressSearchViewController: UIViewController {
	
	var delegate: AddressSearchDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
	
	static func launch() -> AddressSearchViewController {
		// Pull framework bundle
		let kitBundle = Bundle(for: AddressSearchViewController.self)
		let bundleURL = kitBundle.url(forResource: "AddressSearch", withExtension: "bundle")
		let bundle = Bundle(url: bundleURL!)
		
		let storyboard = UIStoryboard(name: "Map", bundle: bundle)
		let controller = storyboard.instantiateInitialViewController() as! AddressSearchViewController
		
		return controller
	}

}
