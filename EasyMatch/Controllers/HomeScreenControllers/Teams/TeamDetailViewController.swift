import UIKit

protocol TeamDetailDelegate: AnyObject {
    func updateTeam(teamName: String)
}

class TeamDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let team: Team
    weak var delegate: TeamDetailDelegate?

    
    // MARK: - UI Components
    private let sportLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let leaderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let membersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("Join Team", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didTapJoin), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializer
    init(team: Team) {
        self.team = team
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
        
        self.title = team.name
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        sportLabel.text = "Sport: \(team.sport)"
        leaderLabel.text = "Team Leader: \(team.leader)"
        membersLabel.text = "Members: \(team.membersCount)"
        
        let stackView = UIStackView(arrangedSubviews: [sportLabel, leaderLabel, membersLabel, joinButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            joinButton.widthAnchor.constraint(equalToConstant: 200),
            joinButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Selectors
    @objc private func didTapJoin() {
        delegate?.updateTeam(teamName: team.name)
        
        let alert = UIAlertController(title: "Joined!", message: "You have successfully joined \(team.name).", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
        membersLabel.text = "Members: \(team.membersCount + 1)"
    }
}
