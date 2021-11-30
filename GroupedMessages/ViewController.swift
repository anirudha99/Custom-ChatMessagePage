//
//  ViewController.swift
//  GroupedMessages
//
//  Created by Anirudha SM on 18/11/21.
//

import UIKit

struct ChatMessage {
    let text: String
    let isIncoming: Bool
    let date: Date
}

extension Date{
    static func dateFromCustomString(customString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: customString) ?? Date()
    }
}

class ViewController: UITableViewController {
    
    let cellID = "cell"
    
    let messagesFromServer = [
        ChatMessage(text: "first message", isIncoming: true, date: Date.dateFromCustomString(customString: "18/10/2021")),
        ChatMessage(text: "Providing some text so that it repeats Providing some text so that it repeats", isIncoming: true, date: Date.dateFromCustomString(customString: "18/10/2021")),
        ChatMessage(text: "Providing some text so that it repeats Providing some text so that it repeats Providing some text so that it repeats Providing some text so that it repeats", isIncoming: false, date: Date.dateFromCustomString(customString: "19/11/2021")),
        ChatMessage(text: "hey", isIncoming: false, date: Date.dateFromCustomString(customString: "19/11/2021")),
        ChatMessage(text: "first message", isIncoming: true, date: Date.dateFromCustomString(customString: "19/11/2021")),
        ChatMessage(text: "hello", isIncoming: false, date: Date.dateFromCustomString(customString: "20/11/2021")),
    ]

    
    
    fileprivate func attemptToAssembleGroupMessages(){
        print("Attempt to group messsages")
        
       let groupedMessages = Dictionary(grouping: messagesFromServer) { element in
            return element.date
        }
        
        //provide sorting for keys
        let sortedKeys = groupedMessages.keys.sorted()
        sortedKeys.forEach { (key) in
            let values = groupedMessages[key]
            chatMessages.append(values ?? [])
        }
    }
    
    var chatMessages = [[ChatMessage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptToAssembleGroupMessages()
        
        navigationItem.title = "Messages"
        navigationController?.navigationBar.prefersLargeTitles = true
    
        tableView.register(ChatMessageCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 0.90, alpha: 1)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatMessages.count
    }
    
    class DateHeaderLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            backgroundColor = .black
            textColor = .white
            textAlignment = .center
            font = UIFont.boldSystemFont(ofSize: 14)
            translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override var intrinsicContentSize: CGSize{
            let originalContentSize = super.intrinsicContentSize
            let height = originalContentSize.height + 10
            let width = originalContentSize.width + 16
            layer.cornerRadius = height / 2
            layer.masksToBounds = true
            return CGSize(width: width, height: height )
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let firstMessageInSection = chatMessages[section].first {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            let dateString = dateFormatter.string(from: firstMessageInSection.date)
            
            let label = DateHeaderLabel()
            label.text = dateString
            
            
            
            let containerView = UIView()
            containerView.addSubview(label)
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
            
            return containerView
        }
       return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatMessageCell
        
        let chatMessage = chatMessages[indexPath.section][indexPath.row]
        cell.chatMessage = chatMessage

        return cell
    }
}

