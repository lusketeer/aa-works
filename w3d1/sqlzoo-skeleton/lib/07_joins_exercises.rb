# == Schema Information
#
# Table name: actor
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movie
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director    :integer
#
# Table name: casting
#
#  movieid     :integer      not null, primary key
#  actorid     :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movie
    JOIN
      casting ON movie.id = casting.movieid
    JOIN
      actor ON casting.actorid = actor.id
    WHERE
      actor.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      m.title
    FROM
      movie m
      INNER JOIN
        casting c
        ON
          m.id = c.movieid
      INNER JOIN
        actor a
        ON
          c.actorid = a.id
    WHERE
      a.name = 'Harrison Ford'
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
    SELECT
      m.title
    FROM
      movie m
      INNER JOIN
        casting c
        ON
          m.id = c.movieid
      INNER JOIN
        actor a
        ON
          c.actorid = a.id
    WHERE
      a.name = 'Harrison Ford' AND c.ord <> 1
    SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      m.title, a.name
    FROM
      movie m
      INNER JOIN
        casting c
        ON
          m.id = c.movieid
      INNER JOIN
        actor a
        ON
          c.actorid = a.id
    WHERE
      m.yr = 1962 AND c.ord = 1
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      m.yr, COUNT(m.yr)
    FROM
      movie m
      INNER JOIN
        casting c
        ON
          m.id = c.movieid
      INNER JOIN
      actor a
        ON
          c.actorid = a.id
    WHERE
      a.name = 'John Travolta'
    GROUP BY
      m.yr
    HAVING
      COUNT(m.yr) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      m.title, a.name
    FROM
      movie m
      INNER JOIN
        casting c
        ON
        m.id = c.movieid
      INNER JOIN
        actor a
        ON
        c.actorid = a.id
    WHERE
       c.ord = 1 AND c.movieid IN (
         SELECT
         c1.movieid
         FROM
         casting c1
         INNER JOIN
         actor a1
         ON
         c1.actorid = a1.id
         WHERE
         a1.name = 'Julie Andrews'
       )
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      a.name
    FROM
      actor a
      INNER JOIN
        casting c
        ON
        c.actorid = a.id
    WHERE
      c.ord = 1
    GROUP BY
      a.name
    HAVING
      COUNT(c.movieid) >= 15
    ORDER BY
      a.name
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      m.title, COUNT(c.actorid)
    FROM
      movie m
      INNER JOIN
        casting c
        ON
        c.movieid = m.id
    WHERE
      m.yr = 1978
    GROUP BY
      m.title
    ORDER BY
      COUNT(c.actorid) DESC, m.title ASC

  SQL
end

def colleagues_of_garfunkel
  # List all the people who have worked with 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      a.name
    FROM
      movie m
      INNER JOIN
        casting c
        ON
        c.movieid = m.id
      INNER JOIN
        actor a
        ON
        c.actorid = a.id
    WHERE
      a.name <> 'Art Garfunkel' AND c.movieid IN (
        SELECT
          c.movieid
        FROM
           movie m
          INNER JOIN
            casting c
            ON
            c.movieid = m.id
          INNER JOIN
            actor a
            ON
              c.actorid = a.id
        WHERE
          a.name = 'Art Garfunkel'

      )
  SQL
end
