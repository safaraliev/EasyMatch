import UIKit

// Модель данных для поста
struct Post {
    let game: String
    let address: String
    let content: String
    let time: String
}

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Таблица для отображения постов
    private let tableView : UITableView = {
        let tv = UITableView()
        tv.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)

        return tv
    }()
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NAV
        navigationItem.title = "Available matches now: \(posts.count)"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPostAlert))
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 222/255, green: 243/255, blue: 88/255, alpha: 1)
        
        
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        SetupUI()
        
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        let post = posts[indexPath.row]
        cell.gameLabel.text = post.game
        cell.addressLabel.text = post.address
        cell.contentLabel.text = post.content
        cell.timeLabel.text = post.time
        return cell
    }

    // MARK: Setup UI
    
    private func SetupUI(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - Actions

    
    @objc private func addPostAlert() {
        

        
        let alert = UIAlertController(title: "Add post", message: "write information below", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.placeholder = "Game"
        }
        alert.addTextField { textField in
            textField.placeholder = "address"
        }
        alert.addTextField { textField in
            textField.placeholder = "comment"
        }
        alert.addTextField { textField in
            textField.placeholder = "time"
        }
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: {_ in
            guard let textField = alert.textFields, textField.count == 4 else {return}
            
            let game = textField[0].text ?? ""
            let adress = textField[1].text ?? ""
            let content = textField[2].text ?? ""
            let time = textField[3].text ?? ""
            
            let newPost = Post(game: game, address: adress, content: content, time: time)
            self.posts.insert(newPost, at: 0) // Добавляем новый пост в начало массива
            self.navigationItem.title = "Available matches now: \(self.posts.count)"
//            self.tableView.reloadData()
            self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
