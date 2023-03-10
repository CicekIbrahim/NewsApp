//
//  StringEXT.swift
//  NewsApp
//
//  Created by Ibrahim Cicek on 10.03.2023.
//

import Foundation

extension String {
    func toDate() -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MM-yyyy"

        if let date = dateFormatterGet.date(from: self) {
            return dateFormatterPrint.string(from: date)
        } else {
            return nil
        }
    }
}
