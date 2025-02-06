
import UIKit
import FirebaseAuth

class HomeController: UIViewController {
    

    // MARK: - UI Components
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "profileImage")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Nuridin Safaraliev"
        label.numberOfLines = 1
        return label
    }()
    
    
    private let ageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "20"
        label.numberOfLines = 1
        return label
    }()
    
    private let sportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Favorite sport: Football"
        label.numberOfLines = 1
        return label
    }()

    private let teamLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "Team: NAU "
        label.numberOfLines = 1
        return label
    }()
    
    private let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("edit", for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(didTapEdit), for: .touchUpInside)
        return button
    }()
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.nameLabel.text = "\(user.username)\n\(user.email)"
            }
            
            
        }
        

        
    }
    
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
    
        self.navigationItem.titleView?.backgroundColor = .black
        
        self.view.addSubview(imageView)
        self.view.addSubview(nameLabel)
        self.view.addSubview(ageLabel)
        self.view.addSubview(sportLabel)
        self.view.addSubview(editButton)
        self.view.addSubview(teamLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        sportLabel.translatesAutoresizingMaskIntoConstraints = false
        editButton.translatesAutoresizingMaskIntoConstraints = false
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 80),
            nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            ageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            ageLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        
            teamLabel.topAnchor.constraint(equalTo: ageLabel.bottomAnchor, constant: 10),
            teamLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            sportLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: 10),
            sportLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            
            editButton.topAnchor.constraint(equalTo: sportLabel.bottomAnchor, constant: 50),
            editButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            editButton.widthAnchor.constraint(equalToConstant: 100)
        ])

    }
    
    // MARK: - Selectors
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
            
        }
    }
    
    @objc private func didTapEdit(){
        let vc = HomeEditController()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func updateProfile(name: String, age: String, sport: String) {
            nameLabel.text = name
            ageLabel.text = age
            sportLabel.text = sport
        }

    
}
extension HomeController: TeamDetailDelegate {
    func updateTeam(teamName: String) {
        teamLabel.text = "Team: \(teamName)"
    }
}
