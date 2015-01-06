require 'addressable/uri'
require 'rest-client'
require "byebug"

def url(path)
  Addressable::URI.new(
  scheme: 'http',
  host:   'localhost',
  port:   3000,
  path:   path
  ).to_s
end

def get_contacts

  p RestClient.get(url('/contacts/2/comments'))
end

def create_user

  begin
    RestClient.post(
      url('/users.json'),
      {
        user: {
          name: "Gizmo",
          email: "gizmo@gizmo.com"
        }
      }
    )
  rescue => e
    p e.response
  end
end

def get_user
  RestClient.get(
    url('/users/2')
  )
end

def update(model_name, id, params)
  # byebug
  begin
    RestClient.patch(
      url("/#{model_name}s/#{id}"),
      params
    )
  rescue => e
    p e.response
  end
end

def destroy(model_name, id)
  RestClient.delete(
    url("/#{model_name}s/#{id}")
  )
end

params = {
  contact: {
    name: "Ron",
    email: "new_gizmo3@gizmo.com",
    user_id: 2
  }
}

def favorite(model_name, id)
  RestClient.patch(
    url("/#{model_name}s/#{id}/favorite"),
    nil
  )
end

def show_group(id = 3)
  RestClient.get(
    url("/users/#{id}/groups/1")
  )
end

p show_group
