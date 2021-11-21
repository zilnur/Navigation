import Foundation
import UIKit

class CustomTextField: UITextField {
    
    init(font: UIFont, textColor: UIColor, placeholder: String) {
        super.init(frame: .zero)
        self.font = font
        self.textColor = textColor
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        nil
    }
}
