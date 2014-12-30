class PageController < ApplicationController
  def index
    sql =<<-SQL
      SELECT
        id
      FROM
        shortened_urls
      WHERE
        id IN
        (
          SELECT
          url_id
          FROM
          visits
          GROUP BY
          url_id
          ORDER BY
          COUNT(visitor_id) DESC
          LIMIT 10
        )
    SQL

    url_ids = ActiveRecord::Base.connection.execute(sql)

    @urls = url_ids.map do |url_id|
      ShortenedUrl.find(url_id['id'])
    end
  end
end
