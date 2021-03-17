//
//  MenuViewController.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import UIKit
import SDWebImage

class MenuViewController: UITableViewController {
    
    var newsService = NewsAPI()
    var newsArray = [Article]()
    var detailArticleURL: URL?
    
    
    //MARK: - Time and date formatters
    let stringDateFormatter: DateFormatter = {
        let sdf = DateFormatter()
        sdf.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        return sdf
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .short
        df.dateStyle = .medium
        return df
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "newscell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "list.bullet"), primaryAction: nil, menu: categoryMenu())
        
        fetchNews(url: "\(K.baseUrl)\(K.apiKey)")
    }
    
    //MARK: - Tableview Delegate and Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "newscell", for: indexPath) as! NewsTableViewCell
        cell.newsLabel.text = newsArray[indexPath.row].title
        
        let publishedAtDate = stringDateFormatter.date(from: newsArray[indexPath.row].publishedAt)
        cell.newsDate.text = dateFormatter.string(from: publishedAtDate!)
        
        cell.newsSource.text = newsArray[indexPath.row].source
        cell.newsImage.sd_setImage(with: newsArray[indexPath.row].image, placeholderImage: UIImage(named: "default"), options: .highPriority) { (image, error, cacheType, url) in
            if error != nil {
                print(error.debugDescription)
                return
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailArticleURL = newsArray[indexPath.row].url
        
        if detailArticleURL != nil {
            performSegue(withIdentifier: K.Segue.detail, sender: self)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    //MARK: - Update UI
    func fetchNews(url: String) {
        newsArray = []
        newsService.fetchAPI(with: url) { (news) in
            DispatchQueue.main.async {
                for i in news {
                    self.newsArray.append(Article(title: i.title, publishedAt: i.publishedAt, url: i.url, image: i.urlToImage, source: i.source.name))
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Category UIMenu
    func categoryMenu() -> UIMenu {
        
        let topnews = UIAction(title: "Top News") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(K.apiKey)")
        }
        let business = UIAction(title: "Business") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=business&\(K.apiKey)")
        }
        let entertainment = UIAction(title: "Entertainment") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=entertainment&\(K.apiKey)")
        }
        let health = UIAction(title: "Health") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=health&\(K.apiKey)")
        }
        let science = UIAction(title: "Science") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=science&\(K.apiKey)")
        }
        let sports = UIAction(title: "Sports") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=sports&\(K.apiKey)")
        }
        let technology = UIAction(title: "Technology") { (action) in
            self.fetchNews(url: "\(K.baseUrl)category=technology&\(K.apiKey)")
        }
        let categoryMenu = UIMenu(title: "Category", children: [topnews, business, entertainment, health, technology, science, sports])
        
        return categoryMenu
    }
    
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.articleUrl = detailArticleURL
        }
    }
}


