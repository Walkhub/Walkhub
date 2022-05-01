import Foundation

extension String {
    func prettyPhoneNumber() -> String {
        let str = self.replacingOccurrences(of: " ", with: "")
        let arr = Array(str)
        if arr.count > 3 {
            if let regex = try? NSRegularExpression(pattern: "^010([0-9]{3,4})([0-9]{4})", options: .caseInsensitive) {
                let modString = regex.stringByReplacingMatches(
                    in: str,
                    options: [],
                    range: NSRange(str.startIndex..., in: str),
                    withTemplate: "010 $1 $2"
                )
                return modString
            }
        }
        return self
    }
}
