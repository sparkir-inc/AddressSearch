//
//  AddressSearchDelegate.swift
//  AddressSearch
//
//  Created by Ty Schenk on 8/27/19.
//  Copyright © 2019 Sparkir, Inc. All rights reserved.
//

import MapKit

public protocol ASDelegate {
	func addressSelected(data: Dictionary<NSTextCheckingKey, String>)
}
