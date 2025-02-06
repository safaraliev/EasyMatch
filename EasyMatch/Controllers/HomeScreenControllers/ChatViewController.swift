import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    private let tableView = UITableView()
    private let messageInputView = UIView()
    private let messageTextField = UITextField()
    private let sendButton = UIButton()
    
    private var messages: [String] = ["Welcome to the team chat!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Team Chat"
        
        // Setup TableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MessageCell")
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        // Setup Message Input View
        messageInputView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        messageInputView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(messageInputView)
        
        // Setup Message TextField
        messageTextField.borderStyle = .roundedRect
        messageTextField.placeholder = "Type a message..."
        messageTextField.delegate = self
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        messageInputView.addSubview(messageTextField)
        
        // Setup Send Button
        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .normal)
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        messageInputView.addSubview(sendButton)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // TableView constraints
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            // Message Input View constraints
            messageInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 90),
            
            // Message TextField constraints
            messageTextField.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 16),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            messageTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // Send Button constraints
            sendButton.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -16),
            sendButton.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor)
        ])
    }
    
    @objc private func sendMessage() {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        messages.append(text)
        messageTextField.text = ""
        let indexPath = IndexPath(row: messages.count - 1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
}
