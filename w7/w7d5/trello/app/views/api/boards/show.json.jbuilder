# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list
json.extract! @board, :title

json.lists do |json|
  json.array! @board.lists do |list|
    json.extract! list, :id, :title, :board_id, :ord
    # json.id         list.id
    # json.title      list.title
    # json.board_id   list.board_id
    # json.ord        list.ord
    json.cards do |json|
      json.array! list.cards do |card|
        json.extract! card, :id, :title, :list_id, :description, :ord
        # json.id             card.id
        # json.title          card.title
        # json.list_id        card.list_id
        # json.description    card.description
        # json.ord            card.ord
      end
    end
  end
end

json.owner do
  json.email @board.user.email
end

json.members do |json|
  json.array! @board.members do |member|
    json.id     member.id
    json.email  member.email
  end
end
