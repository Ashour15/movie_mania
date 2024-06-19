## Movie And Reviews Data Importer with Rails

This is a Ruby on Rails application designed to import movie data from CSV files and provide search and sorting capabilities.

**Getting Started:**

1. Clone this repository: 
2. Install dependencies: 
3. Configure your database 
4. Run database migrations: `rails db:migrate`
5. Start the development server: `rails s`

**Features:**

- Imports movie and review data from CSV files (`data/movies.csv` and `data/reviews.csv`).
- Displays an overview of all movies with title, description, year, director, country, actors and average rating.
- Provides a search form to filter movies by associated actor name.
- Sorts the movie overview by average rating (ascending or descending).

**Data Import:**

- You can import data by running the movies or reviews task:
`rails import:movies`
`rails import:review`
- It's best to run the commands in that same order.

**Search and Sort:**

- The search form allows users to filter movies by associated actor name.
- The movie overview can be sorted by average rating (ascending or descending) using efficient techniques like database-side aggregations.

**Further Development:**

- Enhance the search functionality
- Implement pagination for large datasets.
- Add user authentication and authorization for managing movie data.
- Explore advanced data processing techniques for improved performance

