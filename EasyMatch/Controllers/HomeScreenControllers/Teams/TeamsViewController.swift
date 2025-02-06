import UIKit

struct Team {
    let name: String
    let sport: String
    let leader: String
    var membersCount: Int
}

class TeamsViewController: UIViewController {
    
    weak var delegate: TeamDetailDelegate?
    
    // MARK: - Properties
    private var teams: [Team] = [
        Team(name: "Houston Rockets", sport: "Basketball", leader: "James Harden", membersCount: 15),
        Team(name: "Texas Tornadoes", sport: "Soccer", leader: "Alex Johnson", membersCount: 11),
        Team(name: "Spinning Cyclones", sport: "Tennis", leader: "Emily Davis", membersCount: 5),
        Team(name: "Mighty Swimmers", sport: "Swimming", leader: "Michael Phelps", membersCount: 10),
        Team(name: "Fast Falcons", sport: "Football", leader: "Tom Brady", membersCount: 22)
    ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "teamCell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        self.title = "Teams"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        self.view.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
        tableView.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
        self.view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell", for: indexPath)
        cell.textLabel?.text = teams[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(red: 53/255, green: 61/255, blue: 54/255, alpha: 1)
        cell.textLabel?.textColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedTeam = teams[indexPath.row]
        let detailVC = TeamDetailViewController(team: selectedTeam)
        detailVC.delegate = delegate // Pass the delegate instance
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

}
