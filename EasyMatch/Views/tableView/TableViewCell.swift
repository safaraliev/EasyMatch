//
//  TableViewCell.swift
//  EasyMatch
//
//  Created by Нуридин Сафаралиев on 11/8/24.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let id = "Cell"

    
    let gameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 25)
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let addressLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20)
            label.textColor = .white
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let contentLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 18)
            label.textColor = .lightGray
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let timeLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 25)
            label.textColor = .lightGray
            label.textAlignment = .right
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    private let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 53/255, green: 61/255, blue: 54/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
        // MARK: - Initialization
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            contentView.addSubview(cellBackgroundView)
            // Добавляем все UILabel в contentView
            cellBackgroundView.addSubview(gameLabel)
            cellBackgroundView.addSubview(addressLabel)
            cellBackgroundView.addSubview(contentLabel)
            cellBackgroundView.addSubview(timeLabel)
            
            
            self.backgroundColor = UIColor(red: 32/255, green: 39/255, blue: 32/255, alpha: 1)
            // Устанавливаем констрейнты
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Setup Constraints
    private func setupConstraints() {
            // Констрейнты для cellBackgroundView
            NSLayoutConstraint.activate([
                cellBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
                cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
            
            // Констрейнты для gameLabel
            NSLayoutConstraint.activate([
                gameLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
                gameLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 15),
                gameLabel.trailingAnchor.constraint(lessThanOrEqualTo: timeLabel.leadingAnchor, constant: -10)
            ])
            
            // Констрейнты для timeLabel
            NSLayoutConstraint.activate([
                timeLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
                timeLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -15),
                timeLabel.widthAnchor.constraint(equalToConstant: 60)
            ])
        
        
        
            // Констрейнты для addressLabel
            NSLayoutConstraint.activate([
                addressLabel.topAnchor.constraint(equalTo: gameLabel.bottomAnchor, constant: 8),
                addressLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 15),
                addressLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -15)
            ])
            
            // Констрейнты для contentLabel
            NSLayoutConstraint.activate([
                contentLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
                contentLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 15),
                contentLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -15),
                contentLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -10)
            ])

    
    }
}
