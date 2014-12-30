# == Schema Information
#
# Table name: stops
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: route
#
#  num         :integer      not null, primary key
#  company     :string       not null, primary key
#  pos         :integer      not null, primary key
#  stop        :integer

require_relative './sqlzoo.rb'

def num_stops
  # How many stops are in the database?
  execute(<<-SQL)
    SELECT
      COUNT(id)
    FROM
      stops
  SQL
end

def craiglockhart_id
  # Find the id value for the stop 'Craiglockhart'.
  execute(<<-SQL)
    SELECT
      id
    FROM
      stops
    WHERE
      name = 'Craiglockhart'
  SQL
end

def lrt_stops
  # Give the id and the name for the stops on the '4' 'LRT' service.
  execute(<<-SQL)
    SELECT
      s.id, s.name
    FROM
      stops s
      INNER JOIN
        route r
        ON
        s.id = r.stop
    WHERE
      r.num = '4' AND r.company = 'LRT'
  SQL
end

def connecting_routes
  # The query shown gives the number of routes that visit either London Road
  # (149) or Craiglockhart (53). Run the query and notice the two services
  # that link these stops have a count of 2. Add a HAVING clause to restrict
  # the output to these two routes.
  execute(<<-SQL)
    SELECT
      company, num, COUNT(pos)
    FROM
      route
    WHERE
      stop IN (53, 149)
    GROUP BY
      company, num
    HAVING
      COUNT(pos) <= 2

  SQL
end

def cl_to_lr
  # Execute the self join shown and observe that b.stop gives all the places
  # you can get to from Craiglockhart, without changing routes. Change the
  # query so that it shows the services from Craiglockhart to London Road.
  execute(<<-SQL)
    SELECT
      r1.company, r1.num, r1.stop, r2.stop
    FROM
      route r1
      INNER JOIN
        route r2
        ON
          r1.num = r2.num AND r1.company = r2.company
    WHERE
      r1.stop = 53
  SQL
end

def cl_to_lr_by_name
  # The query shown is similar to the previous one, however by joining two
  # copies of the stops table we can refer to stops by name rather than by
  # number. Change the query so that the services between 'Craiglockhart' and
  # 'London Road' are shown. If you are tired of these places try
  # 'Fairmilehead' against 'Tollcross'
  execute(<<-SQL)
    SELECT
      r1.company, r1.num, s.name, s2.name
    FROM
      route r1
      INNER JOIN
        route r2
        ON
        r1.num = r2.num AND r1.company = r2.company
      INNER JOIN
        stops s
        ON
        r1.stop = s.id
      INNER JOIN
        stops s2
        ON
        r2.stop = s2.id
    WHERE
      r1.stop = 53

  SQL
end

def haymarket_and_leith
  # Give a list of all the services which connect stops 115 and 137
  # ('Haymarket' and 'Leith')
  execute(<<-SQL)
    SELECT
      r.company, r.num
    FROM
      route r
      INNER JOIN
        route r2
        ON
          r.num = r2.num AND r.company = r2.company
    WHERE
      (r.stop = 115 AND r2.stop = 137)
    GROUP BY
      r.company, r.num
  SQL
end

def craiglockhart_and_tollcross
  # Give a list of the services which connect the stops 'Craiglockhart' and
  # 'Tollcross'
  execute(<<-SQL)
    SELECT
      r.company, r.num
    FROM
      route r
      INNER JOIN
        route r2
        ON
          r.num = r2.num AND r.company = r2.company
      INNER JOIN
        stops s
        ON
          s.id = r.stop
      INNER JOIN
        stops s2
        ON
          s2.id = r2.stop
    WHERE
      (s.name = 'Craiglockhart' AND s2.name = 'Tollcross')
    GROUP BY
      r.company, r.num
  SQL
end

def start_at_craiglockhart
  # Give a distinct list of the stops which may be reached from 'Craiglockhart'
  # by taking one bus, including 'Craiglockhart' itself. Include the company
  # and bus no. of the relevant services.
  execute(<<-SQL)
  SELECT
    s2.name, r1.company, r1.num
  FROM
    route r1
    INNER JOIN
      route r2
      ON
        r1.num = r2.num AND r1.company = r2.company
      INNER JOIN
        stops s
        ON
          r1.stop = s.id
      INNER JOIN
        stops s2
        ON
          r2.stop = s2.id
    WHERE
      s.name = 'Craiglockhart'
  SQL
end

def craiglockhart_to_sighthill
  # Find the routes involving two buses that can go from Craiglockhart to
  # Sighthill. Show the bus no. and company for the first bus, the name of the
  # stop for the transfer, and the bus no. and company for the second bus.
  # execute(<<-SQL)
  #     SELECT
  #       DISTINCT a.num, a.company, a.name, b.num, b.company
  #     FROM
  #       (
  #         SELECT
  #           DISTINCT r1.num, r1.company, s1.name
  #         FROM
  #           route r1
  #           INNER JOIN
  #             (
  #             SELECT
  #               DISTINCT r.stop, r.num, r.company, s.name
  #             FROM
  #               route r
  #               INNER JOIN
  #                 stops s
  #                 ON
  #                 s.id = r.stop
  #             WHERE
  #               s.name = 'Craiglockhart'
  #             ) j1
  #             ON
  #             r1.num = j1.num
  #           INNER JOIN
  #             stops s1
  #             ON
  #             s1.id = r1.stop
  #         ) a
  #         INNER JOIN
  #         (
  #           SELECT
  #             DISTINCT r2.num, r2.company,  s2.name
  #           FROM
  #             route r2
  #             INNER JOIN
  #               (
  #               SELECT
  #                 DISTINCT r.stop, r.num, r.company, s.name
  #               FROM
  #                 route r
  #                 INNER JOIN
  #                   stops s
  #                   ON
  #                   s.id = r.stop
  #               WHERE
  #                 s.name = 'Sighthill'
  #               ) j2
  #               ON
  #               r2.num = j2.num
  #             INNER JOIN
  #               stops s2
  #               ON
  #               s2.id = r2.stop
  #         ) b
  #         ON a.name = b.name AND a.num <> b.num
  #     WHERE
  #       a.name <> 'Sighthill' AND a.name <> 'Craiglockhart'
  # SQL
  execute(<<-SQL)

    SELECT
        DISTINCT first.num, first.company, s.name, second.num, second.company
    FROM
    (
    SELECT
      starta.company, finisha.num, finisha.stop
    FROM
      route starta
      INNER JOIN
      route finisha
        ON
        starta.company = finisha.company AND starta.num = finisha.num
    WHERE
      starta.stop = (
        SELECT
          id
        FROM
          stops
        WHERE
          name = 'Craiglockhart'
      )
      ) first
    INNER JOIN
    (
    SELECT
      startb.company, finishb.num, finishb.stop
    FROM
      route startb
      INNER JOIN
      route finishb
        ON
        startb.company = finishb.company AND startb.num = finishb.num
      WHERE
        startb.stop = (
          SELECT
            id
          FROM
            stops
          WHERE
            name = 'Sighthill'
        )
      ) second
      ON
      first.stop = second.stop
      INNER JOIN
      stops s
      ON
      first.stop = s.id

  SQL













end
