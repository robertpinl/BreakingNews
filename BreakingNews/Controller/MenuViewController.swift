//
//  MenuViewController.swift
//  BreakingNews
//
//  Created by Robert Pinl on 30.01.2021.
//

import UIKit
import SDWebImage

class MenuViewController: UITableViewController, SelectCountryDelegate {
    
    let apiService = ApiManager()
    var newsArray = [Article]()
    var countryShort: String = "country=us&"
    var detailArticleURL: URL?
    
    //MARK: Time and date formatters
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
        
        fetchNews(url: "\(K.baseUrl)\(countryShort)\(K.apiKey)")
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
        
        cell.newsSource.text = newsArray[indexPath.row].source.name
        cell.newsImage.sd_setImage(with: newsArray[indexPath.row].urlToImage, placeholderImage: UIImage(named: "default"), options: .highPriority) { (image, error, cacheType, url) in
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
        Task {
            do {
                let articles = try await apiService.fetchAPI()
                for article in articles {
                    self.newsArray.append(Article(title: article.title, publishedAt: article.publishedAt, url: article.url, urlToImage: article.urlToImage, source: article.source))
                    self.tableView.reloadData()
                }
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
    //MARK: - Category UIMenu
    func categoryMenu() -> UIMenu {
        
        let topnews = UIAction(title: "Top News") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)\(K.apiKey)")
        }
        let business = UIAction(title: "Business") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=business&\(K.apiKey)")
        }
        let entertainment = UIAction(title: "Entertainment") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=entertainment&\(K.apiKey)")
        }
        let health = UIAction(title: "Health") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=health&\(K.apiKey)")
        }
        let science = UIAction(title: "Science") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=science&\(K.apiKey)")
        }
        let sports = UIAction(title: "Sports") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=sports&\(K.apiKey)")
        }
        let technology = UIAction(title: "Technology") { (action) in
            self.fetchNews(url: "\(K.baseUrl)\(self.countryShort)category=technology&\(K.apiKey)")
        }
        let categoryMenu = UIMenu(title: "Category", children: [topnews, business, entertainment, health, technology, science, sports])
        
        return categoryMenu
    }
    
    //MARK: - Change Country
    @IBAction func changeCountryPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: K.Segue.countrySelection, sender: self)
    }
    
    func didChangeCountry(country: Country) {
        self.countryShort = "country=\(country.short)&"
        fetchNews(url: "\(K.baseUrl)\(countryShort)\(K.apiKey)")
    }
    
    //MARK: - Prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == K.Segue.detail {
            if let destination = segue.destination as? DetailViewController {
                destination.articleUrl = detailArticleURL
            }
        }
        
        if segue.identifier == K.Segue.countrySelection {
            let destination = segue.destination as! CountrySelectionViewController
            destination.delegate = self
        }
    }
}



