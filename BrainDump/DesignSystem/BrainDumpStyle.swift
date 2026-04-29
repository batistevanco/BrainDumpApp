import SwiftUI

enum FN {
    static let ink = Color(red: 0.067, green: 0.067, blue: 0.067)
    static let secondary = Color(red: 0.420, green: 0.447, blue: 0.502)
    static let tertiary = Color(red: 0.612, green: 0.639, blue: 0.686)
    static let line = Color(red: 0.898, green: 0.906, blue: 0.922)
    static let surface = Color(red: 0.969, green: 0.969, blue: 0.980)
    static let success = Color(red: 0.114, green: 0.620, blue: 0.459)
}

func time(_ date: Date) -> String {
    date.formatted(.dateTime.hour(.twoDigits(amPM: .omitted)).minute(.twoDigits).locale(Locale(identifier: "nl_BE")))
}
