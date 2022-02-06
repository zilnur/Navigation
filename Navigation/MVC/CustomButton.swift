import Foundation
import UIKit

class CustomButton: UIButton {
    var onTap = {}
    
    init(title:String?, titleColor:UIColor?, backgroundColor: UIColor?) {
//        self.onTap = onTap
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    @objc private func buttonTapped () {
        onTap()
    }
}
