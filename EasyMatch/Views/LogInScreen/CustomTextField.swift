import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor(red: 73/255, green: 80/255, blue: 74/255, alpha: 1)
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.textColor = .white
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        let placeholderColor = UIColor(red: 129/255, green: 133/255, blue: 130/255, alpha: 1)
        
        switch fieldType {
        case .username:
            self.attributedPlaceholder = NSAttributedString(
                string: "Username",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )

        case .email:
            self.attributedPlaceholder = NSAttributedString(
                string: "Email Address",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
            
        case .password:
            self.attributedPlaceholder = NSAttributedString(
                string: "password",
                attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
            )
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
