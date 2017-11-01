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
        self.myTableView.estimatedRowHeight = 200
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
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Movie Cell", for: indexPath)
            let movieToSetUp = movies[indexPath.row]
            if let movieCell = cell as? MovieTableViewCell {
                movieCell.titleLabel.text = movieToSetUp.name
                movieCell.descriptionLabel.text = movieToSetUp.description
                movieCell.moviePosterImageView.image = UIImage(named: movieToSetUp.posterImageName)
                return  movieCell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Right Cell", for: indexPath)
            let movieToSetUp = movies[indexPath.row]
            if let movieCell = cell as? MovieRightAlignedTableViewCell {
                movieCell.rightTitle.text = movieToSetUp.name
                movieCell.rightDescription.text = movieToSetUp.description
                movieCell.rightImage.image = UIImage(named: movieToSetUp.posterImageName)
                return movieCell
            }
        }
        return UITableViewCell()
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

