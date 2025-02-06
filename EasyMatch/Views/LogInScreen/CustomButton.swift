
import UIKit

class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
        
        let buttonColor = UIColor(red: 222/255, green: 243/255, blue: 88/255, alpha: 1)
        
        let tinColor = UIColor(red: 34/255, green: 43/255, blue: 33/255, alpha: 1)
        
        self.backgroundColor = hasBackground ? buttonColor : .clear
        
        let titleColor: UIColor = hasBackground ? tinColor : buttonColor
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
            
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
