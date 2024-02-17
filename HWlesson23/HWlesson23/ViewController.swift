//
//  ViewController.swift
//  HWlesson23
//
//  Created by Карина Дьячина on 16.02.24.
//

import UIKit
import WebKit

class ViewController: UIViewController, StringDelegate {
    func recieveString(text: String) {
    }
    
    
    lazy var textField: UITextField = {
       let textField = UITextField()
        textField.frame = CGRect(x: 10, y: 80, width: 300, height: 30)
        textField.placeholder = "input url"
        textField.keyboardType = .URL
        textField.backgroundColor = .systemGray5
        textField.textColor = .black
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let searchButton = UIButton()
        searchButton.frame = CGRect(x: 320, y: 80, width: 65, height: 30)
        searchButton.tintColor = .darkGray
        searchButton.backgroundColor = .systemBlue
        searchButton.layer.cornerRadius = 5
        searchButton.setTitle("seach", for: .normal)
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return searchButton
    }()
    
    lazy var clearButton: UIButton = {
        let clearButton = UIButton()
        clearButton.setTitle("⌫", for: .normal)
        clearButton.backgroundColor = .systemBlue
        clearButton.layer.cornerRadius = 3
        clearButton.frame = CGRect(x: 320, y: 115, width: 30, height: 30)
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        return clearButton
    }()
    
    lazy var backButton: UIButton = {
        let backButton = UIButton()
        backButton.setTitle("<", for: .normal)
        backButton.backgroundColor = .systemBlue
        backButton.layer.cornerRadius = 3
        backButton.frame = CGRect(x: 10, y: 115, width: 30, height: 30)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return backButton
    }()
    
    lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        forwardButton.setTitle(">", for: .normal)
        forwardButton.backgroundColor = .systemBlue
        forwardButton.layer.cornerRadius = 3
        forwardButton.frame = CGRect(x: 280, y: 115, width: 30, height: 30)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        return forwardButton
    }()
    
    lazy var bookmarkButton: UIButton = {
        let bookmarkButton = UIButton()
        bookmarkButton.setTitle("✩", for: .normal)
        bookmarkButton.backgroundColor = .systemBlue
        bookmarkButton.layer.cornerRadius = 3
        bookmarkButton.frame = CGRect(x: 355, y: 115, width: 30, height: 30)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return bookmarkButton
    }()
    
    lazy var showBookmarksButton: UIButton = {
        let showBookmarksButton = UIButton()
        showBookmarksButton.setTitle("Show bookmarks", for: .normal)
        showBookmarksButton.backgroundColor = .systemBlue
        showBookmarksButton.layer.cornerRadius = 3
        showBookmarksButton.frame = CGRect(x: 45, y: 115, width: 230, height: 30)
        showBookmarksButton.addTarget(self, action: #selector(showBookmarksButtonTapped), for: .touchUpInside)
        return showBookmarksButton
    }()
    
    lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
       // tableView.reloadData()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    weak var delegate: StringDelegate?
    
    var bookmarkArray: Array<Bookmark> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textField)
        view.addSubview(searchButton)
        view.addSubview(backButton)
        view.addSubview(forwardButton)
        view.addSubview(bookmarkButton)
        view.addSubview(showBookmarksButton)
        view.addSubview(clearButton)
        
        setupWebView()
        setupTableView()
        
    }
    
    func setupWebView() {
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: showBookmarksButton.bottomAnchor, constant: 5),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showBookmarksButton.bottomAnchor, constant: 5),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        tableView.register(BookmarkTableViewCell.self, forCellReuseIdentifier: "BookmarkTableViewCell")
    }

    @objc func searchButtonTapped() {
        webView.isHidden = false
        tableView.isHidden = true
        if let text = textField.text {
            if let search = URL(string: text) {
                let field = URLRequest(url: search)
                webView.load(field)
            }
        }
    }
    
    @objc func forwardButtonTapped() {
        webView.goForward()
    }
    
    @objc func backButtonTapped() {
        webView.goBack()
    }
    
    @objc func bookmarkButtonTapped() {
     //   bookmark = true
        let newBookmark = Bookmark(name: "bookmark: ", url: URL(string: textField.text ?? "https://www.google.com")!)
        bookmarkArray.append(newBookmark)
        tableView.reloadData()
        
    }
    
    @objc func showBookmarksButtonTapped() {
        webView.isHidden = true
        tableView.isHidden = false
     //   setupTableView()
//        func bookmarkData(
//            options: NSURL.BookmarkCreationOptions = [],
//            includingResourceValuesForKeys keys: [URLResourceKey]?,
//            relativeTo relativeURL: URL?
//        ) throws -> Data {
//            return Data()
//        }
    }
    
    @objc func clearButtonTapped() {
        textField.text = ""
    }
    
//    func sendString() {
//        let message = textField.text
//        delegate?.recieveString(text: textField.text!)
//    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookmarkTableViewCell", for: indexPath) as! BookmarkTableViewCell
        cell.configure(bookmark: bookmarkArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath)")
        webView.isHidden = true
        tableView.isHidden = false
       // delegate?.recieveString(text: textField.text!)
        recieveString(text: textField.text!)
        if let url = URL(string: textField.text!) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

