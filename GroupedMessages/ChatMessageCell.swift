//
//  ChatMessageCell.swift
//  GroupedMessages
//
//  Created by Anirudha SM on 18/11/21.
//

import UIKit



class ChatMessageCell: UITableViewCell {
    
    let messageLabel = UILabel()
    
    let messagebackgroundView = UIView()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    
    var chatMessage : ChatMessage! {
        didSet{
            messagebackgroundView.backgroundColor = chatMessage.isIncoming ? .systemGray : .systemRed
            messageLabel.textColor = chatMessage.isIncoming ? .black : .white
            messageLabel.text = chatMessage.text
            
            if chatMessage.isIncoming {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else{
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        messagebackgroundView.backgroundColor = .yellow
        messagebackgroundView.layer.cornerRadius = 12
        
        addSubview(messagebackgroundView)
        addSubview(messageLabel)
        
        messageLabel.numberOfLines = 0
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messagebackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messagebackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            messagebackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            messagebackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            messagebackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16)
            
        ])
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        leadingConstraint.isActive = true
        
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        trailingConstraint.isActive = true
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
