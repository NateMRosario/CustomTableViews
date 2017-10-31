//
//  ViewController.swift
//  CustomTableViewCells
//
//  Created by C4Q on 10/31/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies: [Movie] = []

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        myTableView.delegate = self
        myTableView.dataSource = self
        self.myTableView.rowHeight = UITableViewAutomaticDimension
        self.myTableView.estimatedRowHeight = 200.0
    }
    func loadData() {
        let allMovies = MovieData.movies
        let sortedMovies = allMovies.sorted{$0.name < $1.name}
        self.movies = sortedMovies
    }

    ///Two required Data Source methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath)
        if let cell = cell as? MovieTableViewCell {
            let rowToSetUp = indexPath.row
            let movieToSetUp = movies[rowToSetUp]
            cell.titleLabel.text = movieToSetUp.name
            cell.descriptionLabel.text = movieToSetUp.description
            cell.moviePosterImageView.image = UIImage(named: movieToSetUp.posterImageName)
            return cell
        } else {
            return cell
        }
    }

    @IBAction func sortButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0 :
            self.movies = movies.sorted{$0.genre < $1.genre}
        case 1:
            self.movies = movies.sorted{$0.name < $1.name}
        default:
            break
        }
        myTableView.reloadData()
    }
}

