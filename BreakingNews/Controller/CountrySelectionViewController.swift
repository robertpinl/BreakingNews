//
//  CountrySelectionViewController.swift
//  BreakingNews
//
//  Created by Robert P on 17.03.2021.
//

import UIKit

protocol SelectCountryDelegate {
    func didChangeCountry(country: Country)
}

class CountrySelectionViewController: UITableViewController {
    
    var delegate: SelectCountryDelegate?
    
    let countries = [Country(name: "United Arab Emirates", flag: "🇦🇪", short: "ae"),
                     Country(name: "Argentina", flag: "🇦🇷", short: "ar"),
                     Country(name: "Austria", flag: "🇦🇹", short: "at"),
                     Country(name: "Australia", flag: "🇦🇺", short: "au"),
                     Country(name: "Belgium", flag: "🇧🇪", short: "be"),
                     Country(name: "Brazil", flag: "🇧🇷", short: "br"),
                     Country(name: "Canada", flag: "🇨🇦", short: "ca"),
                     Country(name: "Switzerland", flag: "🇨🇭", short: "ch"),
                     Country(name: "China", flag: "🇨🇳", short: "cn"),
                     Country(name: "Colombia", flag: "🇨🇴", short: "co"),
                     Country(name: "Cuba", flag: "🇨🇺", short: "cu"),
                     Country(name: "Czechia", flag: "🇨🇿", short: "cz"),
                     Country(name: "Germany", flag: "🇩🇪", short: "de"),
                     Country(name: "Egypt", flag: "🇪🇬", short: "eg"),
                     Country(name: "France", flag: "🇫🇷", short: "fr"),
                     Country(name: "United Kingdom", flag: "🇬🇧", short: "gb"),
                     Country(name: "Greece", flag: "🇬🇷", short: "gr"),
                     Country(name: "Hungary", flag: "🇭🇺", short: "hu"),
                     Country(name: "Indonesia", flag: "🇮🇩", short: "in"),
                     Country(name: "New Zealand", flag: "🇳🇿", short: "nz"),
                     Country(name: "United States of America", flag: "🇺🇸", short: "us")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath)
        
        let country = countries[indexPath.row]
        cell.textLabel?.text = "  \(country.flag)  \(country.name)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didChangeCountry(country: countries[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}
