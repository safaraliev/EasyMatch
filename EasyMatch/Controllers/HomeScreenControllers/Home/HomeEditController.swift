
import UIKit

class HomeEditController: UIViewController {
    
    // MARK: - UI Components
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Name:"
        return label
    }()
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Age:"
        return label
    }()
    
    private let sportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = "Favorite Sport:"
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "Enter name:"
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "Enter age:"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let sportTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.placeholder = "Enter favorite sport:"
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(didTapSave), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Variables
    var delegate: HomeController?

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
        
        // Add the UI components
        self.view.addSubview(nameLabel)
        self.view.addSubview(ageLabel)
        self.view.addSubview(sportLabel)
        self.view.addSubview(nameTextField)
        self.view.addSubview(ageTextField)
        self.view.addSubview(sportTextField)
        self.view.addSubview(saveButton)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        sportLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        sportTextField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Name Label and TextField
            nameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80),
            nameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Age Label and TextField
            ageLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            ageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            ageLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            ageTextField.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            ageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Sport Label and TextField
            sportLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            sportLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            sportLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            sportTextField.topAnchor.constraint(equalTo: sportLabel.bottomAnchor, constant: 10),
            sportTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            sportTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            sportTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Save Button
            saveButton.topAnchor.constraint(equalTo: sportTextField.bottomAnchor, constant: 30),
            saveButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapSave() {
        // Save the edited data
        guard let name = nameTextField.text,
              let age = ageTextField.text,
              let sport = sportTextField.text else { return }
        
        // Update the HomeController with new data
        delegate?.updateProfile(name: name, age: age, sport: sport)
        
        AuthService.shared.uploadInfo(userAge: age) { error in
            if let error = error {
                print("ERROR:",error.localizedDescription)
            }
        }
        // Pop back to the HomeController
        self.navigationController?.popViewController(animated: true)
    }
    
}
