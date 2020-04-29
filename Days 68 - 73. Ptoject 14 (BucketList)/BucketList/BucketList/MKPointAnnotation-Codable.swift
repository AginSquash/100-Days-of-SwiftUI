//
//  MKPointAnnotation-Codable.swift
//  BucketList
//
//  Created by Vlad Vrublevsky on 29.04.2020.
//  Copyright © 2020 Vlad Vrublevsky. All rights reserved.
//

import MapKit

class CodableMKPointAnnotation: MKPointAnnotation, Codable { //This way not working now!
    enum CodingKeys: CodingKey {
        case title, subtitle, latitude, longitude
    }

    override init() {
        super.init()
    }

    public required init(from decoder: Decoder) throws {
        super.init()

        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        subtitle = try container.decode(String.self, forKey: .subtitle)

        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(subtitle, forKey: .subtitle)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
}


// FIx
struct CodableMKPoint: Codable
{
    let title: String
    let subtitle: String
    let latitude: Double
    let longitude: Double
}

func MKPointAnnotationToCodableMKPoint(points: [MKPointAnnotation]) -> [CodableMKPoint] {
    var codableMKPoints = [CodableMKPoint]()
    for point in points
    {
        let codableMKPoint = CodableMKPoint(title: point.title ?? "Unknown title", subtitle: point.subtitle ?? "Unknown subtitle",
                                            latitude: point.coordinate.latitude, longitude: point.coordinate.longitude)
        codableMKPoints.append(codableMKPoint)
    }
    return codableMKPoints
}

func CodableMKPointToMKPointAnnotation(points: [CodableMKPoint]) -> [MKPointAnnotation]
{
    var mkPointAnnotation = [MKPointAnnotation]()
    for point in points {
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.title = point.title
        pointAnnotation.subtitle = point.subtitle
        pointAnnotation.coordinate.latitude = point.latitude
        pointAnnotation.coordinate.longitude = point.longitude
        mkPointAnnotation.append(pointAnnotation)
    }
    return mkPointAnnotation
}
