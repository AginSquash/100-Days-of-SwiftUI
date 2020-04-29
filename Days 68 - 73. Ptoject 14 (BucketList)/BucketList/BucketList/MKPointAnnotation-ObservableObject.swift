//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Vlad Vrublevsky on 29.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var wrappedTitle: String {
        get { self.title ?? "Unknown value" }
        set { self.title = newValue }
    }
    public var wrappedSubtitle: String {
          get { self.subtitle ?? "Unknown value" }
          set { subtitle = newValue }
      }
}
