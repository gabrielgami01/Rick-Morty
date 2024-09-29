import UIKit

extension UILabel {
    static func createLabel(for textStyle: UIFont.TextStyle) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: textStyle)
        label.numberOfLines = 0
        
        return label
    }

    static func createHeaderLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.text = text
            
        return label
    }
}
